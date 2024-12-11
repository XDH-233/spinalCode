import spinal.core._
import spinal.lib._
import spinal.core.sim._
import spinal.lib.sim._
import spinal.lib.bus.avalon.sim.AvalonSTDriver
import spinal.lib.bus.avalon._
import tool.BusExt.AvstExt
import tool.BusExt.StreamBundleExt
import tool.BusExt.StreamExt

import scala.language.postfixOps

case class AvstArbiterDemo() extends Component {
  val config: AvalonSTConfig =
    AvalonSTConfig(useChannels = true, channelWidth = 25, useData = true, dataWidth = 16, useSOP = true, useEOP = true, useEmpty = true, emptyWidth = 1)

  val st_a, st_b, st_c: AvalonST = slave(AvalonST(config))

  val streamArbiter: StreamArbiter[AvalonSTPayload] = new StreamArbiter(AvalonSTPayload(config), 3)(StreamArbiter.Arbitration.roundRobin, tool.BusExt.avst_lock)
  streamArbiter.io.inputs.zip(Seq(st_a, st_b, st_c)).foreach { case (i: Stream[AvalonSTPayload], s: AvalonST) => s <> i.toAvalonSt(config) }

  val sel:   UInt                         = streamArbiter.io.output.payload.channel >> 16
  val demux: Vec[Stream[AvalonSTPayload]] = StreamDemux(streamArbiter.io.output, (sel - 1).resize(2), 3)

  val st_a_o, st_b_o, st_c_o = master(AvalonST(config))
  Seq(st_a_o, st_b_o, st_c_o).zip(demux).foreach { case (s, d) => s <> d.toAvalonSt(config) }
  Seq(st_a, st_b, st_c, st_a_o, st_b_o, st_c_o).foreach { s =>
    s.payload.setPartialName("")
    s.payload.sop.setPartialName("startofpacket")
    s.payload.eop.setPartialName("endofpacket")
  }
}

object StreamArbiterDemoApp extends App {

  tool.GeneralConfig.rtlGenConfig("verilogGen/avst_arbiter_lock").generateVerilog(AvstArbiterDemo())

//  SimConfig.withWave
//    .withConfig(
//      SpinalConfig(
//        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
//        defaultClockDomainFrequency  = FixedFrequency(100 MHz),
//        anonymSignalPrefix           = "tmp",
//        nameWhenByFile               = false,
//        withTimescale                = false
//      )
//    )
//    .compile(AvstArbiterDemo())
//    .doSim { dut =>
//      import dut._
//      dut.clockDomain.forkStimulus(10)
//      dut.clockDomain.waitSampling(1000)
//    }

}

object Example extends App {
  val dut = SimConfig.withWave.compile(StreamFifo(Bits(8 bits), 2))
  dut.doSim("simple test") { dut =>
    SimTimeout(10000)
    val scoreboard = ScoreboardInOrder[Int]()
    dut.io.flush #= false
    // drive random data and add pushed data to scoreboard
    StreamDriver(dut.io.push, dut.clockDomain) { payload =>
      payload.randomize()
      true
    }

    StreamMonitor(dut.io.push, dut.clockDomain) { payload =>
      scoreboard.pushRef(payload.toInt)
    }
    // randmize ready on the output and add popped data to scoreboard
    StreamReadyRandomizer(dut.io.pop, dut.clockDomain)
    StreamMonitor(dut.io.pop, dut.clockDomain) { payload =>
      scoreboard.pushDut(payload.toInt)
    }
    dut.clockDomain.forkStimulus(10)
    dut.clockDomain.waitActiveEdgeWhere(scoreboard.matches == 100)
  }
}
