package PCIe

import PCIe.PcieUsConfig.TlpFmt
import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axilite.{AxiLite4, AxiLite4Config, AxiLite4SlaveFactory, AxiLite4SpecRenamer}
import spinal.lib.slave

import scala.math.ceil
import scala.language.postfixOps

case class MSIXTableEntry() extends Bundle {
  val irq_addr: UInt = UInt(64 bits)
  val msg_data = new Bundle {
    val vec: UInt = UInt(8 bits)
    val rsv: Bits = Bits(24 bits)
  }
  val masked: Bool = Bool()
  val rsv:    Bits = Bits(31 bits)
}

case class PCIeMSIX(msixNum: Int = 32) extends Component {
  val axilConfig: AxiLite4Config = AxiLite4Config(
    addressWidth = 16,
    dataWidth    = 32
  )
  val io = new Bundle {
    val axil_msix: AxiLite4 = slave(AxiLite4(axilConfig))

    val irq: Stream[UInt] = slave Stream (UInt(log2Up(msixNum) bits))

    val tx_wr_req_tlp: Stream[TlpIf] = master Stream (TlpIf(TlpIfConfig(32)))
  }

  noIoPrefix()

  AxiLite4SpecRenamer(io.axil_msix)

  val bus_slave: AxiLite4SlaveFactory = AxiLite4SlaveFactory(io.axil_msix)

  val msix_entries:   Vec[Bits]      = Vec.fill(msixNum)(Bits(128 bits) setAsReg () init (0)) //use regs vector is msixNum not big
  val pbaae_num:      Int            = scala.math.ceil(msixNum.toDouble / 64).toInt
  val pba_entries:    Vec[Bits]      = Vec.fill(pbaae_num)(Bits(64 bits) setAsReg () init (0))
  val irq_msix_entry: MSIXTableEntry = MSIXTableEntry()
  val irq_masked:     Bool           = irq_msix_entry.masked

  msix_entries.zipWithIndex.foreach { case (e, i) => bus_slave.readAndWriteMultiWord(msix_entries(i), i << 4) }
  pba_entries.zipWithIndex.foreach { case (e, i) => bus_slave.readMultiWord(pba_entries(i), 0x800 + i * (8)) }
  irq_msix_entry.assignFromBits(msix_entries.read(io.irq.payload))

  io.tx_wr_req_tlp.data := irq_msix_entry.msg_data.asBits
  io.tx_wr_req_tlp.strb := 1
  io.tx_wr_req_tlp.sop.set()
  io.tx_wr_req_tlp.eop.set()
  io.tx_wr_req_tlp.hdr.clearAll()
  io.tx_wr_req_tlp.hdr.allowOverride()
  io.tx_wr_req_tlp.hdr.length       := 1
  io.tx_wr_req_tlp.hdr.requested_id := 0 // TODO
  io.tx_wr_req_tlp.hdr.first_dw_be  := 0xf
  when(irq_msix_entry.irq_addr.takeHigh(32).orR) {
    io.tx_wr_req_tlp.hdr.fmt     := TlpFmt.FMT_4DW_DATA
    io.tx_wr_req_tlp.hdr.address := irq_msix_entry.irq_addr.takeHigh(62)
  } otherwise {
    io.tx_wr_req_tlp.hdr.fmt     := TlpFmt.FMT_3DW_DATA
    io.tx_wr_req_tlp.hdr.address := irq_msix_entry.irq_addr(2, 30 bits) ## B(0, 32 bits)
  }

  //TODO
  io.irq.ready.set()
  io.tx_wr_req_tlp.valid.clear()

  io.tx_wr_req_tlp.payload.setPartialName("")
}

object PCIeMSIXRTL extends App {
  tool.GeneralConfig.rtlGenConfig("src/test/pyuvm/pcie_msix").generateVerilog(PCIeMSIX().setDefinitionName("pcie_msix"))
}
