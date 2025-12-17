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

from crc_calculator import CRC8_CDMA2000, CRC8_HITAG


class HashTableOp(IntEnum):
    APPEND = 0
    DELETE = 1
    QUERY = 2

class MultiHashOutStatus(IntEnum):
    SUCCESS = 0
    NON_EXIST = 1
    UNAVAILABLE = 2
    EXIST = 3

class HashAccessOut():
    def __init__(self, key, op, status):
        self.key = key
        self.op = op
        self.status = status

    def __str__(self):
        return f"HashAccessOut: key: {self.key:16x}, op: {self.op.name}, status: {self.status.name}"


class HashTableStatistics():
    def __init__(self):
        self.op_cnt = {HashTableOp.APPEND: 0, HashTableOp.DELETE: 0, HashTableOp.QUERY: 0}
        self.append_stat = {MultiHashOutStatus.SUCCESS: 0, MultiHashOutStatus.UNAVAILABLE: 0, MultiHashOutStatus.EXIST: 0}
        self.append_success_cnt = 0
        self.append_failure_cnt = 0
        self.delete_success_cnt = 0
        self.delete_failure_cnt = 0
        self.query_success_cnt = 0
        self.query_failure_cnt = 0

    def __str__(self):
        string = "-"*20 + "HASH TABLE STATISTICS" + "-"*20 + "\n"
        string += f"Operation count: {self.op_cnt[HashTableOp.APPEND]} APPEND, {self.op_cnt[HashTableOp.DELETE]} DELETE, {self.op_cnt[HashTableOp.QUERY]} QUERY\n"
        string += f"APPEND: {MultiHashOutStatus.SUCCESS.name}: {self.append_stat[MultiHashOutStatus.SUCCESS]}, {MultiHashOutStatus.UNAVAILABLE.name}: {self.append_stat[MultiHashOutStatus.UNAVAILABLE]}, {MultiHashOutStatus.EXIST.name}: {self.append_stat[MultiHashOutStatus.EXIST]}\n"
        string += f"DELETE: {self.delete_success_cnt} success, {self.delete_failure_cnt} failure\n"
        string += f"QUERY: {self.query_success_cnt} success, {self.query_failure_cnt} failure\n"
        return string


class TbMultiHashTable():
    def __init__(self,entity,):
        self.dut = entity
        self.table = {}
        self.stat = HashTableStatistics()
        self.exp = []


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
                hash_value_cdma = CRC8_CDMA2000.calculate(key_in.to_bytes(8, "big", signed=False))
                hash_value_hitag = CRC8_HITAG.calculate(key_in.to_bytes(8, "big", signed=False))

                if hash_value_cdma == hash_value_hitag:
                    self.log.warning(f"RM: hash_value_cdma == hash_value_hitag: 0x{hash_value_cdma:02x}!")

                try:
                    op_enum = HashTableOp(op)
                    op_str = op_enum.name
                except ValueError:
                    op_str = f"UNKNOWN({op})"

                self.log.info(f"Access in: key: {key_in:16x}, op: {op_str:6}, crc8: 0x{hash_value_cdma:02x}, 0x{hash_value_hitag:02x}")
                cmda_exist = False
                hitag_exist = False
                cdma_avail = False
                hitag_avail = False
                cmda_hash_not_exist = False
                hitag_hash_not_exist = False
                if hash_value_cdma in self.table:
                    entrys_cmda_hash = self.table[hash_value_cdma]
                    cmda_exist = key_in in entrys_cmda_hash
                    cdma_avail = len(entrys_cmda_hash) < 8
                else:
                    cmda_hash_not_exist = True

                if hash_value_hitag in self.table:
                    entrys_hitag_hash = self.table[hash_value_hitag]
                    hitag_exist = key_in in entrys_hitag_hash
                    hitag_avail = len(entrys_hitag_hash) < 8
                else:
                    hitag_hash_not_exist = True

                if op is  HashTableOp.APPEND.value:
                    if cmda_exist or hitag_exist:
                        self.log.warning(f"RM: APPEND Key: {key_in:16x} hash_value: 0x{hash_value_cdma:02x}, duplicated!")
                        self.exp.append(HashAccessOut(key_in, op_enum, MultiHashOutStatus.EXIST))
                    elif cdma_avail :
                        self.table[hash_value_cdma].append(key_in)
                        self.exp.append(HashAccessOut(key_in, op_enum, MultiHashOutStatus.SUCCESS))
                    elif cmda_hash_not_exist:
                        self.table[hash_value_cdma] = [key_in]
                        self.exp.append(HashAccessOut(key_in, op_enum, MultiHashOutStatus.SUCCESS))
                    elif hitag_avail:
                        self.table[hash_value_hitag].append(key_in)
                        self.exp.append(HashAccessOut(key_in, op_enum, MultiHashOutStatus.SUCCESS))
                    elif hitag_hash_not_exist:
                        self.table[hash_value_hitag] = [key_in]
                        self.exp.append(HashAccessOut(key_in, op_enum, MultiHashOutStatus.SUCCESS))
                    else:
                        self.log.warning(f"RM: APPEND No enough space for key: {key_in:16x}, cmda_hash_value: 0x{hash_value_cdma:02x}, hitag_hash_value: 0x{hash_value_hitag:02x}!")
                        self.exp.append(HashAccessOut(key_in, op_enum, MultiHashOutStatus.UNAVAILABLE))

                    if hash_value_cdma in self.table:
                        string = ""
                        for key in self.table[hash_value_cdma]:
                            string += f"{key:16x}, "
                        self.log.debug(f"RM: APPEND Key: {key_in:16x} in hash_value_cdma: 0x{hash_value_cdma:02x}, entrys: {string}")
                    if hash_value_hitag in self.table:
                        string = ""
                        for key in self.table[hash_value_hitag]:
                            string += f"{key:16x}, "
                        self.log.debug(f"RM: APPEND Key: {key_in:16x} in hash_value_hitag: 0x{hash_value_hitag:02x}, entrys: {string}")


                elif op is HashTableOp.DELETE.value:
                    if cmda_exist:
                        self.table[hash_value_cdma].remove(key_in)
                        self.exp.append(HashAccessOut(key_in, op_enum, MultiHashOutStatus.SUCCESS))
                    elif hitag_exist:
                        self.table[hash_value_hitag].remove(key_in)
                        self.exp.append(HashAccessOut(key_in, op_enum, MultiHashOutStatus.SUCCESS))
                    else:
                        self.log.warning(f"RM: DELETE Key: {key_in:16x} not exist!")
                        self.exp.append(HashAccessOut(key_in, op_enum, MultiHashOutStatus.NON_EXIST))

                elif op is HashTableOp.QUERY.value:
                    if cmda_exist or hitag_exist:
                        self.exp.append(HashAccessOut(key_in, op_enum, MultiHashOutStatus.SUCCESS))
                    else:
                        self.log.warning(f"RM: QUERY Key: {key_in:16x} not exist!")
                        self.exp.append(HashAccessOut(key_in, op_enum, MultiHashOutStatus.NON_EXIST))



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
                    status_enum = MultiHashOutStatus(status)
                    status_str = status_enum.name
                except ValueError:
                    status_str = f"UNKNOWN({status})"
                self.log.info(f"Accesss out: key: {key:16x}, op: {op_str:6}, status: {status_str}")
                if op is  HashTableOp.APPEND.value:
                    self.stat.op_cnt[HashTableOp.APPEND] += 1
                    self.stat.append_stat[status_enum] += 1

                elif op is HashTableOp.DELETE.value:
                    self.stat.op_cnt[HashTableOp.DELETE] += 1
                    if status_enum is MultiHashOutStatus.SUCCESS:
                        self.stat.delete_success_cnt += 1
                    else:
                        self.stat.delete_failure_cnt += 1
                elif op is HashTableOp.QUERY.value:
                    self.stat.op_cnt[HashTableOp.QUERY] += 1
                    if status_enum is MultiHashOutStatus.SUCCESS:
                        self.stat.query_success_cnt += 1
                    else:
                        self.stat.query_failure_cnt += 1


                if len(self.exp) == 0:
                    self.log.error(f"Expected access out is empty!")
                    assert False, "Expected access out is empty!"
                else:
                    exp = self.exp.pop(0)
                    if exp.key != key or exp.op != op_enum or exp.status != status_enum:
                        self.log.error(f"Access out mismatch! expected: {exp}, actual: key: {key:16x}, op: {op_enum.name}, status: {status_enum.name}")
                        assert False, "Access out mismatch!"




    async def reset(self):
        self.dut.reset.value = 1
        self.dut.key_valid.value = 0
        await ClockCycles(self.dut.clk, 10)
        self.dut.reset.value = 0
        await ClockCycles(self.dut.clk, 10)


@cocotb.test
async def smoke(dut):
    tb = TbMultiHashTable(dut)
    await tb.reset()

    for i in range(20000):
        dut.key_valid.value = 1
        rand_op_int = random.randint(0, 100)
        rand_op = 0
        if rand_op_int < 35:
            rand_op = 0
        elif rand_op_int < 65:
            rand_op = 1
        else:
            rand_op = 2
        dut.key_payload_op.value = rand_op
        rand_key = random.randint(0, (1<<64)-1) # 1 in 10,000 chance of deleting a random key, possibly an unstored key
        rand_existed_key = rand_key
        rand_int = random.randint(0, 10000)
        if len(tb.table) > 0:
            rand_existed_hash_value = random.choice(list(tb.table.keys()))
            keys = tb.table[rand_existed_hash_value]
            if len(keys) > 0:
                rand_existed_key = random.choice(keys)

        if rand_op is HashTableOp.DELETE.value:
            if rand_int < 1:
                rand_existed_key = rand_key
            dut.key_payload_key.value = rand_existed_key
        else:
            if rand_int < 1000:
                dut.key_payload_key.value = rand_existed_key # 1 in 1000 chance of appending a stored key,  duplicated appending.
            else:
                dut.key_payload_key.value = random.randint(0, (1<<64)-1)
        await RisingEdge(dut.clk)
    dut.key_valid.value = 0
    await ClockCycles(dut.clk, 10)
    tb.log.info(f"{tb.stat}")
