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

from crc_calculator import CRC8_CDMA2000, CRC16, CRC16_CCITT, CRC32


class HashTableOp(IntEnum):
    APPEND = 0
    DELETE = 1
    QUERY = 2

class HashOutStatus(IntEnum):
    SUCCESS = 0
    NON_EXIST = 1
    UNAVAILABLE = 2

class HashTableStatistics():
    def __init__(self):
        self.op_cnt = {HashTableOp.APPEND: 0, HashTableOp.DELETE: 0, HashTableOp.QUERY: 0}
        self.append_success_cnt = 0
        self.append_failure_cnt = 0
        self.delete_success_cnt = 0
        self.delete_failure_cnt = 0
        self.query_success_cnt = 0
        self.query_failure_cnt = 0

    def __str__(self):
        string = "-"*20 + "HASH TABLE STATISTICS" + "-"*20 + "\n"
        string += f"Operation count: {self.op_cnt[HashTableOp.APPEND]} APPEND, {self.op_cnt[HashTableOp.DELETE]} DELETE, {self.op_cnt[HashTableOp.QUERY]} QUERY\n"
        string += f"APPEND: {self.append_success_cnt} success, {self.append_failure_cnt} failure\n"
        string += f"DELETE: {self.delete_success_cnt} success, {self.delete_failure_cnt} failure\n"
        string += f"QUERY: {self.query_success_cnt} success, {self.query_failure_cnt} failure\n"
        return string


class TbHashTable():
    def __init__(self,entity,):
        self.dut = entity
        self.table = {}
        self.stat = HashTableStatistics()


        log_name = "tb_HashTable"
        self.log = logging.getLogger(log_name)
        self.log.setLevel(logging.DEBUG)

        cocotb.start_soon(Clock(self.dut.clk, 2, unit="ns").start())
        cocotb.start_soon(self.access_in_mntr())
        cocotb.start_soon(self.access_out_mntr())

    async def access_in_mntr(self):
        while True:
            await RisingEdge(self.dut.clk)
            if self.dut.key_valid.value == 1:
                key_in = self.dut.key_payload_key.value.to_unsigned()
                op = self.dut.key_payload_op.value.to_unsigned()
                hash_value = CRC8_CDMA2000.calculate(key_in.to_bytes(8, "big", signed=False))
                try:
                    op_enum = HashTableOp(op)
                    op_str = op_enum.name
                except ValueError:
                    op_str = f"UNKNOWN({op})"

                if op is  HashTableOp.APPEND.value:
                    if hash_value in self.table:
                        entrys = self.table[hash_value]
                        if len(entrys) < 8:
                            if key_in in entrys:
                                self.log.warning(f"RM: APPEND Key: 0x{key_in:16x} hash_value: 0x{hash_value:02x}, duplicated!")
                            self.table[hash_value].append(key_in)
                        else:
                            self.log.warning(f"RM: APPEND No enough space for key: 0x{key_in:16x}, hash_value: 0x{hash_value:02x}!")
                    else:
                        self.table[hash_value] = [key_in]
                elif op is HashTableOp.DELETE.value:
                    if hash_value in self.table:
                        entrys = self.table[hash_value]
                        if key_in in entrys:
                            entrys.remove(key_in)
                            if len(entrys) == 0:
                                self.table.pop(hash_value)
                                self.log.info(f"RM: recycle hash_value: 0x{hash_value:02x}!")
                        else:
                            self.log.warning(f"RM: DELETE Key: 0x{key_in:16x} not exist but hash_value: 0x{hash_value:02x} exist!")
                    else:
                        self.log.warning(f"RM: DELETE hash_value: 0x{hash_value:02x} not exist!")
                elif op is HashTableOp.QUERY.value:
                    pass

                self.log.info(f"Access in: key: 0x{key_in:16x}, op: {op_str:6}, crc8: 0x{hash_value:02x}")

    async def access_out_mntr(self):
        while True:
            await RisingEdge(self.dut.clk)
            if self.dut.access_out_valid.value == 1:
                op = self.dut.access_out_payload_op.value.to_unsigned()
                key = self.dut.access_out_payload_key.value.to_unsigned()
                status = self.dut.access_out_payload_status.value.to_unsigned()
                try:
                    op_enum = HashTableOp(op)
                    op_str = op_enum.name
                except ValueError:
                    op_str = f"UNKNOWN({op})"
                try:
                    status_enum = HashOutStatus(status)
                    status_str = status_enum.name
                except ValueError:
                    status_str = f"UNKNOWN({status})"
                self.log.info(f"Accesss out: key: 0x{key:16x}, op: {op_str:6}, status: {status_str}")
                if op is  HashTableOp.APPEND.value:
                    self.stat.op_cnt[HashTableOp.APPEND] += 1
                    if status_enum is HashOutStatus.SUCCESS:
                        self.stat.append_success_cnt += 1
                    else:
                        self.stat.append_failure_cnt += 1
                elif op is HashTableOp.DELETE.value:
                    self.stat.op_cnt[HashTableOp.DELETE] += 1
                    if status_enum is HashOutStatus.SUCCESS:
                        self.stat.delete_success_cnt += 1
                    else:
                        self.stat.delete_failure_cnt += 1
                elif op is HashTableOp.QUERY.value:
                    self.stat.op_cnt[HashTableOp.QUERY] += 1
                    if status_enum is HashOutStatus.SUCCESS:
                        self.stat.query_success_cnt += 1
                    else:
                        self.stat.query_failure_cnt += 1



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
        rand_op = random.randint(0, 2)
        dut.key_payload_op.value = rand_op
        rand_existed_key = 0
        rand_int = random.randint(0, 10000)
        if len(tb.table) > 0:
            rand_existed_hash_value = random.choice(list(tb.table.keys()))
            keys = tb.table[rand_existed_hash_value]
            rand_existed_key = random.choice(keys)

        if rand_op is HashTableOp.DELETE.value:
            if rand_int < 1:
                rand_existed_key = random.randint(0, (1<<64)-1) # 1 in 10,000 chance of deleting a random key, possibly an unstored key
            dut.key_payload_key.value = rand_existed_key
        else:
            if rand_int < 1:
                dut.key_payload_key.value = rand_existed_key # 1 in 10,000 chance of appending a stored key,  duplicated appending.
            else:
                dut.key_payload_key.value = random.randint(0, (1<<64)-1)
        await RisingEdge(dut.clk)
    dut.key_valid.value = 0
    await ClockCycles(dut.clk, 10)
    tb.log.info(f"{tb.stat}")
