package PCIe

import spinal.core._
import spinal.lib._

case class pcie_tlp_fifo(tlpIfConfig: TlpIfConfig, inTlpSegCount: Int, outTlpSegCount: Int, depth:Int) extends Component {
  val io = new Bundle {
    val in_tlp:  Vec[Stream[TlpIf]] = Vec.fill(inTlpSegCount)(slave Stream (TlpIf(tlpIfConfig)))
    val out_tlp: Vec[Stream[TlpIf]] = Vec.fill(outTlpSegCount)(slave Stream (TlpIf(tlpIfConfig)))
  }
  noIoPrefix()
}
