import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer


class RtmDriver:
    """RadixIdTree (radix-4 id manager) 的 cocotb 测试环境 + python 参考模型。

    参考模型: free 集合, alloc = 弹出最小元素, recycle = 放回。
    所有用例通过 dut.avail_id_payload 宽度自适应 id_num，可直接跑
    `make regress` 遍历 ID_NUMS 中的任意参数组合。
    """

    def __init__(self, dut):
        self.dut = dut
        self.id_num = 1 << len(dut.avail_id_payload)
        self.free = set(range(self.id_num))
        self.clk = Clock(dut.clk, 10, unit="ns")
        cocotb.start_soon(self.clk.start())

    # ---------------- 低层读写 ----------------
    async def reset(self):
        self.dut.reset.value = 1
        self.dut.avail_id_ready.value = 0
        self.dut.recycle_id_valid.value = 0
        self.dut.recycle_id_payload.value = 0
        await Timer(1, unit="ns")
        await RisingEdge(self.dut.clk)
        self.dut.reset.value = 0
        await Timer(1, unit="ns")

    async def tick(self):
        await RisingEdge(self.dut.clk)
        await Timer(1, unit="ns")

    # ---------------- 参考模型 ----------------
    def do_alloc_model(self):
        self.free.discard(min(self.free))

    def do_recycle_model(self, id_):
        assert id_ in self.allocated(), f"recycle non-allocated id {id_}"
        self.free.add(id_)

    def allocated(self):
        return set(range(self.id_num)) - self.free

    # ---------------- 检查 ----------------
    def check(self, msg=""):
        vld = int(self.dut.avail_id_valid.value)
        cnt = int(self.dut.avail_cnt.value)
        assert vld == int(bool(self.free)), f"{msg} avail_id.valid={vld} != free:{self.free}"
        assert cnt == len(self.free), f"{msg} avail_cnt={cnt} != {len(self.free)}"
        if self.free:
            exp = min(self.free)
            got = int(self.dut.avail_id_payload.value)
            assert got == exp, f"{msg} avail_id={got} != min(free)={exp}"

    async def alloc(self):
        """握手弹出当前 avail_id 并更新模型"""
        assert int(self.dut.avail_id_valid.value) == 1
        exp = int(self.dut.avail_id_payload.value)
        assert exp == min(self.free), f"avail_id={exp} != min(free)={min(self.free)}"
        self.dut.avail_id_ready.value = 1
        await self.tick()
        self.dut.avail_id_ready.value = 0
        self.free.discard(exp)
        return exp

    async def recycle(self, id_):
        self.dut.recycle_id_valid.value = 1
        self.dut.recycle_id_payload.value = id_
        await self.tick()
        self.dut.recycle_id_valid.value = 0
        self.free.add(id_)


@cocotb.test()
async def test_alloc_all_order(dut):
    """从空到满依次分配, 必须严格按 0..N-1 顺序给出"""
    env = RtmDriver(dut)
    await env.reset()
    for i in range(env.id_num):
        got = await env.alloc()
        env.check(f"after alloc #{i}")
        assert got == i, f"alloc got {got}, expect {i}"
    await env.tick()
    assert int(dut.avail_id_valid.value) == 0, "valid must drop when full"
    assert int(dut.avail_cnt.value) == 0


@cocotb.test()
async def test_recycle_reuse(dut):
    """回收后立即复用, 且严格按最低 id 优先（任意 id_num 自适应）"""
    env = RtmDriver(dut)
    await env.reset()
    n = env.id_num
    for _ in range(n):
        await env.alloc()
    # 乱序回收若干个 id（数量随 n 缩放，至少 4 个），每次回收后立刻比对
    k = min(n, max(4, n // 16))
    rids = random.Random(7).sample(range(n), k)
    for rid in rids:
        await env.recycle(rid)
        env.check(f"after recycle {rid}")
    # 逐个弹出, 必须严格按 min(free) 顺序（alloc 内部已断言 payload == min(free)）
    for _ in range(k):
        await env.alloc()
        env.check("after realloc")


@cocotb.test()
async def test_alloc_recycle_same_cycle(dut):
    """同周期 alloc + recycle: alloc 优先, 该 id 不应再被给出"""
    env = RtmDriver(dut)
    await env.reset()
    n = env.id_num
    for _ in range(n):
        await env.alloc()
    r1, r2 = n // 3, 2 * n // 3
    await env.recycle(r1)
    await env.recycle(r2)
    # 同拍: alloc 走 min(free)=r1, 同时再回收 r2（不同 id 的同拍并行）
    dut.avail_id_ready.value = 1
    dut.recycle_id_valid.value = 1
    dut.recycle_id_payload.value = r2
    await RisingEdge(dut.clk)
    await Timer(1, unit="ns")
    dut.avail_id_ready.value = 0
    dut.recycle_id_valid.value = 0
    env.free.discard(r1)  # alloc 走了 r1
    env.check(f"same-cycle alloc({r1})+recycle({r2})")


@cocotb.test()
async def test_recycle_all_back(dut):
    """打满 -> 全部回收（乱序）-> 恢复全空 -> 再次严格顺序分配"""
    env = RtmDriver(dut)
    await env.reset()
    n = env.id_num
    for _ in range(n):
        await env.alloc()
    order = random.Random(42).sample(range(n), n)
    for rid in order:
        await env.recycle(rid)
    env.check("all recycled")
    assert int(dut.avail_id_valid.value) == 1
    assert int(dut.avail_cnt.value) == n
    for i in range(n):
        got = await env.alloc()
        assert got == i, f"after full recycle, alloc got {got}, expect {i}"


@cocotb.test()
async def test_fill_drain_rounds(dut):
    """多轮'打满->回收一半->再打满'的压力往返, 全程比对"""
    env = RtmDriver(dut)
    await env.reset()
    n = env.id_num
    rng = random.Random(99)
    outstanding = []
    for _round in range(3):
        while env.free:
            outstanding.append(await env.alloc())
        env.check(f"round{_round} full")
        # 回收约一半
        k = len(outstanding) // 2
        for _ in range(k):
            rid = outstanding.pop(rng.randrange(len(outstanding)))
            await env.recycle(rid)
        env.check(f"round{_round} drained half")
        # 继续打满
        while env.free:
            outstanding.append(await env.alloc())
        env.check(f"round{_round} refill")
    assert len(outstanding) == n


@cocotb.test()
async def test_double_recycle_harmless(dut):
    """协议外场景: 重复回收同一 id 只造成叶层重复置 1, 硬件无危害,
    后续分配顺序仍正确（记录当前实现的行为边界）"""
    env = RtmDriver(dut)
    await env.reset()
    n = env.id_num
    for _ in range(n):
        await env.alloc()
    rid = n - 1
    await env.recycle(rid)
    await env.recycle(rid)  # double recycle
    env.free.add(rid)       # 模型按幂等处理
    env.check("after double recycle")
    got = await env.alloc()
    assert got == rid, f"expect {rid}, got {got}"


@cocotb.test()
async def test_random(dut):
    """随机 alloc/recycle 与参考模型全程比对"""
    env = RtmDriver(dut)
    random.seed(31337)
    await env.reset()
    outstanding = []
    for i in range(4000):
        if outstanding and random.random() < 0.45:
            rid = outstanding.pop(random.randrange(len(outstanding)))
            await env.recycle(rid)
        elif env.free:
            got = await env.alloc()
            outstanding.append(got)
        else:
            rid = outstanding.pop(random.randrange(len(outstanding)))
            await env.recycle(rid)
        if i % 7 == 0:
            env.check(f"random step {i}")
    env.check("random end")
    assert len(outstanding) + len(env.free) == env.id_num
