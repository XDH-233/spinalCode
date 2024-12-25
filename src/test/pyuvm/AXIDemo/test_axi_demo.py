import itertools
import logging
import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer, ClockCycles
from cocotbext.axi import AxiBus, AxiMaster, AxiRam, AxiStreamSource, AxiStreamBus, AxiStreamFrame


class TB:
    def __init__(self, dut):
        self.dut = dut

        self.log = logging.getLogger("cocotb.tb")
        self.log.setLevel(logging.DEBUG)

        cocotb.start_soon(Clock(dut.clk, 2, units="ns").start())

        self.axi_master = AxiMaster(AxiBus.from_prefix(dut, "axi4_s"), dut.clk, dut.reset)
        self.axi_ram = AxiRam(AxiBus.from_prefix(dut, "axi4_s"), dut.clk, dut.reset, size=2 ** 16)

        self.source = AxiStreamSource(AxiStreamBus.from_prefix(dut,"axi4s_s"), dut.clk, dut.reset)

        self.axi_ram.write_if.log.setLevel(logging.DEBUG)
        self.axi_ram.read_if.log.setLevel(logging.DEBUG)

    def set_idle_generator(self, generator=None):
        if generator:
            self.axi_master.write_if.aw_channel.set_pause_generator(generator())
            self.axi_master.write_if.w_channel.set_pause_generator(generator())
            self.axi_master.read_if.ar_channel.set_pause_generator(generator())
            self.axi_ram.write_if.b_channel.set_pause_generator(generator())
            self.axi_ram.read_if.r_channel.set_pause_generator(generator())

    def set_backpressure_generator(self, generator=None):
        if generator:
            self.axi_master.write_if.b_channel.set_pause_generator(generator())
            self.axi_master.read_if.r_channel.set_pause_generator(generator())
            self.axi_ram.write_if.aw_channel.set_pause_generator(generator())
            self.axi_ram.write_if.w_channel.set_pause_generator(generator())
            self.axi_ram.read_if.ar_channel.set_pause_generator(generator())

    async def cycle_reset(self):
        self.dut.reset.setimmediatevalue(0)
        await RisingEdge(self.dut.clk)
        await RisingEdge(self.dut.clk)
        self.dut.reset.value = 1
        await RisingEdge(self.dut.clk)
        await RisingEdge(self.dut.clk)
        self.dut.reset.value = 0
        await RisingEdge(self.dut.clk)
        await RisingEdge(self.dut.clk)


# @cocotb.test()
async def run_test_write(dut):
    idle_inserter = None
    backpressure_inserter = None
    size = None

    tb = TB(dut)

    byte_lanes = tb.axi_master.write_if.byte_lanes
    max_burst_size = tb.axi_master.write_if.max_burst_size

    if size is None:
        size = max_burst_size

    await tb.cycle_reset()

    tb.set_idle_generator(idle_inserter)
    tb.set_backpressure_generator(backpressure_inserter)

    for length in list(range(1, byte_lanes * 2)) + [1024]:
        for offset in list(range(byte_lanes)) + list(range(4096 - byte_lanes, 4096)):
            tb.log.info("length %d, offset %d", length, offset)
            addr = offset + 0x1000
            test_data = bytearray([x % 256 for x in range(length)])

            tb.axi_ram.write(addr - 128, b'\xaa' * (length + 256))  # write mem

            await tb.axi_master.write(addr, test_data, size=size)  # write dut

            tb.log.debug("%s", tb.axi_ram.hexdump_str((addr & ~0xf) - 16, (((addr & 0xf) + length - 1) & ~0xf) + 48))

            assert tb.axi_ram.read(addr, length) == test_data
            assert tb.axi_ram.read(addr - 1, 1) == b'\xaa'
            assert tb.axi_ram.read(addr + length, 1) == b'\xaa'

    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)


async def run_test_read(dut, idle_inserter=None, backpressure_inserter=None, size=None):
    tb = TB(dut)

    byte_lanes = tb.axi_master.write_if.byte_lanes
    max_burst_size = tb.axi_master.write_if.max_burst_size

    if size is None:
        size = max_burst_size

    await tb.cycle_reset()

    tb.set_idle_generator(idle_inserter)
    tb.set_backpressure_generator(backpressure_inserter)

    for length in list(range(1, byte_lanes * 2)) + [1024]:
        for offset in list(range(byte_lanes)) + list(range(4096 - byte_lanes, 4096)):
            tb.log.info("length %d, offset %d", length, offset)
            addr = offset + 0x1000
            test_data = bytearray([x % 256 for x in range(length)])

            tb.axi_ram.write(addr, test_data)

            data = await tb.axi_master.read(addr, length, size=size)

            assert data.data == test_data

    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)


async def run_test_write_words(dut):
    tb = TB(dut)

    byte_lanes = tb.axi_master.write_if.byte_lanes

    await tb.cycle_reset()

    for length in list(range(1, 4)):
        for offset in list(range(byte_lanes)):
            tb.log.info("length %d, offset %d", length, offset)
            addr = offset + 0x1000

            test_data = bytearray([x % 256 for x in range(length)])
            event = tb.axi_master.init_write(addr, test_data)
            await event.wait()
            assert tb.axi_ram.read(addr, length) == test_data

            test_data = bytearray([x % 256 for x in range(length)])
            await tb.axi_master.write(addr, test_data)
            assert tb.axi_ram.read(addr, length) == test_data

            test_data = [x * 0x1001 for x in range(length)]
            await tb.axi_master.write_words(addr, test_data)
            assert tb.axi_ram.read_words(addr, length) == test_data

            test_data = [x * 0x10200201 for x in range(length)]
            await tb.axi_master.write_dwords(addr, test_data)
            assert tb.axi_ram.read_dwords(addr, length) == test_data

            test_data = [x * 0x1020304004030201 for x in range(length)]
            await tb.axi_master.write_qwords(addr, test_data)
            assert tb.axi_ram.read_qwords(addr, length) == test_data

            test_data = 0x01 * length
            await tb.axi_master.write_byte(addr, test_data)
            assert tb.axi_ram.read_byte(addr) == test_data

            test_data = 0x1001 * length
            await tb.axi_master.write_word(addr, test_data)
            assert tb.axi_ram.read_word(addr) == test_data

            test_data = 0x10200201 * length
            await tb.axi_master.write_dword(addr, test_data)
            assert tb.axi_ram.read_dword(addr) == test_data

            test_data = 0x1020304004030201 * length
            await tb.axi_master.write_qword(addr, test_data)
            assert tb.axi_ram.read_qword(addr) == test_data

    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)


async def run_test_read_words(dut):
    tb = TB(dut)

    byte_lanes = tb.axi_master.write_if.byte_lanes

    await tb.cycle_reset()

    for length in list(range(1, 4)):
        for offset in list(range(byte_lanes)):
            tb.log.info("length %d, offset %d", length, offset)
            addr = offset + 0x1000

            test_data = bytearray([x % 256 for x in range(length)])
            tb.axi_ram.write(addr, test_data)
            event = tb.axi_master.init_read(addr, length)
            await event.wait()
            assert event.data.data == test_data

            test_data = bytearray([x % 256 for x in range(length)])
            tb.axi_ram.write(addr, test_data)
            assert (await tb.axi_master.read(addr, length)).data == test_data

            test_data = [x * 0x1001 for x in range(length)]
            tb.axi_ram.write_words(addr, test_data)
            assert await tb.axi_master.read_words(addr, length) == test_data

            test_data = [x * 0x10200201 for x in range(length)]
            tb.axi_ram.write_dwords(addr, test_data)
            assert await tb.axi_master.read_dwords(addr, length) == test_data

            test_data = [x * 0x1020304004030201 for x in range(length)]
            tb.axi_ram.write_qwords(addr, test_data)
            assert await tb.axi_master.read_qwords(addr, length) == test_data

            test_data = 0x01 * length
            tb.axi_ram.write_byte(addr, test_data)
            assert await tb.axi_master.read_byte(addr) == test_data

            test_data = 0x1001 * length
            tb.axi_ram.write_word(addr, test_data)
            assert await tb.axi_master.read_word(addr) == test_data

            test_data = 0x10200201 * length
            tb.axi_ram.write_dword(addr, test_data)
            assert await tb.axi_master.read_dword(addr) == test_data

            test_data = 0x1020304004030201 * length
            tb.axi_ram.write_qword(addr, test_data)
            assert await tb.axi_master.read_qword(addr) == test_data

    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)


async def run_stress_test(dut, idle_inserter=None, backpressure_inserter=None):
    tb = TB(dut)

    await tb.cycle_reset()

    tb.set_idle_generator(idle_inserter)
    tb.set_backpressure_generator(backpressure_inserter)

    async def worker(master, offset, aperture, count=16):
        for k in range(count):
            length = random.randint(1, min(512, aperture))
            addr = offset + random.randint(0, aperture - length)
            test_data = bytearray([x % 256 for x in range(length)])

            await Timer(random.randint(1, 100), 'ns')

            await master.write(addr, test_data)

            await Timer(random.randint(1, 100), 'ns')

            data = await master.read(addr, length)
            assert data.data == test_data

    workers = []

    for k in range(16):
        workers.append(cocotb.start_soon(worker(tb.axi_master, k * 0x1000, 0x1000, count=16)))

    while workers:
        await workers.pop(0).join()

    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)

@cocotb.test()
async def write_smoke(dut):
    idle_inserter = None
    backpressure_inserter = None
    size = None

    tb = TB(dut)

    byte_lanes = tb.axi_master.write_if.byte_lanes
    max_burst_size = tb.axi_master.write_if.max_burst_size

    if size is None:
        size = max_burst_size

    await tb.cycle_reset()

    tb.set_idle_generator(idle_inserter)
    tb.set_backpressure_generator(backpressure_inserter)
    offset = 0
    #----------------------------------------Narrow Transfer------------------------------------------#
    addr = 0 + 0x1000
    length = random.randint(1, 100) #bytes
    test_data = bytearray([x % 256 for x in range(length)])
    burst_size = 0 #random.randint(0,2)
    await tb.axi_master.write(addr, test_data, size=burst_size)  # write dut

    #--------------------------------------Unaligned Transfer-----------------------------------------#
    addr = 2 + 0x1000
    length = random.randint(1, 100) #bytes
    test_data = bytearray([x % 256 for x in range(length)])
    burst_size = 2 #random.randint(0,2)
    await tb.axi_master.write(addr, test_data, size=burst_size)  # write dut

    await  ClockCycles(dut.clk, 100)

def incrementing_payload(length):
    return bytearray(itertools.islice(itertools.cycle(range(256)), length))

def size_list():
    data_width = len(cocotb.top.axi4s_s_tdata)
    byte_width = data_width // 8
    return list(range(1, byte_width*4+1)) + [512] + [1]*64

@cocotb.test()
async def axi_stream_smoke(dut):
    tb = TB(dut)

    id_count = 2**len(tb.source.bus.tid)

    cur_id = 1

    await tb.cycle_reset()
    idle_inserter = None
    backpressure_inserter = None
    tb.set_idle_generator(idle_inserter)
    tb.set_backpressure_generator(backpressure_inserter)

    test_frames = []
    payload_lengths = size_list()
    for test_data in [incrementing_payload(x) for x in payload_lengths]:
        test_frame = AxiStreamFrame(test_data)
        test_frame.tid = cur_id
        test_frame.tdest = cur_id
        await tb.source.send(test_frame)
        cur_id = (cur_id + 1) % id_count
    await  ClockCycles(dut.clk, 500)
