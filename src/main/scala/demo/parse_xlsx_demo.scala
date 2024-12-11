package demo

import spinal.core._
import spinal.lib.bus.avalon.{AvalonMM, AvalonMMConfig}
import spinal.lib.bus.regif.HtmlGenerator
import spinal.lib.slave
import tool.AvalonMMBusInterface
import tool.BusIfExt._

import scala.language.postfixOps

case class parse_xlsx_demo() extends Component {
  val avmmConfig: AvalonMMConfig = AvalonMMConfig(
    addressWidth     = 32,
    dataWidth        = 32,
    burstCountWidth  = 0,
    useByteEnable    = true,
    useDebugAccess   = false,
    useRead          = true,
    useWrite         = true,
    useResponse      = false,
    useLock          = false,
    useWaitRequestn  = true,
    useReadDataValid = true,
    useBurstCount    = false
  )

  val io = new Bundle {
    val avmm: AvalonMM = slave(AvalonMM(avmmConfig))
  }

  val busIf: AvalonMMBusInterface = new AvalonMMBusInterface(io.avmm, (0x80000, 100 Byte))

  busIf.parseFromXlsx("regs_excel.xlsx")

  busIf.accept(HtmlGenerator("regif-parsed", "regs parsed from excel xlsx"))

}

object RegSim extends App {
  SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
    defaultClockDomainFrequency  = FixedFrequency(100 MHz),
    nameWhenByFile               = false,
    anonymSignalPrefix           = "tmp"
  ).generateVerilog(parse_xlsx_demo())
}
