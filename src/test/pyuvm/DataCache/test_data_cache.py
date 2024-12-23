import enum
import random

import cocotb
import pyuvm
from cocotb.clock import Clock
from cocotb.queue import Queue
from cocotb.triggers import ClockCycles, RisingEdge, FallingEdge
from pyuvm import *


class CpuKind(enum.IntEnum):
    MEMORY = 0
    FLUSH = 1
    EVICT = 2


class CpuSeqItem(uvm_sequence_item):
    def __init__(self, name, rw, ad, kind, bypass, data=None):
        super().__init__(name)
        self.wr = rw
        self.addr = ad
        self.kind = kind
        self.bypass = bypass
        self.data = data

    def randomize(self):
        self.wr = random.randint(0, 1)
        self.addr = (random.randint(0, (1 << 12) - 1) >> 1) << 1
        self.kind = CpuKind.MEMORY
        self.bypass = 0
        if self.wr == 1:
            self.data = random.randint(0, (1 << 16) - 1)

    def __str__(self) -> str:
        string = "---------CpuSeqItem---------\n"
        string += f"rw    : {self.wr}\n"
        string += f"addr  : {self.addr:x}\n"
        string += f"kind  : {self.kind.name}\n"
        string += f"bypass: {self.bypass}\n"
        if self.wr == 1:
            string += f"data  : {self.data:x}\n"
        return string


class DataCacheBfm(metaclass=utility_classes.Singleton):
    def __init__(self):
        self.dut = cocotb.top
        self.cpu_cmd_drv_queue = Queue(maxsize=1)
        self.cpu_rsp_mon_queue = Queue(maxsize=0)
        self.cpu_rsp_exp_queue = Queue(maxsize=0)
        self.cache_map = {}
        self.hit_count = 0

    async def reset(self):
        await RisingEdge(self.dut.clk)
        self.dut.reset.value = 1
        self.dut.io_cpu_cmd_valid.value = 0
        self.dut.io_mem_cmd_ready.value = 1
        self.dut.io_mem_rsp_valid.value = 0
        await ClockCycles(self.dut.clk, 20)
        self.dut.reset.value = 0
        await RisingEdge(self.dut.clk)

    async def send_cpu_cmd(self, wr, addr, kind, bypass, data):
        cmd_tuple = (wr, addr, kind, bypass, data)
        await self.cpu_cmd_drv_queue.put(cmd_tuple)

    async def get_cpu_rsp(self):
        rsp = await self.cpu_rsp_mon_queue.get()
        return rsp

    async def driver_bfm(self):
        while True:
            await FallingEdge(self.dut.clk)
            try:
                (wr, addr, kind, bypass, data) = self.cpu_cmd_drv_queue.get_nowait()
                line_idx = ((addr % (1 << 9)) >> 4) << 4
                line_word_idx = (addr % 16) // 2
                while not self.dut.io_cpu_cmd_ready.value:
                    await FallingEdge(self.dut.clk)
                self.dut.io_cpu_cmd_valid.value = 1
                self.dut.io_cpu_cmd_payload_kind.value = kind.value
                self.dut.io_cpu_cmd_payload_wr.value = wr
                self.dut.io_cpu_cmd_payload_address.value = addr
                self.dut.io_cpu_cmd_payload_mask.value = (1 << len(self.dut.io_cpu_cmd_payload_mask)) - 1
                self.dut.io_cpu_cmd_payload_bypass.value = bypass
                self.dut.io_cpu_cmd_payload_all.value = 0
                if wr == 1:
                    self.dut.io_cpu_cmd_payload_data.value = data
                else:
                    self.dut.io_cpu_cmd_payload_data.value = 0
                await FallingEdge(self.dut.clk)
                self.dut.io_cpu_cmd_valid.value = 0
                await FallingEdge(self.dut.clk)
                if self.dut.io_mem_cmd_valid.value:  # miss
                    await ClockCycles(self.dut.clk, 20)
                    self.dut.io_mem_rsp_valid.value = 1
                    data_rpl = []
                    for _ in range(8):
                        data_rand = random.randint(0, (1 << 16) - 1)
                        data_rpl.append(data_rand)
                        self.dut.io_mem_rsp_payload_data.value = data_rand
                        await RisingEdge(self.dut.clk)
                    if wr == 0:
                        rd_rsp_exp = data_rpl[line_word_idx]
                        self.cpu_rsp_exp_queue.put_nowait(rd_rsp_exp)
                    else:
                        data_rpl[line_word_idx] = data
                    self.cache_map[line_idx] = data_rpl
                    self.dut.io_mem_rsp_valid.value = 0
                    await RisingEdge(self.dut.clk)
                else:  # hit
                    self.hit_count += 1
                    if wr == 0:
                        rd_rsp_map_exp = self.cache_map[line_idx][line_word_idx]
                        self.cpu_rsp_exp_queue.put_nowait(rd_rsp_map_exp)
                    else:
                        self.cache_map[line_idx][line_word_idx] = data
            except QueueEmpty:
                pass

    async def cpu_rsp_bfm(self):
        while True:
            await RisingEdge(self.dut.clk)
            if self.dut.io_cpu_rsp_valid.value:
                data = self.dut.io_cpu_rsp_payload_data.value.integer
                self.cpu_rsp_mon_queue.put_nowait(data)

    def start_bfm(self):
        cocotb.start_soon(self.driver_bfm())
        cocotb.start_soon(self.cpu_rsp_bfm())


class Driver(uvm_driver):
    def build_phase(self):
        self.ap = uvm_analysis_port("ap", self)

    def end_of_elaboration_phase(self):
        self.bfm = DataCacheBfm()

    def start_of_simulation_phase(self):
        clock = Clock(self.bfm.dut.clk, 10, units="us")  # Create a 10us period clock on port clk
        cocotb.start_soon(clock.start())

    async def launch_tb(self):
        await self.bfm.reset()
        self.bfm.start_bfm()

    async def run_phase(self):
        await self.launch_tb()
        while True:
            cpu_cmd = await self.seq_item_port.get_next_item()
            await self.bfm.send_cpu_cmd(cpu_cmd.wr, cpu_cmd.addr, cpu_cmd.kind, cpu_cmd.bypass, cpu_cmd.data)
            self.logger.debug(f"Sent a cpu cmd:\n{cpu_cmd}")
            if cpu_cmd.wr == 0:
                rsp = await self.bfm.get_cpu_rsp()
                self.logger.debug(f"Got a cpu rsp: {rsp:x}")
                self.ap.write(rsp)
            self.seq_item_port.item_done()


class Monitor(uvm_monitor):
    def build_phase(self):
        self.ap = uvm_analysis_port("ap", self)
        self.bfm = DataCacheBfm()

    async def run_phase(self):
        while True:
            await RisingEdge(self.bfm.dut.clk)
            cpu_rsp_exp = await self.bfm.cpu_rsp_exp_queue.get()
            self.logger.debug(f"Got cpu rsp expected: {cpu_rsp_exp:x}")
            self.ap.write(cpu_rsp_exp)


class Scorebard(uvm_component):
    def build_phase(self):
        self.exp_fifo = uvm_tlm_analysis_fifo("exp_fifo", self)
        self.get_fifo = uvm_tlm_analysis_fifo("get_fifo", self)

    def check_phase(self):
        passed = True
        try:
            self.errors = ConfigDB().get(self, "", "CREATE_ERRORS")
        except UVMConfigItemNotFound:
            self.errors = False
        while self.get_fifo.can_get():
            _, actual_result = self.get_fifo.try_get()
            drv_success, expected_result = self.exp_fifo.try_get()
            if not drv_success:
                self.logger.critical(f"Get result: but no driven!")
            else:
                if expected_result == actual_result:
                    self.logger.info(f"PASSED: {actual_result:x}")
                else:
                    self.logger.error(f"FAILD: get: {actual_result:x}, expected: {expected_result:x}")
                    passed = False
            assert passed


class DataCacheEnv(uvm_env):

    def build_phase(self):
        self.seqr = uvm_sequencer("seqr", self)
        ConfigDB().set(None, "*", "SEQR", self.seqr)
        self.driver = Driver.create("driver", self)
        self.monitor = Monitor.create("monitor", self)
        self.scoreboard = Scorebard("scoreboard", self)

    def connect_phase(self):
        self.driver.seq_item_port.connect(self.seqr.seq_item_export)
        self.driver.ap.connect(self.scoreboard.get_fifo.analysis_export)
        self.monitor.ap.connect(self.scoreboard.exp_fifo.analysis_export)


class RandomSeq(uvm_sequence):
    async def body(self):
        for _ in range(1000):
            cpu_cmd_tr = CpuSeqItem("cpu_cmd_tr", None, None, None, None)
            await self.start_item(cpu_cmd_tr)
            cpu_cmd_tr.randomize()
            await self.finish_item(cpu_cmd_tr)


class TestAllSeq(uvm_sequence):
    async def body(self):
        seqr = ConfigDB().get(None, "", "SEQR")
        random = RandomSeq("random")
        await random.start(seqr)


@pyuvm.test()
class DataCacheTest(uvm_test):
    def build_phase(self):
        self.env = DataCacheEnv("env", self)

    def end_of_elaboration_phase(self):
        self.test_all = TestAllSeq.create("test_all")
        self.set_logging_level_hier(logging.DEBUG)
        self.file_handler = logging.FileHandler("log.log", mode="w")
        self.add_logging_handler_hier(self.file_handler)
        self.remove_streaming_handler_hier()

    async def run_phase(self):
        self.raise_objection()
        await self.test_all.start()
        await ClockCycles(self.env.driver.bfm.dut.clk, 100)
        self.logger.info(f"Hit count: {self.env.driver.bfm.hit_count}")
        self.drop_objection()


async def reset(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())
    dut.reset.value = 1
    dut.io_cpu_cmd_valid.value = 0
    dut.io_mem_cmd_ready.value = 1
    dut.io_mem_rsp_valid.value = 0
    await ClockCycles(dut.clk, 20)
    dut.reset.value = 0
    await ClockCycles(dut.clk, 100)


async def cpu_read(dut, addr):
    dut.io_cpu_cmd_valid.value = 1
    dut.io_cpu_cmd_payload_kind.value = 0
    dut.io_cpu_cmd_payload_wr.value = 0
    dut.io_cpu_cmd_payload_address.value = addr
    dut.io_cpu_cmd_payload_data.value = 0
    dut.io_cpu_cmd_payload_mask.value = 3
    dut.io_cpu_cmd_payload_bypass.value = 0
    dut.io_cpu_cmd_payload_all.value = 0
    await RisingEdge(dut.clk)
    dut.io_cpu_cmd_valid.value = 0
    await ClockCycles(dut.clk, 2)
    if dut.io_mem_cmd_valid.value:
        await ClockCycles(dut.clk, MEM_READ_CYCLES)
        dut.io_mem_rsp_valid.value = 1
        for _ in range(8):
            dut.io_mem_rsp_payload_data.value = random.randint(0, (1 << 16) - 1)
            await RisingEdge(dut.clk)
        dut.io_mem_rsp_valid.value = 0
        await ClockCycles(dut.clk, 10)


async def cpu_write(dut, addr, data):
    dut.io_cpu_cmd_valid.value = 1
    dut.io_cpu_cmd_payload_kind.value = 0
    dut.io_cpu_cmd_payload_wr.value = 1
    dut.io_cpu_cmd_payload_address.value = addr
    dut.io_cpu_cmd_payload_data.value = data
    dut.io_cpu_cmd_payload_mask.value = 3
    dut.io_cpu_cmd_payload_bypass.value = 0
    dut.io_cpu_cmd_payload_all.value = 0
    await RisingEdge(dut.clk)
    dut.io_cpu_cmd_valid.value = 0
    await ClockCycles(dut.clk, 2)
    if dut.io_mem_cmd_valid.value:
        await ClockCycles(dut.clk, MEM_READ_CYCLES)
        dut.io_mem_rsp_valid.value = 1
        for _ in range(8):
            dut.io_mem_rsp_payload_data.value = random.randint(0, (1 << 16) - 1)
            await RisingEdge(dut.clk)
        dut.io_mem_rsp_valid.value = 0
        await ClockCycles(dut.clk, 10)


MEM_READ_CYCLES = 10


# @cocotb.test()
async def smoke(dut):
    await reset(dut)
    # cpu read(0)
    await cpu_read(dut, 7)
    # cpu write(0x358, 0xce07)
    await cpu_write(dut, 0x358, 0xce07)
    await cpu_read(dut, 0x8)
    await ClockCycles(dut.clk, 10)
    await cpu_write(dut, 0x350, 0xdddd)
    await ClockCycles(dut.clk, 10)
    await cpu_read(dut, 0x350)
    await ClockCycles(dut.clk, 500)


# @cocotb.test()
async def fill(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())
    await reset(dut)
    for line in range(32):
        await cpu_read(dut, line << 4)

    await cpu_read(dut, 32 << 4)
    await ClockCycles(dut.clk, 1000)


# @cocotb.test()
async def address(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())
    await reset(dut)
    await cpu_write(dut, 8, 0x1234)
    await ClockCycles(dut.clk, MEM_READ_CYCLES)
    await cpu_read(dut, 0x200)
    await cpu_read(dut, 0x208)
    await ClockCycles(dut.clk, 100)
