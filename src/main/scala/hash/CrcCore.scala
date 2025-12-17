package hash

import spinal.core._

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

case class CRC(data_in: Bits, crc_ploy: Bits, crc_init: Bits, crc_result: Bits) extends Area {
  val dataWidth: Int = data_in.getWidth
  val crcWidth:  Int = crc_ploy.getWidth
  require(crc_init.getWidth == crcWidth && crc_result.getWidth == crcWidth)
  val crc_tmp_result: Vec[Bits] = Vec(Bits(crcWidth bits), dataWidth)
  for (index <- 0 until dataWidth) {
    val crc_core = CrcCore(
      polynomial   = crc_ploy,
      init_value   = if (index == 0) crc_init else crc_tmp_result(index - 1),
      data_in      = data_in(dataWidth - 1 - index),
      result_value = crc_tmp_result(index)
    )
  }
  crc_result := crc_tmp_result.last
}

case class CrcCal(dataWidth: Int, crcWidth: Int) extends Component {
  val io = new Bundle {
    val data_in:    Bits = in Bits (dataWidth bits)
    val crc_poly:   Bits = in Bits (crcWidth bits)
    val crc_init:   Bits = in Bits (crcWidth bits)
    val crc_result: Bits = out Bits (crcWidth bits)
  }
  noIoPrefix()
  val crc_tmp_result: Vec[Bits] = Vec(Bits(crcWidth bits), dataWidth)
  for (index <- 0 until dataWidth) {
    val crc_core = CrcCore(
      polynomial   = io.crc_poly,
      init_value   = if (index == 0) io.crc_init else crc_tmp_result(index - 1),
      data_in      = io.data_in(dataWidth - 1 - index),
      result_value = crc_tmp_result(index)
    )
  }
  io.crc_result := crc_tmp_result.last
}

object CrcCalRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(CrcCal(64, 8))
}
