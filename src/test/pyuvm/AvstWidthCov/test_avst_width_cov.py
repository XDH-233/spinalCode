from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, ClockCycles, RisingEdge
from cocotb.queue import QueueEmpty, Queue
import enum

from cocotb.utils import hexdump
from pyuvm import *
import pyuvm

from cocotb_bus.drivers.avalon import AvalonSTPkts as AvalonSTDriver
from  cocotb_bus.monitors.avalon import AvalonSTPkts as AvalonSTMonitor

from src.test.pyuvm.lib import *


logging.basicConfig(level=logging.NOTSET)
logger = logging.getLogger()


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
        for _ in range(100):
            cmd = AvstSeqItem("cmd", None, None,Ops.DIVIDE)
            await self.start_item(cmd)
            cmd.randomize_data()
            await self.finish_item(cmd)

class ExpandSeq(uvm_sequence):
    async def body(self):
        for _ in range(100):
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
        # self.avst_d_out_mntr_queue = Queue(0)
        # self.avst_e_out_mntr_queue = Queue(0)
        self.avst_out_queue = Queue(0)
        self.avst_divide_drv = AvalonSTDriver(self.dut, "avst_d_in", self.dut.clk, config={"firstSymbolInHighOrderBits": False})
        self.avst_expand_drv = AvalonSTDriver(self.dut, "avst_e_in", self.dut.clk, config={"firstSymbolInHighOrderBits": False})
        self.avst_d_out_mntr = AvalonSTMonitor(self.dut, "avst_d_out", self.dut.clk,config={"firstSymbolInHighOrderBits": False}, report_channel=True)
        self.avst_e_out_mntr = AvalonSTMonitor(self.dut, "avst_e_out", self.dut.clk,config={"firstSymbolInHighOrderBits": False}, report_channel=True)

        self.avst_d_out_mntr.add_callback(self.avst_d_out_mntr_cb)
        self.avst_e_out_mntr.add_callback(self.avst_e_out_mntr_cb)

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
            await RisingEdge(self.dut.clk)
            try:
                (data, channel, op) = self.driver_queue.get_nowait()
                if op == Ops.DIVIDE:
                    await self.avst_divide_drv._driver_send(pkt=data,channel=channel)
                elif op == Ops.EXPAND:
                    await self.avst_expand_drv._driver_send(pkt=data,channel=channel)
            except QueueEmpty:
                pass

    def avst_d_out_mntr_cb(self, transation):
        self.avst_out_queue.put_nowait((transation["data"], transation["channel"], Ops.DIVIDE))

    def avst_e_out_mntr_cb(self, transation):
        self.avst_out_queue.put_nowait((transation["data"], transation["channel"], Ops.EXPAND))

    def start_bfm(self):
        cocotb.start_soon(self.driver_bfm())


class Driver(uvm_driver):
    def build_phase(self):
        self.ap = uvm_analysis_port("ap", self)

    def end_of_elaboration_phase(self):
        self.bfm = AvstWidthCovBfm()

    def start_of_simulation_phase(self):
        clock = Clock(self.bfm.dut.clk, 10, units="us")  # Create a 10us period clock on port clk
        cocotb.start_soon(clock.start())

    async def launch_tb(self):
        await self.bfm.reset()
        self.bfm.start_bfm()

    async def run_phase(self):
        await self.launch_tb()
        while True:
            cmd = await self.seq_item_port.get_next_item() #FIXME: blocked
            await self.bfm.send_op(cmd.data, cmd.channel, cmd.op)
            self.ap.write((cmd.data, cmd.channel, cmd.op))
            self.seq_item_port.item_done()

class Monitor(uvm_component):

    def build_phase(self):
        self.ap = uvm_analysis_port("ap", self)
        self.bfm = AvstWidthCovBfm()

    async  def run_phase(self):
        while True:
            await RisingEdge(self.bfm.dut.clk)
            item_tup_mon = await self.bfm.avst_out_queue.get()
            (data, channel, op) = item_tup_mon
            item_str = f"op: {op.name}, channel: 0x{channel:x}"
            self.logger.info(f"Monitored {item_str}")
            self.logger.debug(hexdump(data))
            self.ap.write(item_tup_mon)

class Scoreboard(uvm_component):
    def build_phase(self):
        self.din_fifo = uvm_tlm_analysis_fifo("din_fifo", self)
        self.get_fifo = uvm_tlm_analysis_fifo("get_fifo", self)
        self.din_get = uvm_get_port("din_get_port", self)
        self.res_get = uvm_get_port("res_get_port", self)
        self.din_export = self.din_fifo.analysis_export
        self.get_export = self.get_fifo.analysis_export

    def connect_phase(self):
        self.din_get.connect(self.din_fifo.get_export)
        self.res_get.connect(self.get_fifo.get_export)

    def check_phase(self):
        passed = True
        try:
            self.errors = ConfigDB().get(self, "", "CREATE_ERRORS")
        except UVMConfigItemNotFound:
            self.errors = False
        while self.get_fifo.can_get():
            _, actual_result = self.get_fifo.try_get()
            drv_success, din = self.din_fifo.try_get()
            if not drv_success:
                self.logger.critical(f"Get result: but no driven!")
            else:
                (data_in, channel_in, op_in) = din
                (data_out, channel_out, op_out) = actual_result
                if data_in == data_out and channel_in == channel_out and op_in == op_out:
                    self.logger.info(f"PASSED: OP: {op_in.name}, CHANNEL: 0x{channel_in:x}")
                else:
                    self.logger.error(f"FAILED: OP_IN : {op_in.name}, CHANNEL_IN: 0x{channel_in:x}"
                                      f"FAILED: OP_OUT: {op_out.name}, CHANNEL_OUT: 0x{channel_out:x}")
                    passed = False
        assert  passed



class AvstWidthCovEnv(uvm_env):

    def build_phase(self):
        self.seqr = uvm_sequencer("seqr", self)
        ConfigDB().set(None, "*", "SEQR", self.seqr)
        self.driver = Driver.create("driver", self)
        self.monitor = Monitor.create("monitor",self)
        self.scoreboard = Scoreboard("scoreboard", self)

    def connect_phase(self):
        self.driver.seq_item_port.connect(self.seqr.seq_item_export)
        self.driver.ap.connect(self.scoreboard.din_export)
        self.monitor.ap.connect(self.scoreboard.get_export)


@pyuvm.test()
class AvstWidthCovTest(uvm_test):
    """Test AvstWidthCov with divide and expand"""

    def build_phase(self):
        self.env = AvstWidthCovEnv("env", self)

    def end_of_elaboration_phase(self):
        self.test_all = TestAllSeq.create("test_all")
        # self.set_logging_level_hier(logging.DEBUG)
        self.file_handler = logging.FileHandler("log.log", mode="w")
        self.add_logging_handler_hier(self.file_handler)
        self.remove_streaming_handler_hier()

    def start_of_simulation_phase(self):
        self.env.driver.bfm.avst_d_out_mntr.log.addHandler(self.file_handler)
        self.env.driver.bfm.avst_e_out_mntr.log.addHandler(self.file_handler)



    async def run_phase(self):
        self.raise_objection()
        await self.test_all.start()
        await ClockCycles(self.env.driver.bfm.dut.clk, 1000)
        self.drop_objection()

