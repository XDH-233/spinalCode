package demo

import spinal.core.{Bits, Bundle, ClockDomainConfig, Component, FixedFrequency, HIGH, IntToBuilder, Reg, SYNC, SpinalConfig}
import spinal.lib.bus.avalon.{AvalonMM, AvalonMMConfig}
import spinal.lib.bus.regif.{AccessType, HtmlGenerator, RegInst}
import spinal.lib.slave
import tool.AvalonMMBusInterface

import scala.language.postfixOps
case class avmm_reg_if_demo() extends Component {
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

  val busIf:  AvalonMMBusInterface = new AvalonMMBusInterface(io.avmm, (0x80000, 100 Byte))
  val M_REG0: RegInst              = busIf.newReg(doc = "REG0")
  val M_REG1: RegInst              = busIf.newReg(doc = "REG1")
  val M_REG2: RegInst              = busIf.newRegAt(address = 0x10, doc = "REG2")
  val M_REG3: RegInst              = busIf.newRegAt(address = 0x14, doc = "REG3")

  val reg0_field0: Bits = Bits(16 bits)
  val reg0_field1: Bits = Bits(16 bits)

  val reg1_field0: Bits = Bits(16 bits)
  val reg1_field1: Bits = Bits(16 bits)

  val reg2_field: Bits = Reg(Bits(32 bits)) init 0

  val reg3_field0: Bits = Bits(4 bits)
  val reg3_field1: Bits = Bits(4 bits)
  val reg3_field2: Bits = Bits(3 bits)
  val reg3_field3: Bits = Reg(Bits(20 bits)) init 0

  reg0_field0 := 0
  reg0_field1 := 0

  reg1_field0 := 0
  reg1_field1 := 0

  reg3_field0 := 6
  reg3_field1 := 5
  reg3_field2 := 0

  M_REG0.registerAtOnlyReadLogic(0, reg0_field0, AccessType.RO, 0, "description of reg0_field0")
  M_REG0.registerAtOnlyReadLogic(16, reg0_field1, AccessType.RO, 0, "description of reg0_field1")

  M_REG1.registerAtOnlyReadLogic(0, reg1_field0, AccessType.RO, 0, "description of reg1_field0")
  M_REG1.registerAtOnlyReadLogic(16, reg1_field1, AccessType.RO, 0, "description of reg1_field1")

  M_REG2.registerAtWithWriteLogic(0, reg2_field, AccessType.RW, 0, "description of reg2_field")

  M_REG3.registerAtOnlyReadLogic(0, reg3_field0, AccessType.RO, 6, "description of reg3_field0")
  M_REG3.registerAtOnlyReadLogic(4, reg3_field1, AccessType.RO, 5, "description of reg3_field1")
  M_REG3.registerAtOnlyReadLogic(8, reg3_field2, AccessType.RO, 0, "description of reg3_field2")
  M_REG3.registerAtWithWriteLogic(12, reg3_field3, AccessType.RW, 0, "description of reg3_field3")

  busIf.accept(HtmlGenerator("regif_demo", "Avalon MM regs csr"))
}

object AvmmRegSimCsr extends App {
  SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
    defaultClockDomainFrequency  = FixedFrequency(100 MHz),
    nameWhenByFile               = false,
    anonymSignalPrefix           = "tmp"
  ).generateVerilog(avmm_reg_if_demo())
}
