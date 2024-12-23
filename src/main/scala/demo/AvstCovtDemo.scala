package demo

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.bus.avalon._
import tool.BusExt.AvstExt

import scala.language.postfixOps

case class AvstCovtDemo() extends Component {
  val config: AvalonSTConfig = AvalonSTConfig(
    useChannels  = true,
    channelWidth = 128,
    useData      = true,
    dataWidth    = 512,
    useSOP       = true,
    useEOP       = true,
    useEmpty     = true,
    emptyWidth   = 6
  )
  val e_config: AvalonSTConfig = AvalonSTConfig(
    useChannels  = true,
    channelWidth = 128,
    useData      = true,
    dataWidth    = 128,
    useSOP       = true,
    useEOP       = true,
    useEmpty     = true,
    emptyWidth   = 4
  )
  val io = new Bundle {
    val avst_in: AvalonST = slave(AvalonST(config))
    val avst_e_in: AvalonST = slave(AvalonST(e_config))
    val avst_out: AvalonST = master(avst_in.divide(4))
    val avst_e_out: AvalonST = master(avst_e_in.expand(4))
//    val avst_e_out: AvalonST = master(AvstExpand(asvst_e_in, 4).ret)
  }
  noIoPrefix()
//  val avstExpand = AvstExpand(io.asvst_e_in, 4)
//  avstExpand.ret.ready.set()
}

object AvstCovtDemoApp extends App {
//  tool.GeneralConfig.rtlGenConfig("verilogGen").generateVerilog(AvstCovtDemo())
  SimConfig.withFstWave
    .withConfig(
      SpinalConfig(
        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
        anonymSignalPrefix           = "tmp",
        nameWhenByFile               = false,
        withTimescale                = false
      )
    )
    .compile(AvstCovtDemo())
    .doSim { dut =>
      import dut._
      dut.clockDomain.forkStimulus(10)
//      io.asvst_in.valid #= false
//      io.avst_out.ready #= true
//      clockDomain.waitSampling(100)
//      io.asvst_in.valid       #= true
//      io.asvst_in.payload.sop #= true
//      io.asvst_in.payload.data.randomize()
//      io.asvst_in.payload.eop   #= false
//      io.asvst_in.payload.empty #= 0
//      clockDomain.waitSampling(4)
//      io.asvst_in.payload.sop #= false
//      (0 until 3).foreach { _ =>
//        io.asvst_in.payload.data.randomize()
//        clockDomain.waitSampling(4)
//      }
//      io.asvst_in.payload.eop   #= true
//      io.asvst_in.payload.empty #= 12
//      io.asvst_in.payload.data.randomize()
//      clockDomain.waitSampling(4)
//      io.asvst_in.valid         #= false
//      io.asvst_in.payload.eop   #= false
//      io.asvst_in.payload.empty #= 0
//      io.asvst_in.payload.data  #= 0
      clockDomain.waitSampling(100)
    }
}
