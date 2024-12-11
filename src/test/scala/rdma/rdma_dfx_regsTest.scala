package rdma

import org.scalatest.flatspec.AnyFlatSpec

class rdma_dfx_regsTest extends AnyFlatSpec {
  it should "gen rtl well" in tool.GeneralConfig.rtlGenConfig("verilogGen/rdma/rdmaDfx").generateVerilog(rdma_dfx_regs())
}
