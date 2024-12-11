package demo

import spinal.core._
import spinal.lib._

import scala.language.postfixOps

case class OneHot2UIntDemo() extends Component {
  val io = new Bundle {
    val din:        Bits = in Bits (128 bits);
    val oneHot2Bin: UInt = out UInt (log2Up(din.getWidth) bits)
  }

  io.oneHot2Bin := OHToUInt(io.din)
}

import spinal.core.sim._
object OneHot2UIntDemoSim extends App {
  val spinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
    defaultClockDomainFrequency = FixedFrequency(100 MHz),
    nameWhenByFile = false,
    anonymSignalPrefix = "tmp"
  )
  SimConfig.withConfig(spinalConfig).withWave.compile(OneHot2UIntDemo()).doSim { dut =>


  }
}
