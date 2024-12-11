package rdma

import spinal.core.sim._

import org.scalatest.flatspec.AnyFlatSpec

class mtt_cacheTest extends AnyFlatSpec {

  "rtl gen" should "work right" in tool.GeneralConfig.rtlGenConfig("verilogGen/rdma").generateVerilog(mtt_cache())

  it should "sim well" in tool.GeneralConfig.verilatorSimConfig.compile(mtt_cache()).doSim{dut =>
    dut.clockDomain.forkStimulus(10)
    dut.clockDomain.waitSampling(100)
  }

}
