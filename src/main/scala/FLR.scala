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

case class QPStateDestroyCmd() extends Bundle {
  val destroy_type  = QpStateDestryType()
  val trans_id      = UInt(16 bits)
  val queue_slot_id = UInt(24 bits)
}

case class SlotIdBufferMeta(max_slot_id_one_cycle: Int = 8) extends Bundle {
  val vld_num  = UInt(log2Up(max_slot_id_one_cycle) bits)
  val slot_ids = Vec.fill(max_slot_id_one_cycle)(UInt(24 bits))
}

case class FLR(buffer_row_slot_id_num: Int = 8) extends Component {

  val FLR_QP_OST_TH  = 16
  val FLR_SRQ_OST_TH = 16
  val FLR_CQ_OST_TH  = 16
  val LR_EQ_OST_TH   = 16

  val io = new Bundle {
    val flr_cmd_if            = slave Stream (FLRCmd())
    val slot_id_buffer_push   = slave Stream (SlotIdBufferMeta())
    val mpt_mtt_flr_fuct_id   = master Stream (UInt(16 bits))
    val mpt_mtt_flr_done      = in Bool ()
    val qp_state_destroy_cmd  = master Stream (QPStateDestroyCmd())
    val qp_state_destroy_done = in Bool ()
  }

  noIoPrefix()

  val slot_id_buffer            = new StreamFifo(SlotIdBufferMeta(), 128)
  val flr_cmd_fifo              = new StreamFifo(FLRCmd(), 16)
  val flr_cmd_fifo_pop_mr       = new Stream(FLRCmd())
  val flr_cmd_fifo_pop_qp_state = new Stream(FLRCmd())
  val qp_state_flr_cmd_ready    = Bool()
  val mr_flr_cmd_fifo           = new StreamFifo(FLRCmd(), 16)
  val mr_flr_done_fifo          = new StreamFifo(FLRCmd(), 16)
  val qp_state_flr_done_fifo    = new StreamFifo(FLRCmd(), 16)

  val cur_slot_id_valid    = Bool() setAsReg () init False
  val cur_source_type      = flr_cmd_fifo_pop_qp_state.payload.source_type
  val cur_slot_sum         = flr_cmd_fifo_pop_qp_state.payload.slot_id_cnt
  val destroy_cmd_sent_cnt = UInt(16 bits) setAsReg () init 0
  val destroy_done_cnt     = UInt(16 bits) setAsReg () init 0
  val cur_ostd_cnt         = UInt(16 bits) setAsReg () init 0
  val new_ostd_destroy_cmd = Bool()

  val max_ostd_num             = UInt(16 bits)
  val destroy_type             = QpStateDestryType()
  val cur_slot_id              = UInt(24 bits)
  val cur_slot_id_addr         = UInt(log2Up(buffer_row_slot_id_num) bits)
  val slot_id_bufer_pop        = Stream(SlotIdBufferMeta())
  val slot_id_buffer_poped_num = UInt(16 bits)

  io.flr_cmd_if <> flr_cmd_fifo.io.push

  // flr_cmd_fifo_pop mux
  flr_cmd_fifo_pop_mr.payload       := flr_cmd_fifo.io.pop.payload
  flr_cmd_fifo_pop_qp_state.payload := flr_cmd_fifo.io.pop.payload
  when(flr_cmd_fifo.io.pop.source_type === FLRSourceType.MR) {
    flr_cmd_fifo_pop_mr.valid       := flr_cmd_fifo.io.pop.valid
    flr_cmd_fifo.io.pop.ready       := io.mpt_mtt_flr_fuct_id.ready & mr_flr_cmd_fifo.io.push.ready
    flr_cmd_fifo_pop_qp_state.valid := False
  } otherwise {
    flr_cmd_fifo_pop_mr.valid       := False
    flr_cmd_fifo_pop_qp_state.valid := flr_cmd_fifo.io.pop.valid
    flr_cmd_fifo.io.pop.ready       := qp_state_flr_cmd_ready
  }

  // mr_flr_cmd_proc
  io.mpt_mtt_flr_fuct_id.valid    := flr_cmd_fifo_pop_mr.valid
  io.mpt_mtt_flr_fuct_id.payload  := flr_cmd_fifo_pop_mr.payload.function_id
  mr_flr_cmd_fifo.io.push.valid   := flr_cmd_fifo_pop_mr.valid
  mr_flr_cmd_fifo.io.push.payload := flr_cmd_fifo_pop_mr.payload

  // mr_flr_done_proc
  mr_flr_done_fifo.io.push.valid   := mr_flr_cmd_fifo.io.pop.valid & io.mpt_mtt_flr_done
  mr_flr_done_fifo.io.push.payload := mr_flr_cmd_fifo.io.pop.payload
  mr_flr_cmd_fifo.io.pop.ready     := mr_flr_done_fifo.io.push.ready & io.mpt_mtt_flr_done

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
      max_ostd_num := LR_EQ_OST_TH
      destroy_type := QpStateDestryType.EQ
    }
    default {
      max_ostd_num := 0
      destroy_type := QpStateDestryType.QP
    }
  }

  new_ostd_destroy_cmd                          := cur_slot_id_valid & (destroy_cmd_sent_cnt < max_ostd_num) & (destroy_cmd_sent_cnt < cur_slot_sum)
  io.qp_state_destroy_cmd.valid                 := qp_state_flr_done_fifo.io.pop.valid & (~cur_slot_id_valid | new_ostd_destroy_cmd)
  io.qp_state_destroy_cmd.payload.destroy_type  := destroy_type
  io.qp_state_destroy_cmd.payload.trans_id      := qp_state_flr_done_fifo.io.pop.payload.trans_id
  io.qp_state_destroy_cmd.payload.queue_slot_id := cur_slot_id
  cur_slot_id                                   := slot_id_buffer.io.pop.slot_ids.read(cur_slot_id_addr)
  cur_slot_id_addr                              := (destroy_cmd_sent_cnt - slot_id_buffer_poped_num).resized
  // disable_done_proc

  // slot_id_buffer free
  slot_id_buffer.io.push  <> io.slot_id_buffer_push
  slot_id_buffer.io.pop   <> slot_id_bufer_pop
  slot_id_bufer_pop.ready := ((slot_id_bufer_pop.vld_num + slot_id_buffer_poped_num) === destroy_cmd_sent_cnt + 1) & io.qp_state_destroy_done

}


object FLRRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(FLR())
}

