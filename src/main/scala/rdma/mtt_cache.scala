package rdma

import rdma.rdma_vh._
import spinal.core._
import spinal.lib._
import tool.PlruControl._
import intel_ip.rdma_ctyun_sfifo._
import intel_ip.rdma_ctyun_sfifo
import intel_ip.rdma_ctyun_sdpram._
import spinal.core
import spinal.lib.bus.avalon
import spinal.lib.bus.avalon.{AvalonST, AvalonSTConfig}
import tool.{Access, PlruControlFactory}
import tool.BusExt._

import scala.language.postfixOps

case class mr_trans() extends Bundle {
  val sop:           Bool = Bool()
  val eop:           Bool = Bool()
  val err:           Bool = Bool()
  val need_trans:    Bool = Bool()
  val log_entity_sz: UInt = UInt(5 bits)
  val mtt_pba:       UInt = UInt(MRM_PA_BW bits)
  val trans_len:     UInt = UInt(MRM_SGE_MAX_LEN_BW bits)
  val trans_sofst:   UInt = UInt(MRM_PGE_OFS_BW bits)
  val mr_idx:        Bits = Bits(MRM_MPTIDX_BW_WITH_V bits)
}

case class mtt_cache_din() extends Bundle {

  val mr_tran_din: mr_trans = mr_trans()
  val spge_idx:    UInt     = UInt(MRM_PGE_IDX_BW bits)
  val epge_idx:    UInt     = UInt(MRM_PGE_IDX_BW bits)
}

case class mtt_cache_dout() extends Bundle {
  val sop:           Bool = Bool()
  val eop:           Bool = Bool()
  val log_entity_sz: UInt = UInt(5 bits)
  val trans_pba:     UInt = UInt(MRM_PA_BW bits)
  val trans_len:     UInt = UInt(MRM_SGE_MAX_LEN_BW bits)
}

case class mtt_cache_tag() extends Bundle {
  val spge_tag: UInt = UInt(MRM_PGE_IDX_BW bits)
  val mr_idx:   Bits = Bits(MRM_MPTIDX_BW_WITH_V bits)
}

case class qry_tmp(cl_num: Int, cl_entry_num: Int) extends Bundle {
  val mr_trans_tmp: mr_trans = mr_trans()
  val hit:          Bool     = Bool()
  val cl_idx:       UInt     = UInt(log2Up(cl_num) bits)
  val cl_ofst:      UInt     = UInt(log2Up(cl_entry_num) bits)
}

case class mtt_dma_req_din(clNum: Int) extends Bundle {
  val dma_len: UInt = UInt(9 bits)
  val dma_pa:  UInt = UInt(MRM_PA_BW bits)
  val cl_num:  UInt = UInt(log2Up(clNum) bits)
}

case class mtt_cache(cacheLineNum: Int = MRM_CLNUM.toInt, entiesPerLine: Int = MRM_CLENTRY_NUM.toInt, aging_cycles: Int = 2500) extends Component {
  val mtt_dma_rrsp_avst_config: AvalonSTConfig =
    AvalonSTConfig(dataWidth = GLB_DMA_DAT_BW.toInt, useChannels = true, channelWidth = log2Up(cacheLineNum), useSOP = true, useEOP = true)
  val cacheLineRowNum: BigInt = (entiesPerLine * 64) / GLB_DMA_DAT_BW // 4
  val entryNumInRow:   BigInt = GLB_DMA_DAT_BW / 64 // 8

  def getAvst[T <: Data](t: HardType[T]): AvalonST = AvalonST(AvalonSTConfig(dataWidth = t.getBitsWidth, useSOP = true, useEOP = true))

  val io = new Bundle {
    val mtt_qry:          Stream[mtt_cache_din]   = slave Stream (mtt_cache_din())
    val mtt_trans:        Stream[mtt_cache_dout]  = master Stream (mtt_cache_dout())
    val dma_rdreq:        Stream[mtt_dma_req_din] = master Stream (mtt_dma_req_din(cacheLineNum))
    val dma_rrsp:         AvalonST                = slave(AvalonST(mtt_dma_rrsp_avst_config))
    val mtt_qry_ff_afull: Bool                    = out Bool ()
  }
  noIoPrefix()

  val mtt_qry_pop, mtt_qry_push: Stream[mtt_cache_din] = Stream(mtt_cache_din()) //buffer(io.mtt_qry, 64)
  val mtt_qry_fifo:              rdma_ctyun_sfifo      = rdma_ctyun_sfifo(64, push_st = io.mtt_qry, pop_st = mtt_qry_pop)
  val qry_tags:                  Vec[mtt_cache_tag]    = Vec.fill(cacheLineNum)(Reg(mtt_cache_tag()))
  val plru_qry_update:           Stream[Access]        = Stream(Access(cacheLineNum))
  val dma_rpl_end:               Flow[UInt]            = Flow(UInt(log2Up(cacheLineNum) bits))
  val plru_ctrl_fact:            PlruControlFactory    = plruControlFactory.die_after(2500 cycles).rpl_blk_release(dma_rpl_end).update_from(plru_qry_update)

  val hit_miss_logic = new Area {
    val hits: Vec[Bool] = Vec.fill(cacheLineNum)(Bool())
    hits.zip(qry_tags.zip(plru_ctrl_fact.get_aging_valids)).foreach { case (h, (t, v)) =>
      h := !(t.spge_tag.takeHigh(MRM_PGE_IDX_BW.toInt - log2Up(entiesPerLine)) ^ (mtt_qry_pop.spge_idx
        .takeHigh(MRM_PGE_IDX_BW.toInt - log2Up(entiesPerLine)))).orR & v & !(t.mr_idx ^ mtt_qry_pop.mr_tran_din.mr_idx).orR
    }
    val hit:     Bool = hits.orR
    val hit_idx: UInt = OHToUInt(hits)
    val rpl_cl_idx = plru_ctrl_fact.get_plru_entry

    // assert
    val miss_info: Bool = ~hit & mtt_qry_pop.fire & ~mtt_qry_pop.mr_tran_din.err & mtt_qry_pop.mr_tran_din.need_trans
    assert(
      ~miss_info,
      L"$REPORT_TIME ps cache miss, mr_idx: ${mtt_qry_pop.mr_tran_din.mr_idx}, spge_idx: ${mtt_qry_pop.spge_idx}, plru_entry: ${plru_ctrl_fact.get_plru_entry}!",
      WARNING
    )
  }

  val qry_tmp_reorder_push: Stream[qry_tmp] = Stream(qry_tmp(cacheLineNum, entiesPerLine))

  val miss_dma_logic = new Area {
    val on_epge_range: Bool =
      !(mtt_qry_pop.epge_idx(MRM_PGE_IDX_BW.toInt - 1 downto log2Up(entiesPerLine)) ^ mtt_qry_pop.spge_idx(
        MRM_PGE_IDX_BW.toInt - 1 downto log2Up(entiesPerLine)
      )).orR
    val dma_page_num: UInt =
      32 //Mux(on_epge_range, mtt_qry_pop.epge_idx.takeLow(log2Up(entiesPerLine)).asUInt +^ 1, U(32)) // FIXME: may leading next qry hit data not replaced.
    val spge_ofst:     UInt                    = ((mtt_qry_pop.spge_idx >> log2Up(entiesPerLine)) << log2Up(entiesPerLine)) << 3
    val dma_rreq_push: Stream[mtt_dma_req_din] = Stream(mtt_dma_req_din(cacheLineNum))
    dma_rreq_push.dma_pa  := mtt_qry_pop.mr_tran_din.mtt_pba + spge_ofst
    dma_rreq_push.dma_len := dma_page_num << log2Up(64 / 8)
    dma_rreq_push.cl_num  := hit_miss_logic.rpl_cl_idx
    dma_rreq_push.valid   := mtt_qry_pop.fire & ~hit_miss_logic.hit & ~mtt_qry_pop.mr_tran_din.err & mtt_qry_pop.mr_tran_din.need_trans
    io.dma_rdreq          <> buffer(dma_rreq_push, 32)
  }
  val qry_tmp_reorder_pop: Stream[qry_tmp] = buffer(qry_tmp_reorder_push, 128)
  val dma_rrsp_pop:        AvalonST        = bufferAvst(io.dma_rrsp, 32)
  val dma_rsp_cnt:         UInt            = RegInit(U(0, log2Up(cacheLineRowNum) bits))
  val tmp_pop_pipe:        Stream[qry_tmp] = qry_tmp_reorder_pop.m2sPipe()
  val cache_ram_rw_logic = new Area {
    val rden_int: Bool =
      qry_tmp_reorder_pop.valid & qry_tmp_reorder_pop.hit & qry_tmp_reorder_pop.mr_trans_tmp.need_trans & !qry_tmp_reorder_pop.mr_trans_tmp.err
    val rden:         Bool      = Bool()
    val raddr_int:    UInt      = qry_tmp_reorder_pop.cl_idx @@ (qry_tmp_reorder_pop.cl_ofst.takeHigh(2).asUInt)
    val raddr:        UInt      = UInt(log2Up(cacheLineNum * entiesPerLine / entryNumInRow) bits)
    val wren:         Bool      = dma_rrsp_pop.fire
    val wdata:        Bits      = dma_rrsp_pop.payload.data
    val waddr:        UInt      = (tmp_pop_pipe.cl_idx << log2Up(cacheLineRowNum)) + dma_rsp_cnt
    val cache_rd_out: Vec[Bits] = ctyunSdpRamFactory.useM20K.setLatency(1).write(wren, waddr, wdata).read(rden, raddr).subdivideIn(64 bits)
//    val mem = Mem(wdata,cacheEntryNum * entiesPerLine / entryNumInRow)
//    mem.write(waddr,wdata,wren)
//    val cache_rd_out: Vec[Bits] = mem.readSync(raddr,rden).subdivideIn(64 bits)
    val ruw:   Bool = rden & wren & (waddr === raddr) & dma_rrsp_pop.payload.eop
    val ruw_d: Bool = RegNext(ruw) init False
    rden  := Mux(ruw_d, RegNext(rden_int) init (False), rden_int)
    raddr := Mux(ruw_d, RegNext(raddr_int), raddr_int)
    //assert
    assert(~ruw, L"$REPORT_TIME ps, read under write! ${raddr}", WARNING)
  }

  val mtt_trans_gen_logic = new Area {
    val err_qry:    Bool = tmp_pop_pipe.mr_trans_tmp.err // | !tmp_pop_pipe.mr_trans_tmp.need_trans
    val need_trans: Bool = tmp_pop_pipe.mr_trans_tmp.need_trans
    val mtt_pa_sel: UInt = tmp_pop_pipe.cl_ofst.takeLow(log2Up(entryNumInRow)).asUInt

    val rpl_mtt_pa: UInt = dma_rrsp_pop.payload.data.subdivideIn(64 bits).read(mtt_pa_sel).asUInt + tmp_pop_pipe.mr_trans_tmp.trans_sofst
    val row_sel:    UInt = tmp_pop_pipe.cl_ofst >> log2Up(entryNumInRow)
    val cached_mtt_pa: UInt = Mux(need_trans, tmp_pop_pipe.mr_trans_tmp.trans_sofst, U(0)) + Mux(
      need_trans,
      cache_ram_rw_logic.cache_rd_out.read(mtt_pa_sel).asUInt,
      tmp_pop_pipe.mr_trans_tmp.mtt_pba
    )
    when(dma_rrsp_pop.fire) {
      when(dma_rrsp_pop.payload.eop) {
        dma_rsp_cnt.clearAll()
      } otherwise {
        dma_rsp_cnt := dma_rsp_cnt + 1
      }
    }
    tmp_pop_pipe.ready := Mux(
      tmp_pop_pipe.hit,
      io.mtt_trans.ready & ~cache_ram_rw_logic.ruw_d,
      (dma_rrsp_pop.valid & dma_rrsp_pop.payload.eop & io.mtt_trans.ready) | (err_qry & io.mtt_trans.ready)
    )
    io.mtt_trans.valid := Mux(
      tmp_pop_pipe.hit,
      tmp_pop_pipe.valid & ~cache_ram_rw_logic.ruw_d,
      (tmp_pop_pipe.valid & dma_rsp_cnt === row_sel & dma_rrsp_pop.valid) | (tmp_pop_pipe.valid & err_qry)
    )
    io.mtt_trans.sop           := tmp_pop_pipe.mr_trans_tmp.sop
    io.mtt_trans.eop           := tmp_pop_pipe.mr_trans_tmp.eop
    io.mtt_trans.log_entity_sz := tmp_pop_pipe.mr_trans_tmp.log_entity_sz
    io.mtt_trans.trans_len     := tmp_pop_pipe.mr_trans_tmp.trans_len
    io.mtt_trans.trans_pba     := Mux(tmp_pop_pipe.hit, Mux(err_qry, U(0), cached_mtt_pa), rpl_mtt_pa)
    //assert
    val dma_cl_err: Bool = (dma_rrsp_pop.payload.channel =/= tmp_pop_pipe.cl_idx) & dma_rrsp_pop.fire & tmp_pop_pipe.valid
    assert(~dma_cl_err, L"$REPORT_TIME ps, DMA response cl_num: ${dma_rrsp_pop.payload.channel} equal not to qry_tmp_pop cl_idx: ${tmp_pop_pipe.cl_idx} !")
  }

  io.mtt_qry_ff_afull := mtt_qry_fifo.io.almost_full

  when(mtt_qry_pop.fire & ~hit_miss_logic.hit) {
    qry_tags(hit_miss_logic.rpl_cl_idx).spge_tag := (mtt_qry_pop.spge_idx >> log2Up(entiesPerLine)) << log2Up(entiesPerLine)
    qry_tags(hit_miss_logic.rpl_cl_idx).mr_idx   := mtt_qry_pop.mr_tran_din.mr_idx
  }

  mtt_qry_pop.ready := qry_tmp_reorder_push.ready & Mux(hit_miss_logic.hit, True, miss_dma_logic.dma_rreq_push.ready & plru_qry_update.ready)

  qry_tmp_reorder_push.valid        := mtt_qry_pop.fire
  qry_tmp_reorder_push.mr_trans_tmp := mtt_qry_pop.mr_tran_din
  qry_tmp_reorder_push.cl_idx       := Mux(hit_miss_logic.hit, hit_miss_logic.hit_idx, hit_miss_logic.rpl_cl_idx)
  qry_tmp_reorder_push.hit          := hit_miss_logic.hit
  qry_tmp_reorder_push.cl_ofst      := mtt_qry_pop.spge_idx.takeLow(log2Up(entiesPerLine)).asUInt

  plru_qry_update.valid       := mtt_qry_pop.fire & !mtt_qry_pop.mr_tran_din.err & mtt_qry_pop.mr_tran_din.need_trans
  plru_qry_update.hit_or_miss := hit_miss_logic.hit
  plru_qry_update.id          := hit_miss_logic.hit_idx

  dma_rrsp_pop.ready  := ~tmp_pop_pipe.hit & ~mtt_trans_gen_logic.err_qry
  dma_rpl_end.valid   := dma_rrsp_pop.fire & dma_rrsp_pop.payload.eop
  dma_rpl_end.payload := tmp_pop_pipe.cl_idx
  // name set
  io.mtt_qry.payload.setPartialName("")
  io.mtt_trans.payload.setPartialName("")
  io.dma_rdreq.payload.setPartialName("")
  io.dma_rrsp.payload.setPartialName("")
  io.dma_rrsp.payload.channel.setPartialName("cl_num")

  // stat
  val qry_cnt, hit_cnt = Counter(0, 65535)
  when(mtt_qry_pop.fire)(qry_cnt.increment())
  when(mtt_qry_pop.fire & hit_miss_logic.hit)(hit_cnt.increment())
}
