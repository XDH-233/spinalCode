package tool

import spinal.core._
import spinal.lib.bus.avalon._
import spinal.lib.bus.misc.SizeMapping
import spinal.lib.bus.regif._

import scala.language.postfixOps

class AvalonMMBusInterface(avmm_bus: AvalonMM, sizeMap: SizeMapping, pre: String = "")(implicit moduleName: ClassName) extends BusIf {
  override def getModuleName: String = moduleName.name

  override val bus:             Bundle  = avmm_bus
  override val regPre:          String  = pre
  override val busDataWidth:    Int     = avmm_bus.config.dataWidth
  override val busAddrWidth:    Int     = avmm_bus.config.addressWidth
  override val askWrite:        Bool    = avmm_bus.write
  override val askRead:         Bool    = avmm_bus.read
  override val doWrite:         Bool    = avmm_bus.write
  override val doRead:          Bool    = avmm_bus.read
  override val bus_rderr:       Bool    = Bool()
  override val bus_rdata:       Bits    = Bits(busDataWidth bits)
  override val reg_rderr:       Bool    = RegNext(bus_rderr) init(False)
  override val reg_rdata:       Bits    = RegNext(bus_rdata) init (0)
  override val writeData:       Bits    = avmm_bus.writeData
  override val withStrb:        Boolean = avmm_bus.config.useByteEnable
  override val withSecFireWall: Boolean = false
  override val wstrb:           Bits    = avmm_bus.byteEnable
  override val wmask:           Bits    = B(1)
  override val wmaskn:          Bits    = B(1)

  avmm_bus.readDataValid := RegNext(doRead) init False
  avmm_bus.readData      := reg_rdata
  avmm_bus.waitRequestn  := ~(doRead | doWrite)

  override def readAddress(): UInt = avmm_bus.address

  override def writeAddress(): UInt = avmm_bus.address

  override def readHalt(): Unit = avmm_bus.waitRequestn := True

  override def writeHalt(): Unit = avmm_bus.waitRequestn := True

}
