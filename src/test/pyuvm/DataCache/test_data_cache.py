from pyuvm import *
import cocotb
import random
from cocotb.clock               import Clock
from cocotb.triggers            import ClockCycles, RisingEdge


from cocotb.queue import Queue



class CpuSeqItem(uvm_sequence_item):
    def __init__(self, name):
        super().__init__(name)



class DataCacheBfm(metaclass=utility_classes.Singleton):
    def __init__(self):
        self.dut = cocotb.top
        self.driver_queue = Queue(maxsize=1)

    async def reset(self):
        await RisingEdge(self.dut.clk)
        self.dut.reset.value = 1
        self.dut.io_cpu_cmd_valid.value = 0
        self.dut.io_mem_cmd_ready.value = 1
        await ClockCycles(self.dut.clk, 20)
        self.dut.reset.value = 0
        await RisingEdge(self.dut.clk)


    async def send_op(self, data,channel,op):
        cmd_tuple = (data, channel,op)
        await self.driver_queue.put(cmd_tuple)

    async def driver_bfm(self):
        while True:
            await RisingEdge(self.dut.clk)
            try:
                pass #TODO
            except QueueEmpty:
                pass



    def start_bfm(self):
        cocotb.start_soon(self.driver_bfm())


async def reset(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())
    dut.reset.value = 1
    dut.reset.value = 1
    dut.io_cpu_cmd_valid.value = 0
    dut.io_mem_cmd_ready.value = 1
    dut.io_mem_rsp_valid.value = 0
    await ClockCycles(dut.clk, 20)
    dut.reset.value = 0
    await ClockCycles(dut.clk, 100)

async def cpu_read(dut,addr):
    dut.io_cpu_cmd_valid.value           = 1
    dut.io_cpu_cmd_payload_kind.value    = 0
    dut.io_cpu_cmd_payload_wr.value      = 0
    dut.io_cpu_cmd_payload_address.value = addr
    dut.io_cpu_cmd_payload_data.value    = 0
    dut.io_cpu_cmd_payload_mask.value    = 3
    dut.io_cpu_cmd_payload_bypass.value  = 0
    dut.io_cpu_cmd_payload_all.value     = 0
    await RisingEdge(dut.clk)
    dut.io_cpu_cmd_valid.value = 0
    await ClockCycles(dut.clk, 2)
    if dut.io_mem_cmd_valid.value:
        await ClockCycles(dut.clk, MEM_READ_CYCLES)
        dut.io_mem_rsp_valid.value = 1
        for _ in range(8):
            dut.io_mem_rsp_payload_data.value = random.randint(0, (1 << 16)-1)
            await RisingEdge(dut.clk)
        dut.io_mem_rsp_valid.value = 0
        await ClockCycles(dut.clk, 10)

async def cpu_write(dut, addr, data):
    dut.io_cpu_cmd_valid.value           = 1
    dut.io_cpu_cmd_payload_kind.value    = 0
    dut.io_cpu_cmd_payload_wr.value      = 1
    dut.io_cpu_cmd_payload_address.value = addr
    dut.io_cpu_cmd_payload_data.value    = data
    dut.io_cpu_cmd_payload_mask.value    = 3
    dut.io_cpu_cmd_payload_bypass.value  = 0
    dut.io_cpu_cmd_payload_all.value     = 0
    await RisingEdge(dut.clk)
    dut.io_cpu_cmd_valid.value = 0
    await ClockCycles(dut.clk, 2)
    if dut.io_mem_cmd_valid.value:
        await ClockCycles(dut.clk, MEM_READ_CYCLES)
        dut.io_mem_rsp_valid.value = 1
        for _ in range(8):
            dut.io_mem_rsp_payload_data.value = random.randint(0, (1 << 16)-1)
            await RisingEdge(dut.clk)
        dut.io_mem_rsp_valid.value = 0
        await ClockCycles(dut.clk, 10)

MEM_READ_CYCLES = 10

# @cocotb.test()
async def smoke(dut):

    await reset(dut)
    # cpu read(0)
    await cpu_read(dut,7)
    # cpu write(0x358, 0xce07)
    await cpu_write(dut,0x358, 0xce07)
    await cpu_read(dut,0x8)
    await ClockCycles(dut.clk, 10)
    await cpu_write(dut,0x350, 0xdddd)
    await ClockCycles(dut.clk, 10)
    await cpu_read(dut,0x350)
    await ClockCycles(dut.clk, 500)

# @cocotb.test()
async def fill(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())
    await reset(dut)
    for line in range(32):
        await cpu_read(dut,line << 4)

    await cpu_read(dut, 32 << 4)
    await ClockCycles(dut.clk, 1000)

@cocotb.test()
async def address(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())
    await reset(dut)
    await cpu_write(dut, 8, 0x1234)
    await ClockCycles(dut.clk, MEM_READ_CYCLES)
    await cpu_read(dut, 0x200)
    await ClockCycles(dut.clk, 100)