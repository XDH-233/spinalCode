import cocotb
import logging
import random
from copy import deepcopy
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge
from cocotb.logging import SimLog
from cocotb.utils import get_sim_time
from enum import IntEnum
from copy import deepcopy

from crc_calculator import CRC8, CRC16, CRC16_CCITT, CRC32


class HashTableOp(IntEnum):
    APPEND = 0
    DELETE = 1
    QUERY = 2

class TbHashTable():
    def __init__(self,entity,):
        self.dut = entity
        log_name = "tb_HashTable"
        log_ident = 4
        self.log = logging.getLogger(log_name)
        self.log.setLevel(logging.DEBUG)

        cocotb.start_soon(Clock(self.dut.clk, 2, unit="ns").start())
        cocotb.start_soon(self.access_in_mntr())

    async def access_in_mntr(self):
        while True:
            await RisingEdge(self.dut.clk)
            if self.dut.key_valid.value == 1:
                key_in = self.dut.key_payload_key.value.integer
                op = self.dut.key_payload_op.value.integer
                crc8 = CRC8.calculate(key_in.to_bytes(8, "little"))
                try:
                    op_enum = HashTableOp(op)
                    op_str = op_enum.name
                except ValueError:
                    op_str = f"UNKNOWN({op})"
                self.log.info(f"key: {key_in:16x}, op: {op_str:6}, crc8: {crc8:02x}")


    async def reset(self):
        self.dut.reset.value = 1
        self.dut.key_valid.value = 0
        await ClockCycles(self.dut.clk, 10)
        self.dut.reset.value = 0
        await ClockCycles(self.dut.clk, 10)


@cocotb.test
async def smoke(dut):
    tb = TbHashTable(dut)
    await tb.reset()

    for i in range(20000):
        dut.key_valid.value = 1
        dut.key_payload_key.value = random.randint(0, (1<<64)-1)
        dut.key_payload_op.value = random.randint(0, 2)
        await RisingEdge(dut.clk)
    dut.key_valid.value = 0
    await ClockCycles(dut.clk, 10)
