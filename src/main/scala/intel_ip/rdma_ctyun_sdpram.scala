package intel_ip

import spinal.core._
import spinal.lib._

import scala.language.postfixOps

case class SdpPort(dataWidth: Int, addrWidth: Int) extends Bundle with IMasterSlave {
  val wren:      Bool = Bool()
  val rden:      Bool = Bool()
  val byteena:   Bits = Bits((dataWidth + 7) / 8 bits)
  val din:       Bits = Bits(dataWidth bits)
  val rdaddress: UInt = UInt(addrWidth bits)
  val wraddress: UInt = UInt(addrWidth bits)
  val dout:      Bits = Bits(dataWidth bits)

  override def asMaster(): Unit = {
    out(wren, rden, byteena, din, rdaddress, wraddress)
    in(dout)
  }

}

/** @param dw
  *   data width
  * @param aw
  *   addr width
  * @param rdLatency
  *   read latency: 1 or 2
  * @param ramType
  *   AUTO, M20K, MLAB; MLAB is unavailable if WR_DATA_WIDTH != RD_DATA_WIDTH
  * @param ruwPolicy
  *   OLD_DATA, DONT_CARE or NEW_DATA; NEW_DATA is available only when use MLAB or AUTO
  * @param initFile
  */
case class rdma_ctyun_sdpram(dw: Int, aw: Int, rdLatency: Int = 2, ramType: String = "AUTO", ruwPolicy: String = "OLD_DATA", initFile: String = "")
    extends BlackBox {
  val io = new Bundle {
    val clock:    Bool    = in Bool ()
    val ram_port: SdpPort = slave(SdpPort(dw, aw)).setPartialName("")
  }
  var latency: Int = rdLatency
  noIoPrefix()
  mapClockDomain(clock = io.clock)
  addGenerics(
    ("WR_ADDR_WIDTH", aw),
    ("RD_ADDR_WIDTH", aw),
    ("WR_DATA_WIDTH", dw),
    ("RD_DATA_WIDTH", dw),
    ("READ_LATENCY", latency),
    ("RAM_TYPE", ramType),
    ("READ_DURING_WRITE", ruwPolicy),
    ("INIT_FILE", initFile)
  )

  def write(wr: Bool, addr: UInt, din: Bits): Unit = {
    io.ram_port.wren      := wr
    io.ram_port.wraddress := addr
    io.ram_port.din       := din
    io.ram_port.byteena   := B((din.getBitsWidth + 7) / 8 bits, default -> True)
  }

  def read(rd: Bool, addr: UInt): Bits = {
    io.ram_port.rden      := rd
    io.ram_port.rdaddress := addr
    io.ram_port.dout
  }

  addRTLPath("ipSimModel/ALTERA_LNSIM_MEMORY_INITIALIZATION.sv")
  addRTLPath("ipSimModel/altera_syncram.sv")
  addRTLPath("src/main/scala/intel_ip/rdma_ctyun_sdpram.v")
}

object rdma_ctyun_sdpram {
  def apply[T <: Data](dataType: HardType[T], aw: Int, rdLatency: Int, ramType: String, ruwPolicy: String, initFile: String): rdma_ctyun_sdpram =
    new rdma_ctyun_sdpram(dataType.getBitsWidth, aw, rdLatency, ramType, ruwPolicy, initFile)
  def ctyunSdpRamFactory: CtyunSdpRamFactory = CtyunSdpRamFactory()
}

case class CtyunSdpRamFactory() {
  private var ram_buf: List[rdma_ctyun_sdpram] = List()
  var ramTyte              = "AUTO"
  var readUnderWritePolicy = "OLD_DATA"
  var rdLatency            = 2
  var dataWdith            = 8

  private def build[T <: Data](dataType: HardType[T], depth: Int): rdma_ctyun_sdpram = {
    rdma_ctyun_sdpram(dw = dataType.getBitsWidth, aw = log2Up(depth), rdLatency = rdLatency, ramType = ramTyte, ruwPolicy = readUnderWritePolicy)
  }
  def write[T <: Data](wr: Bool, waddr: UInt, din: T): CtyunSdpRamFactory = {
    dataWdith = din.getBitsWidth
    val newRam = build(din, 1 << waddr.getBitsWidth).setName(din.name + "_ram")
    ram_buf = newRam :: ram_buf
    ram_buf.head.write(wr, waddr, din.asBits)
    this
  }

  def read(rd: Bool, raddr: UInt): Bits = {
    val dout: Bits = ram_buf.head.read(rd, raddr)
    dout
  }

  def useMLAB = {
    ramTyte = "MLAB"
    this
  }
  def useM20K = {
    ramTyte = "M20K"
    this
  }
  def readOldData = {
    readUnderWritePolicy = "OLD_DATA"
    this
  }
  def readNewData = {
    readUnderWritePolicy = "NEW_DATA"
    this
  }
  def doNotCare = {
    readUnderWritePolicy = "DONT_CARE"
    this
  }
  def setLatency(l: Int) = {
    rdLatency = l
    this
  }
}


import rdma_ctyun_sdpram._
import spinal.core.sim._

case class sto() extends Bundle {
  val a: Bits = Bits(8 bits)
  val b: Bits = Bits(8 bits)
  val c: Bool = Bool()
}
case class RAMDemo() extends Component {
  val io = new Bundle {
    val wr    = in Bool ()
    val waddr = in UInt (8 bits)
    val wdata = in(sto())
    val rd    = in Bool ()
    val raddr = in UInt (8 bits)
    val rdata = out(sto())
  }
  noIoPrefix()
  io.rdata.assignFromBits(ctyunSdpRamFactory.useMLAB.readNewData.setLatency(1).write(io.wr, io.waddr, io.wdata).read(io.rd, io.raddr))
}

object RAMDemoSim extends App {

  tool.GeneralConfig.verilatorSimConfig
    .compile(RAMDemo())
    .doSim { dut =>
      import dut._
      dut.clockDomain.forkStimulus(10)

    }
}
