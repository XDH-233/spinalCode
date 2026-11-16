import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles

@cocotb.test()
async def somke(dut):
    cocotb.start_soon(Clock(dut.clk, 2, unit="ns").start())
    dut.one_hot_in.value = 0
    await RisingEdge(dut.clk)
    for i in range(0, 128):
        print(f"i:-----{i}--------")
        one_hot = 1 << i
        print(f"one_hot:{one_hot:b}")
        dut.one_hot_in.value = one_hot
        await RisingEdge(dut.clk)
        bin = dut.bin_out.value.to_unsigned()
        print(f"bin:{bin}")
    await ClockCycles(dut.clk, 10)