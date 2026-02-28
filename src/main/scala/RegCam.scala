import spinal.core._
import spinal.lib._

import scala.language.postfixOps

case class CamEntry(width: Int) extends Bundle {
  val data: Bits = Bits(width bits)
  val vld:  Bool = Bool()

}

case class RegCam(width: Int, Depth: Int) extends Component {
  val io = new Bundle {
    val query:          Flow[Bits] = slave Flow (Bits(width bits))
    val exist:          Bool       = out Bool ()
    val insert:         Flow[Bits] = slave Flow (Bits(width bits))
    val insert_success: Bool       = out Bool ()
    val clear:          Flow[Bits] = slave Flow (Bits(width bits))
    val clear_success:  Bool       = out Bool ()
  }

  noIoPrefix()

  val regs: Vec[Bits] = Vec.fill(Depth)(Reg(Bits(width + 1 bits)) init (0))

  val entrs = Vec.fill(Depth)(CamEntry(width))

  val vlds:             Vec[Bool] = Vec.fill(Depth)(Bool())
  val vlds_bits:        Bits      = vlds.asBits
  val plus_one:         Bits      = (vlds_bits.asUInt + 1).asBits
  val low_zero_one_hot: Vec[Bool] = ((plus_one ^ vlds_bits) & plus_one).asBools
  val avail:            UInt      = OHToUInt(low_zero_one_hot.asBits)
  val full:             Bool      = vlds.asBits.andR
  val qry_exist = qry(io.query.payload)
  val clr_exist = qry(io.clear.payload)

  io.exist := RegNext(qry_exist.exist & io.query.valid) init False

  vlds.zip(regs).foreach { case (v, r) => v := r.lsb }
  entrs.zip(regs).foreach { case (e, r) =>
    e.data := r(1, width bits)
    e.vld  := r.lsb
  }

  regs.zip(low_zero_one_hot).foreach { case (r, l) =>
    when(io.clear.valid & io.clear.payload === r(1, width bits) & r.lsb) {
      r := r(1, width bits) ## B(1 bits, default -> False)
    } elsewhen (io.insert.valid & ~full & l) {
      r := io.insert.payload ## B(1 bits, default -> True)
    }// clear and insert a same entry is illegal

  }

  io.insert_success := RegNext(io.insert.valid & ~full) init False
  io.clear_success  := RegNext(io.clear.valid & clr_exist.exist) init False

  private def qry(b: Bits) = new Area {
    val exists: Vec[Bool] = Vec.fill(Depth)(Bool())
    exists.zip(regs).foreach { case (e, r) =>
      val entry = CamEntry(width)
      entry.data := r(1, width bits)
      entry.vld  := r.lsb
      e          := r.lsb & (entry.data === b)
    }
    val exist: Bool = exists.asBits.orR

  }

}

object TCAMRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(RegCam(15, 8))
}
