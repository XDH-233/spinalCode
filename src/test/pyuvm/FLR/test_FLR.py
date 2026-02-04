import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

import logging

class Driver():
    def __init__(self, dut, name, signal_name, data_names):
        self.dut = dut
        self.name = name
        self.data_names = data_names
        self.signal_name = signal_name
        self.log = logging.getLogger(f"{name}")
        self.log.setLevel(logging.DEBUG)
        self.valid = getattr(dut, f"{signal_name}_valid")
        self.ready = getattr(dut, f"{signal_name}_ready")

    async def send(self, datas):
        for data in datas:
            await self.sending(data)

    async def sending(self, dict):
        for dn in self.data_names:
            sig = getattr(self.dut, f"{self.signal_name}_payload_{dn}")
            sig.value = dict[dn]
        self.valid.value = 1
        await RisingEdge(self.dut.clk)
        while self.ready.value != 1:
            await RisingEdge(self.dut.clk)
        self.valid.value = 0


class Monitor():
    def __init__(self, dut, name, signal_name, data_names=None):
        self.dut = dut
        self.name = name
        self.data_names = data_names
        self.signal_name = signal_name
        self.log = logging.getLogger(f"{name}")
        self.log.setLevel(logging.DEBUG)
        self.valid = getattr(dut, f"{signal_name}_valid")
        self.ready = getattr(dut, f"{signal_name}_ready")

        cocotb.start_soon(self.montoring())

    async def montoring(self):
        while True:
            await RisingEdge(self.dut.clk)
            if self.valid.value and self.ready.value:
                string = ""
                if self.data_names is None:
                    sig = getattr(self.dut, f"{self.signal_name}_payload")
                    sig_value = sig.value.to_unsigned()
                    string += f"{self.name}: 0x{sig_value:x}\n"
                else:
                    for dn in self.data_names:
                        sig = getattr(self.dut, f"{self.signal_name}_payload_{dn}")
                        sig_value = sig.value.to_unsigned()
                        string += f"{dn}: 0x{sig_value:x}\n"
                self.log.info(f"Got {self.name} data:\n{string}")


class TbFLR():
    def __init__(self,dut):
        self.dut = dut

        self.flr_cmd_drv = Driver(self.dut, "flr_cmd_driver", "flr_cmd_if", ["source_type", "function_id", "trans_id", "slot_id_cnt"])

        cocotb.start_soon(Clock(self.dut.clk, 2, unit="ns").start())

        self.destroy_cmd_mntr=Monitor(self.dut, "destroy_cmd_mntr", "qp_state_destroy_cmd", ["destroy_type", "trans_id", "queue_slot_id"])
        self.flr_done_mntr = Monitor(self.dut, "flr_done_mntr", "flr_done", ["source_type", "trans_id"])
        self.mr_fuct_id_mntr = Monitor(self.dut, "mr_fuct_id_mntr", "mpt_mtt_flr_fuct_id")


    async def reset(self):
        self.dut.reset.value = 1
        self.dut.qp_state_destroy_cmd_ready.value = 1
        self.dut.flr_done_ready.value = 1
        self.dut.mpt_mtt_flr_fuct_id_ready.value = 1
        await ClockCycles(self.dut.clk, 10)
        self.dut.reset.value = 0
        await ClockCycles(self.dut.clk, 10)

    async def slot_id_pre_fill(self,num: int):
        prefix = "slot_id_buffer_push_payload_slot_ids_"
        cycles = (num + 102) // 102
        self.dut.slot_id_buffer_push_valid.value = 1
        for c in range(cycles):
            vld_num = 0
            if num - (c+1) * 102  > 0:
                vld_num = 102
            else:
                vld_num = num - c * 102
            self.dut.slot_id_buffer_push_payload_vld_num.value = vld_num
            for i in range(102):
               sig = getattr(self.dut, prefix + str(i))
               sig.value = c * 102 + i
            await ClockCycles(self.dut.clk, 1)
        self.dut.slot_id_buffer_push_valid.value = 0



@cocotb.test()
async def smoke(dut):
    tb = TbFLR(dut)
    await tb.reset()
    await tb.slot_id_pre_fill(128)
    await ClockCycles(dut.clk, 10)
    await tb.slot_id_pre_fill(64)
    dut.flr_cmd_if_valid.value = 1
    await tb.flr_cmd_drv.send([{"source_type": 0, "function_id": 5, "trans_id": 1, "slot_id_cnt": 128}])
    await ClockCycles(dut.clk, 20)
    await tb.flr_cmd_drv.send([{"source_type": 4, "function_id": 5, "trans_id": 2, "slot_id_cnt": 32}])
    await ClockCycles(dut.clk, 20)
    await tb.flr_cmd_drv.send([{"source_type": 2, "function_id": 5, "trans_id": 3, "slot_id_cnt": 64}])
    await ClockCycles(dut.clk, 100)
    dut.qp_state_destroy_done.value = 1
    await ClockCycles(dut.clk, 128)
    dut.qp_state_destroy_done.value = 0
    await ClockCycles(dut.clk, 100)
    dut.qp_state_destroy_done.value = 1
    await ClockCycles(dut.clk, 64)
    dut.qp_state_destroy_done.value = 0
    await ClockCycles(dut.clk, 100)
    dut.mpt_mtt_flr_done.value = 1
    await RisingEdge(dut.clk)
    dut.mpt_mtt_flr_done.value = 0
    await ClockCycles(dut.clk, 100)


@cocotb.test()
async def ostd(dut):
    tb = TbFLR(dut)
    await tb.reset()
    await tb.slot_id_pre_fill(128)
    await ClockCycles(dut.clk, 10)
    await tb.slot_id_pre_fill(64)
    dut.flr_cmd_if_valid.value = 1
    await tb.flr_cmd_drv.send([{"source_type": 0, "function_id": 5, "trans_id": 1, "slot_id_cnt": 128}])
    await ClockCycles(dut.clk, 100)
    dut.qp_state_destroy_done.value = 1
    await ClockCycles(dut.clk, 128)
    dut.qp_state_destroy_done.value = 0
    await ClockCycles(dut.clk, 100)

