// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : cmdq_cmdq_dma_ctrl
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766
// Gen time  : 2024-11-25 11:51:40


module cmdq_cmdq_dma_ctrl (
  input  wire          cmdqe_dma_rreq_s_valid,
  output wire          cmdqe_dma_rreq_s_ready,
  input  wire [63:0]   cmdqe_dma_rreq_s_payload_addr,
  input  wire [16:0]   cmdqe_dma_rreq_s_payload_length,
  input  wire [5:0]    cmdqe_dma_rreq_s_payload_queue_id,
  input  wire [10:0]   cmdqe_dma_rreq_s_payload_vf_num,
  input  wire          cmdqe_dma_rreq_s_payload_vf_active,
  input  wire [4:0]    cmdqe_dma_rreq_s_payload_pf_num,
  input  wire [8:0]    cmdqe_dma_rreq_s_payload_tag,
  input  wire [4:0]    cmdqe_dma_rreq_s_payload_rdma_channel_id,
  input  wire          cmdqe_dma_rreq_s_payload_at,
  input  wire          cmdqe_dma_rreq_s_payload_attr,
  input  wire [5:0]    cmdqe_dma_rreq_s_payload_channel_id,
  input  wire [1:0]    cmdqe_dma_rreq_s_payload_rsv0,
  input  wire          mb_dma_dma_rreq_s_valid,
  output wire          mb_dma_dma_rreq_s_ready,
  input  wire [63:0]   mb_dma_dma_rreq_s_payload_addr,
  input  wire [16:0]   mb_dma_dma_rreq_s_payload_length,
  input  wire [5:0]    mb_dma_dma_rreq_s_payload_queue_id,
  input  wire [10:0]   mb_dma_dma_rreq_s_payload_vf_num,
  input  wire          mb_dma_dma_rreq_s_payload_vf_active,
  input  wire [4:0]    mb_dma_dma_rreq_s_payload_pf_num,
  input  wire [8:0]    mb_dma_dma_rreq_s_payload_tag,
  input  wire [4:0]    mb_dma_dma_rreq_s_payload_rdma_channel_id,
  input  wire          mb_dma_dma_rreq_s_payload_at,
  input  wire          mb_dma_dma_rreq_s_payload_attr,
  input  wire [5:0]    mb_dma_dma_rreq_s_payload_channel_id,
  input  wire [1:0]    mb_dma_dma_rreq_s_payload_rsv0,
  input  wire          dma_rreq_m_ready,
  output wire          dma_rreq_m_valid,
  output wire [127:0]  dma_rreq_m_payload_channel,
  output wire          cmdqe_dma_rrsp_m_valid,
  input  wire          cmdqe_dma_rrsp_m_ready,
  output wire [23:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3,
  output wire [7:0]    cmdqe_dma_rrsp_m_payload_cmd_entry_in_type_,
  output wire [31:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_len,
  output wire [31:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_high,
  output wire [8:0]    cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv2,
  output wire [22:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_low,
  output wire [15:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid,
  output wire [15:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_opcode,
  output wire [15:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_op_mod,
  output wire [15:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_rsv,
  output wire [63:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_inline_cmd,
  output wire [23:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv,
  output wire [7:0]    cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_status,
  output wire [31:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_syndrome,
  output wire [63:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_cmd_output,
  output wire [31:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high,
  output wire [8:0]    cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv1,
  output wire [22:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_low,
  output wire [31:0]   cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_length,
  output wire          cmdqe_dma_rrsp_m_payload_cmd_entry_out_own,
  output wire [6:0]    cmdqe_dma_rrsp_m_payload_cmd_entry_out_status,
  output wire [7:0]    cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv0,
  output wire [7:0]    cmdqe_dma_rrsp_m_payload_cmd_entry_out_signature,
  output wire [7:0]    cmdqe_dma_rrsp_m_payload_cmd_entry_out_token,
  input  wire          mb_dma_rrsp_m_ready,
  output wire          mb_dma_rrsp_m_valid,
  output wire [511:0]  mb_dma_rrsp_m_payload_data,
  output wire [127:0]  mb_dma_rrsp_m_payload_channel,
  output wire [5:0]    mb_dma_rrsp_m_payload_empty,
  output wire          mb_dma_rrsp_m_payload_eop,
  output wire          mb_dma_rrsp_m_payload_sop,
  output wire          dma_rrsp_s_ready,
  input  wire          dma_rrsp_s_valid,
  input  wire [511:0]  dma_rrsp_s_payload_data,
  input  wire [127:0]  dma_rrsp_s_payload_channel,
  input  wire [5:0]    dma_rrsp_s_payload_empty,
  input  wire          dma_rrsp_s_payload_eop,
  input  wire          dma_rrsp_s_payload_sop,
  input  wire          err_cmdqe_dma_wreq_s_valid,
  output wire          err_cmdqe_dma_wreq_s_ready,
  input  wire [63:0]   err_cmdqe_dma_wreq_s_payload_desc_addr,
  input  wire [16:0]   err_cmdqe_dma_wreq_s_payload_desc_length,
  input  wire [5:0]    err_cmdqe_dma_wreq_s_payload_desc_queue_id,
  input  wire          err_cmdqe_dma_wreq_s_payload_desc_vf_active,
  input  wire [10:0]   err_cmdqe_dma_wreq_s_payload_desc_vf_num,
  input  wire [4:0]    err_cmdqe_dma_wreq_s_payload_desc_pf_num,
  input  wire [4:0]    err_cmdqe_dma_wreq_s_payload_desc_desc_type,
  input  wire [16:0]   err_cmdqe_dma_wreq_s_payload_desc_rsv,
  input  wire [1:0]    err_cmdqe_dma_wreq_s_payload_desc_tlp_channel_id,
  input  wire [23:0]   err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_rsv,
  input  wire [7:0]    err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_status,
  input  wire [31:0]   err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_syndrome,
  input  wire [63:0]   err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_cmd_output,
  input  wire [31:0]   err_cmdqe_dma_wreq_s_payload_cmd_out_output_mb_point_high,
  input  wire [8:0]    err_cmdqe_dma_wreq_s_payload_cmd_out_rsv1,
  input  wire [22:0]   err_cmdqe_dma_wreq_s_payload_cmd_out_output_mb_point_low,
  input  wire [31:0]   err_cmdqe_dma_wreq_s_payload_cmd_out_output_length,
  input  wire          err_cmdqe_dma_wreq_s_payload_cmd_out_own,
  input  wire [6:0]    err_cmdqe_dma_wreq_s_payload_cmd_out_status,
  input  wire [7:0]    err_cmdqe_dma_wreq_s_payload_cmd_out_rsv0,
  input  wire [7:0]    err_cmdqe_dma_wreq_s_payload_cmd_out_signature,
  input  wire [7:0]    err_cmdqe_dma_wreq_s_payload_cmd_out_token,
  output wire          cmd_rsp_dma_wreq_s_ready,
  input  wire          cmd_rsp_dma_wreq_s_valid,
  input  wire [511:0]  cmd_rsp_dma_wreq_s_payload_data,
  input  wire [127:0]  cmd_rsp_dma_wreq_s_payload_channel,
  input  wire [5:0]    cmd_rsp_dma_wreq_s_payload_empty,
  input  wire          cmd_rsp_dma_wreq_s_payload_eop,
  input  wire          cmd_rsp_dma_wreq_s_payload_sop,
  input  wire          dma_wreq_m_ready,
  output wire          dma_wreq_m_valid,
  output wire [511:0]  dma_wreq_m_payload_data,
  output wire [127:0]  dma_wreq_m_payload_channel,
  output wire [5:0]    dma_wreq_m_payload_empty,
  output wire          dma_wreq_m_payload_eop,
  output wire          dma_wreq_m_payload_sop,
  input  wire          reset,
  input  wire          clk
);

  wire       [127:0]  cmdqe_dma_rreq_s_fifo_din;
  wire       [127:0]  mb_dma_dma_rreq_s_fifo_din;
  wire       [383:0]  err_cmdqe_dma_wreq_s_fifo_din;
  wire       [647:0]  cmd_rsp_dma_wreq_s_fifo_din;
  wire       [127:0]  streamArbiter_io_inputs_0_payload;
  wire       [127:0]  streamArbiter_io_inputs_1_payload;
  wire       [647:0]  streamDemux_io_input_payload;
  wire                streamDemux_io_outputs_0_ready;
  wire                streamDemux_io_outputs_1_ready;
  wire       [511:0]  cmdqe_dma_rrsp_fifo_din;
  wire       [647:0]  mb_dma_rrsp_fifo_din;
  wire                cmdqe_dma_rreq_s_fifo_full;
  wire       [127:0]  cmdqe_dma_rreq_s_fifo_dout;
  wire                cmdqe_dma_rreq_s_fifo_empty;
  wire                cmdqe_dma_rreq_s_fifo_almost_empty;
  wire                cmdqe_dma_rreq_s_fifo_almost_full;
  wire       [4:0]    cmdqe_dma_rreq_s_fifo_usedw;
  wire                cmdqe_dma_rreq_s_fifo_overflow;
  wire                cmdqe_dma_rreq_s_fifo_underflow;
  wire                mb_dma_dma_rreq_s_fifo_full;
  wire       [127:0]  mb_dma_dma_rreq_s_fifo_dout;
  wire                mb_dma_dma_rreq_s_fifo_empty;
  wire                mb_dma_dma_rreq_s_fifo_almost_empty;
  wire                mb_dma_dma_rreq_s_fifo_almost_full;
  wire       [4:0]    mb_dma_dma_rreq_s_fifo_usedw;
  wire                mb_dma_dma_rreq_s_fifo_overflow;
  wire                mb_dma_dma_rreq_s_fifo_underflow;
  wire                err_cmdqe_dma_wreq_s_fifo_full;
  wire       [383:0]  err_cmdqe_dma_wreq_s_fifo_dout;
  wire                err_cmdqe_dma_wreq_s_fifo_empty;
  wire                err_cmdqe_dma_wreq_s_fifo_almost_empty;
  wire                err_cmdqe_dma_wreq_s_fifo_almost_full;
  wire       [4:0]    err_cmdqe_dma_wreq_s_fifo_usedw;
  wire                err_cmdqe_dma_wreq_s_fifo_overflow;
  wire                err_cmdqe_dma_wreq_s_fifo_underflow;
  wire                cmd_rsp_dma_wreq_s_fifo_full;
  wire       [647:0]  cmd_rsp_dma_wreq_s_fifo_dout;
  wire                cmd_rsp_dma_wreq_s_fifo_empty;
  wire                cmd_rsp_dma_wreq_s_fifo_almost_empty;
  wire                cmd_rsp_dma_wreq_s_fifo_almost_full;
  wire       [6:0]    cmd_rsp_dma_wreq_s_fifo_usedw;
  wire                cmd_rsp_dma_wreq_s_fifo_overflow;
  wire                cmd_rsp_dma_wreq_s_fifo_underflow;
  wire                streamArbiter_io_inputs_0_ready;
  wire                streamArbiter_io_inputs_1_ready;
  wire                streamArbiter_io_output_valid;
  wire       [127:0]  streamArbiter_io_output_payload;
  wire       [0:0]    streamArbiter_io_chosen;
  wire       [1:0]    streamArbiter_io_chosenOH;
  wire                dma_wreq_arbi_io_inputs_0_ready;
  wire                dma_wreq_arbi_io_inputs_1_ready;
  wire                dma_wreq_arbi_io_output_valid;
  wire       [511:0]  dma_wreq_arbi_io_output_payload_data;
  wire       [127:0]  dma_wreq_arbi_io_output_payload_channel;
  wire       [5:0]    dma_wreq_arbi_io_output_payload_empty;
  wire                dma_wreq_arbi_io_output_payload_eop;
  wire                dma_wreq_arbi_io_output_payload_sop;
  wire       [0:0]    dma_wreq_arbi_io_chosen;
  wire       [1:0]    dma_wreq_arbi_io_chosenOH;
  wire                streamDemux_io_input_ready;
  wire                streamDemux_io_outputs_0_valid;
  wire       [647:0]  streamDemux_io_outputs_0_payload;
  wire                streamDemux_io_outputs_1_valid;
  wire       [647:0]  streamDemux_io_outputs_1_payload;
  wire                cmdqe_dma_rrsp_fifo_full;
  wire       [511:0]  cmdqe_dma_rrsp_fifo_dout;
  wire                cmdqe_dma_rrsp_fifo_empty;
  wire                cmdqe_dma_rrsp_fifo_almost_empty;
  wire                cmdqe_dma_rrsp_fifo_almost_full;
  wire       [4:0]    cmdqe_dma_rrsp_fifo_usedw;
  wire                cmdqe_dma_rrsp_fifo_overflow;
  wire                cmdqe_dma_rrsp_fifo_underflow;
  wire                mb_dma_rrsp_fifo_full;
  wire       [647:0]  mb_dma_rrsp_fifo_dout;
  wire                mb_dma_rrsp_fifo_empty;
  wire                mb_dma_rrsp_fifo_almost_empty;
  wire                mb_dma_rrsp_fifo_almost_full;
  wire       [6:0]    mb_dma_rrsp_fifo_usedw;
  wire                mb_dma_rrsp_fifo_overflow;
  wire                mb_dma_rrsp_fifo_underflow;
  wire       [168:0]  tmp_din_5;
  wire       [80:0]   tmp_din_6;
  wire       [6:0]    tmp_din_7;
  wire       [224:0]  tmp_din_8;
  wire       [15:0]   tmp_din_9;
  wire       [31:0]   tmp_din_10;
  wire       [31:0]   tmp_din_11;
  wire       [63:0]   tmp_din_12;
  wire       [255:0]  tmp_err_dma_wreq_pop_st_payload_data;
  wire                cmdqe_dma_rreq_fifo_pop_valid;
  wire                cmdqe_dma_rreq_fifo_pop_ready;
  wire       [63:0]   cmdqe_dma_rreq_fifo_pop_payload_addr;
  wire       [16:0]   cmdqe_dma_rreq_fifo_pop_payload_length;
  wire       [5:0]    cmdqe_dma_rreq_fifo_pop_payload_queue_id;
  wire       [10:0]   cmdqe_dma_rreq_fifo_pop_payload_vf_num;
  wire                cmdqe_dma_rreq_fifo_pop_payload_vf_active;
  wire       [4:0]    cmdqe_dma_rreq_fifo_pop_payload_pf_num;
  wire       [8:0]    cmdqe_dma_rreq_fifo_pop_payload_tag;
  wire       [4:0]    cmdqe_dma_rreq_fifo_pop_payload_rdma_channel_id;
  wire                cmdqe_dma_rreq_fifo_pop_payload_at;
  wire                cmdqe_dma_rreq_fifo_pop_payload_attr;
  wire       [5:0]    cmdqe_dma_rreq_fifo_pop_payload_channel_id;
  wire       [1:0]    cmdqe_dma_rreq_fifo_pop_payload_rsv0;
  wire                mb_dma_rreq_fifo_pop_valid;
  wire                mb_dma_rreq_fifo_pop_ready;
  wire       [63:0]   mb_dma_rreq_fifo_pop_payload_addr;
  wire       [16:0]   mb_dma_rreq_fifo_pop_payload_length;
  wire       [5:0]    mb_dma_rreq_fifo_pop_payload_queue_id;
  wire       [10:0]   mb_dma_rreq_fifo_pop_payload_vf_num;
  wire                mb_dma_rreq_fifo_pop_payload_vf_active;
  wire       [4:0]    mb_dma_rreq_fifo_pop_payload_pf_num;
  wire       [8:0]    mb_dma_rreq_fifo_pop_payload_tag;
  wire       [4:0]    mb_dma_rreq_fifo_pop_payload_rdma_channel_id;
  wire                mb_dma_rreq_fifo_pop_payload_at;
  wire                mb_dma_rreq_fifo_pop_payload_attr;
  wire       [5:0]    mb_dma_rreq_fifo_pop_payload_channel_id;
  wire       [1:0]    mb_dma_rreq_fifo_pop_payload_rsv0;
  wire                err_cmdqe_dma_wreq_fifo_pop_valid;
  wire                err_cmdqe_dma_wreq_fifo_pop_ready;
  wire       [63:0]   err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr;
  wire       [16:0]   err_cmdqe_dma_wreq_fifo_pop_payload_desc_length;
  wire       [5:0]    err_cmdqe_dma_wreq_fifo_pop_payload_desc_queue_id;
  wire                err_cmdqe_dma_wreq_fifo_pop_payload_desc_vf_active;
  wire       [10:0]   err_cmdqe_dma_wreq_fifo_pop_payload_desc_vf_num;
  wire       [4:0]    err_cmdqe_dma_wreq_fifo_pop_payload_desc_pf_num;
  wire       [4:0]    err_cmdqe_dma_wreq_fifo_pop_payload_desc_desc_type;
  wire       [16:0]   err_cmdqe_dma_wreq_fifo_pop_payload_desc_rsv;
  wire       [1:0]    err_cmdqe_dma_wreq_fifo_pop_payload_desc_tlp_channel_id;
  wire       [23:0]   err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_rsv;
  wire       [7:0]    err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_status;
  wire       [31:0]   err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_syndrome;
  wire       [63:0]   err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_cmd_output;
  wire       [31:0]   err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high;
  wire       [8:0]    err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_rsv1;
  wire       [22:0]   err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_low;
  wire       [31:0]   err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_length;
  wire                err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_own;
  wire       [6:0]    err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_status;
  wire       [7:0]    err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_rsv0;
  wire       [7:0]    err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_signature;
  wire       [7:0]    err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_token;
  wire       [127:0]  tmp_err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr;
  wire       [255:0]  tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high;
  wire       [127:0]  tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_rsv;
  wire                cmd_rsp_wreq_fifo_pop_ready;
  wire                cmd_rsp_wreq_fifo_pop_valid;
  wire       [511:0]  cmd_rsp_wreq_fifo_pop_payload_data;
  wire       [127:0]  cmd_rsp_wreq_fifo_pop_payload_channel;
  wire       [5:0]    cmd_rsp_wreq_fifo_pop_payload_empty;
  wire                cmd_rsp_wreq_fifo_pop_payload_eop;
  wire                cmd_rsp_wreq_fifo_pop_payload_sop;
  wire                dma_rreq_arbi_valid;
  wire                dma_rreq_arbi_ready;
  wire       [127:0]  dma_rreq_arbi_payload;
  wire                err_dma_wreq_pop_st_valid;
  wire                err_dma_wreq_pop_st_ready;
  wire       [511:0]  err_dma_wreq_pop_st_payload_data;
  wire       [127:0]  err_dma_wreq_pop_st_payload_channel;
  wire       [5:0]    err_dma_wreq_pop_st_payload_empty;
  wire                err_dma_wreq_pop_st_payload_eop;
  wire                err_dma_wreq_pop_st_payload_sop;
  wire                cmd_rsp_wreq_pop_st_valid;
  wire                cmd_rsp_wreq_pop_st_ready;
  wire       [511:0]  cmd_rsp_wreq_pop_st_payload_data;
  wire       [127:0]  cmd_rsp_wreq_pop_st_payload_channel;
  wire       [5:0]    cmd_rsp_wreq_pop_st_payload_empty;
  wire                cmd_rsp_wreq_pop_st_payload_eop;
  wire                cmd_rsp_wreq_pop_st_payload_sop;
  wire       [63:0]   dma_rrsp_desc_addr;
  wire       [16:0]   dma_rrsp_desc_length;
  wire       [5:0]    dma_rrsp_desc_queue_id;
  wire       [10:0]   dma_rrsp_desc_vf_num;
  wire                dma_rrsp_desc_vf_active;
  wire       [4:0]    dma_rrsp_desc_pf_num;
  wire       [8:0]    dma_rrsp_desc_tag;
  wire       [4:0]    dma_rrsp_desc_rdma_channel_id;
  wire                dma_rrsp_desc_at;
  wire                dma_rrsp_desc_attr;
  wire       [5:0]    dma_rrsp_desc_channel_id;
  wire       [1:0]    dma_rrsp_desc_rsv0;
  wire       [0:0]    select_1;
  wire       [127:0]  tmp_dma_rrsp_desc_addr;
  wire       [255:0]  tmp_din;
  wire       [127:0]  tmp_din_1;
  wire       [255:0]  tmp_din_2;
  wire       [127:0]  tmp_din_3;
  wire       [255:0]  tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3;
  wire       [127:0]  tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid;
  wire       [255:0]  tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high;
  wire       [127:0]  tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv;
  wire       [647:0]  tmp_din_4;
  wire       [647:0]  tmp_dma_wreq_m_payload_data;

  assign tmp_err_dma_wreq_pop_st_payload_data = {err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_token,{err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_signature,{err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_rsv0,{err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_status,{err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_own,{err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_length,{err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_low,{err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_rsv1,{err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high,{err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_cmd_output,{err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_syndrome,{err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_status,err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_rsv}}}}}}}}}}}};
  assign tmp_din_5 = {err_cmdqe_dma_wreq_s_payload_cmd_out_rsv1,{err_cmdqe_dma_wreq_s_payload_cmd_out_output_mb_point_high,{err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_cmd_output,{err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_syndrome,{err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_status,err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_rsv}}}}};
  assign tmp_din_6 = {err_cmdqe_dma_wreq_s_payload_desc_length,err_cmdqe_dma_wreq_s_payload_desc_addr};
  assign tmp_din_7 = tmp_din_2[231 : 225];
  assign tmp_din_8 = {tmp_din_2[224],{tmp_din_2[223 : 192],{tmp_din_2[191 : 169],{tmp_din_2[168 : 160],{tmp_din_2[159 : 128],{tmp_din_3[127 : 64],{tmp_din_3[63 : 32],{tmp_din_3[31 : 24],tmp_din_3[23 : 0]}}}}}}}};
  assign tmp_din_9 = tmp_din_1[47 : 32];
  assign tmp_din_10 = {tmp_din_1[31 : 16],tmp_din_1[15 : 0]};
  assign tmp_din_11 = tmp_din[95 : 64];
  assign tmp_din_12 = {tmp_din[63 : 32],{tmp_din[31 : 24],tmp_din[23 : 0]}};
  rdma_ctyun_sfifo #(
    .DEPTH      (32 ),
    .DATA_WIDTH (128)
  ) cmdqe_dma_rreq_s_fifo (
    .clk          (clk                               ), //i
    .srst         (reset                             ), //i
    .wr_en        (cmdqe_dma_rreq_s_valid            ), //i
    .din          (cmdqe_dma_rreq_s_fifo_din[127:0]  ), //i
    .full         (cmdqe_dma_rreq_s_fifo_full        ), //o
    .rd_en        (cmdqe_dma_rreq_fifo_pop_ready     ), //i
    .dout         (cmdqe_dma_rreq_s_fifo_dout[127:0] ), //o
    .empty        (cmdqe_dma_rreq_s_fifo_empty       ), //o
    .almost_empty (cmdqe_dma_rreq_s_fifo_almost_empty), //o
    .almost_full  (cmdqe_dma_rreq_s_fifo_almost_full ), //o
    .usedw        (cmdqe_dma_rreq_s_fifo_usedw[4:0]  ), //o
    .overflow     (cmdqe_dma_rreq_s_fifo_overflow    ), //o
    .underflow    (cmdqe_dma_rreq_s_fifo_underflow   )  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (32 ),
    .DATA_WIDTH (128)
  ) mb_dma_dma_rreq_s_fifo (
    .clk          (clk                                ), //i
    .srst         (reset                              ), //i
    .wr_en        (mb_dma_dma_rreq_s_valid            ), //i
    .din          (mb_dma_dma_rreq_s_fifo_din[127:0]  ), //i
    .full         (mb_dma_dma_rreq_s_fifo_full        ), //o
    .rd_en        (mb_dma_rreq_fifo_pop_ready         ), //i
    .dout         (mb_dma_dma_rreq_s_fifo_dout[127:0] ), //o
    .empty        (mb_dma_dma_rreq_s_fifo_empty       ), //o
    .almost_empty (mb_dma_dma_rreq_s_fifo_almost_empty), //o
    .almost_full  (mb_dma_dma_rreq_s_fifo_almost_full ), //o
    .usedw        (mb_dma_dma_rreq_s_fifo_usedw[4:0]  ), //o
    .overflow     (mb_dma_dma_rreq_s_fifo_overflow    ), //o
    .underflow    (mb_dma_dma_rreq_s_fifo_underflow   )  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (32 ),
    .DATA_WIDTH (384)
  ) err_cmdqe_dma_wreq_s_fifo (
    .clk          (clk                                   ), //i
    .srst         (reset                                 ), //i
    .wr_en        (err_cmdqe_dma_wreq_s_valid            ), //i
    .din          (err_cmdqe_dma_wreq_s_fifo_din[383:0]  ), //i
    .full         (err_cmdqe_dma_wreq_s_fifo_full        ), //o
    .rd_en        (err_cmdqe_dma_wreq_fifo_pop_ready     ), //i
    .dout         (err_cmdqe_dma_wreq_s_fifo_dout[383:0] ), //o
    .empty        (err_cmdqe_dma_wreq_s_fifo_empty       ), //o
    .almost_empty (err_cmdqe_dma_wreq_s_fifo_almost_empty), //o
    .almost_full  (err_cmdqe_dma_wreq_s_fifo_almost_full ), //o
    .usedw        (err_cmdqe_dma_wreq_s_fifo_usedw[4:0]  ), //o
    .overflow     (err_cmdqe_dma_wreq_s_fifo_overflow    ), //o
    .underflow    (err_cmdqe_dma_wreq_s_fifo_underflow   )  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (128),
    .DATA_WIDTH (648)
  ) cmd_rsp_dma_wreq_s_fifo (
    .clk          (clk                                 ), //i
    .srst         (reset                               ), //i
    .wr_en        (cmd_rsp_dma_wreq_s_valid            ), //i
    .din          (cmd_rsp_dma_wreq_s_fifo_din[647:0]  ), //i
    .full         (cmd_rsp_dma_wreq_s_fifo_full        ), //o
    .rd_en        (cmd_rsp_wreq_fifo_pop_ready         ), //i
    .dout         (cmd_rsp_dma_wreq_s_fifo_dout[647:0] ), //o
    .empty        (cmd_rsp_dma_wreq_s_fifo_empty       ), //o
    .almost_empty (cmd_rsp_dma_wreq_s_fifo_almost_empty), //o
    .almost_full  (cmd_rsp_dma_wreq_s_fifo_almost_full ), //o
    .usedw        (cmd_rsp_dma_wreq_s_fifo_usedw[6:0]  ), //o
    .overflow     (cmd_rsp_dma_wreq_s_fifo_overflow    ), //o
    .underflow    (cmd_rsp_dma_wreq_s_fifo_underflow   )  //o
  );
  cmdq_StreamArbiter_2 streamArbiter (
    .io_inputs_0_valid   (mb_dma_rreq_fifo_pop_valid              ), //i
    .io_inputs_0_ready   (streamArbiter_io_inputs_0_ready         ), //o
    .io_inputs_0_payload (streamArbiter_io_inputs_0_payload[127:0]), //i
    .io_inputs_1_valid   (cmdqe_dma_rreq_fifo_pop_valid           ), //i
    .io_inputs_1_ready   (streamArbiter_io_inputs_1_ready         ), //o
    .io_inputs_1_payload (streamArbiter_io_inputs_1_payload[127:0]), //i
    .io_output_valid     (streamArbiter_io_output_valid           ), //o
    .io_output_ready     (dma_rreq_arbi_ready                     ), //i
    .io_output_payload   (streamArbiter_io_output_payload[127:0]  ), //o
    .io_chosen           (streamArbiter_io_chosen                 ), //o
    .io_chosenOH         (streamArbiter_io_chosenOH[1:0]          ), //o
    .clk                 (clk                                     ), //i
    .reset               (reset                                   )  //i
  );
  cmdq_StreamArbiter_3 dma_wreq_arbi (
    .io_inputs_0_valid           (err_dma_wreq_pop_st_valid                     ), //i
    .io_inputs_0_ready           (dma_wreq_arbi_io_inputs_0_ready               ), //o
    .io_inputs_0_payload_data    (err_dma_wreq_pop_st_payload_data[511:0]       ), //i
    .io_inputs_0_payload_channel (err_dma_wreq_pop_st_payload_channel[127:0]    ), //i
    .io_inputs_0_payload_empty   (err_dma_wreq_pop_st_payload_empty[5:0]        ), //i
    .io_inputs_0_payload_eop     (err_dma_wreq_pop_st_payload_eop               ), //i
    .io_inputs_0_payload_sop     (err_dma_wreq_pop_st_payload_sop               ), //i
    .io_inputs_1_valid           (cmd_rsp_wreq_pop_st_valid                     ), //i
    .io_inputs_1_ready           (dma_wreq_arbi_io_inputs_1_ready               ), //o
    .io_inputs_1_payload_data    (cmd_rsp_wreq_pop_st_payload_data[511:0]       ), //i
    .io_inputs_1_payload_channel (cmd_rsp_wreq_pop_st_payload_channel[127:0]    ), //i
    .io_inputs_1_payload_empty   (cmd_rsp_wreq_pop_st_payload_empty[5:0]        ), //i
    .io_inputs_1_payload_eop     (cmd_rsp_wreq_pop_st_payload_eop               ), //i
    .io_inputs_1_payload_sop     (cmd_rsp_wreq_pop_st_payload_sop               ), //i
    .io_output_valid             (dma_wreq_arbi_io_output_valid                 ), //o
    .io_output_ready             (dma_wreq_m_ready                              ), //i
    .io_output_payload_data      (dma_wreq_arbi_io_output_payload_data[511:0]   ), //o
    .io_output_payload_channel   (dma_wreq_arbi_io_output_payload_channel[127:0]), //o
    .io_output_payload_empty     (dma_wreq_arbi_io_output_payload_empty[5:0]    ), //o
    .io_output_payload_eop       (dma_wreq_arbi_io_output_payload_eop           ), //o
    .io_output_payload_sop       (dma_wreq_arbi_io_output_payload_sop           ), //o
    .io_chosen                   (dma_wreq_arbi_io_chosen                       ), //o
    .io_chosenOH                 (dma_wreq_arbi_io_chosenOH[1:0]                ), //o
    .clk                         (clk                                           ), //i
    .reset                       (reset                                         )  //i
  );
  cmdq_StreamDemux_1 streamDemux (
    .io_select            (select_1                               ), //i
    .io_input_valid       (dma_rrsp_s_valid                       ), //i
    .io_input_ready       (streamDemux_io_input_ready             ), //o
    .io_input_payload     (streamDemux_io_input_payload[647:0]    ), //i
    .io_outputs_0_valid   (streamDemux_io_outputs_0_valid         ), //o
    .io_outputs_0_ready   (streamDemux_io_outputs_0_ready         ), //i
    .io_outputs_0_payload (streamDemux_io_outputs_0_payload[647:0]), //o
    .io_outputs_1_valid   (streamDemux_io_outputs_1_valid         ), //o
    .io_outputs_1_ready   (streamDemux_io_outputs_1_ready         ), //i
    .io_outputs_1_payload (streamDemux_io_outputs_1_payload[647:0])  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (32 ),
    .DATA_WIDTH (512)
  ) cmdqe_dma_rrsp_fifo (
    .clk          (clk                             ), //i
    .srst         (reset                           ), //i
    .wr_en        (streamDemux_io_outputs_0_valid  ), //i
    .din          (cmdqe_dma_rrsp_fifo_din[511:0]  ), //i
    .full         (cmdqe_dma_rrsp_fifo_full        ), //o
    .rd_en        (cmdqe_dma_rrsp_m_ready          ), //i
    .dout         (cmdqe_dma_rrsp_fifo_dout[511:0] ), //o
    .empty        (cmdqe_dma_rrsp_fifo_empty       ), //o
    .almost_empty (cmdqe_dma_rrsp_fifo_almost_empty), //o
    .almost_full  (cmdqe_dma_rrsp_fifo_almost_full ), //o
    .usedw        (cmdqe_dma_rrsp_fifo_usedw[4:0]  ), //o
    .overflow     (cmdqe_dma_rrsp_fifo_overflow    ), //o
    .underflow    (cmdqe_dma_rrsp_fifo_underflow   )  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (128),
    .DATA_WIDTH (648)
  ) mb_dma_rrsp_fifo (
    .clk          (clk                           ), //i
    .srst         (reset                         ), //i
    .wr_en        (streamDemux_io_outputs_1_valid), //i
    .din          (mb_dma_rrsp_fifo_din[647:0]   ), //i
    .full         (mb_dma_rrsp_fifo_full         ), //o
    .rd_en        (mb_dma_rrsp_m_ready           ), //i
    .dout         (mb_dma_rrsp_fifo_dout[647:0]  ), //o
    .empty        (mb_dma_rrsp_fifo_empty        ), //o
    .almost_empty (mb_dma_rrsp_fifo_almost_empty ), //o
    .almost_full  (mb_dma_rrsp_fifo_almost_full  ), //o
    .usedw        (mb_dma_rrsp_fifo_usedw[6:0]   ), //o
    .overflow     (mb_dma_rrsp_fifo_overflow     ), //o
    .underflow    (mb_dma_rrsp_fifo_underflow    )  //o
  );
  assign cmdqe_dma_rreq_s_fifo_din = {cmdqe_dma_rreq_s_payload_rsv0,{cmdqe_dma_rreq_s_payload_channel_id,{cmdqe_dma_rreq_s_payload_attr,{cmdqe_dma_rreq_s_payload_at,{cmdqe_dma_rreq_s_payload_rdma_channel_id,{cmdqe_dma_rreq_s_payload_tag,{cmdqe_dma_rreq_s_payload_pf_num,{cmdqe_dma_rreq_s_payload_vf_active,{cmdqe_dma_rreq_s_payload_vf_num,{cmdqe_dma_rreq_s_payload_queue_id,{cmdqe_dma_rreq_s_payload_length,cmdqe_dma_rreq_s_payload_addr}}}}}}}}}}}; // @ rdma_ctyun_sfifo.scala l34
  assign cmdqe_dma_rreq_s_ready = (! cmdqe_dma_rreq_s_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign cmdqe_dma_rreq_fifo_pop_valid = (! cmdqe_dma_rreq_s_fifo_empty); // @ rdma_ctyun_sfifo.scala l39
  assign cmdqe_dma_rreq_fifo_pop_payload_addr = cmdqe_dma_rreq_s_fifo_dout[63 : 0]; // @ UInt.scala l381
  assign cmdqe_dma_rreq_fifo_pop_payload_length = cmdqe_dma_rreq_s_fifo_dout[80 : 64]; // @ UInt.scala l381
  assign cmdqe_dma_rreq_fifo_pop_payload_queue_id = cmdqe_dma_rreq_s_fifo_dout[86 : 81]; // @ Bits.scala l133
  assign cmdqe_dma_rreq_fifo_pop_payload_vf_num = cmdqe_dma_rreq_s_fifo_dout[97 : 87]; // @ Bits.scala l133
  assign cmdqe_dma_rreq_fifo_pop_payload_vf_active = cmdqe_dma_rreq_s_fifo_dout[98]; // @ Bool.scala l209
  assign cmdqe_dma_rreq_fifo_pop_payload_pf_num = cmdqe_dma_rreq_s_fifo_dout[103 : 99]; // @ Bits.scala l133
  assign cmdqe_dma_rreq_fifo_pop_payload_tag = cmdqe_dma_rreq_s_fifo_dout[112 : 104]; // @ Bits.scala l133
  assign cmdqe_dma_rreq_fifo_pop_payload_rdma_channel_id = cmdqe_dma_rreq_s_fifo_dout[117 : 113]; // @ Bits.scala l133
  assign cmdqe_dma_rreq_fifo_pop_payload_at = cmdqe_dma_rreq_s_fifo_dout[118]; // @ Bool.scala l209
  assign cmdqe_dma_rreq_fifo_pop_payload_attr = cmdqe_dma_rreq_s_fifo_dout[119]; // @ Bool.scala l209
  assign cmdqe_dma_rreq_fifo_pop_payload_channel_id = cmdqe_dma_rreq_s_fifo_dout[125 : 120]; // @ UInt.scala l381
  assign cmdqe_dma_rreq_fifo_pop_payload_rsv0 = cmdqe_dma_rreq_s_fifo_dout[127 : 126]; // @ Bits.scala l133
  assign mb_dma_dma_rreq_s_fifo_din = {mb_dma_dma_rreq_s_payload_rsv0,{mb_dma_dma_rreq_s_payload_channel_id,{mb_dma_dma_rreq_s_payload_attr,{mb_dma_dma_rreq_s_payload_at,{mb_dma_dma_rreq_s_payload_rdma_channel_id,{mb_dma_dma_rreq_s_payload_tag,{mb_dma_dma_rreq_s_payload_pf_num,{mb_dma_dma_rreq_s_payload_vf_active,{mb_dma_dma_rreq_s_payload_vf_num,{mb_dma_dma_rreq_s_payload_queue_id,{mb_dma_dma_rreq_s_payload_length,mb_dma_dma_rreq_s_payload_addr}}}}}}}}}}}; // @ rdma_ctyun_sfifo.scala l34
  assign mb_dma_dma_rreq_s_ready = (! mb_dma_dma_rreq_s_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign mb_dma_rreq_fifo_pop_valid = (! mb_dma_dma_rreq_s_fifo_empty); // @ rdma_ctyun_sfifo.scala l39
  assign mb_dma_rreq_fifo_pop_payload_addr = mb_dma_dma_rreq_s_fifo_dout[63 : 0]; // @ UInt.scala l381
  assign mb_dma_rreq_fifo_pop_payload_length = mb_dma_dma_rreq_s_fifo_dout[80 : 64]; // @ UInt.scala l381
  assign mb_dma_rreq_fifo_pop_payload_queue_id = mb_dma_dma_rreq_s_fifo_dout[86 : 81]; // @ Bits.scala l133
  assign mb_dma_rreq_fifo_pop_payload_vf_num = mb_dma_dma_rreq_s_fifo_dout[97 : 87]; // @ Bits.scala l133
  assign mb_dma_rreq_fifo_pop_payload_vf_active = mb_dma_dma_rreq_s_fifo_dout[98]; // @ Bool.scala l209
  assign mb_dma_rreq_fifo_pop_payload_pf_num = mb_dma_dma_rreq_s_fifo_dout[103 : 99]; // @ Bits.scala l133
  assign mb_dma_rreq_fifo_pop_payload_tag = mb_dma_dma_rreq_s_fifo_dout[112 : 104]; // @ Bits.scala l133
  assign mb_dma_rreq_fifo_pop_payload_rdma_channel_id = mb_dma_dma_rreq_s_fifo_dout[117 : 113]; // @ Bits.scala l133
  assign mb_dma_rreq_fifo_pop_payload_at = mb_dma_dma_rreq_s_fifo_dout[118]; // @ Bool.scala l209
  assign mb_dma_rreq_fifo_pop_payload_attr = mb_dma_dma_rreq_s_fifo_dout[119]; // @ Bool.scala l209
  assign mb_dma_rreq_fifo_pop_payload_channel_id = mb_dma_dma_rreq_s_fifo_dout[125 : 120]; // @ UInt.scala l381
  assign mb_dma_rreq_fifo_pop_payload_rsv0 = mb_dma_dma_rreq_s_fifo_dout[127 : 126]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_s_fifo_din = {{err_cmdqe_dma_wreq_s_payload_cmd_out_token,{err_cmdqe_dma_wreq_s_payload_cmd_out_signature,{err_cmdqe_dma_wreq_s_payload_cmd_out_rsv0,{err_cmdqe_dma_wreq_s_payload_cmd_out_status,{err_cmdqe_dma_wreq_s_payload_cmd_out_own,{err_cmdqe_dma_wreq_s_payload_cmd_out_output_length,{err_cmdqe_dma_wreq_s_payload_cmd_out_output_mb_point_low,tmp_din_5}}}}}}},{err_cmdqe_dma_wreq_s_payload_desc_tlp_channel_id,{err_cmdqe_dma_wreq_s_payload_desc_rsv,{err_cmdqe_dma_wreq_s_payload_desc_desc_type,{err_cmdqe_dma_wreq_s_payload_desc_pf_num,{err_cmdqe_dma_wreq_s_payload_desc_vf_num,{err_cmdqe_dma_wreq_s_payload_desc_vf_active,{err_cmdqe_dma_wreq_s_payload_desc_queue_id,tmp_din_6}}}}}}}}; // @ rdma_ctyun_sfifo.scala l34
  assign err_cmdqe_dma_wreq_s_ready = (! err_cmdqe_dma_wreq_s_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign err_cmdqe_dma_wreq_fifo_pop_valid = (! err_cmdqe_dma_wreq_s_fifo_empty); // @ rdma_ctyun_sfifo.scala l39
  assign tmp_err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr = err_cmdqe_dma_wreq_s_fifo_dout[127 : 0]; // @ BaseType.scala l299
  assign err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr[63 : 0]; // @ UInt.scala l381
  assign err_cmdqe_dma_wreq_fifo_pop_payload_desc_length = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr[80 : 64]; // @ UInt.scala l381
  assign err_cmdqe_dma_wreq_fifo_pop_payload_desc_queue_id = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr[86 : 81]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_desc_vf_active = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr[87]; // @ Bool.scala l209
  assign err_cmdqe_dma_wreq_fifo_pop_payload_desc_vf_num = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr[98 : 88]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_desc_pf_num = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr[103 : 99]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_desc_desc_type = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr[108 : 104]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_desc_rsv = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr[125 : 109]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_desc_tlp_channel_id = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr[127 : 126]; // @ Bits.scala l133
  assign tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high = err_cmdqe_dma_wreq_s_fifo_dout[383 : 128]; // @ BaseType.scala l299
  assign tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_rsv = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high[127 : 0]; // @ BaseType.scala l299
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_rsv = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_rsv[23 : 0]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_status = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_rsv[31 : 24]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_syndrome = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_rsv[63 : 32]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_cmd_output = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_inline_data_rsv[127 : 64]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high[159 : 128]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_rsv1 = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high[168 : 160]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_low = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high[191 : 169]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_length = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high[223 : 192]; // @ UInt.scala l381
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_own = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high[224]; // @ Bool.scala l209
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_status = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high[231 : 225]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_rsv0 = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high[239 : 232]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_signature = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high[247 : 240]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_token = tmp_err_cmdqe_dma_wreq_fifo_pop_payload_cmd_out_output_mb_point_high[255 : 248]; // @ Bits.scala l133
  assign cmd_rsp_dma_wreq_s_fifo_din = {cmd_rsp_dma_wreq_s_payload_sop,{cmd_rsp_dma_wreq_s_payload_eop,{cmd_rsp_dma_wreq_s_payload_empty,{cmd_rsp_dma_wreq_s_payload_channel,cmd_rsp_dma_wreq_s_payload_data}}}}; // @ rdma_ctyun_sfifo.scala l46
  assign cmd_rsp_dma_wreq_s_ready = (! cmd_rsp_dma_wreq_s_fifo_full); // @ rdma_ctyun_sfifo.scala l47
  assign cmd_rsp_wreq_fifo_pop_valid = (! cmd_rsp_dma_wreq_s_fifo_empty); // @ rdma_ctyun_sfifo.scala l51
  assign cmd_rsp_wreq_fifo_pop_payload_data = cmd_rsp_dma_wreq_s_fifo_dout[511 : 0]; // @ Bits.scala l133
  assign cmd_rsp_wreq_fifo_pop_payload_channel = cmd_rsp_dma_wreq_s_fifo_dout[639 : 512]; // @ UInt.scala l381
  assign cmd_rsp_wreq_fifo_pop_payload_empty = cmd_rsp_dma_wreq_s_fifo_dout[645 : 640]; // @ UInt.scala l381
  assign cmd_rsp_wreq_fifo_pop_payload_eop = cmd_rsp_dma_wreq_s_fifo_dout[646]; // @ Bool.scala l209
  assign cmd_rsp_wreq_fifo_pop_payload_sop = cmd_rsp_dma_wreq_s_fifo_dout[647]; // @ Bool.scala l209
  assign mb_dma_rreq_fifo_pop_ready = streamArbiter_io_inputs_0_ready; // @ BusExt.scala l215
  assign cmdqe_dma_rreq_fifo_pop_ready = streamArbiter_io_inputs_1_ready; // @ BusExt.scala l215
  assign streamArbiter_io_inputs_0_payload = {mb_dma_rreq_fifo_pop_payload_rsv0,{mb_dma_rreq_fifo_pop_payload_channel_id,{mb_dma_rreq_fifo_pop_payload_attr,{mb_dma_rreq_fifo_pop_payload_at,{mb_dma_rreq_fifo_pop_payload_rdma_channel_id,{mb_dma_rreq_fifo_pop_payload_tag,{mb_dma_rreq_fifo_pop_payload_pf_num,{mb_dma_rreq_fifo_pop_payload_vf_active,{mb_dma_rreq_fifo_pop_payload_vf_num,{mb_dma_rreq_fifo_pop_payload_queue_id,{mb_dma_rreq_fifo_pop_payload_length,mb_dma_rreq_fifo_pop_payload_addr}}}}}}}}}}}; // @ Stream.scala l300
  assign streamArbiter_io_inputs_1_payload = {cmdqe_dma_rreq_fifo_pop_payload_rsv0,{cmdqe_dma_rreq_fifo_pop_payload_channel_id,{cmdqe_dma_rreq_fifo_pop_payload_attr,{cmdqe_dma_rreq_fifo_pop_payload_at,{cmdqe_dma_rreq_fifo_pop_payload_rdma_channel_id,{cmdqe_dma_rreq_fifo_pop_payload_tag,{cmdqe_dma_rreq_fifo_pop_payload_pf_num,{cmdqe_dma_rreq_fifo_pop_payload_vf_active,{cmdqe_dma_rreq_fifo_pop_payload_vf_num,{cmdqe_dma_rreq_fifo_pop_payload_queue_id,{cmdqe_dma_rreq_fifo_pop_payload_length,cmdqe_dma_rreq_fifo_pop_payload_addr}}}}}}}}}}}; // @ Stream.scala l300
  assign dma_rreq_arbi_valid = streamArbiter_io_output_valid; // @ Stream.scala l298
  assign dma_rreq_arbi_payload = streamArbiter_io_output_payload; // @ Stream.scala l300
  assign cmd_rsp_wreq_pop_st_valid = cmd_rsp_wreq_fifo_pop_valid; // @ BusExt.scala l119
  assign cmd_rsp_wreq_pop_st_payload_data = cmd_rsp_wreq_fifo_pop_payload_data; // @ BusExt.scala l120
  assign cmd_rsp_wreq_pop_st_payload_channel = cmd_rsp_wreq_fifo_pop_payload_channel; // @ BusExt.scala l120
  assign cmd_rsp_wreq_pop_st_payload_empty = cmd_rsp_wreq_fifo_pop_payload_empty; // @ BusExt.scala l120
  assign cmd_rsp_wreq_pop_st_payload_eop = cmd_rsp_wreq_fifo_pop_payload_eop; // @ BusExt.scala l120
  assign cmd_rsp_wreq_pop_st_payload_sop = cmd_rsp_wreq_fifo_pop_payload_sop; // @ BusExt.scala l120
  assign cmd_rsp_wreq_fifo_pop_ready = cmd_rsp_wreq_pop_st_ready; // @ BusExt.scala l121
  assign dma_rrsp_s_ready = streamDemux_io_input_ready; // @ BusExt.scala l121
  assign streamDemux_io_input_payload = {dma_rrsp_s_payload_sop,{dma_rrsp_s_payload_eop,{dma_rrsp_s_payload_empty,{dma_rrsp_s_payload_channel,dma_rrsp_s_payload_data}}}}; // @ Stream.scala l300
  assign dma_rreq_m_valid = dma_rreq_arbi_valid; // @ cmdq_dma_ctrl.scala l43
  assign dma_rreq_m_payload_channel = dma_rreq_arbi_payload; // @ cmdq_dma_ctrl.scala l44
  assign dma_rreq_arbi_ready = dma_rreq_m_ready; // @ cmdq_dma_ctrl.scala l45
  assign tmp_dma_rrsp_desc_addr = dma_rrsp_s_payload_channel; // @ BaseType.scala l318
  assign dma_rrsp_desc_addr = tmp_dma_rrsp_desc_addr[63 : 0]; // @ UInt.scala l381
  assign dma_rrsp_desc_length = tmp_dma_rrsp_desc_addr[80 : 64]; // @ UInt.scala l381
  assign dma_rrsp_desc_queue_id = tmp_dma_rrsp_desc_addr[86 : 81]; // @ Bits.scala l133
  assign dma_rrsp_desc_vf_num = tmp_dma_rrsp_desc_addr[97 : 87]; // @ Bits.scala l133
  assign dma_rrsp_desc_vf_active = tmp_dma_rrsp_desc_addr[98]; // @ Bool.scala l209
  assign dma_rrsp_desc_pf_num = tmp_dma_rrsp_desc_addr[103 : 99]; // @ Bits.scala l133
  assign dma_rrsp_desc_tag = tmp_dma_rrsp_desc_addr[112 : 104]; // @ Bits.scala l133
  assign dma_rrsp_desc_rdma_channel_id = tmp_dma_rrsp_desc_addr[117 : 113]; // @ Bits.scala l133
  assign dma_rrsp_desc_at = tmp_dma_rrsp_desc_addr[118]; // @ Bool.scala l209
  assign dma_rrsp_desc_attr = tmp_dma_rrsp_desc_addr[119]; // @ Bool.scala l209
  assign dma_rrsp_desc_channel_id = tmp_dma_rrsp_desc_addr[125 : 120]; // @ UInt.scala l381
  assign dma_rrsp_desc_rsv0 = tmp_dma_rrsp_desc_addr[127 : 126]; // @ Bits.scala l133
  assign select_1 = dma_rrsp_desc_tag[0]; // @ cmdq_dma_ctrl.scala l49
  assign tmp_din = streamDemux_io_outputs_0_payload[255 : 0]; // @ BaseType.scala l299
  assign tmp_din_1 = tmp_din[255 : 128]; // @ BaseType.scala l299
  assign tmp_din_2 = streamDemux_io_outputs_0_payload[511 : 256]; // @ BaseType.scala l299
  assign tmp_din_3 = tmp_din_2[127 : 0]; // @ BaseType.scala l299
  assign streamDemux_io_outputs_0_ready = (! cmdqe_dma_rrsp_fifo_full); // @ BusExt.scala l204
  assign cmdqe_dma_rrsp_fifo_din = {{tmp_din_2[255 : 248],{tmp_din_2[247 : 240],{tmp_din_2[239 : 232],{tmp_din_7,tmp_din_8}}}},{{tmp_din_1[127 : 64],{tmp_din_1[63 : 48],{tmp_din_9,tmp_din_10}}},{tmp_din[127 : 105],{tmp_din[104 : 96],{tmp_din_11,tmp_din_12}}}}}; // @ rdma_ctyun_sfifo.scala l34
  assign tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3 = cmdqe_dma_rrsp_fifo_dout[255 : 0]; // @ BaseType.scala l299
  assign tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3[255 : 128]; // @ BaseType.scala l299
  assign tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high = cmdqe_dma_rrsp_fifo_dout[511 : 256]; // @ BaseType.scala l299
  assign tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high[127 : 0]; // @ BaseType.scala l299
  assign cmdqe_dma_rrsp_m_valid = (! cmdqe_dma_rrsp_fifo_empty); // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3 = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3[23 : 0]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_in_type_ = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3[31 : 24]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_len = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3[63 : 32]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_high = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3[95 : 64]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv2 = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3[104 : 96]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_low = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3[127 : 105]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid[15 : 0]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_opcode = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid[31 : 16]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_op_mod = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid[47 : 32]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_rsv = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid[63 : 48]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_inline_cmd = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid[127 : 64]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv[23 : 0]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_status = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv[31 : 24]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_syndrome = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv[63 : 32]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_cmd_output = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv[127 : 64]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high[159 : 128]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv1 = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high[168 : 160]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_low = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high[191 : 169]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_length = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high[223 : 192]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_own = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high[224]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_status = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high[231 : 225]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv0 = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high[239 : 232]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_signature = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high[247 : 240]; // @ cmdq_dma_ctrl.scala l50
  assign cmdqe_dma_rrsp_m_payload_cmd_entry_out_token = tmp_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high[255 : 248]; // @ cmdq_dma_ctrl.scala l50
  assign streamDemux_io_outputs_1_ready = (! mb_dma_rrsp_fifo_full); // @ BusExt.scala l227
  assign tmp_din_4 = streamDemux_io_outputs_1_payload; // @ Bits.scala l152
  assign mb_dma_rrsp_fifo_din = {tmp_din_4[647],{tmp_din_4[646],{tmp_din_4[645 : 640],{tmp_din_4[639 : 512],tmp_din_4[511 : 0]}}}}; // @ rdma_ctyun_sfifo.scala l46
  assign mb_dma_rrsp_m_valid = (! mb_dma_rrsp_fifo_empty); // @ cmdq_dma_ctrl.scala l51
  assign mb_dma_rrsp_m_payload_data = mb_dma_rrsp_fifo_dout[511 : 0]; // @ cmdq_dma_ctrl.scala l51
  assign mb_dma_rrsp_m_payload_channel = mb_dma_rrsp_fifo_dout[639 : 512]; // @ cmdq_dma_ctrl.scala l51
  assign mb_dma_rrsp_m_payload_empty = mb_dma_rrsp_fifo_dout[645 : 640]; // @ cmdq_dma_ctrl.scala l51
  assign mb_dma_rrsp_m_payload_eop = mb_dma_rrsp_fifo_dout[646]; // @ cmdq_dma_ctrl.scala l51
  assign mb_dma_rrsp_m_payload_sop = mb_dma_rrsp_fifo_dout[647]; // @ cmdq_dma_ctrl.scala l51
  assign err_dma_wreq_pop_st_valid = err_cmdqe_dma_wreq_fifo_pop_valid; // @ cmdq_dma_ctrl.scala l54
  assign err_dma_wreq_pop_st_payload_channel = {err_cmdqe_dma_wreq_fifo_pop_payload_desc_tlp_channel_id,{err_cmdqe_dma_wreq_fifo_pop_payload_desc_rsv,{err_cmdqe_dma_wreq_fifo_pop_payload_desc_desc_type,{err_cmdqe_dma_wreq_fifo_pop_payload_desc_pf_num,{err_cmdqe_dma_wreq_fifo_pop_payload_desc_vf_num,{err_cmdqe_dma_wreq_fifo_pop_payload_desc_vf_active,{err_cmdqe_dma_wreq_fifo_pop_payload_desc_queue_id,{err_cmdqe_dma_wreq_fifo_pop_payload_desc_length,err_cmdqe_dma_wreq_fifo_pop_payload_desc_addr}}}}}}}}; // @ cmdq_dma_ctrl.scala l55
  assign err_dma_wreq_pop_st_payload_sop = 1'b1; // @ cmdq_dma_ctrl.scala l56
  assign err_dma_wreq_pop_st_payload_eop = 1'b1; // @ cmdq_dma_ctrl.scala l57
  assign err_dma_wreq_pop_st_payload_empty = 6'h20; // @ cmdq_dma_ctrl.scala l58
  assign err_dma_wreq_pop_st_payload_data = {256'd0, tmp_err_dma_wreq_pop_st_payload_data}; // @ cmdq_dma_ctrl.scala l59
  assign err_cmdqe_dma_wreq_fifo_pop_ready = err_dma_wreq_pop_st_ready; // @ cmdq_dma_ctrl.scala l60
  assign tmp_dma_wreq_m_payload_data = {dma_wreq_arbi_io_output_payload_sop,{dma_wreq_arbi_io_output_payload_eop,{dma_wreq_arbi_io_output_payload_empty,{dma_wreq_arbi_io_output_payload_channel,dma_wreq_arbi_io_output_payload_data}}}}; // @ BaseType.scala l299
  assign dma_wreq_m_valid = dma_wreq_arbi_io_output_valid; // @ cmdq_dma_ctrl.scala l61
  assign dma_wreq_m_payload_data = tmp_dma_wreq_m_payload_data[511 : 0]; // @ cmdq_dma_ctrl.scala l61
  assign dma_wreq_m_payload_channel = tmp_dma_wreq_m_payload_data[639 : 512]; // @ cmdq_dma_ctrl.scala l61
  assign dma_wreq_m_payload_empty = tmp_dma_wreq_m_payload_data[645 : 640]; // @ cmdq_dma_ctrl.scala l61
  assign dma_wreq_m_payload_eop = tmp_dma_wreq_m_payload_data[646]; // @ cmdq_dma_ctrl.scala l61
  assign dma_wreq_m_payload_sop = tmp_dma_wreq_m_payload_data[647]; // @ cmdq_dma_ctrl.scala l61
  assign err_dma_wreq_pop_st_ready = dma_wreq_arbi_io_inputs_0_ready; // @ cmdq_dma_ctrl.scala l62
  assign cmd_rsp_wreq_pop_st_ready = dma_wreq_arbi_io_inputs_1_ready; // @ cmdq_dma_ctrl.scala l62

endmodule
