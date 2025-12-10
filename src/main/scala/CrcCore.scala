import spinal.core._
import spinal.core.sim._

import scala.language.postfixOps

case class CrcCore(polynomial: Bits, init_value: Bits, data_in: Bool, result_value: Bits) extends Area {
  require(polynomial.getBitsWidth == init_value.getBitsWidth)
  require(polynomial.getBitsWidth == result_value.getBitsWidth)
  val data_in_xor: Bool = data_in ^ init_value.msb
  //bit 0 result
  result_value(0) := data_in_xor
  //the other bits
  for (index <- 1 until polynomial.getWidth) {
    result_value(index) := (data_in_xor && polynomial(index)) ^ init_value(index - 1)
  }
}

case class CRC(dataWidth: Int, crcWidth: Int) extends Component {
  val io = new Bundle {
    val data_in:    Bits = in Bits (dataWidth bits)
    val crc_ploy:   Bits = in Bits (crcWidth bits)
    val crc_init:   Bits = in Bits (crcWidth bits)
    val crc_result: Bits = out Bits (crcWidth bits)
  }
  noIoPrefix()
  val crc_tmp_result: Vec[Bits] = Vec(Bits(crcWidth bits), dataWidth)
  for (index <- 0 until dataWidth) {
    val crc_core = CrcCore(
      polynomial   = io.crc_ploy,
      init_value   = if (index == 0) io.crc_init else crc_tmp_result(index - 1),
      data_in      = io.data_in(dataWidth - 1 - index),
      result_value = crc_tmp_result(index)
    )
  }
  io.crc_result := crc_tmp_result.last
}

case class CrcCal(dataWidth: Int, crcWidth: Int) extends Component {
  val io = new Bundle {
    val data_in:    Bits = in Bits (dataWidth bits)
    val crc_ploy:   Bits = in Bits (crcWidth bits)
    val crc_init:   Bits = in Bits (crcWidth bits)
    val crc_result: Bits = out Bits (crcWidth bits)
  }
  noIoPrefix()
  val crc_tmp_result: Vec[Bits] = Vec(Bits(crcWidth bits), dataWidth)
  for (index <- 0 until dataWidth) {
    val crc_core = CrcCore(
      polynomial   = io.crc_ploy,
      init_value   = if (index == 0) io.crc_init else crc_tmp_result(index - 1),
      data_in      = io.data_in(dataWidth - 1 - index),
      result_value = crc_tmp_result(index)
    )
  }
  io.crc_result := crc_tmp_result.last
}

object CrcCalSim extends App {
  SimConfig.withWave
    .withConfig(
      SpinalConfig(
        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
        defaultClockDomainFrequency  = FixedFrequency(100 MHz)
      )
    )
    .compile(new CrcCal(32, 32))
    .doSim { dut =>
      import dut._
      dut.clockDomain.forkStimulus(10)
      io.crc_init.randomize()
      io.crc_ploy.randomize()
      (0 until 100).foreach{_=>
        io.data_in.randomize()
        dut.clockDomain.waitSampling()
      }

    }

}
