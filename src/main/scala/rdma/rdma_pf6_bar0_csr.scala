package rdma

import spinal.core._
import spinal.lib._
import spinal.lib.bus.avalon.{AvalonMM, AvalonMMConfig, AvalonMMSlaveFactory}
import spinal.lib.bus.regif.{AccessType, HtmlGenerator, RalfGenerator, RegInst}
import tool.AvalonMMBusInterface

import scala.language.postfixOps

case class rdma_pf6_bar0_csr() extends Component {
  val avmmConfigRegs: AvalonMMConfig = AvalonMMConfig(
    addressWidth     = 32,
    dataWidth        = 32,
    burstCountWidth  = -1,
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

  val avmmConfigDb: AvalonMMConfig = AvalonMMConfig(
    addressWidth     = 64,
    dataWidth        = 512,
    burstCountWidth  = -1,
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
    val avmm: AvalonMM = slave(AvalonMM(avmmConfigDb))
  }

  val avmm_regs: AvalonMM = AvalonMM(avmmConfigRegs)
  val avmm_db:   AvalonMM = AvalonMM(avmmConfigDb)

  avmm_regs.address   := io.avmm.address.resized
  avmm_regs.writeData := io.avmm.writeData.resized
  avmm_db.address     := io.avmm.address
  avmm_db.writeData   := io.avmm.writeData

  when(io.avmm.address < 0x4000) {
    avmm_regs.write       := io.avmm.write
    avmm_regs.read        := io.avmm.read
    io.avmm.readData      := avmm_regs.readData.resized
    io.avmm.readDataValid := avmm_regs.readDataValid
    io.avmm.waitRequestn  := avmm_regs.waitRequestn
    avmm_db.write.clear()
    avmm_db.read.clear()
  } otherwise {
    avmm_db.write         := io.avmm.write
    avmm_db.read          := io.avmm.read
    io.avmm.readData      := avmm_db.readData
    io.avmm.readDataValid := avmm_db.readDataValid
    io.avmm.waitRequestn  := avmm_db.waitRequestn
    avmm_regs.write.clear()
    avmm_regs.read.clear()
  }

  val busIf:  AvalonMMBusInterface = new AvalonMMBusInterface(avmm_regs, (0x0000, 100 Byte))
  val M_REG0: RegInst              = busIf.newReg(doc = "REG0")
  val M_REG1: RegInst              = busIf.newReg(doc = "REG1")
  val M_REG2: RegInst              = busIf.newRegAt(address = 0x10, doc = "REG2")
  val M_REG3: RegInst              = busIf.newRegAt(address = 0x14, doc = "REG3")

  val fw_rev_major, fw_rev_minor:     Bits = Reg(Bits(16 bits)) init 0
  val fw_rev_subminor, cmd_interface: Bits = Reg(Bits(16 bits)) init 0
  val cmdq_phy_addr_high:             Bits = Reg(Bits(32 bits)) init 0
  val log_cmdq_stride:                Bits = Reg(Bits(4 bits)) init 6
  val log_cmdq_size:                  Bits = Reg(Bits(4 bits)) init 5
  val nic_interface:                  Bits = Reg(Bits(3 bits)) init 0
  val cmdq_phy_addr_low:              Bits = Reg(Bits(20 bits)) init 0

  M_REG0.registerAtOnlyReadLogic(0, fw_rev_major, AccessType.RO, 0, "fw_rev_major")
  M_REG0.registerAtOnlyReadLogic(16, fw_rev_minor, AccessType.RO, 0, "fw_rev_minor")

  M_REG1.registerAtOnlyReadLogic(0, fw_rev_subminor, AccessType.RO, 0, "fw_rev_subminor")
  M_REG1.registerAtOnlyReadLogic(16, cmd_interface, AccessType.RO, 0, "cmd_interface")

  M_REG2.registerAtWithWriteLogic(0, cmdq_phy_addr_high, AccessType.RW, 0, "cmdq_phy_addr_high")

  M_REG3.registerAtOnlyReadLogic(0, log_cmdq_stride, AccessType.RO, 6, "log_cmdq_stride")
  M_REG3.registerAtOnlyReadLogic(4, log_cmdq_size, AccessType.RO, 5, "log_cmdq_size")
  M_REG3.registerAtOnlyReadLogic(8, nic_interface, AccessType.RO, 0, "nic_interface")
  M_REG3.registerAtWithWriteLogic(12, cmdq_phy_addr_low, AccessType.RW, 0, "cmdq_phy_addr_low")

  busIf.accept(HtmlGenerator("regif", "rdma pf6 bar0 csr"))
  busIf.accept(RalfGenerator("header"))

  val avmmBusSlaveFactory: AvalonMMSlaveFactory = new AvalonMMSlaveFactory(avmm_db)

  val cmdq_db: Bool = Bool() setAsReg () init False
  cmdq_db.clear()

  avmmBusSlaveFactory

}

import spinal.core.sim._

object rdma_pf6_bar0_csr_sim extends App {
  val spinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
    defaultClockDomainFrequency = FixedFrequency(100 MHz),
    nameWhenByFile = false,
    anonymSignalPrefix = "tmp"
  )
  spinalConfig.generateVerilog(rdma_pf6_bar0_csr())
  SimConfig.withWave
    .withConfig(spinalConfig)
    .compile(new rdma_pf6_bar0_csr())
    .doSim { dut =>

      dut.clockDomain.forkStimulus(10)

    }
}
