import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

import logging

import random

class Driver():
    def __init__(self, dut, name, signal_name, data_names):
        self.dut = dut
        self.name = name
        self.data_names = data_names
        self.signal_name = signal_name
        self.log = logging.getLogger(f"{name}")
        self.log.setLevel(logging.DEBUG)
        self.valid = getattr(dut, f"{signal_name}_valid")
        self.ready = getattr(dut, f"{signal_name}_ready")

    async def send(self, datas):
        for data in datas:
            await self.sending(data)

    async def sending(self, dict):
        for dn in self.data_names:
            sig = getattr(self.dut, f"{self.signal_name}_payload_{dn}")
            sig.value = dict[dn]
        self.valid.value = 1
        await RisingEdge(self.dut.clk)
        while self.ready.value != 1:
            await RisingEdge(self.dut.clk)
        self.valid.value = 0


class Monitor():
    def __init__(self, dut, name, signal_name, data_names=None):
        self.dut = dut
        self.name = name
        self.data_names = data_names
        self.signal_name = signal_name
        self.log = logging.getLogger(f"{name}")
        self.log.setLevel(logging.DEBUG)
        self.valid = getattr(dut, f"{signal_name}_valid")
        self.ready = getattr(dut, f"{signal_name}_ready")

        cocotb.start_soon(self.montoring())

    async def montoring(self):
        while True:
            await RisingEdge(self.dut.clk)
            if self.valid.value and self.ready.value:
                string = ""
                if self.data_names is None:
                    sig = getattr(self.dut, f"{self.signal_name}_payload")
                    sig_value = sig.value.to_unsigned()
                    string += f"{self.name}: 0x{sig_value:x}\n"
                else:
                    for dn in self.data_names:
                        sig = getattr(self.dut, f"{self.signal_name}_payload_{dn}")
                        sig_value = sig.value.to_unsigned()
                        string += f"{dn}: 0x{sig_value:x}\n"
                self.log.info(f"Got {self.name} data:\n{string}")


class TbFLR():
    def __init__(self,dut):
        self.dut = dut


        cocotb.start_soon(Clock(self.dut.clk, 2, unit="ns").start())


    async def reset(self):
        self.dut.reset.value = 1
        self.dut.index_out_ready.value = 1
        self.dut.bitmap_in_valid.value = 0
        await ClockCycles(self.dut.clk, 10)
        self.dut.reset.value = 0
        await ClockCycles(self.dut.clk, 10)





@cocotb.test()
async def smoke(dut):
    tb = TbFLR(dut)
    await tb.reset()
    dut.bitmap_in_valid.value = 1
    for i in range(100):
        dut.bitmap_in_payload.value = random.randint(1, 255)
        await RisingEdge(dut.clk)
    dut.bitmap_in_valid.value = 0
    await ClockCycles(dut.clk, 100)

