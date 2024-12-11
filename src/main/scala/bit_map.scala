import spinal.core._
import spinal.lib._

import scala.language.postfixOps

case class BitMapPort(num: Int) extends Bundle {
  val bit: Bool = Bool()
  val idx: UInt = UInt(log2Up(num) bits)
}

case class bit_map(num: Int) extends Component {
  val io = new Bundle {
    val op:      Flow[BitMapPort] = slave Flow(BitMapPort(num))
    val qry_idx: UInt             = in UInt (log2Up(num) bits)
    val qry_bit: Bool             = out Bool ()
  }

  val bit_maps: Vec[Bool] = Vec(Bool() setAsReg () init False, num)
  bit_maps.zipWithIndex.foreach { case (b, i) =>
    when(io.op.valid && io.op.idx === i) {
      b := io.op.bit
    }
  }

  io.qry_bit := bit_maps(io.qry_idx)
}
