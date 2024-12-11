package rdma.command_queue

import org.scalatest.flatspec.AnyFlatSpec

class command_queue_proc_topTest extends AnyFlatSpec {
  it should "gen rlt well" in tool.GeneralConfig.rtlGenConfig("verilogGen/rdma/command_queue", prefix = "cmdq_").generateVerilog(command_queue_proc_top().setDefinitionName("command_queue_top"))
}
