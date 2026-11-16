import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles



class TbMqeFifoPopCtrl():
    def __init__(self, dut):
        self.dut = dut
        cocotb.start_soon(Clock(self.dut.clk, 2, unit="ns").start())

    async def reset(self):
        self.dut.reset.value = 1
        self.dut.ostd_mqe_info_fifo_pop.value = 0
        self.dut.msqe_in_valid.value = 0
        await ClockCycles(self.dut.clk, 10)
        self.dut.reset.value = 0
        await ClockCycles(self.dut.clk, 10)

@cocotb.test()
async def somke(dut):
    tb = TbMqeFifoPopCtrl(dut)
    await tb.reset()
    dut.msqe_in_valid.value = 1
    dut.msqe_out_ready.value = 1
    dut.msqe_in_payload_cmd.value = 1
    dut.msqe_in_payload_data.value = 0x12
    await RisingEdge(dut.clk)
    dut.msqe_in_payload_cmd.value = 1
    dut.msqe_in_payload_data.value = 0x34
    await RisingEdge(dut.clk)
    dut.msqe_in_payload_cmd.value = 2
    dut.msqe_in_payload_data.value = 0x56
    await RisingEdge(dut.clk)
    dut.msqe_in_payload_cmd.value = 2
    dut.msqe_in_payload_data.value = 0x78
    await RisingEdge(dut.clk)
    dut.msqe_in_payload_cmd.value = 3
    dut.msqe_in_payload_data.value = 0x9a
    await RisingEdge(dut.clk)
    dut.msqe_in_valid.value = 0
    await RisingEdge(dut.clk)
    await ClockCycles(dut.clk, 10)
    dut.ostd_mqe_info_fifo_pop.value = 1
    await ClockCycles(dut.clk, 2)
    dut.ostd_mqe_info_fifo_pop.value = 0
    await ClockCycles(dut.clk, 10)
    dut.ostd_mqe_info_fifo_pop.value = 1
    await ClockCycles(dut.clk, 2)
    dut.ostd_mqe_info_fifo_pop.value = 0
    await ClockCycles(dut.clk, 10)
    dut.ostd_mqe_info_fifo_pop.value = 1
    await ClockCycles(dut.clk, 1)
    dut.ostd_mqe_info_fifo_pop.value = 0
    dut.msqe_in_valid.value = 1
    dut.msqe_out_ready.value = 1
    dut.msqe_in_payload_cmd.value = 1
    dut.msqe_in_payload_data.value = 0x12
    await RisingEdge(dut.clk)
    dut.msqe_in_valid.value = 0
    await RisingEdge(dut.clk)
    await ClockCycles(dut.clk, 5)
    dut.ostd_mqe_info_fifo_pop.value = 1
    await ClockCycles(dut.clk, 1)
    dut.ostd_mqe_info_fifo_pop.value = 0
    await ClockCycles(dut.clk, 5)

    dut.msqe_in_valid.value = 1
    dut.msqe_out_ready.value = 1
    dut.msqe_in_payload_cmd.value = 2
    dut.msqe_in_payload_data.value = 0x34
    await RisingEdge(dut.clk)
    dut.msqe_in_valid.value = 0
    await RisingEdge(dut.clk)
    await ClockCycles(dut.clk, 10)


@cocotb.test()
async def flr_qp(dut):
    tb = TbMqeFifoPopCtrl(dut)
    await tb.reset()
    dut.msqe_in_valid.value = 1
    dut.msqe_out_ready.value = 1
    dut.msqe_in_payload_cmd.value = 1
    dut.msqe_in_payload_data.value = 0x12
    await RisingEdge(dut.clk)
    dut.msqe_in_payload_cmd.value = 22
    dut.msqe_in_payload_data.value = 0x34
    await RisingEdge(dut.clk)
    dut.msqe_in_valid.value = 0
    await RisingEdge(dut.clk)
    await ClockCycles(dut.clk, 100)