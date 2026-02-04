import spinal.core._
import spinal.lib._

import scala.language.postfixOps

object FLRSourceType extends SpinalEnum {
  val QP, SRQ, CQ, EQ, MR = newElement()
}

object QpStateDestryType extends SpinalEnum {
  val QP, SRQ, CQ, EQ = newElement()
}

case class FLRCmd() extends Bundle {
  val source_type = FLRSourceType()
  val function_id = UInt(16 bits)
  val trans_id    = UInt(16 bits)
  val slot_id_cnt = UInt(16 bits)
}

case class QPStateDestroyCmd(sid_w: Int = 15) extends Bundle {
  val destroy_type  = QpStateDestryType()
  val trans_id      = UInt(16 bits)
  val queue_slot_id = UInt(sid_w bits)
}

case class SlotIdBufferMeta(max_slot_id_one_cycle: Int = 102, sid_w: Int = 15) extends Bundle {
  val vld_num  = UInt(log2Up(max_slot_id_one_cycle) bits)
  val slot_ids = Vec.fill(max_slot_id_one_cycle)(UInt(sid_w bits))
}

case class FLRDone(sid_w: Int = 15) extends Bundle {
  val source_type = FLRSourceType()
  val trans_id    = UInt(16 bits)
}

case class FLR(buffer_row_slot_id_num: Int = 102, sid_w: Int = 15) extends Component {

  val FLR_QP_OST_TH  = 64
  val FLR_SRQ_OST_TH = 16
  val FLR_CQ_OST_TH  = 16
  val FLR_EQ_OST_TH  = 16

  val io = new Bundle {
    val flr_cmd_if            = slave Stream (FLRCmd())
    val slot_id_buffer_push   = slave Stream (SlotIdBufferMeta())
    val mpt_mtt_flr_fuct_id   = master Stream (UInt(16 bits))
    val mpt_mtt_flr_done      = in Bool ()
    val qp_state_destroy_cmd  = master Stream (QPStateDestroyCmd())
    val qp_state_destroy_done = in Bool ()
    val flr_done              = master Stream ((FLRDone()))
  }

  noIoPrefix()

  val slot_ids_fifo             = new StreamFifo(SlotIdBufferMeta(), 512)
  val slot_id_fifo              = new StreamFifo(UInt(sid_w bits), 32 * 1024)
  val trans_id_fifo             = new StreamFifo(UInt(16 bits), 16)
  val flr_cmd_mr                = new Stream(FLRCmd())
  val flr_cmd_qp_state          = new Stream(FLRCmd())
  val qp_state_flr_cmd_fifo_pop = new Stream(FLRCmd())
  val qp_state_flr_cmd_ready    = Bool()
  val qp_state_flr_cmd_fifo     = new StreamFifo(FLRCmd(), 16)
  val mr_flr_cmd_fifo           = new StreamFifo(FLRCmd(), 16)
  val mr_flr_cmd_ostd_fifo      = new StreamFifo(FLRCmd(), 16)
  val mr_flr_done_fifo          = new StreamFifo(FLRCmd(), 16)
  val qp_state_flr_done_fifo    = new StreamFifo(FLRCmd(), 16)

  val cur_source_type      = qp_state_flr_cmd_fifo_pop.source_type
  val cur_slot_sum         = qp_state_flr_cmd_fifo_pop.slot_id_cnt
  val destroy_cmd_sent_cnt = UInt(16 bits) setAsReg () init 0
  val destroy_done_cnt     = UInt(16 bits) setAsReg () init 0
  val new_ostd_destroy_cmd = Bool()

  val max_ostd_num           = UInt(16 bits)
  val destroy_ostd_cnt       = UInt(16 bits) setAsReg () init 0
  val destroy_type           = QpStateDestryType()
  val cur_slot_id            = UInt(sid_w bits)
  val buffer_slot_id_pop_cnt = Reg(UInt(log2Up(buffer_row_slot_id_num) bits)) setAsReg () init 0

  qp_state_flr_cmd_fifo.io.push <> flr_cmd_qp_state
  mr_flr_cmd_fifo.io.push       <> flr_cmd_mr
  qp_state_flr_cmd_fifo.io.pop  <> qp_state_flr_cmd_fifo_pop

  // flr_cmd_fifo_pop demux
  flr_cmd_mr.payload       := io.flr_cmd_if.payload
  flr_cmd_qp_state.payload := io.flr_cmd_if.payload
  when(io.flr_cmd_if.source_type === FLRSourceType.MR) {
    flr_cmd_mr.valid       := io.flr_cmd_if.valid
    io.flr_cmd_if.ready    := flr_cmd_mr.ready & trans_id_fifo.io.push.ready
    flr_cmd_qp_state.valid := False
  } otherwise {
    flr_cmd_mr.valid       := False
    flr_cmd_qp_state.valid := io.flr_cmd_if.valid
    io.flr_cmd_if.ready    := flr_cmd_qp_state.ready & trans_id_fifo.io.push.ready
  }
  qp_state_flr_cmd_fifo_pop.ready := qp_state_flr_cmd_ready

  // mr_flr_cmd_proc
  io.mpt_mtt_flr_fuct_id.valid         := mr_flr_cmd_fifo.io.pop.valid
  io.mpt_mtt_flr_fuct_id.payload       := mr_flr_cmd_fifo.io.pop.payload.function_id
  mr_flr_cmd_fifo.io.pop.ready         := mr_flr_cmd_ostd_fifo.io.push.ready & io.mpt_mtt_flr_fuct_id.ready
  mr_flr_cmd_ostd_fifo.io.push.valid   := mr_flr_cmd_fifo.io.pop.valid
  mr_flr_cmd_ostd_fifo.io.push.payload := mr_flr_cmd_fifo.io.pop.payload
  mr_flr_cmd_ostd_fifo.io.pop.ready   := mr_flr_cmd_fifo.io.pop.ready & io.mpt_mtt_flr_done
  // mr_flr_done_proc
  mr_flr_done_fifo.io.push.valid   := mr_flr_cmd_ostd_fifo.io.pop.valid & io.mpt_mtt_flr_done
  mr_flr_done_fifo.io.push.payload := mr_flr_cmd_ostd_fifo.io.pop.payload

  // qp_state_flr_cmd_pop

  // disable_cmd gen
  switch(cur_source_type) {
    is(FLRSourceType.QP) {
      max_ostd_num := FLR_QP_OST_TH
      destroy_type := QpStateDestryType.QP
    }
    is(FLRSourceType.SRQ) {
      max_ostd_num := FLR_SRQ_OST_TH
      destroy_type := QpStateDestryType.SRQ
    }
    is(FLRSourceType.CQ) {
      max_ostd_num := FLR_CQ_OST_TH
      destroy_type := QpStateDestryType.CQ
    }
    is(FLRSourceType.EQ) {
      max_ostd_num := FLR_EQ_OST_TH
      destroy_type := QpStateDestryType.EQ
    }
    default {
      max_ostd_num := 0
      destroy_type := QpStateDestryType.QP
    }
  }

  new_ostd_destroy_cmd                          := (destroy_ostd_cnt < max_ostd_num) & (destroy_cmd_sent_cnt < cur_slot_sum)
  io.qp_state_destroy_cmd.valid                 := qp_state_flr_cmd_fifo_pop.valid & (new_ostd_destroy_cmd)
  io.qp_state_destroy_cmd.payload.destroy_type  := destroy_type
  io.qp_state_destroy_cmd.payload.trans_id      := qp_state_flr_cmd_fifo_pop.trans_id
  io.qp_state_destroy_cmd.payload.queue_slot_id := cur_slot_id
  cur_slot_id                                   := slot_id_fifo.io.pop.payload

  // slot_id_buffer convert
  slot_ids_fifo.io.push        <> io.slot_id_buffer_push
  slot_id_fifo.io.push.valid   := slot_ids_fifo.io.pop.valid
  slot_id_fifo.io.push.payload := slot_ids_fifo.io.pop.payload.slot_ids.read(buffer_slot_id_pop_cnt)
  slot_ids_fifo.io.pop.ready   := slot_ids_fifo.io.push.ready & (buffer_slot_id_pop_cnt + 1 === slot_ids_fifo.io.pop.payload.vld_num)
  when(slot_id_fifo.io.push.fire) {
    when(buffer_slot_id_pop_cnt + 1 === slot_ids_fifo.io.pop.payload.vld_num) {
      buffer_slot_id_pop_cnt := 0
    } otherwise {
      buffer_slot_id_pop_cnt := buffer_slot_id_pop_cnt + 1
    }
  }

  slot_id_fifo.io.pop.ready := io.qp_state_destroy_cmd.fire // may be backpress

  // disable_done_proc
  qp_state_flr_done_fifo.io.push.valid   := io.qp_state_destroy_done & (destroy_done_cnt + 1 === cur_slot_sum)
  qp_state_flr_done_fifo.io.push.payload := qp_state_flr_cmd_fifo_pop.payload

  when(qp_state_flr_cmd_fifo_pop.fire) {
    destroy_cmd_sent_cnt := 0
  } elsewhen (io.qp_state_destroy_cmd.fire) {
    destroy_cmd_sent_cnt := destroy_cmd_sent_cnt + 1
  }

  when(io.qp_state_destroy_done) {
    when(destroy_done_cnt + 1 === cur_slot_sum) {
      destroy_done_cnt := 0
    } otherwise {
      destroy_done_cnt := destroy_done_cnt + 1
    }
  }

  qp_state_flr_cmd_ready := io.qp_state_destroy_done & (destroy_done_cnt + 1 === cur_slot_sum)

  when(io.qp_state_destroy_done) {
    when(~new_ostd_destroy_cmd) {
      destroy_ostd_cnt := destroy_ostd_cnt - 1
    }
  } elsewhen (io.qp_state_destroy_cmd.fire) {
    destroy_ostd_cnt := destroy_ostd_cnt + 1
  }

  // trans_id_fifo
  trans_id_fifo.io.push.valid   := io.flr_cmd_if.valid
  trans_id_fifo.io.push.payload := io.flr_cmd_if.payload.trans_id

  // flr done proc
  when(mr_flr_done_fifo.io.pop.valid & mr_flr_done_fifo.io.pop.trans_id === trans_id_fifo.io.pop.payload) {
    io.flr_done.source_type             := mr_flr_done_fifo.io.pop.source_type
    io.flr_done.trans_id                := mr_flr_done_fifo.io.pop.trans_id
    io.flr_done.valid                   := True
    mr_flr_done_fifo.io.pop.ready       := io.flr_done.ready
    qp_state_flr_done_fifo.io.pop.ready := False
    trans_id_fifo.io.pop.ready          := io.flr_done.ready
  } elsewhen (qp_state_flr_done_fifo.io.pop.valid & qp_state_flr_done_fifo.io.pop.trans_id === trans_id_fifo.io.pop.payload) {
    io.flr_done.source_type             := qp_state_flr_done_fifo.io.pop.source_type
    io.flr_done.trans_id                := qp_state_flr_done_fifo.io.pop.trans_id
    io.flr_done.valid                   := True
    qp_state_flr_done_fifo.io.pop.ready := io.flr_done.ready
    mr_flr_done_fifo.io.pop.ready       := False
    trans_id_fifo.io.pop.ready          := io.flr_done.ready
  } otherwise {
    io.flr_done.source_type             := FLRSourceType.QP
    io.flr_done.trans_id                := 0
    io.flr_done.valid                   := False
    qp_state_flr_done_fifo.io.pop.ready := False
    mr_flr_done_fifo.io.pop.ready       := False
    trans_id_fifo.io.pop.ready          := False
  }

}

object FLRRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(FLR())
}
