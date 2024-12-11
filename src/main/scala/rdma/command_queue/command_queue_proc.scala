package rdma.command_queue

import intel_ip.rdma_ctyun_sdpram._
import intel_ip.rdma_ctyun_sfifo._
import rdma.command_queue.DMAFun.{db_id2cmdqe_phy_addr, gen_dma_rreq, gen_dma_wreq}
import spinal.core._
import spinal.lib.bus.avalon.{AvalonST, AvalonSTPayload}
import spinal.lib._
import tool.BusExt.AvstExt

import scala.language.postfixOps

case class command_queue_proc(cmdqSize: Int = 32) extends Component {

  val io = new Bundle {
    val db_vec_s:        Stream[Bits] = slave Stream (Bits(cmdqSize bits))
    val dma_rreq_m:      AvalonST     = master(AvalonST(AvstConfig.dmaRReqConfig))
    val dma_rrsp_s:      AvalonST     = slave(AvalonST(AvstConfig.dmaRRspWReqConfig))
    val dma_wreq_m:      AvalonST     = master(AvalonST(AvstConfig.dmaRRspWReqConfig))
    val cmdq_phy_addr_i: UInt         = in UInt (64 bits)
    val cmd_req:         AvalonST     = master(AvalonST(AvstConfig.cmdReqConfig))
    val cmd_rsp:         AvalonST     = slave(AvalonST(AvstConfig.cmdRspConfig))
  }
  noIoPrefix()
  val db_id_for_err_push:          Stream[UInt] = Stream(UInt(log2Up(cmdqSize) bits))
  val db_id_for_err_pop:           Stream[UInt] = buffer(db_id_for_err_push, cmdqSize)
  val cmd_id_for_cmd_req_gen_push: Stream[UInt] = Stream(UInt(log2Up(cmdqSize) bits))
  val cmd_id_for_cmd_req_gen_pop:  Stream[UInt] = buffer(cmd_id_for_cmd_req_gen_push, cmdqSize)
  val db_id:                       UInt         = OHToUInt(io.db_vec_s.payload)

  val cmdq_phy_addr_reg: UInt    = RegNext(io.cmdq_phy_addr_i) init 0
  val cmdqe_phy_addr:    UInt    = db_id2cmdqe_phy_addr(db_id, cmdq_phy_addr_reg)
  val cmd_id_mngr:       id_mngr = id_mngr(cmdqSize)
  val cmd_id:            UInt    = cmd_id_mngr.io.fetch.payload

  val cmd_id_finish_err_cmdqe_push: Stream[UInt] = Stream(UInt(5 bits))
  val cmd_id_finish_err_cmdqe_pop:  Stream[UInt] = buffer(cmd_id_finish_err_cmdqe_push, cmdqSize)
  val cmd_id_finish_cmd_rsp_push:   Stream[UInt] = Stream(UInt(5 bits))
  val cmd_id_finish_cmd_rsp_pop:    Stream[UInt] = buffer(cmd_id_finish_cmd_rsp_push, cmdqSize)
  val cmd_id_fihish_arbi:           Stream[UInt] = StreamArbiterFactory.lowerFirst.onArgs(cmd_id_finish_err_cmdqe_pop, cmd_id_finish_cmd_rsp_pop)

  // cmdqe_phy_addr_ram

  // dma_ctrl
  val cmdqe_dma_rreq_st:     Stream[DMARReqDesc]        = Stream(DMARReqDesc())
  val mb_dma_rreq_st:        Stream[DMARReqDesc]        = Stream(DMARReqDesc())
  val cmdqe_dma_rrsp_st:     Stream[CmdqEntry]          = Stream(CmdqEntry())
  val mb_dma_rrsp_fifo_st:   AvalonST                   = AvalonST(AvstConfig.dmaRRspWReqConfig)
  val err_cmdqe_dma_wreq_st: Stream[ErrCmdqeDMAWReqPkt] = Stream(ErrCmdqeDMAWReqPkt())
  val cmd_rsp_dma_wreq_avst: AvalonST                   = AvalonST(AvstConfig.dmaRRspWReqConfig)
  val mb_dma_rreq_desc: DMARReqDesc =
    gen_dma_rreq((cmdqe_dma_rrsp_st.payload.cmd_entry_in.input_len - 16).resize(17), cmdqe_dma_rrsp_st.payload.input_mb_addr, True)
  val cmdqe_dma_rreq_desc: DMARReqDesc = gen_dma_rreq(U(64), cmdqe_phy_addr, False)

  // cmdqe_check
  val cmdqe_check = new Area {
    val cmdqe:                CmdqEntry   = cmdqe_dma_rrsp_st.payload
    val input_len:            UInt        = cmdqe.cmd_entry_in.input_len
    val output_len:           UInt        = cmdqe.cmd_entry_out.output_length
    val opcode:               Bits        = cmdqe.cmd_entry_in.input_inline_data.opcode
    val bad_opcode:           Bool        = Bool()
    val in_len_less_than_16:  Bool        = input_len < 16
    val out_len_less_than_16: Bool        = output_len < 16
    val bad_input_len:        Bool        = Bool()
    val bad_output_len:       Bool        = Bool()
    val cmdqe_err:            Bool        = bad_opcode | out_len_less_than_16 | bad_input_len | bad_output_len
    val err_cmdqe_dma_addr:   UInt        = db_id2cmdqe_phy_addr(db_id_for_err_pop.payload, cmdq_phy_addr_reg) + 32
    val err_cmdqe_wreq_desc:  DMAWReqDesc = gen_dma_wreq(U(32), err_cmdqe_dma_addr)

    assert(
      ~(cmdqe_err & cmdqe_dma_rrsp_st.fire),
      L"${REPORT_TIME} bad_opcode:$bad_opcode, in_less:$in_len_less_than_16, out_less:$out_len_less_than_16,bad_in_len:$bad_input_len, out_len:$bad_output_len",
      WARNING
    )
    //------------------------------cmdqe_chekc_logic------------------------------
    bad_opcode.clear()
    switch(opcode) {
      CmdOpcode.values.foreach { opcodeEnumVal =>
        is(opcodeEnumVal.id) {
          bad_input_len  := input_len =/= CmdOpcode.inputLen(opcodeEnumVal)
          bad_output_len := output_len =/= CmdOpcode.outputLen(opcodeEnumVal)
        }
      }
      default {
        bad_opcode.set()
        bad_input_len.clear()
        bad_output_len.clear()
      }
    }
    val err_cmdqe_out: CmdEntryOut = CmdEntryOut()
    err_cmdqe_out := cmdqe.cmd_entry_out
    when(bad_opcode) {
      err_cmdqe_out.status := CmdqEntryStatusValue.ZJ_CMD_OP_BAD_OPCODE_TYPE
    } elsewhen (in_len_less_than_16) {
      err_cmdqe_out.status := CmdqEntryStatusValue.ZJ_CMD_OP_INPUT_LEN_ERR
    } elsewhen (out_len_less_than_16) {
      err_cmdqe_out.status := CmdqEntryStatusValue.ZJ_CMD_OP_OUTPUT_LEN_ERR
    } otherwise {
      err_cmdqe_out.status := CmdqEntryStatusValue.ZJ_CMD_OP_SUCCESS
    }
    when(bad_opcode | in_len_less_than_16 | out_len_less_than_16) {
      err_cmdqe_out.output_inline_data.status := 0
    } elsewhen (bad_input_len) {
      err_cmdqe_out.output_inline_data.status := CmdOutDataStatusValue.ZJ_CMD_STAT_BAD_INPUT_LEN_ERR
    } elsewhen (bad_output_len) {
      err_cmdqe_out.output_inline_data.status := CmdOutDataStatusValue.ZJ_CMD_STAT_BAD_OUTPUT_LEN_ERR
    } otherwise {
      err_cmdqe_out.output_inline_data.status := CmdOutDataStatusValue.ZJ_CMD_STAT_SUCCESS
    }
  }

  // cmd entry out store
  val cmd_entry_out_ram_din: CmdEntryOutStore = CmdEntryOutStore()
  // cmd_reg_gen
  val cmd_req_cmdqe_elements_push: Stream[CmdReqCMDQEElements] = Stream(CmdReqCMDQEElements())
  val cmd_req_cmdqe_elements_pop:  Stream[CmdReqCMDQEElements] = buffer(cmd_req_cmdqe_elements_push, 32)
  val cmd_req_push:                AvalonST                    = AvalonST(AvstConfig.cmdReqConfig)
  val cmd_req_pop:                 AvalonST                    = bufferAvst(cmd_req_push, 128)

  // sub modules
  val cmd_req_gen_inst:    cmd_req_gen    = cmd_req_gen(cmd_req_cmdqe_elements_pop, mb_dma_rrsp_fifo_st, cmd_req_push)
  val cmdq_dma_ctrl_inst:  cmdq_dma_ctrl  = cmdq_dma_ctrl()
  val cmd_rsp_divide_inst: cmd_rsp_divide = cmd_rsp_divide()

  db_id_for_err_push.payload := db_id
  db_id_for_err_push.valid   := io.db_vec_s.valid
  io.db_vec_s.ready          := db_id_for_err_push.ready & cmd_id_mngr.io.fetch.valid & cmdqe_dma_rreq_st.ready

  cmd_id_mngr.io.clear                <> cmd_id_fihish_arbi
  cmd_id_mngr.io.fetch.ready          := io.db_vec_s.fire
  cmd_id_for_cmd_req_gen_push.valid   := io.db_vec_s.fire & cmd_id_mngr.io.fetch.valid
  cmd_id_for_cmd_req_gen_push.payload := cmd_id
  cmd_id_for_cmd_req_gen_pop.ready    := cmd_req_cmdqe_elements_push.ready & cmdqe_dma_rrsp_st.valid

  // db_id(cmdqe_phy_addr_ram)
  err_cmdqe_dma_wreq_st.payload.cmd_out.assignAllByName(cmdqe_check.err_cmdqe_out)
  err_cmdqe_dma_wreq_st.payload.desc   := cmdqe_check.err_cmdqe_wreq_desc
  err_cmdqe_dma_wreq_st.valid          := cmdqe_check.cmdqe_err & cmdqe_dma_rrsp_st.fire
  db_id_for_err_pop.ready              := cmdqe_dma_rrsp_st.fire
  cmdqe_dma_rrsp_st.ready              := cmdqe_check.cmdqe_err | cmd_req_cmdqe_elements_push.ready
  cmd_id_finish_err_cmdqe_push.valid   := cmdqe_check.cmdqe_err & cmdqe_dma_rrsp_st.fire
  cmd_id_finish_err_cmdqe_push.payload := cmd_id_for_cmd_req_gen_pop.payload

  // cmd_out_ram_din
  cmd_entry_out_ram_din.output_mb_point := cmdqe_dma_rrsp_st.payload.output_mb_addr
  cmd_entry_out_ram_din.output_length   := cmdqe_check.output_len
  cmd_entry_out_ram_din.signature       := cmdqe_dma_rrsp_st.cmd_entry_out.signature
  cmd_entry_out_ram_din.token           := cmdqe_dma_rrsp_st.cmd_entry_out.token

  //----------------------------dma ctrl logic ------------------------------
  cmdqe_dma_rreq_st.payload := cmdqe_dma_rreq_desc
  cmdqe_dma_rreq_st.valid   := io.db_vec_s.fire
  mb_dma_rreq_st.payload    := mb_dma_rreq_desc
  mb_dma_rreq_st.valid      := cmdqe_dma_rrsp_st.valid & cmdqe_dma_rrsp_st.valid & cmdqe_dma_rrsp_st.cmd_entry_in.input_len > 16 & ~cmdqe_check.cmdqe_err

  cmdq_dma_ctrl_inst.io.cmdqe_dma_rreq_s     <> cmdqe_dma_rreq_st
  cmdq_dma_ctrl_inst.io.mb_dma_dma_rreq_s    <> mb_dma_rreq_st
  cmdq_dma_ctrl_inst.io.dma_rreq_m           <> io.dma_rreq_m
  cmdq_dma_ctrl_inst.io.dma_rrsp_s           <> io.dma_rrsp_s
  cmdq_dma_ctrl_inst.io.cmdqe_dma_rrsp_m     <> cmdqe_dma_rrsp_st
  cmdq_dma_ctrl_inst.io.mb_dma_rrsp_m        <> mb_dma_rrsp_fifo_st
  cmdq_dma_ctrl_inst.io.dma_wreq_m           <> io.dma_wreq_m
  cmdq_dma_ctrl_inst.io.err_cmdqe_dma_wreq_s <> err_cmdqe_dma_wreq_st
  cmdq_dma_ctrl_inst.io.cmd_rsp_dma_wreq_s   <> cmd_rsp_dma_wreq_avst

  //----------------------------cmd_req_gen ------------------------------
  cmd_req_cmdqe_elements_push.cmd_id          := cmd_id_for_cmd_req_gen_pop.payload
  cmd_req_cmdqe_elements_push.input_len       := cmdqe_check.input_len.resized
  cmd_req_cmdqe_elements_push.cmd_inline_data := cmdqe_check.cmdqe.cmd_entry_in.input_inline_data
  cmd_req_cmdqe_elements_push.valid           := ~cmdqe_check.cmdqe_err & cmdqe_dma_rrsp_st.valid

  // cmd_rsp: mb hd divide
  cmd_rsp_divide_inst.io.cmd_rsp          <> io.cmd_rsp
  cmd_rsp_divide_inst.io.cmd_rsp_dma_wreq <> cmd_rsp_dma_wreq_avst
  cmd_rsp_divide_inst.io.cmd_id_finish    <> cmd_id_finish_cmd_rsp_push
  cmd_rsp_divide_inst.io.db_id_dout := ctyunSdpRamFactory.useMLAB
    .setLatency(1)
    .readNewData
    .write(io.db_vec_s.fire, cmd_id, db_id)
    .read(cmd_rsp_divide_inst.io.rd, cmd_rsp_divide_inst.io.raddr)
    .asUInt
  cmd_rsp_divide_inst.io.cmdq_phy_base_addr := cmdq_phy_addr_reg
  cmd_rsp_divide_inst.io.cmd_out_entry_stored.assignFromBits(
    ctyunSdpRamFactory
      .setLatency(1)
      .write(cmdqe_dma_rrsp_st.valid & ~cmdqe_check.cmdqe_err, cmd_id_for_cmd_req_gen_pop.payload, cmd_entry_out_ram_din)
      .read(cmd_rsp_divide_inst.io.rd, cmd_rsp_divide_inst.io.raddr)
  )

  io.cmd_req <> cmd_req_pop

  // dfx assert
  val cmd_rsp_avst_check = io.cmd_rsp.check
  val output_len: UInt = cmd_rsp_divide_inst.io.cmd_out_entry_stored.output_length
  val cmd_rsp_rcv_len_err: Bool = cmd_rsp_avst_check.pkt_size.valid & (cmd_rsp_avst_check.pkt_size.payload =/= output_len)
  assert(~cmd_rsp_rcv_len_err, L"$REPORT_TIME, Scheduled cmd_rsp rcv length not equal to relative output_length! ${cmd_rsp_avst_check.pkt_size.payload}", WARNING)
}
