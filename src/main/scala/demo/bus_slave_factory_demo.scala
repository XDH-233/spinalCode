package demo

import spinal.core._
import spinal.lib.bus.amba4.axilite.{AxiLite4, AxiLite4SlaveFactory, AxiLite4SpecRenamer}
import spinal.lib.bus.avalon.AvalonMMConfig
import spinal.lib.slave

import scala.language.postfixOps

case class bus_slave_factory_demo() extends Component {
  val avmmConfig: AvalonMMConfig = AvalonMMConfig(
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
  val io = new Bundle {
    val axi_ctrl: AxiLite4 = slave(AxiLite4(32, 32))
    val en:       Bool     = out Bool () setAsReg () init False
    val plus:     Bool     = out Bool () setAsReg () init False
    val cnt:      UInt     = in UInt (64 bits)
  }

  AxiLite4SpecRenamer(io.axi_ctrl)

  val _ = new Area {
    io.plus.clear() // 这一句很关键，在总线没有读写plus 是, plus 要自动清零，这样才能形成脉冲信号
    val busCtrl = new AxiLite4SlaveFactory(io.axi_ctrl)
    busCtrl.readAndWrite(io.en, 0, 0, "en: 功能使能")
    busCtrl.readAndWrite(io.plus, 0x4, 0, "脉冲信号驱动")
    busCtrl.readMultiWord(io.cnt, 0x8, "计数器读值")
    busCtrl.printDataModel()
  }.setName((""))
}

import spinal.core.sim._
import spinal.lib.bus.amba4.axilite.sim._

object BusSlaveFactoryDemoSim extends App {
  SimConfig.withWave
    .withConfig(
      SpinalConfig(
        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
        defaultClockDomainFrequency  = FixedFrequency(100 MHz),
        nameWhenByFile               = false,
        anonymSignalPrefix           = "tmp"
      )
    )
    .compile(new bus_slave_factory_demo())
    .doSim { dut =>

      val aLiteDrv = AxiLite4Driver(dut.io.axi_ctrl, dut.clockDomain)
      dut.io.cnt #= BigInt("f0000000f", 16)
      dut.clockDomain.forkStimulus(10)
      aLiteDrv.reset()
      dut.clockDomain.waitSampling()
      aLiteDrv.write(0, 1)
      aLiteDrv.read(0)
      aLiteDrv.write(4, 1)
      aLiteDrv.read(8)
      aLiteDrv.read(0xc)
      dut.clockDomain.waitSampling(50)
    }
}
