package PCIe

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axilite.{AxiLite4, AxiLite4Config, AxiLite4SlaveFactory, AxiLite4SpecRenamer}

case class ExampleCore() extends Component {

  val axilConfig: AxiLite4Config = AxiLite4Config(
    addressWidth = 24,
    dataWidth    = 32
  )

  val io = new Bundle {
    val axil_ctrl: AxiLite4 = slave(AxiLite4(axilConfig))

  }

  AxiLite4SpecRenamer(io.axil_ctrl)
  val busCtrl = new AxiLite4SlaveFactory(io.axil_ctrl)

  val dma_en:         Bool = Bool() setAsReg () init (False)
  val dma_write_busy: Bool = Bool() setAsReg () init (False)
  val dma_read_busy:  Bool = Bool() setAsReg () init (False)

  val dma_rd_cpl_irq_en: Bool = Bool() setAsReg () init (False)
  val dma_wr_cpl_irq_en: Bool = Bool() setAsReg () init (False)

  busCtrl.readAndWrite(dma_en, 0x0000, 0)
  busCtrl.read(dma_write_busy, 0x0000, 8)
  busCtrl.read(dma_read_busy, 0x0000, 1)
  busCtrl.readAndWrite(dma_rd_cpl_irq_en, 0x0008, 0)
  busCtrl.readAndWrite(dma_wr_cpl_irq_en, 0x0008, 1)

}

object ExampleCoreRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen").generateVerilog(ExampleCore())
}
