package exercise

import spinal.core._
import spinal.lib._
import spinal.core.sim._

import scala.language.postfixOps

case class DataInterface(busWidth: Int, byteWidth: Int, maxLength: Int) extends Bundle with IMasterSlave {

  val data:         Bits     = Bits(busWidth bits)
  val valid, ready: Bool     = Bool()
  val sop, eop:     Bool     = Bool()
  val mty:          UInt     = UInt(log2Up(busWidth / byteWidth) bits)
  val sbd:          SideBand = SideBand(maxLength)

  override def asMaster(): Unit = {
    out(data, valid, sop, eop, mty, sbd)
    in(ready)
  }

  def sofSop: Bool = sbd.sof & sop
  def eofEop: Bool = sbd.eof & eop
  def sofEop: Bool = sbd.sof & eop

  def fire: Bool = valid & ready

}
