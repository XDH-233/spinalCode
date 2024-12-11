import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, ClockCycles
from cocotb.queue import QueueEmpty, Queue
import enum
import logging

from cocotb.triggers import Join, Combine
from cocotb.utils import hexdump
from pyuvm import *
import random
import pyuvm


logging.basicConfig(level=logging.NOTSET)
logger = logging.getLogger()
# logger.setLevel(logging.DEBUG)


from cocotb_bus.drivers.avalon import AvalonSTPkts as AvalonSTDriver

from pyuvm import utility_classes, uvm_env


from src.test.pyuvm.lib import *


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
        string = ""
        string += f"op:{self.op.name}\n"
        if self.channel is not None:
            string += f"channel: {self.channel:x}\n"
        if self.data is not None:
            string += hexdump(self.data)
        return string


class DivideSeq(uvm_sequence):
    async def body(self):
        for _ in range(10):
            cmd = AvstSeqItem("cmd", None, None,Ops.DIVIDE)
            logger.info(f"DivideSeq: a new itme:\n{cmd}")
            await self.start_item(cmd)
            cmd.randomize_data()
            await self.finish_item(cmd)

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
        logger.info("TestAllSeq add divide sequence.")
        expand = ExpandSeq("expand")
        await divide.start(seqr)
        await expand.start(seqr)

class AvstWidthCovBfm(metaclass=utility_classes.Singleton):
    def __init__(self):
        self.dut = cocotb.top
        self.driver_queue = Queue(maxsize=1)
        # self.divide_mon_queue = Queue(maxsize=0)
        # self.expand_mon_queue = Queue(maxsize=0)
        # self.divide_result_mon_queue = Queue(maxsize=0)
        # self.expand_result_mon_queue = Queue(maxsize=0)
        # self.avst_divide_drv = AvalonSTDriver(self.dut, "avst_d_in", self.dut.clk, config={"firstSymbolInHighOrderBits": False})
        # self.avst_expand_drv = AvalonSTDriver(self.dut, "avst_e_in", self.dut.clk, config={"firstSymbolInHighOrderBits": False})

    async def reset(self):
        await FallingEdge(self.dut.clk)
        self.dut.rst.value = 1
        self.dut.avst_d_in_valid.value = 0
        self.dut.avst_e_in_valid.value = 0
        self.dut.avst_d_out_ready.value = 1
        self.dut.avst_e_out_ready.value = 1
        # await FallingEdge(self.dut.clk)
        await ClockCycles(self.dut.clk, 20)
        self.dut.rst.value = 0
        await FallingEdge(self.dut.clk)


    async def send_op(self, data,channel,op):
        cmd_tuple = (data, channel,op)
        await self.driver_queue.put(cmd_tuple)
        logger.info("bfm: put a data into driver_queue")

    async def driver_bfm(self):
        while True:
            try:
                (data, channel, op) = self.driver_queue.get_nowait()
                if op == Ops.DIVIDE:
                    self.dut.avst_d_in_channel.value = channel
                    # await self.avst_divide_drv._driver_send(pkt=data,channel=channel)
                elif op == Ops.EXPAND:
                    # await self.avst_expand_drv._driver_send(pkt=data,channel=channel)
                    self.dut.avst_e_in_channel.value = channel
            except QueueEmpty:
                pass
                # print("shit!, a empty queue")


    def start_bfm(self):
        cocotb.start_soon((self.driver_bfm()))


class Driver(uvm_driver):
    def build_phase(self):
        # self.ap = uvm_analysis_port("ap", self)
        pass
        self.logger.info("Driverr built, no operation")


    def start_of_simulation_phase(self):
        self.bfm = AvstWidthCovBfm()
        self.logger.info("Start simulation and set bfm!")

    async def launch_tb(self):
        await self.bfm.reset()
        self.logger.info("DUT reset done!")
        self.bfm.start_bfm()

    async def run_phase(self):
        await self.launch_tb()
        while True:
            self.logger.info("Now lets fetch a item sequence!")
            cmd = await self.seq_item_port.get_next_item()
            self.logger.info("Got a item from sequence!")
            await self.bfm.send_op(cmd.data, cmd.channel, cmd.op)
            # result = await self.bfm.get_result()
            # self.ap.write(result)
            # cmd.result = result
            self.seq_item_port.item_done()


class AvstWidthCovEnv(uvm_env):
    def build_phase(self):
        self.seqr = uvm_sequencer("seqr", self)
        ConfigDB().set(None, "*", "SEQR", self.seqr)
        self.driver = Driver.create("driver", self)
        self.logger.info("Built sequencer and driver and configDB set")
        # self.cmd_mon = Monitor("cmd_mon", self, "get_cmd")
        # self.coverage = Coverage("coverage", self)
        # self.scoreboard = Scoreboard("scoreboard", self)

    def connect_phase(self):
        self.driver.seq_item_port.connect(self.seqr.seq_item_export)
        self.logger.info("Connected driver to sequencer")
        # self.cmd_mon.ap.connect(self.scoreboard.cmd_export)
        # self.cmd_mon.ap.connect(self.coverage.analysis_export)
        # self.driver.ap.connect(self.scoreboard.result_export)


@pyuvm.test()
class AvstWidthCovTest(uvm_test):
    """Test AvstWidthCov with divide and expand"""

    def build_phase(self):
        self.env = AvstWidthCovEnv("env", self)
        self.logger.info("Built env")

    def end_of_elaboration_phase(self):
        self.logger.info("End of elaboration")
        self.test_all = TestAllSeq.create("test_all")
        self.logger.info("Sequence create done!")

    async def run_phase(self):
        self.logger.info("Run phase start")
        self.raise_objection()
        logger.info("TestAll sequence to start")
        await self.test_all.start()
        logger.info("TestAll sequence end")
        self.drop_objection()

