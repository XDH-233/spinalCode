import cocotb
from cocotb.triggers import FallingEdge
from cocotb.queue import QueueEmpty, Queue
import enum
import logging

from cocotb.triggers import Join, Combine
from pyuvm import *
import random
import pyuvm

from cocotb_bus.drivers.avalon import AvalonSTPkts as AvalonSTDriver

from pyuvm import utility_classes, uvm_env

@enum.unique
class Ops(enum.IntEnum):
    """Legal ops for the AvstWidthCov"""
    DIVIDE = 0
    EXPAND = 1


class AvstWidthCovBfm(metaclass=utility_classes.Singleton):
    def __init__(self):
        self.dut = cocotb.top
        self.driver_queue = Queue(maxsize=1)
        # self.divide_mon_queue = Queue(maxsize=0)
        # self.expand_mon_queue = Queue(maxsize=0)
        # self.divide_result_mon_queue = Queue(maxsize=0)
        # self.expand_result_mon_queue = Queue(maxsize=0)

        self.avst_divide_drv = AvalonSTDriver(self.dut, "avst_d_in", self.dut.clk, report_channel=True, config={"firstSymbolInHighOrderBits": False})
        self.avst_expand_drv = AvalonSTDriver(self.dut, "avst_e_in", self.dut.clk, report_channel=True, config={"firstSymbolInHighOrderBits": False})

    async def reset(self):
        await FallingEdge(self.dut.clk)
        self.dut.reset.value = 1
        self.dut.avst_d_in_valid.value = 0
        self.dut.avst_e_in_valid.value = 0
        self.dut.avst_in_divide_ret_ready.value = 1
        self.dut.avst_e_in_expand_ret_ready.value = 1
        await FallingEdge(self.dut.clk)
        self.dut.reset.value = 0
        await FallingEdge(self.dut.clk)

    async def send_op(self, data,op):
        cmd_tuple = (data, op)
        await self.driver_queue.put(cmd_tuple)

    async def driver_bfm(self):
        while True:
            try:
                (data, channel, op) = self.driver_queue.get_nowait()
                if op == Ops.DIVIDE:
                    await self.avst_divide_drv._driver_send(pkt=data,channel=channel)
                elif op == Ops.EXPAND:
                    await self.avst_expand_drv._driver_send(pkt=data,channel=channel)
            except QueueEmpty:
                pass

    def start_bfm(self):
        cocotb.start_soon((self.driver_bfm()))


class Driver(uvm_driver):
    def build_phase(self):
        self.ap = uvm_analysis_port("ap", self)

    def start_of_simulation_phase(self):
        self.bfm = AvstWidthCovBfm()

    async def launch_tb(self):
        await self.bfm.reset()
        self.bfm.start_bfm()

    async def run_phase(self):
        await self.launch_tb()
        while True:
            pass
            cmd = await self.seq_item_port.get_next_item()
            await self.bfm.send_op(cmd.data, cmd.op)
            # result = await self.bfm.get_result()
            # self.ap.write(result)
            # cmd.result = result
            self.seq_item_port.item_done()




class AvstWidthCovEnv(uvm_env):
    def build_phase(self):
        self.seqr = uvm_sequencer("seqr", self)
        ConfigDB().set(None, "*", "SEQR", self.seqr)
        self.driver = Driver.create("driver", self)
        # self.cmd_mon = Monitor("cmd_mon", self, "get_cmd")
        # self.coverage = Coverage("coverage", self)
        # self.scoreboard = Scoreboard("scoreboard", self)

    def connect_phase(self):
        self.driver.seq_item_port.connect(self.seqr.seq_item_export)
        # self.cmd_mon.ap.connect(self.scoreboard.cmd_export)
        # self.cmd_mon.ap.connect(self.coverage.analysis_export)
        # self.driver.ap.connect(self.scoreboard.result_export)
