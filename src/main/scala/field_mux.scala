import spinal.core._
import spinal.lib._
import tool.GeneralConfig

import scala.language.postfixOps

case class Load(num: Int, width: Int) extends Bundle {
  val sel: UInt = UInt(log2Up(num) bits)
  val dat: Bits = Bits(width bits)
}

case class field_mux(num: Int, width: Int) extends Component {
  val io = new Bundle {
    val load: Flow[Load] = slave Flow(Load(num, width))
    val sel:  UInt       = in UInt (log2Up(num) bits)
    val dat:  Bits       = out Bits (width bits)
  }

  val fields: Vec[Bits] = Vec(Bits(width bits) setAsReg () init (0), num)
  fields.zipWithIndex.foreach { case (f, i) =>
    when(io.load.sel === i && io.load.valid)(f := io.load.dat)
  }

  io.dat := fields(io.sel)

}

object field_mux_rlt extends App {
  GeneralConfig.rtlGenConfig("./").generateVerilog(field_mux(32, 73))
}
