import spinal.core.{ClockDomainConfig, Component, HIGH, SYNC, SpinalConfig, SpinalVerilog, SpinalVhdl}
import spinal.lib.bus.avalon.AvalonMM
import spinal.lib.{WrapWithReg, master, slave}
import spinal.lib.cpu.riscv.impl.{DataCache, DataCacheConfig, DataCacheCpuBus}
import spinal.lib.experimental.chisel.Bundle
import tool.GeneralConfig.dateTimeString

case class LibCacheDemo() extends Component {

  implicit val p = DataCacheConfig(
    cacheSize    = 512, // bytes
    bytePerLine  = 16,
    wayCount     = 1,
    addressWidth = 12,
    cpuDataWidth = 16,
    memDataWidth = 16
  )
  val cache = new DataCache()(p)

  val io = new Bundle {
    val cpu: DataCacheCpuBus = slave(DataCacheCpuBus())
    val mem: AvalonMM        = master(cache.io.mem.toAvalon())
  }

  io.cpu <> cache.io.cpu

}

object DataCacheMain {
  def main(args: Array[String]) {
    SpinalConfig(
      defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
      nameWhenByFile               = false,
      anonymSignalPrefix           = "tmp",
      targetDirectory              = "src/test/pyuvm/DataCache",
      genLineComments              = true,
      withTimescale                = false
    ).generateVerilog({
      implicit val p = DataCacheConfig(
        cacheSize    = 512, // bytes
        bytePerLine  = 16,
        wayCount     = 1,
        addressWidth = 12,
        cpuDataWidth = 16,
        memDataWidth = 16
      )
      new DataCache()(p)
    })
  }
}
