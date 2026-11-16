import cocotb
import random
from cocotb.triggers import Timer

# 参数化 popcount: 默认 WIDTH=32, 如需测其他位宽可加 COMPILE_ARGS += -GWIDTH=n
WIDTH = 32

# 纯组合逻辑, 无时钟: 直接赋值读出比对


async def check(dut, value: int):
    dut.bits_in.value = value
    await Timer(1, unit="ns")
    got = dut.count.value.to_unsigned()
    expect = bin(value).count("1")
    assert got == expect, f"bits_in=0x{value:08x} count={got} expect={expect}"


@cocotb.test()
async def smoke(dut):
    """定向用例: 全0 全1 独热 交替模式"""
    await check(dut, 0x0000_0000)
    await check(dut, 0xFFFF_FFFF)
    await check(dut, 0xAAAA_AAAA)
    await check(dut, 0x5555_5555)
    for i in range(WIDTH):
        await check(dut, 1 << i)          # 单bit独热
        await check(dut, (1 << i) - 1)    # 低位全1, 覆盖所有计数值0~31
    await check(dut, 0xFFFF_FFFF)


@cocotb.test()
async def random_test(dut):
    """随机用例: 与 bin(v).count 参考模型比对"""
    random.seed(12345678)
    for _ in range(1000):
        await check(dut, random.getrandbits(WIDTH))
