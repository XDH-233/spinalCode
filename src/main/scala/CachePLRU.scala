import spinal.core._
import spinal.lib._
import spinal.lib.bus.avalon._
import intel_ip._
import org.openxmlformats.schemas.drawingml.x2006.spreadsheetDrawing.STEditAs
import rdma.command_queue.DMAFun._
import rdma.command_queue.{AvstConfig, DMARReqDesc}

import scala.language.postfixOps

case class DMALite() extends Bundle {
  val dma_addr: UInt = UInt(64 bits)
  val dma_len:  UInt = UInt(17 bits)
}

case class QueryStatus[T <: Bundle](clNum: Int, t: HardType[T]) extends Bundle {
  val hit:   Bool = Bool()
  val cl_id: UInt = UInt(log2Up(clNum) bits)
  val tag:   T    = t()
}
case class CachePLRU[T <: Bundle, E <: Data](t: HardType[T], e: HardType[E], clNum: Int, entryPerLine: Int)(
    hitLogic:                                   (T, T) => Bool
) extends Component {
  require(isPow2(clNum))
  val AGING_CYCLES = 2500
  val io = new Bundle {
    val query:      Stream[T]      = slave Stream (t)
    val entrys:     Stream[Vec[E]] = master Stream (Vec(e, entryPerLine))
    val miss:       Bool           = out Bool ()
    val rpl_entrys: Stream[Vec[E]] = slave Stream (Vec(e, entryPerLine))
  }

  val tags:             Vec[T]                 = Vec(t() setAsReg (), clNum)
  val aging_cnts:       Vec[UInt]              = Vec(UInt(16 bits) setAsReg () init (0), clNum)
  val alive:            Bits                   = Vec(aging_cnts.zipWithIndex.map { case (c, i) => c < AGING_CYCLES }.reverse).asBits
  val hits:             Bits                   = Vec(tags.map(tag => hitLogic(io.query.payload, tag)).reverse).asBits
  val hit_alive:        Bits                   = hits & alive
  val hits_one_hot:     Bits                   = ((hit_alive.asUInt - 1).asBits ^ hits) & hits
  val hit:              Bool                   = hit_alive.orR
  val hit_idx:          UInt                   = OHToUInt(hits_one_hot)
  val plru_state:       Bits                   = Bits(clNum - 1 bits) setAsReg () init 0
  val plru_ctrl:        PlruCtrl            = PlruCtrl(clNum)
  val reorder_push:     Stream[QueryStatus[T]] = Stream(QueryStatus(clNum, t))
  val reorder_pop:      Stream[QueryStatus[T]] = Stream(QueryStatus(clNum, t))
  val pop_pipe:         Stream[QueryStatus[T]] = reorder_pop.m2sPipe().m2sPipe()
  val query_reorder_ff: rdma_ctyun_sfifo       = rdma_ctyun_sfifo(clNum, push_st = reorder_push, pop_st = reorder_pop)
  val cache_line_ram:   rdma_ctyun_sdpram      = rdma_ctyun_sdpram(entryPerLine * e.getBitsWidth, log2Up(clNum), 2, "M20K")
  val rd_entrys:        Vec[E]                 = Vec(e(), entryPerLine)
  val rd_entrys_reg:    Vec[E]                 = RegNextWhen(rd_entrys, ~io.entrys.ready & pop_pipe.valid & pop_pipe.hit)
  val back_pre:         Bool                   = ~io.entrys.ready & pop_pipe.valid & pop_pipe.hit
  aging_cnts.zip(hit_alive.asBools).zipWithIndex.foreach { case ((c, h), i) =>
    when(h) {
      c.clearAll()
    } elsewhen (plru_ctrl.io.plru_entry === i) {
      c.clearAll()
    } otherwise {
      c := c + 1
    }
  }
  plru_ctrl.io.plru_state                        := plru_state
  plru_ctrl.io.plru_update_req.plru_update_entry := plru_ctrl.io.plru_entry
  plru_ctrl.io.plru_update_req.plru_state        := plru_state
  when(~hit) {
    plru_state := plru_ctrl.io.plru_update_result
  }
  reorder_push.hit   := hit
  reorder_push.cl_id := Mux(hit, hit_idx, plru_ctrl.io.plru_entry)
  reorder_push.tag   := Mux(hit, tags(hit_idx), io.query.payload)
  reorder_push.valid := io.query.valid

  cache_line_ram.write(io.rpl_entrys.fire, pop_pipe.cl_id, io.rpl_entrys.payload.asBits)

  when(pop_pipe.hit) {} elsewhen (io.rpl_entrys.valid) {
    tags(pop_pipe.cl_id) := pop_pipe.tag
  }

  io.query.ready  := reorder_push.ready
  pop_pipe.ready  := io.entrys.ready & Mux(pop_pipe.valid & ~pop_pipe.hit, io.rpl_entrys.valid, True)
  io.entrys.valid := pop_pipe.valid

  rd_entrys.zip(cache_line_ram.read(reorder_pop.valid & reorder_pop.hit, reorder_pop.cl_id).subdivideIn(e.getBitsWidth bits)).foreach { case (e, r) =>
    e.assignFromBits(r)
  }

  when(pop_pipe.hit) {
    io.entrys.payload := Mux(back_pre, rd_entrys_reg, rd_entrys)
  } otherwise {
    io.entrys.payload := io.rpl_entrys.payload
  }
  io.miss             := ~hit
  io.rpl_entrys.ready := io.entrys.ready
}

case class MrCacheTag() extends Bundle {
  val mr_idx:   UInt = UInt(15 bits)
  val spge_idx: UInt = UInt(26 bits)
  val epge_idx: UInt = UInt(26 bits)
}

object test extends App {
  tool.GeneralConfig
    .rtlGenConfig("verilogGen")
    .generateVerilog(CachePLRU(MrCacheTag(), UInt(64 bits), 32, 8) { (t_in: MrCacheTag, ts: MrCacheTag) =>
      t_in.mr_idx === ts.mr_idx && t_in.spge_idx >= ts.spge_idx && t_in.epge_idx <= ts.epge_idx
    })
}
