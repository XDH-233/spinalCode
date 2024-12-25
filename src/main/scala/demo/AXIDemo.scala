package demo

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi._
import spinal.lib.bus.amba4.axis._
import tool.BusExt.{AXI4Ext, AXI4SExt}

case class AXIDemo() extends Component {
  val axi_config: Axi4Config =
    Axi4Config(addressWidth = 16, dataWidth = 32, idWidth = 3, useRegion = false, useLock = false, useCache = false, useQos = false, useProt = false)
  val axis_config: Axi4StreamConfig = Axi4StreamConfig(dataWidth = 4, useKeep = true, useLast = true,useId = true, idWidth = 8)

  val io = new Bundle {
    val axi4_s:  Axi4                     = slave(new Axi4(axi_config))
    val axi4s_s: Stream[Axi4Stream.Axi4StreamBundle] = slave (Axi4Stream(axis_config))
  }
  noIoPrefix()

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
//  io.axi4s_s.payload.setPartialName("")
//  io.axi4s_s.valid.setCompositeName(io.axi4s_s, postfix = "tvalid")
//  io.axi4s_s.ready.setCompositeName(io.axi4s_s, postfix = "tready")
//  io.axi4s_s.payload.elements.foreach{case(s,e) => e.setCompositeName(io.axi4s_s, postfix = "t"+e.name)}

  val reg: Bool = RegInit(False)
}

object AXIDemoRTL extends App {
  tool.GeneralConfig.rtlGenConfig("src/test/pyuvm/AXIDemo").generateVerilog(AXIDemo().setDefinitionName("axi_demo"))
}
