import spinal.core._
import spinal.lib._
import spinal.core

case class sdpram(dw: Int, aw: Int) extends Component {
  val io = new Bundle {
    val rd_clk  = in Bool ()
    val rden    = in Bool ()
    val rd_addr = in UInt (aw bits)
    val rd_dout = out Bits (dw bits)

    val wr_clk  = in Bool ()
    val wren    = in Bool ()
    val wr_addr = in UInt (aw bits)
    val wr_din  = in Bits (dw bits)
    val perror  = out Bool ()

  }
  noIoPrefix()

  val mem = Mem(core.Bits(dw bits), 1 << aw)

  val wrCld = ClockDomain(io.wr_clk)
  val rdCld = ClockDomain(io.rd_clk)

  val wrClkArea = new ClockingArea(wrCld) {
    mem.write(io.wr_addr, io.wr_din, io.wren)
  }

  val rdClkArea = new ClockingArea(rdCld) {
    io.rd_dout := RegNext(mem.readSync(address = io.rd_addr, enable = io.rden, clockCrossing = true))
  }

  io.perror.clear()
}

case class rams() extends Component {

  val confList = Seq((512, 1024), (64, 512), (512, 2048), (64, 1024), (256, 512), (24, 1024), (352, 1024), (96, 256))
  confList.foreach { case (dw, dp) =>
    val dpStr = if (dp % 1024 == 0) s"${dp / 1024}Kx" else s"${dp}x"

    val sdpram_inst = sdpram(dw, log2Up(dp)).setDefinitionName("sdpram" + dpStr + dw.toString())
    sdpram_inst.io.wr_clk.clear()
    sdpram_inst.io.wren.clear()
    sdpram_inst.io.wr_din.clearAll()
    sdpram_inst.io.wr_addr.clearAll()
    sdpram_inst.io.rd_clk.clear()
    sdpram_inst.io.rden.clear()
    sdpram_inst.io.rd_addr.clearAll()

  }

}

object sdpram extends App {
  // tool.GeneralConfig.rtlGenConfig("verilogGen/ofed_files").generateVerilog(sdpram(8,4))
  SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
    nameWhenByFile               = false,
    anonymSignalPrefix           = "tmp",
    targetDirectory              = "verilogGen/ofed_files",
    genLineComments              = true,
    withTimescale                = false
  ).generateVerilog(rams())
}
