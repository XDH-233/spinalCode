import spinal.core._
import spinal.lib._

import scala.language.postfixOps

case class SidBuf(sid_width: Int = 15) extends Bundle {
  val slot_id: UInt = UInt(sid_width bits)
  val last:    Bool = Bool()
}

case class BitmapIn(dw: Int = 192 * 8, sid_width: Int = 15) extends Bundle {
  val bitmap:           Bits = Bits(dw bits)
  val last:             Bool = Bool()
  val cur_sto_id_start: UInt = UInt(sid_width bits)
  val cur_sto_id_end:   UInt = UInt(sid_width bits)
}

case class slot_bitmap_proc(dw: Int = 192 * 8, segment_width: Int = 128, sid_width: Int = 15) extends Component {
  val io = new Bundle {
    val bitmap_in:    Stream[BitmapIn] = slave Stream (BitmapIn(dw, sid_width))
    val slot_id_info: Stream[SidBuf]   = master Stream (SidBuf(sid_width))
  }

  noIoPrefix()

  val bitmap_fifo:     StreamFifo[Bits] = StreamFifo(Bits(io.bitmap_in.payload.getBitsWidth bits), 8)
  val bitmap_fifo_pop: Stream[BitmapIn] = Stream(BitmapIn(dw, sid_width))
  val slot_id_fifo:    StreamFifo[Bits] = StreamFifo(Bits(sid_width + 1 bits), sid_width) // TODO: to segment_width

  bitmap_fifo.io.push.valid   := io.bitmap_in.valid
  bitmap_fifo.io.push.payload := io.bitmap_in.payload.asBits
  io.bitmap_in.ready          := bitmap_fifo.io.push.ready
  bitmap_fifo_pop.valid       := bitmap_fifo.io.pop.valid
  bitmap_fifo.io.pop.ready    := bitmap_fifo_pop.ready

  bitmap_fifo_pop.payload.assignFromBits(bitmap_fifo.io.pop.payload)

  val bitmap_reg_vld:          Bool = Bool() setAsReg () init (False)
  val bitmap_reg:              Bits = Bits(dw bits) setAsReg ()
  val bitmap_seg:              Bits = Mux(bitmap_reg_vld, bitmap_reg.takeLow(segment_width), bitmap_fifo_pop.bitmap.takeLow(segment_width))
  val bitmap_seg_reg:          Bits = Bits(segment_width bits) setAsReg ()
  val bitmap_seg_reg_vld:      Bool = Bool() setAsReg () init (False)
  val bitmap_seg_proc:         Bits = Mux(bitmap_seg_reg_vld, bitmap_seg_reg, bitmap_seg)
  val bitmap_seg_proc_minus_1: Bits = (bitmap_seg_proc.asSInt - 1).asBits
  val low_1_one_hot:           Bits = (bitmap_seg_proc ^ bitmap_seg_proc_minus_1) & bitmap_seg_proc
  val low_1_index:             UInt = OHToUInt(low_1_one_hot)
  val bitmap_seg_next:         Bits = bitmap_seg_proc ^ low_1_one_hot
  val shift_en:                Bool = ~bitmap_seg_next.orR & slot_id_fifo.io.push.ready
  val seg_start_id_reg:        UInt = UInt(sid_width bits) setAsReg ()
  val seg_start_id:            UInt = UInt(sid_width bits)
  val slot_id_out:             UInt = (seg_start_id + low_1_index.resized)
  val bitmap_end:              Bool = (seg_start_id + segment_width >= bitmap_fifo_pop.cur_sto_id_end)

  when(slot_id_fifo.io.push.ready) {
    bitmap_seg_reg := bitmap_seg_next
  }

  when(shift_en) {
    when(bitmap_end) {
      bitmap_reg_vld := False
    } otherwise {
      bitmap_reg_vld := bitmap_fifo_pop.valid
    }
  }

  when(bitmap_seg_reg_vld) {
    when(shift_en) {
      bitmap_seg_reg_vld := False
    }
  } otherwise {
    bitmap_seg_reg_vld := bitmap_fifo_pop.valid & slot_id_fifo.io.push.ready
  }

  when(shift_en) {
    bitmap_seg_reg_vld := False
  } otherwise {
    bitmap_seg_reg_vld := bitmap_fifo_pop.valid
  }

  when(shift_en) {
    bitmap_reg := Mux(bitmap_reg_vld, bitmap_reg |>> segment_width, bitmap_fifo_pop.bitmap |>> segment_width)
  }

  when(shift_en) {
    when(bitmap_reg_vld) {
      seg_start_id_reg := seg_start_id_reg + segment_width
    } otherwise {
      seg_start_id_reg := bitmap_fifo_pop.cur_sto_id_start + segment_width
    }
  }

  seg_start_id := Mux(bitmap_reg_vld, seg_start_id_reg, bitmap_fifo_pop.cur_sto_id_start)

  bitmap_fifo_pop.ready := slot_id_fifo.io.push.ready & bitmap_end & shift_en

  val slot_id_buf: SidBuf = SidBuf(sid_width)
  slot_id_buf.slot_id := slot_id_out
  slot_id_buf.last    := bitmap_fifo_pop.last & shift_en & bitmap_end

  slot_id_fifo.io.push.valid   := bitmap_fifo_pop.valid
  slot_id_fifo.io.push.payload := slot_id_buf.asBits

  io.slot_id_info.valid     := slot_id_fifo.io.pop.valid
  slot_id_fifo.io.pop.ready := io.slot_id_info.ready
  io.slot_id_info.payload.assignFromBits(slot_id_fifo.io.pop.payload)

}

object slot_bitmap_procRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(slot_bitmap_proc(64, 16, 15))
}
