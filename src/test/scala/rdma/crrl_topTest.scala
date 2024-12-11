package rdma

import org.scalatest.flatspec.AnyFlatSpec

class crrl_topTest extends AnyFlatSpec {

  it should "gen rtl well" in tool.GeneralConfig.rtlGenConfig("verilogGen/rdma/crrl", "crrl_").generateVerilog(crrl_top().setDefinitionName("crrl_top"))


}
