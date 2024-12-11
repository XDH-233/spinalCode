package exercise

import spinal.core._
import spinal.lib._

import scala.language.postfixOps

case class SideBand(packetLength: Int) extends Bundle {
  val sof, eof: Bool = Bool()
  val len:      UInt = UInt(log2Up(packetLength) bits)
}
