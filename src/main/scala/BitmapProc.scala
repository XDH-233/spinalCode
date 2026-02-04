import spinal.core._
import spinal.core.sim._
import spinal.lib
import spinal.lib._

import scala.language.postfixOps

case class BitmapProc(btm_w: Int = 128) extends Component {
  val io = new Bundle {
    val bitmap_in: Stream[Bits] = slave Stream (Bits(btm_w bits))
    val index_out: Stream[UInt] = master Stream (UInt(log2Up(btm_w) bits))
  }

  noIoPrefix()

  val fifo: StreamFifo[Bits] = StreamFifo(Bits(btm_w bits), btm_w)

//  val one_hots = Vec.fill(btm_w)(Bits(btm_w bits))
//  val ids      = one_hots.map(oht => OHToUInt(oht))

  val bitmap_tmp      = Bits(btm_w bits) setAsReg () init 0
  val bitmap_reg_sent = Bits(btm_w bits) setAsReg () init 0
  val bitmap_reg_vld  = Bool() setAsReg () init False

  val fifo_pop_pipe: Stream[Bits] = fifo.io.pop.m2sPipe()
//  val id_num   = CountOne(fifo_pop_pipe.payload)
//  fifo_pop_pipe.payload.asBools.zip(one_hots.zipWithIndex).foreach { case (p, (oht, i)) => oht := (i -> p, default -> false) }

  val btm_low_1_one_hot = ((bitmap_tmp.asUInt - 1).asBits ^ bitmap_tmp) & bitmap_tmp
  val btm_low_1_idx     = OHToUInt(btm_low_1_one_hot)
  val will_done         = ~((btm_low_1_one_hot ^ bitmap_reg_sent) ^ fifo_pop_pipe.payload).orR
  io.bitmap_in <> fifo.io.push

  io.index_out.payload := btm_low_1_idx
  io.index_out.valid   := bitmap_reg_vld
  fifo_pop_pipe.ready    := will_done & io.index_out.ready & bitmap_reg_vld

  when(~bitmap_reg_vld) {
    bitmap_tmp      := fifo_pop_pipe.payload
    bitmap_reg_vld  := fifo_pop_pipe.valid
    bitmap_reg_sent := 0
  } elsewhen (io.index_out.fire) {
    when(will_done) {
      bitmap_reg_vld  := fifo.io.pop.valid
      bitmap_tmp      := fifo.io.pop.payload
      bitmap_reg_sent := 0
    } otherwise {
      bitmap_tmp      := fifo_pop_pipe.payload ^ btm_low_1_one_hot ^ bitmap_reg_sent
      bitmap_reg_sent := btm_low_1_one_hot ^ bitmap_reg_sent
    }
  }

}

object BitmapProcRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(BitmapProc(8))
}

