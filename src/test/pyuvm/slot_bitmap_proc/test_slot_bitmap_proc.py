import cocotb
import logging
import random
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles

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

class TbSlotBitmapProc():
    def __init__(self, dut):
        self.dut = dut
        cocotb.start_soon(Clock(self.dut.clk, 2, unit="ns").start())
        self.btm_drv = Driver(dut, "btm_drv","bitmap_in", ["bitmap","last","cur_sto_id_start","cur_sto_id_end"])



    async def reset(self):
        self.dut.reset.value = 1
        await ClockCycles(self.dut.clk, 10)
        self.dut.reset.value = 0
        await ClockCycles(self.dut.clk, 10)

@cocotb.test()
async def smoke(dut):
    tb = TbSlotBitmapProc(dut)
    await tb.reset()
    bitmap_rand0 = random.randint(0, (1<<64)-1)
    bitmap_rand1 = random.randint(0, (1<<64)-1)
    print(f"{bitmap_rand0:b}")
    print(bitmap_rand0.bit_length())
    datas = [
        {"bitmap": bitmap_rand0, "last": 0, "cur_sto_id_start": 24, "cur_sto_id_end": 24+64-1},
        {"bitmap": bitmap_rand1, "last": 1, "cur_sto_id_start": 88, "cur_sto_id_end": 88+64-1}
    ]
    await tb.btm_drv.send(datas)
    await ClockCycles(dut.clk, 30)
    tb.dut.slot_id_info_ready.value = 1
    await ClockCycles(dut.clk,100)