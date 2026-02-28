import cocotb
import logging
import random
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles


class TbTCAM():
    def __init__(self, dut):
        self.dut = dut
        cocotb.start_soon(Clock(self.dut.clk, 2, unit="ns").start())


    async def insert(self, data):
        self.dut.insert_valid.value = 1
        self.dut.insert_payload.value = data
        await RisingEdge(self.dut.clk)
        self.dut.insert_valid.value = 0
    
    async def query(self, data):
        self.dut.query_valid.value = 1
        self.dut.query_payload.value = data
        await RisingEdge(self.dut.clk)
        self.dut.query_valid.value = 0

    async def clear(self, data):
        self.dut.clear_valid.value = 1
        self.dut.clear_payload.value = data
        await RisingEdge(self.dut.clk)
        self.dut.clear_valid.value = 0

    async def insert_clear(self, idata, cdata):
        self.dut.insert_valid.value = 1
        self.dut.insert_payload.value = idata
        self.dut.clear_valid.value = 1
        self.dut.clear_payload.value = cdata
        await RisingEdge(self.dut.clk)
        self.dut.insert_valid.value = 0
        self.dut.clear_valid.value = 0

    async def reset(self):
        self.dut.reset.value = 1
        await ClockCycles(self.dut.clk, 10)
        self.dut.reset.value = 0
        await ClockCycles(self.dut.clk, 10)



@cocotb.test()
async def test_TCAM(dut):
    tb = TbTCAM(dut)
    await tb.reset()
    for i in range(0, 10):
        await tb.insert(random.randint(0, 100))
        await ClockCycles(dut.clk, 1)

    await tb.clear(0x33)

    await ClockCycles(dut.clk, 10)

    await tb.insert_clear(0x1234, 0x2c)

    await ClockCycles(dut.clk, 10)

    await tb.query(0x1234)
    await ClockCycles(dut.clk, 100)