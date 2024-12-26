package demo

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi._
import spinal.lib.bus.amba4.axilite.{AxiLite4, AxiLite4Config}
import spinal.lib.bus.amba4.axis._
import spinal.lib.bus.regif.AccessType.RW
import spinal.lib.bus.regif.{AxiLite4BusInterface, RegInst}
import tool.BusExt.{AXI4Ext, AXI4SExt, AXILite4Ext}

import scala.language.postfixOps

case class AXIDemo() extends Component {
  private val axiConfig: Axi4Config =
    Axi4Config(addressWidth = 16, dataWidth = 32, idWidth = 3, useRegion = false, useLock = false, useCache = false, useQos = false, useProt = false)
  private val axisConfig: Axi4StreamConfig = Axi4StreamConfig(dataWidth = 4, useKeep = true, useLast = true, useId = true, idWidth = 8)

  private val axilConfig = AxiLite4Config(addressWidth = 32, dataWidth = 32)

  val io = new Bundle {
    val axi4_s:  Axi4                                = slave(new Axi4(axiConfig))
    val axi4s_s: Stream[Axi4Stream.Axi4StreamBundle] = slave(Axi4Stream(axisConfig))
    val axil_s:  AxiLite4                            = slave(AxiLite4(axilConfig))
  }
  noIoPrefix()
  val reg_field0 = RegInit(B(0x1234, 16 bits))
  val reg_field1 = RegInit(B(0xabcd, 16 bits))
  val bus_if: AxiLite4BusInterface = AxiLite4BusInterface(io.axil_s, (0x0000, 100 Byte))

  val REG0: RegInst = bus_if.newReg("RG0")

  REG0.registerInWithWriteLogic(reg_field0,RW, 0x1234,"REG0 filed0")
  REG0.registerInWithWriteLogic(reg_field1, RW, 0xabcd, "REG0 field1")

  io.axi4_s.aw.ready.set()
  io.axi4_s.w.ready.set()

  io.axi4_s.b.valid := RegNext(io.axi4_s.w.fire & io.axi4_s.w.last) init False
  io.axi4_s.b.payload.clearAll()
  io.axi4_s.b.payload.id.allowOverride()
  io.axi4_s.b.payload.id := RegNext(io.axi4_s.aw.id)
  io.axi4_s.ar.ready.set()
  io.axi4_s.r.valid.clear()
  io.axi4_s.r.payload.clearAll()

  io.axi4s_s.ready.set()
  io.axi4_s.setCocotbAxiNameStyle()
  io.axi4s_s.setCocotbAxisNameStyle()
  io.axil_s.setCocotbAxilNameStyle()

}

object AXIDemoRTL extends App {
  tool.GeneralConfig.rtlGenConfig("src/test/pyuvm/AXIDemo").generateVerilog(AXIDemo().setDefinitionName("axi_demo"))
}
