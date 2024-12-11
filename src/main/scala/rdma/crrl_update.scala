package rdma
import intel_ip.{rdma_ctyun_sdpram, rdma_ctyun_sfifo}
import spinal.core._
import spinal.lib._

import scala.language.{implicitConversions, postfixOps}

case class QpMngrReqSdb() extends Bundle {
  val module_id: Bits = Bits(3 + 1 bits) //#
  val req_id:    Bits = Bits(11 + 1 bits)
  val qpn:       Bits = Bits(23 + 1 bits) // [23:16] used for qpn version
  val req_type:  Bits = Bits(3 + 1 bits)
  val status:    Bits = Bits(3 + 1 bits)
}

case class CrrlIterruptState() extends Bundle {
  val finish_flag:        Bool = Bool() // #
  val interrupt_bit:      Bool = Bool()
  val dma_length:         UInt = UInt(31 + 1 bits) // remain length
  val sqe_rkey:           Bits = Bits(31 + 1 bits)
  val sqe_va:             UInt = UInt(63 + 1 bits)
  val sge_num:            UInt = UInt(2 + 1 bits)
  val last_rd_rsp_opcode: Bits = Bits(7 + 1 bits) // for ordering
  val sq_wqe_index:       UInt = UInt(15 + 1 bits)
}

case class CrrlIdState() extends Bundle {
  val crrl_cnt:  UInt = UInt(4 + 1 bits) // max 16
  val ssn:       UInt = UInt(23 + 1 bits)
  val ce_bit:    Bool = Bool()
  val last_psn:  UInt = UInt(23 + 1 bits)
  val first_psn: UInt = UInt(23 + 1 bits)
}

case class CrrlState() extends Bundle {
  val id_state: CrrlIdState       = CrrlIdState()
  val it_state: CrrlIterruptState = CrrlIterruptState()
}

object CrrlState {
  implicit def toIdState(crrlState: CrrlState): CrrlIdState       = crrlState.id_state
  implicit def toItState(crrlState: CrrlState): CrrlIterruptState = crrlState.it_state
}

case class CrrlIfDat() extends Bundle {
  val crr_state: CrrlState    = CrrlState()
  val crrl_sdb:  QpMngrReqSdb = QpMngrReqSdb()
}

case class CrrlQueueStat(queueSize: Int) extends Bundle {
  val push_ptr: UInt = UInt(log2Up(queueSize) bits)
  val pop_ptr:  UInt = UInt(log2Up(queueSize) bits)
  val full:     Bool = Bool()
  val empty:    Bool = Bool()
}

case class crrl_update(maxQp: Int = 258, queueSzie: Int = 16) extends Component {
  val io = new Bundle {
    val crrl_req: Stream[CrrlIfDat] = slave Stream (CrrlIfDat())
    val crrl_rsp: Stream[CrrlIfDat] = master Stream (CrrlIfDat())
  }
  noIoPrefix()
  val sched_req_pop: Stream[CrrlIfDat] = io.crrl_req.m2sPipe()

  val WQE_IDX_WIDTH:  Int = io.crrl_req.crr_state.sq_wqe_index.getBitsWidth
  val ID_STATE_WIDTH: Int = io.crrl_req.crr_state.id_state.getBitsWidth
  val IT_STATE_WIDTH: Int = io.crrl_req.crr_state.it_state.getBitsWidth
  val sqe_wqe_idx_ram: rdma_ctyun_sdpram =
    intel_ip.rdma_ctyun_sdpram(dw = WQE_IDX_WIDTH, aw = log2Up(256), rdLatency = 1, ramType = "MLAB", ruwPolicy = "NEW_DATA")
  val it_state_ram: rdma_ctyun_sdpram = rdma_ctyun_sdpram(dw = IT_STATE_WIDTH, aw = log2Up(maxQp - 2) + log2Up(queueSzie))
  val id_state_ram: rdma_ctyun_sdpram = rdma_ctyun_sdpram(dw = ID_STATE_WIDTH, aw = log2Up(maxQp - 2) + log2Up(queueSzie))
  val version_ram:  rdma_ctyun_sdpram = rdma_ctyun_sdpram(dw = 8, aw = log2Up(maxQp - 2), rdLatency = 1)
  val ptr_ram: rdma_ctyun_sdpram =
    rdma_ctyun_sdpram(dw = log2Up(queueSzie) * 2 + 2, aw = log2Up(maxQp - 2), rdLatency = 1, ramType = "MLAB", ruwPolicy = "NEW_DATA")
  val pop_pipe: Stream[CrrlIfDat] = sched_req_pop.m2sPipe()

  val qp_id:           UInt = (sched_req_pop.crrl_sdb.qpn(8 downto 0).asUInt - 2).resize(log2Up(maxQp - 2))
  val qp_id_pipe:      UInt = (pop_pipe.crrl_sdb.qpn(8 downto 0).asUInt - 2).resize(log2Up(maxQp - 2))
  val qp_version_pipe: Bits = pop_pipe.crrl_sdb.qpn(23 downto 16)

  val ptr_rd_addr:  UInt          = qp_id
  val ptr_rd_en:    Bool          = sched_req_pop.fire
  val ptr_rd_out:   CrrlQueueStat = CrrlQueueStat(queueSzie)
  val inital_empty: Bool          = ptr_rd_out.asBits === 0
  val ptr_wr_en:    Bool          = pop_pipe.fire
  val ptr_wr_addr:  UInt          = qp_id_pipe
  val ptr_wr_din:   CrrlQueueStat = CrrlQueueStat(queueSzie)
  val crrl_cnt:     UInt          = UInt(log2Up(queueSzie) + 1 bits) setAsReg () init (0)

  val wqe_idx_greater: Bool = pop_pipe.crr_state.sq_wqe_index >= sqe_wqe_idx_ram.io.ram_port.dout.asUInt
  val version_match:   Bool = qp_version_pipe === version_ram.io.ram_port.dout

  val pipe_module_id: Bits = pop_pipe.crrl_sdb.module_id
  val pipe_req_type:  Bits = pop_pipe.crrl_sdb.req_type

  val req_clear: Bool = pipe_module_id === rdma_vh.CMDQ_MNG
  val req_push:  Bool = pipe_module_id === rdma_vh.TX_WQE_PROC && pipe_req_type === rdma_vh.GEN_RD_REQ
  val req_pop:   Bool = pipe_module_id === rdma_vh.RX_WQE_PROC && pipe_req_type === rdma_vh.RX_WQE_RCV_RD_RSP && pop_pipe.crr_state.finish_flag
  val req_fill:  Bool = pipe_module_id === rdma_vh.RX_WQE_PROC && pipe_req_type === rdma_vh.RX_WQE_RCV_RD_RSP && pop_pipe.crr_state.interrupt_bit
  val req_read: Bool = (pipe_module_id === rdma_vh.DB_SCHEDULER && pipe_req_type === rdma_vh.DB_SCHEUDLE_TX) ||
    (pipe_module_id === rdma_vh.RX_PKT_PROCE && ((pipe_req_type === rdma_vh.RCV_RD_RSP_OTHERS) || (pipe_req_type === rdma_vh.RCV_RD_RSP_1ST)))
  val supported_operation: Bool = (req_clear ## req_push ## req_pop ## req_fill ## req_read).orR
  val do_clear:            Bool = req_clear && version_match
  val do_push:             Bool = req_push & version_match & wqe_idx_greater & ~ptr_rd_out.full
  val do_pop:              Bool = req_pop & version_match & ~(ptr_rd_out.empty | inital_empty)
  val do_fill:             Bool = req_fill & version_match & ~(ptr_rd_out.empty | inital_empty)
  val do_read:             Bool = req_read & version_match & ~(ptr_rd_out.empty | inital_empty)

  val state_ram_raddr:   UInt                 = (qp_id_pipe << log2Up(queueSzie)) + ptr_rd_out.pop_ptr
  val id_state_waddr:    UInt                 = (qp_id_pipe << log2Up(queueSzie)) + ptr_rd_out.push_ptr
  val it_state_waddr:    UInt                 = (qp_id_pipe << log2Up(queueSzie)) + Mux(req_push, ptr_rd_out.push_ptr, ptr_rd_out.pop_ptr)
  val id_rd_out:         CrrlIdState          = CrrlIdState()
  val it_rd_out:         CrrlIterruptState    = CrrlIterruptState()
  val crrl_state_rd_out: CrrlState            = CrrlState()
  val sdb_st:            Stream[QpMngrReqSdb] = Stream(QpMngrReqSdb())
  val sdb_pipe_st:       Stream[QpMngrReqSdb] = sdb_st.m2sPipe().m2sPipe()
  val rsp_rd: Bool = (sdb_pipe_st.module_id === rdma_vh.DB_SCHEDULER && sdb_pipe_st.req_type === rdma_vh.DB_SCHEUDLE_TX) ||
    (sdb_pipe_st.module_id === rdma_vh.RX_PKT_PROCE && (sdb_pipe_st.req_type === rdma_vh.RCV_RD_RSP_1ST || sdb_pipe_st.req_type === rdma_vh.RCV_RD_RSP_OTHERS))
  val crrl_rsp_push:         Stream[CrrlIfDat] = Stream(CrrlIfDat())
  val back_pre:              Bool              = Bool() setAsReg () init False
  val crrl_state_rd_out_reg: CrrlState         = RegNextWhen(crrl_state_rd_out, ~crrl_rsp_push.ready & ~back_pre)
  val rx_wqe_others_no_it: Bool =
    sdb_pipe_st.module_id === rdma_vh.RX_PKT_PROCE && sdb_pipe_st.req_type === rdma_vh.RCV_RD_RSP_OTHERS && ~Mux(
      back_pre,
      crrl_state_rd_out_reg.interrupt_bit,
      it_rd_out.interrupt_bit
    )
  // ptr/ver/wqe read
  sqe_wqe_idx_ram.read(ptr_rd_en, ptr_rd_addr)
  version_ram.read(ptr_rd_en, ptr_rd_addr)
  ptr_rd_out.assignFromBits(ptr_ram.read(ptr_rd_en, ptr_rd_addr))
  // ptr update
  when(do_clear) {
    ptr_wr_din.push_ptr.clearAll()
    ptr_wr_din.pop_ptr.clearAll()
    ptr_wr_din.full.clear()
    ptr_wr_din.empty.set()
  } elsewhen (do_push) {
    ptr_wr_din.push_ptr := ptr_rd_out.push_ptr + 1
    ptr_wr_din.pop_ptr  := ptr_rd_out.pop_ptr
    ptr_wr_din.full     := ptr_wr_din.push_ptr === ptr_wr_din.pop_ptr
    ptr_wr_din.empty.clear()
  } elsewhen (do_pop) {
    ptr_wr_din.push_ptr := ptr_rd_out.push_ptr
    ptr_wr_din.pop_ptr  := ptr_rd_out.pop_ptr + 1
    ptr_wr_din.full.clear()
    ptr_wr_din.empty := ptr_wr_din.push_ptr === ptr_wr_din.pop_ptr
  } otherwise (ptr_wr_din := ptr_rd_out)

  when(do_clear){
    crrl_cnt.clearAll()
  } elsewhen(do_push){
    crrl_cnt := crrl_cnt + 1
  }elsewhen(do_pop){
    crrl_cnt := crrl_cnt - 1
  }

  // ptr/ver/wqe write
  ptr_ram.write(ptr_wr_en, ptr_wr_addr, ptr_wr_din.asBits)
  version_ram.write(ptr_wr_en, ptr_wr_addr, qp_version_pipe)
  sqe_wqe_idx_ram.write(ptr_wr_en & do_push, ptr_wr_addr, (pop_pipe.crr_state.sq_wqe_index + 1).asBits)
  // sdb st pipe
  sdb_st.valid   := pop_pipe.valid
  pop_pipe.ready := sdb_st.ready
  sdb_st.payload := pop_pipe.crrl_sdb
  when(~supported_operation) {
    sdb_st.status := rdma_vh.CRRL_REQ_UNSUPPORTED_REQ_TYPE
  } elsewhen (~version_match) {
    sdb_st.status := rdma_vh.CRRL_QPN_ENSPIRE
  } elsewhen (req_push) {
    when(~wqe_idx_greater) {
      sdb_st.status := 0//rdma_vh.CRRL_REQ_WQE_IDX_LOWWER // FIXME
    } elsewhen (ptr_rd_out.full) {
      sdb_st.status := rdma_vh.TX_WQE_PROC_WR_OVERFLOW
    } otherwise {
      sdb_st.status.clearAll()
    }
  } elsewhen (req_clear) {
    sdb_st.status.clearAll()
  } elsewhen (ptr_rd_out.empty | inital_empty) {
    sdb_st.status := rdma_vh.CRRL_REQ_ACESS_EMPTY_QUEUE
  }
  // id/it write
  id_state_ram.write(do_push, id_state_waddr, pop_pipe.crr_state.id_state.asBits)
  it_state_ram.write(do_push | do_fill, it_state_waddr, pop_pipe.crr_state.it_state.asBits)
  // id/it read
  id_rd_out.assignFromBits(id_state_ram.read(do_read & sdb_st.fire, state_ram_raddr))
  it_rd_out.assignFromBits(it_state_ram.read(do_read & sdb_st.fire, state_ram_raddr))
  crrl_state_rd_out.id_state := id_rd_out
  crrl_state_rd_out.it_state := it_rd_out
// crrl_rsp push
  back_pre setWhen crrl_rsp_push.valid & ~crrl_rsp_push.ready clearWhen crrl_rsp_push.ready
  crrl_rsp_push.crrl_sdb := sdb_pipe_st.payload
  when(sdb_pipe_st.status === 0 && rx_wqe_others_no_it) {
    crrl_rsp_push.crrl_sdb.status := rdma_vh.RCV_RD_RSP_OTHERS_NO_ITRPT
  }
  when(sdb_pipe_st.status === 0 && rsp_rd && ~rx_wqe_others_no_it) {
    crrl_rsp_push.crr_state := Mux(back_pre, crrl_state_rd_out_reg, crrl_state_rd_out)
  } otherwise {
    crrl_rsp_push.crr_state.clearAll()
  }

  io.crrl_rsp <> crrl_rsp_push.m2sPipe()

  // TODO
  sdb_pipe_st.ready   := crrl_rsp_push.ready
  crrl_rsp_push.valid := sdb_pipe_st.valid

}
