package PCIe

import org.scalatest.flatspec.AnyFlatSpec
import tool.GeneralConfig._

class pcie_us_if_cqTest extends AnyFlatSpec {
  rtlGenConfig("src/test/pyuvm/pcie_us_if_cq").generateVerilog(pcie_us_if_cq(PcieUsConfig(512)))

}
