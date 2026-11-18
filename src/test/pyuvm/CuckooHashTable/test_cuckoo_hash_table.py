import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge, ClockCycles

APPEND, DELETE, QUERY = 0, 1, 2
SUCCESS, NON_EXIST, UNAVAILABLE, EXIST = 0, 1, 2, 3
MASK64 = (1 << 64) - 1


class CuckooTB:
    def __init__(self, dut):
        self.dut = dut
        # positional units arg works on both cocotb 1.x ("units") and 2.x ("unit")
        cocotb.start_soon(Clock(dut.clk, 2, "ns").start())
        dut.key_valid.value = 0
        dut.key_payload_key.value = 0
        dut.key_payload_op.value = 0
        dut.access_out_ready.value = 1

    async def reset(self):
        self.dut.reset.value = 1
        await ClockCycles(self.dut.clk, 8)
        self.dut.reset.value = 0
        await ClockCycles(self.dut.clk, 4)
        # FPGA 上 BRAM 上电为 0；Verilator 不保证。显式清零，保证仿真可复现。
        for i in range(256):
            self.dut.table_1[i].value = 0
        await ClockCycles(self.dut.clk, 2)

    async def op(self, key, op):
        """One op at a time: drive on falling edge, sample ready there, sample response there."""
        dut = self.dut
        key &= MASK64
        while True:
            await FallingEdge(dut.clk)
            dut.key_valid.value = 1
            dut.key_payload_key.value = key
            dut.key_payload_op.value = op
            if dut.key_ready.value:
                break
        # accepted at the next rising edge
        await RisingEdge(dut.clk)
        dut.key_valid.value = 0
        while True:
            await FallingEdge(dut.clk)
            if dut.access_out_valid.value:
                return (
                    int(dut.access_out_payload_key.value),
                    int(dut.access_out_payload_op.value),
                    int(dut.access_out_payload_status.value),
                )

    async def op_probe(self, key, op):
        """同 op()，但额外返回 S1 拍的 hit0/hit1/stashHit，用于确认 stash 命中来源。"""
        dut = self.dut
        key &= MASK64
        while True:
            await FallingEdge(dut.clk)
            dut.key_valid.value = 1
            dut.key_payload_key.value = key
            dut.key_payload_op.value = op
            if dut.key_ready.value:
                break
        await RisingEdge(dut.clk)
        dut.key_valid.value = 0
        while True:
            await FallingEdge(dut.clk)
            if dut.access_out_valid.value:
                return (
                    int(dut.access_out_payload_status.value),
                    int(dut.hit0.value),
                    int(dut.hit1.value),
                    int(dut.stashHit.value),
                )


class Model:
    def __init__(self):
        self.keys = set()

    def check(self, key, op, resp):
        rkey, rop, rstatus = resp
        assert rkey == key, f"key mismatch: sent {key:#x}, got {rkey:#x}"
        assert rop == op, f"op mismatch: sent {op}, got {rop}"

        if op == APPEND:
            if key in self.keys:
                assert rstatus == EXIST, f"append existing {key:#x} -> {rstatus}"
            else:
                assert rstatus in (SUCCESS, UNAVAILABLE), (
                    f"append new {key:#x} -> unexpected status {rstatus}"
                )
                if rstatus == SUCCESS:
                    self.keys.add(key)
        elif op == DELETE:
            if key in self.keys:
                assert rstatus == SUCCESS, f"delete present {key:#x} -> {rstatus}"
                self.keys.remove(key)
            else:
                assert rstatus == NON_EXIST, f"delete absent {key:#x} -> {rstatus}"
        else:
            expected = SUCCESS if key in self.keys else NON_EXIST
            assert rstatus == expected, (
                f"query {key:#x} (present={key in self.keys}) -> {rstatus}, expected {expected}"
            )


def unique_keys(rng, used, n):
    out = []
    while len(out) < n:
        k = rng.getrandbits(64)
        if k not in used:
            used.add(k)
            out.append(k)
    return out


async def burst(tb, ops):
    """Drive ops back-to-back (1/cycle when ready), collect responses in order."""
    dut = tb.dut
    responses = []

    async def collector():
        while len(responses) < len(ops):
            await FallingEdge(dut.clk)
            if dut.access_out_valid.value:
                responses.append(
                    (
                        int(dut.access_out_payload_key.value),
                        int(dut.access_out_payload_op.value),
                        int(dut.access_out_payload_status.value),
                    )
                )

    col = cocotb.start_soon(collector())
    for key, op in ops:
        while True:
            await FallingEdge(dut.clk)
            # 在同一 falling edge 同时给 payload/valid 并采样 ready，
            # 避免第一个 payload 到来前 valid 已经为高而收进上一笔残留数据
            dut.key_valid.value = 1
            dut.key_payload_key.value = key & MASK64
            dut.key_payload_op.value = op
            if dut.key_ready.value:
                break
    # 最后一笔要等接受它的 rising edge 之后再撤 valid
    await RisingEdge(dut.clk)
    dut.key_valid.value = 0
    await col
    return responses


@cocotb.test()
async def test_cuckoo(dut):
    rng = random.Random(0xC0C0)
    tb = CuckooTB(dut)
    model = Model()
    used = set()
    await tb.reset()

    # ---------------------------------------------------------- directed
    keys = unique_keys(rng, used, 16)
    for k in keys:
        model.check(k, APPEND, await tb.op(k, APPEND))
    for k in keys:
        model.check(k, QUERY, await tb.op(k, QUERY))
    model.check(keys[3], APPEND, await tb.op(keys[3], APPEND))
    model.check(keys[5], DELETE, await tb.op(keys[5], DELETE))
    model.check(keys[5], DELETE, await tb.op(keys[5], DELETE))
    model.check(keys[5], QUERY, await tb.op(keys[5], QUERY))
    for k in keys[6:]:
        model.check(k, QUERY, await tb.op(k, QUERY))

    # ---------------------------------------------------------- fill to ~88%
    fill = unique_keys(rng, used, 900 - len(model.keys))
    for k in fill:
        model.check(k, APPEND, await tb.op(k, APPEND))
    assert len(model.keys) >= 850, f"too few keys inserted: {len(model.keys)}"

    # ---------------------------------------------------------- random mixed
    hot = rng.sample(sorted(model.keys), 400)
    for _ in range(1500):
        k = rng.choice(hot)
        r = rng.random()
        if r < 0.45:
            op = QUERY
        elif r < 0.75:
            op = APPEND
        else:
            op = DELETE
        model.check(k, op, await tb.op(k, op))

    # ---------------------------------------------------------- back-to-back burst
    burst_keys = unique_keys(rng, used, 400)
    ops = [(k, APPEND) for k in burst_keys]
    ops += [(rng.choice(burst_keys), QUERY) for _ in range(200)]
    responses = await burst(tb, ops)
    assert len(responses) == len(ops), f"got {len(responses)} responses for {len(ops)} ops"
    for (k, op), resp in zip(ops, responses):
        model.check(k, op, resp)

    # ---------------------------------------------------------- final consistency check
    check_keys = rng.sample(sorted(model.keys), min(200, len(model.keys)))
    for k in check_keys:
        model.check(k, QUERY, await tb.op(k, QUERY))
    for k in list(model.keys)[:50]:
        model.check(k, DELETE, await tb.op(k, DELETE))
        model.check(k, QUERY, await tb.op(k, QUERY))

    dut._log.info(f"final model size = {len(model.keys)}")


@cocotb.test()
async def test_stash_hit(dut):
    """确定性覆盖 stashHit 与 stash 清零。"""
    # 这 5 个 key 满足 h0(key) == h1(key) == 0x2E
    # （CRC-8 poly 0x9B / 0x1D，init 0xFF）：
    # - 前 4 个填满唯一候选桶 0x2E；
    # - 第 5 个 APPEND 触发慢路径，victim 的另一个候选桶仍是 0x2E，
    #   无法改投，必然写入 stash；
    # - QUERY 该 victim 应命中 stash（hit0=hit1=0, stashHit=1），
    #   DELETE 后 stash 应清空。
    keys = [
        0x251102E6425AE758,
        0x612F83873F6C5692,
        0x5B0628C6BAFC2FF2,
        0xEB6CC59392B0CEC2,
        0x21231802221AA2A9,
    ]
    tb = CuckooTB(dut)
    await tb.reset()

    # 前 4 个 key 走快路径填满桶 0x2E
    for k in keys[:4]:
        status = (await tb.op(k, APPEND))[2]
        assert status == SUCCESS, f"fill append {k:#x} -> {status}"

    # 第 5 个 key：两桶全满（h0==h1），victim 无法改投 -> stash
    status = (await tb.op(keys[4], APPEND))[2]
    assert status == SUCCESS, f"trigger append -> {status}"
    await ClockCycles(dut.clk, 2)  # FINISH fire 时 stash 写寄存器

    stash_bits = int(dut.stashValid.value)
    dut._log.info("stashValid = %s", format(stash_bits, "04b"))
    assert stash_bits != 0, "stash was not populated"

    stashed = []
    for i in range(4):
        if (stash_bits >> i) & 1:
            stashed.append((i, int(getattr(dut, f"stashKey_{i}").value)))
    assert len(stashed) == 1, f"expected exactly 1 stashed key, got {[hex(k) for _, k in stashed]}"
    victim_idx, victim = stashed[0]
    assert victim in keys[:4], f"stashed key {victim:#x} is not one of the filled keys"
    dut._log.info("victim %#x in stash slot %d", victim, victim_idx)

    # QUERY stash 中的 key：必须是 stashHit，而不是桶命中
    status, h0, h1, sh = await tb.op_probe(victim, QUERY)
    dut._log.info(
        "stash query: status=%d hit0=%d hit1=%d stashHit=%d", status, h0, h1, sh
    )
    assert status == SUCCESS, f"query stashed {victim:#x} -> {status}"
    assert h0 == 0 and h1 == 0, f"stashed key should not hit buckets, got hit0={h0} hit1={h1}"
    assert sh == 1, "stashHit was not asserted"

    # 其余 4 个 key 仍然能通过桶命中
    for k in keys:
        if k == victim:
            continue
        status = (await tb.op(k, QUERY))[2]
        assert status == SUCCESS, f"query {k:#x} -> {status}"

    # DELETE stash 项：清 valid，之后查不到
    status = (await tb.op(victim, DELETE))[2]
    assert status == SUCCESS
    await ClockCycles(dut.clk, 2)
    assert int(dut.stashValid.value) == 0, "stash valid was not cleared by DELETE"

    status = (await tb.op(victim, QUERY))[2]
    assert status == NON_EXIST, f"query deleted stashed {victim:#x} -> {status}"
    for k in keys:
        if k == victim:
            continue
        status = (await tb.op(k, QUERY))[2]
        assert status == SUCCESS, f"query {k:#x} after delete -> {status}"
