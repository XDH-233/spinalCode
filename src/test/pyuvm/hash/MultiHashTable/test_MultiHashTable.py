import random
from enum import IntEnum

import cocotb
import pyuvm
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge
from pyuvm import *

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


class HashTableStatistics:
    def __init__(self):
        self.op_cnt = {HashTableOp.APPEND: 0, HashTableOp.DELETE: 0, HashTableOp.QUERY: 0}
        self.append_stat = {MultiHashOutStatus.SUCCESS: 0, MultiHashOutStatus.UNAVAILABLE: 0, MultiHashOutStatus.EXIST: 0}
        self.delete_success_cnt = 0
        self.delete_failure_cnt = 0
        self.query_success_cnt = 0
        self.query_failure_cnt = 0

    def __str__(self):
        string = "-" * 20 + "HASH TABLE STATISTICS" + "-" * 20 + "\n"
        string += f"Operation count: {self.op_cnt[HashTableOp.APPEND]} APPEND, {self.op_cnt[HashTableOp.DELETE]} DELETE, {self.op_cnt[HashTableOp.QUERY]} QUERY\n"
        string += f"APPEND: {MultiHashOutStatus.SUCCESS.name}: {self.append_stat[MultiHashOutStatus.SUCCESS]}, {MultiHashOutStatus.UNAVAILABLE.name}: {self.append_stat[MultiHashOutStatus.UNAVAILABLE]}, {MultiHashOutStatus.EXIST.name}: {self.append_stat[MultiHashOutStatus.EXIST]}\n"
        string += f"DELETE: {self.delete_success_cnt} success, {self.delete_failure_cnt} failure\n"
        string += f"QUERY: {self.query_success_cnt} success, {self.query_failure_cnt} failure\n"
        return string


# Sequence item and stimulus helper


class HashAccessItem(uvm_sequence_item):
    """One hash table access. On the input bus: key + op.
    On the output bus: key + op + status."""

    def __init__(self, name, key, op, status=None):
        super().__init__(name)
        self.key = key
        self.op = HashTableOp(op)
        self.status = MultiHashOutStatus(status) if status is not None else None

    def __eq__(self, other):
        same = self.key == other.key and self.op == other.op
        if self.status is not None and other.status is not None:
            same = same and self.status == other.status
        return same

    def __str__(self):
        string = f"key: 0x{self.key:016x}, op: {self.op.name}"
        if self.status is not None:
            string += f", status: {self.status.name}"
        return string

    def randomize(self, pool):
        """Op distribution: ~35% APPEND, ~30% DELETE, ~35% QUERY.
        DELETE: 1/10001 chance of a (likely missing) random key.
        APPEND/QUERY: 1000/10001 chance of re-using a stored key."""
        rand_op = random.randint(0, 100)
        if rand_op < 35:
            self.op = HashTableOp.APPEND
        elif rand_op < 65:
            self.op = HashTableOp.DELETE
        else:
            self.op = HashTableOp.QUERY

        existing_key = pool.pick_existing()
        rand_int = random.randint(0, 10000)
        if self.op is HashTableOp.DELETE:
            self.key = random.getrandbits(64) if rand_int < 1 else existing_key
            pool.note_delete(self.key)
        else:
            self.key = existing_key if rand_int < 1000 else random.getrandbits(64)
            if self.op is HashTableOp.APPEND:
                pool.note_append(self.key)


class KeyPool:
    """Tracks the keys the sequence believes are stored in the table,
    so DELETE/QUERY mostly hit existing keys (mirrors the RM view)."""

    def __init__(self):
        self.keys = []

    def pick_existing(self):
        return random.choice(self.keys) if self.keys else random.getrandbits(64)

    def note_append(self, key):
        if key not in self.keys:
            self.keys.append(key)

    def note_delete(self, key):
        if key in self.keys:
            self.keys.remove(key)


class RandomHashSeq(uvm_sequence):
    """Random APPEND/DELETE/QUERY traffic (distribution in HashAccessItem.randomize)."""

    def __init__(self, name, num_items=20000):
        super().__init__(name)
        self.num_items = num_items

    async def body(self):
        pool = KeyPool()
        for _ in range(self.num_items):
            item = HashAccessItem("item", 0, HashTableOp.APPEND)
            await self.start_item(item)
            item.randomize(pool)
            await self.finish_item(item)


# Components


class HashDriver(uvm_driver):
    async def run_phase(self):
        dut = cocotb.top
        cocotb.start_soon(Clock(dut.clk, 2, unit="ns").start())
        dut.reset.value = 1
        dut.key_valid.value = 0
        await ClockCycles(dut.clk, 10)
        dut.reset.value = 0
        await ClockCycles(dut.clk, 10)

        while True:
            item = await self.seq_item_port.get_next_item()
            dut.key_payload_key.value = item.key
            dut.key_payload_op.value = item.op.value
            dut.key_valid.value = 1
            await RisingEdge(dut.clk)
            self.seq_item_port.item_done()


class Monitor(uvm_component):
    """Samples one interface direction and publishes items on ap."""

    def __init__(self, name, parent, is_out=False):
        super().__init__(name, parent)
        self.is_out = is_out

    def build_phase(self):
        self.ap = uvm_analysis_port("ap", self)

    async def run_phase(self):
        dut = cocotb.top
        while True:
            await RisingEdge(dut.clk)
            if self.is_out:
                if dut.access_out_valid.value == 1:
                    item = HashAccessItem(
                        "out",
                        dut.access_out_payload_key.value.to_unsigned(),
                        dut.access_out_payload_op.value.to_unsigned(),
                        dut.access_out_payload_status.value.to_unsigned(),
                    )
                    self.logger.debug(f"MONITORED OUT: {item}")
                    self.ap.write(item)
            else:
                if dut.key_valid.value == 1:
                    item = HashAccessItem(
                        "in",
                        dut.key_payload_key.value.to_unsigned(),
                        dut.key_payload_op.value.to_unsigned(),
                    )
                    self.logger.debug(f"MONITORED IN: {item}")
                    self.ap.write(item)


class HashCoverage(uvm_subscriber):
    """Collects operation/status statistics from the output stream."""

    def build_phase(self):
        self.stat = HashTableStatistics()

    def write(self, item):
        if item.op is HashTableOp.APPEND:
            self.stat.op_cnt[HashTableOp.APPEND] += 1
            self.stat.append_stat[item.status] += 1
        elif item.op is HashTableOp.DELETE:
            self.stat.op_cnt[HashTableOp.DELETE] += 1
            if item.status is MultiHashOutStatus.SUCCESS:
                self.stat.delete_success_cnt += 1
            else:
                self.stat.delete_failure_cnt += 1
        elif item.op is HashTableOp.QUERY:
            self.stat.op_cnt[HashTableOp.QUERY] += 1
            if item.status is MultiHashOutStatus.SUCCESS:
                self.stat.query_success_cnt += 1
            else:
                self.stat.query_failure_cnt += 1

    def report_phase(self):
        self.logger.info(f"\n{self.stat}")


class HashTableModel:
    """Reference model: two CRC8 hash values per key, up to 8 keys per bucket."""

    MAX_BUCKET = 8

    def __init__(self, logger):
        self.table = {}
        self.log = logger

    @staticmethod
    def hash_values(key):
        data = key.to_bytes(8, "big", signed=False)
        return CRC8_CDMA2000.calculate(data), CRC8_HITAG.calculate(data)

    def access(self, item):
        """Applies one access to the model, returns the expected status."""
        key, op = item.key, item.op
        hash_cdma, hash_hitag = self.hash_values(key)

        if hash_cdma == hash_hitag:
            self.log.warning(f"RM: hash_value_cdma == hash_value_hitag: 0x{hash_cdma:02x}!")
        self.log.info(
            f"RM: key: 0x{key:016x}, op: {op.name}, crc8: 0x{hash_cdma:02x}, 0x{hash_hitag:02x}")

        cdma_entries = self.table.get(hash_cdma)
        hitag_entries = self.table.get(hash_hitag)
        cdma_exist = cdma_entries is not None and key in cdma_entries
        hitag_exist = hitag_entries is not None and key in hitag_entries
        cdma_avail = cdma_entries is not None and len(cdma_entries) < self.MAX_BUCKET
        hitag_avail = hitag_entries is not None and len(hitag_entries) < self.MAX_BUCKET

        if op is HashTableOp.APPEND:
            if cdma_exist or hitag_exist:
                self.log.warning(f"RM: APPEND key: 0x{key:016x} duplicated!")
                status = MultiHashOutStatus.EXIST
            elif cdma_avail:
                cdma_entries.append(key)
                status = MultiHashOutStatus.SUCCESS
            elif cdma_entries is None:
                self.table[hash_cdma] = [key]
                status = MultiHashOutStatus.SUCCESS
            elif hitag_avail:
                hitag_entries.append(key)
                status = MultiHashOutStatus.SUCCESS
            elif hitag_entries is None:
                self.table[hash_hitag] = [key]
                status = MultiHashOutStatus.SUCCESS
            else:
                self.log.warning(
                    f"RM: APPEND no enough space for key: 0x{key:016x}, "
                    f"crc8: 0x{hash_cdma:02x}, 0x{hash_hitag:02x}!")
                status = MultiHashOutStatus.UNAVAILABLE

            for name, hash_value in (("cdma", hash_cdma), ("hitag", hash_hitag)):
                if hash_value in self.table:
                    self.log.debug(
                        f"RM: APPEND key: 0x{key:016x} in hash_{name}: 0x{hash_value:02x}, "
                        f"entries: {[f'0x{k:x}' for k in self.table[hash_value]]}")

        elif op is HashTableOp.DELETE:
            if cdma_exist:
                cdma_entries.remove(key)
                status = MultiHashOutStatus.SUCCESS
            elif hitag_exist:
                hitag_entries.remove(key)
                status = MultiHashOutStatus.SUCCESS
            else:
                self.log.warning(f"RM: DELETE key: 0x{key:016x} not exist!")
                status = MultiHashOutStatus.NON_EXIST

        else:  # QUERY
            if cdma_exist or hitag_exist:
                status = MultiHashOutStatus.SUCCESS
            else:
                self.log.warning(f"RM: QUERY key: 0x{key:016x} not exist!")
                status = MultiHashOutStatus.NON_EXIST

        return status


class HashScoreboard(uvm_component):
    """Predicts expected outputs from the input stream with the RM,
    and compares them in order against the actual output stream."""

    def build_phase(self):
        self.in_fifo = uvm_tlm_analysis_fifo("in_fifo", self)
        self.out_fifo = uvm_tlm_analysis_fifo("out_fifo", self)
        self.exp_fifo = uvm_tlm_analysis_fifo("exp_fifo", self)
        self.model = HashTableModel(self.logger)

    def connect_phase(self):
        self.in_export = self.in_fifo.analysis_export
        self.out_export = self.out_fifo.analysis_export

    async def run_phase(self):
        cocotb.start_soon(self.predict_loop())
        cocotb.start_soon(self.check_loop())

    async def predict_loop(self):
        while True:
            item = await self.in_fifo.get()
            status = self.model.access(item)
            self.exp_fifo.analysis_export.write(
                HashAccessItem("exp", item.key, item.op, status))

    async def check_loop(self):
        while True:
            actual = await self.out_fifo.get()
            expected = await self.exp_fifo.get()
            if expected != actual:
                self.logger.error(
                    f"Access out mismatch! expected: {expected}, actual: {actual}")
                assert False, "Access out mismatch!"
            else:
                self.logger.debug(f"PASSED: {actual}")

    def check_phase(self):
        if self.exp_fifo.can_get():
            _, missed = self.exp_fifo.try_get()
            self.logger.error(f"DUT dropped output: {missed} never observed")
            assert False, "DUT dropped output!"


# Environment and test


class HashEnv(uvm_env):

    def build_phase(self):
        self.seqr = uvm_sequencer("seqr", self)
        self.driver = HashDriver.create("driver", self)
        self.in_mon = Monitor("in_mon", self)
        self.out_mon = Monitor("out_mon", self, is_out=True)
        self.scoreboard = HashScoreboard("scoreboard", self)
        self.coverage = HashCoverage("coverage", self)

    def connect_phase(self):
        self.driver.seq_item_port.connect(self.seqr.seq_item_export)
        self.in_mon.ap.connect(self.scoreboard.in_export)
        self.out_mon.ap.connect(self.scoreboard.out_export)
        self.out_mon.ap.connect(self.coverage.analysis_export)


@pyuvm.test()
class MultiHashTableTest(uvm_test):
    """Random APPEND/DELETE/QUERY traffic checked against a CRC8 dual-hash RM"""

    NUM_ITEMS = 20000

    def build_phase(self):
        self.env = HashEnv("env", self)

    async def run_phase(self):
        self.raise_objection()
        seq = RandomHashSeq("stim", self.NUM_ITEMS)
        await seq.start(self.env.seqr)
        cocotb.top.key_valid.value = 0
        await ClockCycles(cocotb.top.clk, 100)  # drain outstanding accesses
        self.drop_objection()
