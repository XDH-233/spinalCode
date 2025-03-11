import spinal.core._
import spinal.lib._

case class fifo(dw: Int, dp: Int) extends Component {
  val io = new Bundle {
    val fifo_error_enable = in Bool ()
    val core_clock        = in Bool ()
    val data              = in Bits (dw bits)
    val wrreq             = in Bool ()
    val rdreq             = in Bool ()
    val clock             = in Bool ()
    val aclr              = in Bool ()
    val sclr              = in Bool ()
    val q                 = out Bits (dw bits)
    val full              = out Bool ()
    val empty             = out Bool ()
    val perror            = out Bool ()
    val almost_full       = out Bool ()
    val almostfull        = out Bool ()
  }

  noIoPrefix()

  val cld = ClockDomain(io.clock, io.aclr)

  val cldArea = new ClockingArea(cld) {
    val stream_fifo = new StreamFifo(Bits(dw bits), dp)
    stream_fifo.io.push.valid   := io.wrreq
    stream_fifo.io.push.payload := io.data
    io.full                     := ~stream_fifo.io.push.ready
    stream_fifo.io.pop.ready    := io.rdreq
    io.q                        := stream_fifo.io.pop.payload
    io.empty                    := ~stream_fifo.io.pop.valid
    io.almost_full.clear()
    io.almostfull.clear()
    io.perror.clear()
  }

}



case class dcfifo(dw: Int, dp: Int) extends Component {
  val io = new Bundle {
    val fifo_error_enable = in Bool ()
    val core_clock        = in Bool ()
    val data              = in Bits (dw bits)
    val wrreq             = in Bool ()
    val rdreq             = in Bool ()
    val wrclk             = in Bool ()
    val rdclk_srstn       = in Bool ()
    val wrclk_srstn       = in Bool ()
    val rdclk             = in Bool ()
    val aclr              = in Bool ()
    val q                 = out Bits (dw bits)
    val full              = out Bool ()
    val empty             = out Bool ()
    val perror            = out Bool ()
    val fault             = out Bool ()
    val almost_full       = out Bool ()
  }
  noIoPrefix()

  val wrCld = ClockDomain(io.wrclk, io.wrclk_srstn, config = ClockDomainConfig(resetActiveLevel = LOW))
  val rdCld = ClockDomain(io.rdclk, io.rdclk_srstn, config = ClockDomainConfig(resetActiveLevel = LOW))

  val push = Stream(Bits(dw bits))
  val pop  = Stream(Bits(dw bits))

  val fifo_cc = StreamFifoCC(push, pop, dp, wrCld, rdCld)

  push.valid   := io.wrreq
  push.payload := io.data
  io.full      := ~push.ready
  io.empty     := ~pop.valid
  io.q         := pop.payload
  pop.ready    := io.rdreq
  io.perror.clear()
  io.fault.clear()
  io.almost_full.clear()

}

case class fifos() extends Component {

  val scConfigList =
    Seq(
      (64, 8),
      (64, 32),
      (8, 8),
      (8, 128),
      (8, 16),
      (1024, 32),
      (308, 32),
      (128, 32),
      (24, 8),
      (24, 1024),
      (32, 32),
      (256, 32),
      (265, 32),
      (40, 32),
      (11, 32),
      (512, 8),
      (128, 64),
      (96, 32),
      (104, 32),
      (265, 64),
      (256, 64)
    )
  scConfigList.foreach { case (dw, dp) =>
    val dpStr     = if (dp % 1024 == 0) s"${dp / 1024}Kx" else s"${dp}x"
    val fifo_inst = fifo(dw, dp).setDefinitionName("fifo" + dpStr + dw.toString())
    fifo_inst.io.fifo_error_enable.clear()
    fifo_inst.io.core_clock.clear()
    fifo_inst.io.data.clearAll()
    fifo_inst.io.wrreq.clear()
    fifo_inst.io.rdreq.clear()
    fifo_inst.io.aclr.clear()
    fifo_inst.io.sclr.clear()
  }

  val dcConfigList = Seq(
    (128, 8),
    (40, 32),
    (522, 128),
    (1, 16),
    (8, 16),
    (56, 32)
  )
  dcConfigList.foreach { case (dw, dp) =>
    val dpStr       = if (dp % 1024 == 0) s"${dp / 1024}Kx" else s"${dp}x"
    val dcfifo_inst = dcfifo(dw, dp).setDefinitionName("dcfifo" + dpStr + dw.toString())
    dcfifo_inst.io.fifo_error_enable.clear()
    dcfifo_inst.io.core_clock.clear()
    dcfifo_inst.io.data.clearAll()
    dcfifo_inst.io.wrreq.clear()
    dcfifo_inst.io.rdreq.clear()
    dcfifo_inst.io.wrclk.clear()
    dcfifo_inst.io.rdclk_srstn.clear()
    dcfifo_inst.io.wrclk_srstn.clear()
    dcfifo_inst.io.rdclk.clear()
    dcfifo_inst.io.aclr.clear()
  }

}

object fifo extends App {
  SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
    nameWhenByFile               = false,
    anonymSignalPrefix           = "tmp",
    targetDirectory              = "verilogGen/ofed_files",
    genLineComments              = true,
    withTimescale                = false
  ).generateVerilog(fifos())
}
