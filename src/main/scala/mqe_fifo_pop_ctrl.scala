import spinal.core._
import spinal.lib._

import scala.language.postfixOps

object MqeCmd extends SpinalEnum {
  val RDMA_MPT_INVLAID, RDMA_MPT_L2TABLE_INVALID, RDMA_MPT_CACHE_UPDATE, RDMA_MTT_CACHE_UPDATE, RDMA_MPT_HASH_DUMP, RDMA_MPT_VAL_DUMP, RDMA_MTT_HASH_DUMP,
      RDMA_MTT_VAL_DUMP, RDMA_MP_CQ_CREATE, RDMA_MP_CQ_QMTT_PREFILL, RDMA_MP_CQ_DESTROY, RDMA_MP_EQ_CREATE, RDMA_MP_EQ_QMTT_PREFILL, RDMA_MP_EQ_DESTROY,
      RDMA_MP_SRQ_CREATE, RDMA_MP_SRQ_DESTROY, RDMA_MP_QP_STATE_MODIFY, RDMA_MP_QP_DESTROY, RDMA_MP_SQ_QMTT_PREFILL, RDMA_MP_RQ_QMTT_PREFILL,
      RDMA_MP_SRQ_QMTT_PREFILL, RDMA_MP_SRQ_INDEX_QMTT_PREFILL, RDMA_MP_FLR_QP, RDMA_MP_FLR_SRQ, RDMA_MP_FLR_CQ, RDMA_MP_FLR_EQ, RDMA_MP_FLR_MR = newElement()
}

case class Msqe() extends Bundle {
  val cmd  = MqeCmd()
  val data = Bits(8 bits)

}

case class mqe_fifo_pop_ctrl(fifo_latency: Int = 3) extends Component {
  val io = new Bundle {
    val msqe_in:                Stream[Msqe] = slave Stream (Msqe())
    val ostd_mqe_info_fifo_pop: Bool         = in Bool ()
    val msqe_out:               Stream[Msqe] = master Stream (Msqe())
  }

  noIoPrefix()

  val msqe_fifo:      StreamFifo[Msqe] = StreamFifo(Msqe(), 8)
  val ostd_info_fifo: StreamFifo[Bits] = StreamFifo(Bits(8 bits), 8)
  io.msqe_in                     <> msqe_fifo.io.push
  ostd_info_fifo.io.push.valid   := io.msqe_out.valid
  ostd_info_fifo.io.push.payload := io.msqe_out.data
  ostd_info_fifo.io.pop.ready    := io.ostd_mqe_info_fifo_pop
  val fifo_pop: Stream[Msqe] = msqe_fifo.io.pop

  val poped: Bool = RegInit(False)
  val cmd_poped = MqeCmd() setAsReg ()
  val pre_not_empty: Bits = Bits(fifo_latency - 1 bits) setAsReg () init (0)
  val true_empty:    Bool = Bool()

  when(io.msqe_out.fire) {
    cmd_poped := fifo_pop.cmd
  }

  when(fifo_pop.valid) {
    when(io.msqe_out.fire) {
      poped := True
    }
  } otherwise {
    when(true_empty) {
      poped := False
    }
  }

  pre_not_empty := pre_not_empty(fifo_latency - 3 downto 0) ## (io.msqe_out.fire & true_empty).asBits

  val same_cmd_type: Bool = fifo_pop.cmd === cmd_poped

  io.msqe_out.payload := fifo_pop.payload

  val bp_for_diff_type: Bool = Bool()

  when(pre_not_empty.orR) {
    true_empty := False
  } otherwise {
    true_empty := ~ostd_info_fifo.io.pop.valid
  }
  bp_for_diff_type := False

  when(poped) {
    when(same_cmd_type) {
      io.msqe_out.valid := fifo_pop.valid
    } otherwise {
      when(true_empty) {
        io.msqe_out.valid := fifo_pop.valid
      } otherwise {
        io.msqe_out.valid := False
        bp_for_diff_type  := True
      }
    }
  } otherwise {
    io.msqe_out.valid := fifo_pop.valid
  }

  fifo_pop.ready := Mux(bp_for_diff_type, False, io.msqe_out.ready)
}

object mqe_fifo_pop_ctrlRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(mqe_fifo_pop_ctrl())
}
