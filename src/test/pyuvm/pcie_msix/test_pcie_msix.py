import cocotb
import logging
from cocotb.clock import Clock
from cocotbext.axi import AxiLiteMaster, AxiLiteRam, AxiLiteBus
from cocotb.triggers import ClockCycles, RisingEdge

class MSIXTableEntry:
    def __init__(self, addr, num):
        self.address = addr
        self.irq_num = num
        self.mask = 0

    @property
    def to_int(self):
        return self.address | (self.irq_num << 64) | (self.mask << 96)

    @property
    def to_bytes(self):
        return self.to_int.to_bytes(16, "little")


class TbPcieMSIX:
    def __init__(self, dut):
        self.dut = dut

        self.log = logging.getLogger("cocotb.tb")
        self.log.setLevel(logging.DEBUG)

        cocotb.start_soon(Clock(dut.clk, 4, units="ns").start())

        self.axil_master = AxiLiteMaster(AxiLiteBus.from_prefix(dut, "axil_msix"), dut.clk, dut.reset)

    async def reset(self):
        self.dut.reset.value = 1
        await ClockCycles(self.dut.clk, 10)
        self.dut.reset.value = 0
        await RisingEdge(self.dut.clk)


@cocotb.test()
async def smoke(dut):
    tb = TbPcieMSIX(dut)
    await tb.reset()
    msix_addr = 0x8000000
    for irq_idx in range(32):
        msix_config = MSIXTableEntry(msix_addr,irq_idx)
        await  tb.axil_master.write(irq_idx*16, msix_config.to_bytes)

    dut.irq_payload.value = 4
    await ClockCycles(dut.clk, 100)
