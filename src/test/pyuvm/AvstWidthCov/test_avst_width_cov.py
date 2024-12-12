import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, ClockCycles, RisingEdge
from cocotb.queue import QueueEmpty, Queue
import enum
import logging

from cocotb.triggers import Join, Combine
from cocotb.utils import hexdump
from pyuvm import *
import random
import pyuvm

from cocotb_bus.drivers.avalon import AvalonSTPkts as AvalonSTDriver
from  cocotb_bus.monitors.avalon import AvalonSTPkts as AvalonSTMonitor

from src.test.pyuvm.lib import *


logging.basicConfig(level=logging.NOTSET)
logger = logging.getLogger()
# logger.setLevel(logging.DEBUG)


@enum.unique
class Ops(enum.IntEnum):
    """Legal ops for the AvstWidthCov"""
    DIVIDE = 0
    EXPAND = 1


class AvstSeqItem(uvm_sequence_item):
    def __init__(self, name,data, channel, op):
        super().__init__(name)
        self.data = data
        self.channel = channel
        self.op = op

    def randomize_data(self):
        rand_data_bytes_len = random.randint(1, 100)
        self.data = get_bytes(rand_data_bytes_len, random_data())
        self.channel = random.randint(0, (1 << 32))

    def randomize(self):
        self.randomize_data()
        self.op = random.choice(list(Ops))

    def __str__(self):
        str_res = ""
        str_res += f"op     : {self.op.name}\n"
        if self.channel is not None:
            str_res += f"channel: {self.channel:x}\n"
        if self.data is not None:
            str_res += hexdump(self.data)
        return str_res


class DivideSeq(uvm_sequence):
    async def body(self):
        for _ in range(10):
            cmd = AvstSeqItem("cmd", None, None,Ops.DIVIDE)
            logger.error("DivideSeq: start_item")
            await self.start_item(cmd) #FIXME: Blocked
            logger.error("DivideSeq: start_item done!")
            cmd.randomize_data()
            await self.finish_item(cmd)
            logger.error("DivideSeq: finish_item done!")

class ExpandSeq(uvm_sequence):
    async def body(self):
        for _ in range(10):
            cmd = AvstSeqItem("cmd", None, None, Ops.EXPAND)
            await self.start_item(cmd)
            cmd.randomize_data()
            await self.finish_item(cmd)

class TestAllSeq(uvm_sequence):
    async def body(self):
        seqr = ConfigDB().get(None, "", "SEQR")
        divide = DivideSeq("divide")
        expand = ExpandSeq("expand")
        await divide.start(seqr)
        await expand.start(seqr)

class AvstWidthCovBfm(metaclass=utility_classes.Singleton):
    def __init__(self):
        self.dut = cocotb.top
        self.driver_queue = Queue(maxsize=1)
        self.avst_divide_drv = AvalonSTDriver(self.dut, "avst_d_in", self.dut.clk, config={"firstSymbolInHighOrderBits": False})
        self.avst_expand_drv = AvalonSTDriver(self.dut, "avst_e_in", self.dut.clk, config={"firstSymbolInHighOrderBits": False})
        # self.avst_d_out_mntr = AvalonSTMonitor(self.dut, "avst_d_out", self.dut.clk,config={"firstSymbolInHighOrderBits": False}, report_channel=True)
        # self.avst_e_out_mntr = AvalonSTMonitor(self.dut, "avst_e_out", self.dut.clk,config={"firstSymbolInHighOrderBits": False}, report_channel=True)

    async def reset(self):
        await RisingEdge(self.dut.clk)
        self.dut.rst.value = 1
        self.dut.avst_d_in_valid.value = 0
        self.dut.avst_e_in_valid.value = 0
        self.dut.avst_d_out_ready.value = 1
        self.dut.avst_e_out_ready.value = 1
        await ClockCycles(self.dut.clk, 20)
        self.dut.rst.value = 0
        await RisingEdge(self.dut.clk)


    async def send_op(self, data,channel,op):
        cmd_tuple = (data, channel,op)
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
        cocotb.start_soon(self.driver_bfm())


class Driver(uvm_driver):
    def build_phase(self):
        pass


    def start_of_simulation_phase(self):
        self.bfm = AvstWidthCovBfm()
        clock = Clock(self.bfm.dut.clk, 10, units="us")  # Create a 10us period clock on port clk
        cocotb.start_soon(clock.start(start_high=False))

    async def launch_tb(self):
        await self.bfm.reset()
        self.bfm.start_bfm()

    async def run_phase(self):
        await self.launch_tb()
        seqr = ConfigDB().get(None, "", "SEQR")
        seq_q = seqr.seq_q
        export = seqr.seq_item_export
        cmd_bp = AvstSeqItem("cmd", None, None, Ops.EXPAND)
        cmd_bp.randomize_data()
        await self.bfm.send_op(cmd_bp.data, cmd_bp.channel, cmd_bp.op) # sequencer bypass
        self.logger.warning("sent op bypass sequencer")
        while True:
            self.logger.warning("Now lets fetch a item sequence!")
            cmd = await self.seq_item_port.get_next_item() #FIXME: blocked
            self.logger.warning(f"Got a item from sequence!")
            await self.bfm.send_op(cmd.data, cmd.channel, cmd.op)
            self.seq_item_port.item_done()


class AvstWidthCovEnv(uvm_env):

    def build_phase(self):
        self.seqr = uvm_sequencer("seqr", self)
        ConfigDB().set(None, "*", "SEQR", self.seqr)
        self.driver = Driver.create("driver", self)

    def connect_phase(self):
        self.driver.seq_item_port.connect(self.seqr.seq_item_export)




@pyuvm.test()
class AvstWidthCovTest(uvm_test):
    """Test AvstWidthCov with divide and expand"""

    def build_phase(self):
        self.env = AvstWidthCovEnv("env", self)

    def end_of_elaboration_phase(self):
        self.test_all = TestAllSeq.create("test_all")

    async def run_phase(self):
        self.raise_objection()
        await self.test_all.start()
        self.drop_objection()

