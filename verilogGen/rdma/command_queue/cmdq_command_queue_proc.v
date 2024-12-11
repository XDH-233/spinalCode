// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : cmdq_command_queue_proc
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766
// Gen time  : 2024-11-25 11:51:40


module cmdq_command_queue_proc (
  input  wire          db_vec_s_valid,
  output wire          db_vec_s_ready,
  input  wire [31:0]   db_vec_s_payload,
  input  wire          dma_rreq_m_ready,
  output wire          dma_rreq_m_valid,
  output wire [127:0]  dma_rreq_m_payload_channel,
  output wire          dma_rrsp_s_ready,
  input  wire          dma_rrsp_s_valid,
  input  wire [511:0]  dma_rrsp_s_payload_data,
  input  wire [127:0]  dma_rrsp_s_payload_channel,
  input  wire [5:0]    dma_rrsp_s_payload_empty,
  input  wire          dma_rrsp_s_payload_eop,
  input  wire          dma_rrsp_s_payload_sop,
  input  wire          dma_wreq_m_ready,
  output wire          dma_wreq_m_valid,
  output wire [511:0]  dma_wreq_m_payload_data,
  output wire [127:0]  dma_wreq_m_payload_channel,
  output wire [5:0]    dma_wreq_m_payload_empty,
  output wire          dma_wreq_m_payload_eop,
  output wire          dma_wreq_m_payload_sop,
  input  wire [63:0]   cmdq_phy_addr_i,
  input  wire          cmd_req_ready,
  output wire          cmd_req_valid,
  output wire [511:0]  cmd_req_payload_data,
  output wire [24:0]   cmd_req_payload_channel,
  output wire [5:0]    cmd_req_payload_empty,
  output wire          cmd_req_payload_eop,
  output wire          cmd_req_payload_sop,
  output wire          cmd_rsp_ready,
  input  wire          cmd_rsp_valid,
  input  wire [511:0]  cmd_rsp_payload_data,
  input  wire [34:0]   cmd_rsp_payload_channel,
  input  wire [5:0]    cmd_rsp_payload_empty,
  input  wire          cmd_rsp_payload_eop,
  input  wire          cmd_rsp_payload_sop,
  input  wire          reset,
  input  wire          clk
);

  wire       [4:0]    db_id_for_err_fifo_din;
  wire       [4:0]    cmd_id_for_cmd_req_gen_fifo_din;
  wire       [4:0]    cmd_id_finish_err_cmdqe_fifo_din;
  wire       [4:0]    cmd_id_finish_cmd_rsp_fifo_din;
  wire       [140:0]  cmd_req_cmdqe_elements_fifo_din;
  wire       [544:0]  cmd_req_fifo_din;
  wire       [4:0]    cmd_rsp_divide_inst_db_id_dout;
  wire       [63:0]   cmd_rsp_divide_inst_cmd_out_entry_stored_output_mb_point;
  wire       [31:0]   cmd_rsp_divide_inst_cmd_out_entry_stored_output_length;
  wire       [7:0]    cmd_rsp_divide_inst_cmd_out_entry_stored_signature;
  wire       [7:0]    cmd_rsp_divide_inst_cmd_out_entry_stored_token;
  wire       [4:0]    db_id_ram_din;
  wire                cmd_entry_out_ram_din_ram_wren;
  wire       [111:0]  cmd_entry_out_ram_din_ram_din;
  wire                db_id_for_err_fifo_full;
  wire       [4:0]    db_id_for_err_fifo_dout;
  wire                db_id_for_err_fifo_empty;
  wire                db_id_for_err_fifo_almost_empty;
  wire                db_id_for_err_fifo_almost_full;
  wire       [4:0]    db_id_for_err_fifo_usedw;
  wire                db_id_for_err_fifo_overflow;
  wire                db_id_for_err_fifo_underflow;
  wire                cmd_id_for_cmd_req_gen_fifo_full;
  wire       [4:0]    cmd_id_for_cmd_req_gen_fifo_dout;
  wire                cmd_id_for_cmd_req_gen_fifo_empty;
  wire                cmd_id_for_cmd_req_gen_fifo_almost_empty;
  wire                cmd_id_for_cmd_req_gen_fifo_almost_full;
  wire       [4:0]    cmd_id_for_cmd_req_gen_fifo_usedw;
  wire                cmd_id_for_cmd_req_gen_fifo_overflow;
  wire                cmd_id_for_cmd_req_gen_fifo_underflow;
  wire                cmd_id_mngr_io_clear_ready;
  wire                cmd_id_mngr_io_fetch_valid;
  wire       [4:0]    cmd_id_mngr_io_fetch_payload;
  wire                cmd_id_finish_err_cmdqe_fifo_full;
  wire       [4:0]    cmd_id_finish_err_cmdqe_fifo_dout;
  wire                cmd_id_finish_err_cmdqe_fifo_empty;
  wire                cmd_id_finish_err_cmdqe_fifo_almost_empty;
  wire                cmd_id_finish_err_cmdqe_fifo_almost_full;
  wire       [4:0]    cmd_id_finish_err_cmdqe_fifo_usedw;
  wire                cmd_id_finish_err_cmdqe_fifo_overflow;
  wire                cmd_id_finish_err_cmdqe_fifo_underflow;
  wire                cmd_id_finish_cmd_rsp_fifo_full;
  wire       [4:0]    cmd_id_finish_cmd_rsp_fifo_dout;
  wire                cmd_id_finish_cmd_rsp_fifo_empty;
  wire                cmd_id_finish_cmd_rsp_fifo_almost_empty;
  wire                cmd_id_finish_cmd_rsp_fifo_almost_full;
  wire       [4:0]    cmd_id_finish_cmd_rsp_fifo_usedw;
  wire                cmd_id_finish_cmd_rsp_fifo_overflow;
  wire                cmd_id_finish_cmd_rsp_fifo_underflow;
  wire                streamArbiter_io_inputs_0_ready;
  wire                streamArbiter_io_inputs_1_ready;
  wire                streamArbiter_io_output_valid;
  wire       [4:0]    streamArbiter_io_output_payload;
  wire       [0:0]    streamArbiter_io_chosen;
  wire       [1:0]    streamArbiter_io_chosenOH;
  wire                cmd_req_cmdqe_elements_fifo_full;
  wire       [140:0]  cmd_req_cmdqe_elements_fifo_dout;
  wire                cmd_req_cmdqe_elements_fifo_empty;
  wire                cmd_req_cmdqe_elements_fifo_almost_empty;
  wire                cmd_req_cmdqe_elements_fifo_almost_full;
  wire       [4:0]    cmd_req_cmdqe_elements_fifo_usedw;
  wire                cmd_req_cmdqe_elements_fifo_overflow;
  wire                cmd_req_cmdqe_elements_fifo_underflow;
  wire                cmd_req_fifo_full;
  wire       [544:0]  cmd_req_fifo_dout;
  wire                cmd_req_fifo_empty;
  wire                cmd_req_fifo_almost_empty;
  wire                cmd_req_fifo_almost_full;
  wire       [6:0]    cmd_req_fifo_usedw;
  wire                cmd_req_fifo_overflow;
  wire                cmd_req_fifo_underflow;
  wire                cmd_req_gen_inst_cmdqe_elements_ready;
  wire                cmd_req_gen_inst_mb_dma_rrsp_ready;
  wire                cmd_req_gen_inst_cmd_req_valid;
  wire       [511:0]  cmd_req_gen_inst_cmd_req_payload_data;
  wire       [24:0]   cmd_req_gen_inst_cmd_req_payload_channel;
  wire       [5:0]    cmd_req_gen_inst_cmd_req_payload_empty;
  wire                cmd_req_gen_inst_cmd_req_payload_eop;
  wire                cmd_req_gen_inst_cmd_req_payload_sop;
  wire                cmdq_dma_ctrl_inst_cmdqe_dma_rreq_s_ready;
  wire                cmdq_dma_ctrl_inst_mb_dma_dma_rreq_s_ready;
  wire                cmdq_dma_ctrl_inst_dma_rreq_m_valid;
  wire       [127:0]  cmdq_dma_ctrl_inst_dma_rreq_m_payload_channel;
  wire                cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_valid;
  wire       [23:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3;
  wire       [7:0]    cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_type_;
  wire       [31:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_len;
  wire       [31:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_high;
  wire       [8:0]    cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv2;
  wire       [22:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_low;
  wire       [15:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid;
  wire       [15:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_opcode;
  wire       [15:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_op_mod;
  wire       [15:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_rsv;
  wire       [63:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_inline_cmd;
  wire       [23:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv;
  wire       [7:0]    cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_status;
  wire       [31:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_syndrome;
  wire       [63:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_cmd_output;
  wire       [31:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high;
  wire       [8:0]    cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv1;
  wire       [22:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_low;
  wire       [31:0]   cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_length;
  wire                cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_own;
  wire       [6:0]    cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_status;
  wire       [7:0]    cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv0;
  wire       [7:0]    cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_signature;
  wire       [7:0]    cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_token;
  wire                cmdq_dma_ctrl_inst_mb_dma_rrsp_m_valid;
  wire       [511:0]  cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_data;
  wire       [127:0]  cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_channel;
  wire       [5:0]    cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_empty;
  wire                cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_eop;
  wire                cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_sop;
  wire                cmdq_dma_ctrl_inst_dma_rrsp_s_ready;
  wire                cmdq_dma_ctrl_inst_err_cmdqe_dma_wreq_s_ready;
  wire                cmdq_dma_ctrl_inst_cmd_rsp_dma_wreq_s_ready;
  wire                cmdq_dma_ctrl_inst_dma_wreq_m_valid;
  wire       [511:0]  cmdq_dma_ctrl_inst_dma_wreq_m_payload_data;
  wire       [127:0]  cmdq_dma_ctrl_inst_dma_wreq_m_payload_channel;
  wire       [5:0]    cmdq_dma_ctrl_inst_dma_wreq_m_payload_empty;
  wire                cmdq_dma_ctrl_inst_dma_wreq_m_payload_eop;
  wire                cmdq_dma_ctrl_inst_dma_wreq_m_payload_sop;
  wire                cmd_rsp_divide_inst_cmd_rsp_ready;
  wire                cmd_rsp_divide_inst_rd;
  wire       [4:0]    cmd_rsp_divide_inst_raddr;
  wire                cmd_rsp_divide_inst_cmd_rsp_dma_wreq_valid;
  wire       [511:0]  cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_data;
  wire       [127:0]  cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_channel;
  wire       [5:0]    cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_empty;
  wire                cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_eop;
  wire                cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_sop;
  wire                cmd_rsp_divide_inst_cmd_id_finish_valid;
  wire       [4:0]    cmd_rsp_divide_inst_cmd_id_finish_payload;
  wire       [4:0]    db_id_ram_dout;
  wire       [111:0]  cmd_entry_out_ram_din_ram_dout;
  wire       [63:0]   tmp_cmdqe_phy_addr;
  wire       [10:0]   tmp_cmdqe_phy_addr_1;
  wire       [31:0]   tmp_mb_dma_rreq_desc_length;
  wire       [0:0]    tmp_mb_dma_rreq_desc_tag;
  wire       [0:0]    tmp_cmdqe_dma_rreq_desc_tag;
  wire       [63:0]   tmp_cmdqe_check_err_cmdqe_dma_addr;
  wire       [63:0]   tmp_cmdqe_check_err_cmdqe_dma_addr_1;
  wire       [10:0]   tmp_cmdqe_check_err_cmdqe_dma_addr_2;
  wire       [15:0]   tmp_tmp_cmd_rsp_avst_check_pkt_size_payload;
  wire       [15:0]   tmp_tmp_cmd_rsp_avst_check_pkt_size_payload_1;
  wire       [31:0]   tmp_cmd_rsp_rcv_len_err;
  wire                db_id_for_err_push_valid;
  wire                db_id_for_err_push_ready;
  wire       [4:0]    db_id_for_err_push_payload;
  wire                db_id_for_err_pop_valid;
  wire                db_id_for_err_pop_ready;
  wire       [4:0]    db_id_for_err_pop_payload;
  wire                cmd_id_for_cmd_req_gen_push_valid;
  wire                cmd_id_for_cmd_req_gen_push_ready;
  wire       [4:0]    cmd_id_for_cmd_req_gen_push_payload;
  wire                cmd_id_for_cmd_req_gen_pop_valid;
  wire                cmd_id_for_cmd_req_gen_pop_ready;
  wire       [4:0]    cmd_id_for_cmd_req_gen_pop_payload;
  wire                tmp_db_id;
  wire                tmp_db_id_1;
  wire                tmp_db_id_2;
  wire                tmp_db_id_3;
  wire                tmp_db_id_4;
  wire                tmp_db_id_5;
  wire                tmp_db_id_6;
  wire                tmp_db_id_7;
  wire                tmp_db_id_8;
  wire                tmp_db_id_9;
  wire                tmp_db_id_10;
  wire                tmp_db_id_11;
  wire                tmp_db_id_12;
  wire                tmp_db_id_13;
  wire                tmp_db_id_14;
  wire                tmp_db_id_15;
  wire                tmp_db_id_16;
  wire                tmp_db_id_17;
  wire                tmp_db_id_18;
  wire                tmp_db_id_19;
  wire                tmp_db_id_20;
  wire                tmp_db_id_21;
  wire                tmp_db_id_22;
  wire                tmp_db_id_23;
  wire                tmp_db_id_24;
  wire                tmp_db_id_25;
  wire                tmp_db_id_26;
  wire                tmp_db_id_27;
  wire                tmp_db_id_28;
  wire                tmp_db_id_29;
  wire                tmp_db_id_30;
  wire       [4:0]    db_id;
  reg        [63:0]   cmdq_phy_addr_reg;
  wire       [63:0]   cmdqe_phy_addr;
  wire                cmd_id_finish_err_cmdqe_push_valid;
  wire                cmd_id_finish_err_cmdqe_push_ready;
  wire       [4:0]    cmd_id_finish_err_cmdqe_push_payload;
  wire                cmd_id_finish_err_cmdqe_pop_valid;
  wire                cmd_id_finish_err_cmdqe_pop_ready;
  wire       [4:0]    cmd_id_finish_err_cmdqe_pop_payload;
  wire                cmd_id_finish_cmd_rsp_push_valid;
  wire                cmd_id_finish_cmd_rsp_push_ready;
  wire       [4:0]    cmd_id_finish_cmd_rsp_push_payload;
  wire                cmd_id_finish_cmd_rsp_pop_valid;
  wire                cmd_id_finish_cmd_rsp_pop_ready;
  wire       [4:0]    cmd_id_finish_cmd_rsp_pop_payload;
  wire                cmd_id_fihish_arbi_valid;
  wire                cmd_id_fihish_arbi_ready;
  wire       [4:0]    cmd_id_fihish_arbi_payload;
  wire                cmdqe_dma_rreq_st_valid;
  wire                cmdqe_dma_rreq_st_ready;
  wire       [63:0]   cmdqe_dma_rreq_st_payload_addr;
  wire       [16:0]   cmdqe_dma_rreq_st_payload_length;
  wire       [5:0]    cmdqe_dma_rreq_st_payload_queue_id;
  wire       [10:0]   cmdqe_dma_rreq_st_payload_vf_num;
  wire                cmdqe_dma_rreq_st_payload_vf_active;
  wire       [4:0]    cmdqe_dma_rreq_st_payload_pf_num;
  wire       [8:0]    cmdqe_dma_rreq_st_payload_tag;
  wire       [4:0]    cmdqe_dma_rreq_st_payload_rdma_channel_id;
  wire                cmdqe_dma_rreq_st_payload_at;
  wire                cmdqe_dma_rreq_st_payload_attr;
  wire       [5:0]    cmdqe_dma_rreq_st_payload_channel_id;
  wire       [1:0]    cmdqe_dma_rreq_st_payload_rsv0;
  wire                mb_dma_rreq_st_valid;
  wire                mb_dma_rreq_st_ready;
  wire       [63:0]   mb_dma_rreq_st_payload_addr;
  wire       [16:0]   mb_dma_rreq_st_payload_length;
  wire       [5:0]    mb_dma_rreq_st_payload_queue_id;
  wire       [10:0]   mb_dma_rreq_st_payload_vf_num;
  wire                mb_dma_rreq_st_payload_vf_active;
  wire       [4:0]    mb_dma_rreq_st_payload_pf_num;
  wire       [8:0]    mb_dma_rreq_st_payload_tag;
  wire       [4:0]    mb_dma_rreq_st_payload_rdma_channel_id;
  wire                mb_dma_rreq_st_payload_at;
  wire                mb_dma_rreq_st_payload_attr;
  wire       [5:0]    mb_dma_rreq_st_payload_channel_id;
  wire       [1:0]    mb_dma_rreq_st_payload_rsv0;
  wire                cmdqe_dma_rrsp_st_valid;
  wire                cmdqe_dma_rrsp_st_ready;
  wire       [23:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_in_rsv3;
  wire       [7:0]    cmdqe_dma_rrsp_st_payload_cmd_entry_in_type_;
  wire       [31:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len;
  wire       [31:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_mb_point_high;
  wire       [8:0]    cmdqe_dma_rrsp_st_payload_cmd_entry_in_rsv2;
  wire       [22:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_mb_point_low;
  wire       [15:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_uid;
  wire       [15:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_opcode;
  wire       [15:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_op_mod;
  wire       [15:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_rsv;
  wire       [63:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_inline_cmd;
  wire       [23:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_rsv;
  wire       [7:0]    cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_status;
  wire       [31:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_syndrome;
  wire       [63:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_cmd_output;
  wire       [31:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_mb_point_high;
  wire       [8:0]    cmdqe_dma_rrsp_st_payload_cmd_entry_out_rsv1;
  wire       [22:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_mb_point_low;
  wire       [31:0]   cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length;
  wire                cmdqe_dma_rrsp_st_payload_cmd_entry_out_own;
  wire       [6:0]    cmdqe_dma_rrsp_st_payload_cmd_entry_out_status;
  wire       [7:0]    cmdqe_dma_rrsp_st_payload_cmd_entry_out_rsv0;
  wire       [7:0]    cmdqe_dma_rrsp_st_payload_cmd_entry_out_signature;
  wire       [7:0]    cmdqe_dma_rrsp_st_payload_cmd_entry_out_token;
  wire                mb_dma_rrsp_fifo_st_ready;
  wire                mb_dma_rrsp_fifo_st_valid;
  wire       [511:0]  mb_dma_rrsp_fifo_st_payload_data;
  wire       [127:0]  mb_dma_rrsp_fifo_st_payload_channel;
  wire       [5:0]    mb_dma_rrsp_fifo_st_payload_empty;
  wire                mb_dma_rrsp_fifo_st_payload_eop;
  wire                mb_dma_rrsp_fifo_st_payload_sop;
  wire                err_cmdqe_dma_wreq_st_valid;
  wire                err_cmdqe_dma_wreq_st_ready;
  wire       [63:0]   err_cmdqe_dma_wreq_st_payload_desc_addr;
  wire       [16:0]   err_cmdqe_dma_wreq_st_payload_desc_length;
  wire       [5:0]    err_cmdqe_dma_wreq_st_payload_desc_queue_id;
  wire                err_cmdqe_dma_wreq_st_payload_desc_vf_active;
  wire       [10:0]   err_cmdqe_dma_wreq_st_payload_desc_vf_num;
  wire       [4:0]    err_cmdqe_dma_wreq_st_payload_desc_pf_num;
  wire       [4:0]    err_cmdqe_dma_wreq_st_payload_desc_desc_type;
  wire       [16:0]   err_cmdqe_dma_wreq_st_payload_desc_rsv;
  wire       [1:0]    err_cmdqe_dma_wreq_st_payload_desc_tlp_channel_id;
  wire       [23:0]   err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_rsv;
  wire       [7:0]    err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_status;
  wire       [31:0]   err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_syndrome;
  wire       [63:0]   err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_cmd_output;
  wire       [31:0]   err_cmdqe_dma_wreq_st_payload_cmd_out_output_mb_point_high;
  wire       [8:0]    err_cmdqe_dma_wreq_st_payload_cmd_out_rsv1;
  wire       [22:0]   err_cmdqe_dma_wreq_st_payload_cmd_out_output_mb_point_low;
  wire       [31:0]   err_cmdqe_dma_wreq_st_payload_cmd_out_output_length;
  wire                err_cmdqe_dma_wreq_st_payload_cmd_out_own;
  wire       [6:0]    err_cmdqe_dma_wreq_st_payload_cmd_out_status;
  wire       [7:0]    err_cmdqe_dma_wreq_st_payload_cmd_out_rsv0;
  wire       [7:0]    err_cmdqe_dma_wreq_st_payload_cmd_out_signature;
  wire       [7:0]    err_cmdqe_dma_wreq_st_payload_cmd_out_token;
  wire                cmd_rsp_dma_wreq_avst_ready;
  wire                cmd_rsp_dma_wreq_avst_valid;
  wire       [511:0]  cmd_rsp_dma_wreq_avst_payload_data;
  wire       [127:0]  cmd_rsp_dma_wreq_avst_payload_channel;
  wire       [5:0]    cmd_rsp_dma_wreq_avst_payload_empty;
  wire                cmd_rsp_dma_wreq_avst_payload_eop;
  wire                cmd_rsp_dma_wreq_avst_payload_sop;
  reg        [63:0]   mb_dma_rreq_desc_addr;
  reg        [16:0]   mb_dma_rreq_desc_length;
  wire       [5:0]    mb_dma_rreq_desc_queue_id;
  wire       [10:0]   mb_dma_rreq_desc_vf_num;
  wire                mb_dma_rreq_desc_vf_active;
  reg        [4:0]    mb_dma_rreq_desc_pf_num;
  reg        [8:0]    mb_dma_rreq_desc_tag;
  reg        [4:0]    mb_dma_rreq_desc_rdma_channel_id;
  wire                mb_dma_rreq_desc_at;
  wire                mb_dma_rreq_desc_attr;
  reg        [5:0]    mb_dma_rreq_desc_channel_id;
  wire       [1:0]    mb_dma_rreq_desc_rsv0;
  wire       [127:0]  tmp_mb_dma_rreq_desc_addr;
  reg        [63:0]   cmdqe_dma_rreq_desc_addr;
  reg        [16:0]   cmdqe_dma_rreq_desc_length;
  wire       [5:0]    cmdqe_dma_rreq_desc_queue_id;
  wire       [10:0]   cmdqe_dma_rreq_desc_vf_num;
  wire                cmdqe_dma_rreq_desc_vf_active;
  reg        [4:0]    cmdqe_dma_rreq_desc_pf_num;
  reg        [8:0]    cmdqe_dma_rreq_desc_tag;
  reg        [4:0]    cmdqe_dma_rreq_desc_rdma_channel_id;
  wire                cmdqe_dma_rreq_desc_at;
  wire                cmdqe_dma_rreq_desc_attr;
  reg        [5:0]    cmdqe_dma_rreq_desc_channel_id;
  wire       [1:0]    cmdqe_dma_rreq_desc_rsv0;
  wire       [127:0]  tmp_cmdqe_dma_rreq_desc_addr;
  reg                 cmdqe_check_bad_opcode;
  wire                cmdqe_check_in_len_less_than_16;
  wire                cmdqe_check_out_len_less_than_16;
  reg                 cmdqe_check_bad_input_len;
  reg                 cmdqe_check_bad_output_len;
  wire                cmdqe_check_cmdqe_err;
  wire       [63:0]   cmdqe_check_err_cmdqe_dma_addr;
  reg        [63:0]   cmdqe_check_err_cmdqe_wreq_desc_addr;
  reg        [16:0]   cmdqe_check_err_cmdqe_wreq_desc_length;
  wire       [5:0]    cmdqe_check_err_cmdqe_wreq_desc_queue_id;
  wire                cmdqe_check_err_cmdqe_wreq_desc_vf_active;
  wire       [10:0]   cmdqe_check_err_cmdqe_wreq_desc_vf_num;
  wire       [4:0]    cmdqe_check_err_cmdqe_wreq_desc_pf_num;
  wire       [4:0]    cmdqe_check_err_cmdqe_wreq_desc_desc_type;
  wire       [16:0]   cmdqe_check_err_cmdqe_wreq_desc_rsv;
  reg        [1:0]    cmdqe_check_err_cmdqe_wreq_desc_tlp_channel_id;
  wire       [127:0]  tmp_cmdqe_check_err_cmdqe_wreq_desc_addr;
  wire                cmdqe_dma_rrsp_st_fire;
  wire       [23:0]   cmdqe_check_err_cmdqe_out_output_inline_data_rsv;
  reg        [7:0]    cmdqe_check_err_cmdqe_out_output_inline_data_status;
  wire       [31:0]   cmdqe_check_err_cmdqe_out_output_inline_data_syndrome;
  wire       [63:0]   cmdqe_check_err_cmdqe_out_output_inline_data_cmd_output;
  wire       [31:0]   cmdqe_check_err_cmdqe_out_output_mb_point_high;
  wire       [8:0]    cmdqe_check_err_cmdqe_out_rsv1;
  wire       [22:0]   cmdqe_check_err_cmdqe_out_output_mb_point_low;
  wire       [31:0]   cmdqe_check_err_cmdqe_out_output_length;
  wire                cmdqe_check_err_cmdqe_out_own;
  reg        [6:0]    cmdqe_check_err_cmdqe_out_status;
  wire       [7:0]    cmdqe_check_err_cmdqe_out_rsv0;
  wire       [7:0]    cmdqe_check_err_cmdqe_out_signature;
  wire       [7:0]    cmdqe_check_err_cmdqe_out_token;
  wire       [63:0]   cmd_entry_out_ram_din_output_mb_point;
  wire       [31:0]   cmd_entry_out_ram_din_output_length;
  wire       [7:0]    cmd_entry_out_ram_din_signature;
  wire       [7:0]    cmd_entry_out_ram_din_token;
  wire                cmd_req_cmdqe_elements_push_valid;
  wire                cmd_req_cmdqe_elements_push_ready;
  wire       [4:0]    cmd_req_cmdqe_elements_push_payload_cmd_id;
  wire       [7:0]    cmd_req_cmdqe_elements_push_payload_input_len;
  wire       [15:0]   cmd_req_cmdqe_elements_push_payload_cmd_inline_data_uid;
  wire       [15:0]   cmd_req_cmdqe_elements_push_payload_cmd_inline_data_opcode;
  wire       [15:0]   cmd_req_cmdqe_elements_push_payload_cmd_inline_data_op_mod;
  wire       [15:0]   cmd_req_cmdqe_elements_push_payload_cmd_inline_data_rsv;
  wire       [63:0]   cmd_req_cmdqe_elements_push_payload_cmd_inline_data_inline_cmd;
  wire                cmd_req_cmdqe_elements_pop_valid;
  wire                cmd_req_cmdqe_elements_pop_ready;
  wire       [4:0]    cmd_req_cmdqe_elements_pop_payload_cmd_id;
  wire       [7:0]    cmd_req_cmdqe_elements_pop_payload_input_len;
  wire       [15:0]   cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_uid;
  wire       [15:0]   cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_opcode;
  wire       [15:0]   cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_op_mod;
  wire       [15:0]   cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_rsv;
  wire       [63:0]   cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_inline_cmd;
  wire       [127:0]  tmp_cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_uid;
  wire                cmd_req_push_ready;
  wire                cmd_req_push_valid;
  wire       [511:0]  cmd_req_push_payload_data;
  wire       [24:0]   cmd_req_push_payload_channel;
  wire       [5:0]    cmd_req_push_payload_empty;
  wire                cmd_req_push_payload_eop;
  wire                cmd_req_push_payload_sop;
  wire                cmd_req_pop_ready;
  wire                cmd_req_pop_valid;
  wire       [511:0]  cmd_req_pop_payload_data;
  wire       [24:0]   cmd_req_pop_payload_channel;
  wire       [5:0]    cmd_req_pop_payload_empty;
  wire                cmd_req_pop_payload_eop;
  wire                cmd_req_pop_payload_sop;
  wire                db_vec_s_fire;
  reg                 cmd_rsp_avst_check_dup_sop;
  reg                 cmd_rsp_avst_check_channel_changed;
  reg                 cmd_rsp_avst_check_trans_outside;
  reg        [15:0]   cmd_rsp_avst_check_pkt_byte_cnt;
  wire                cmd_rsp_avst_check_pkt_size_valid;
  wire       [15:0]   cmd_rsp_avst_check_pkt_size_payload;
  reg        [31:0]   cmd_rsp_avst_check_pkt_count;
  wire                cmd_rsp_avst_check_fire;
  reg                 cmd_rsp_avst_check_soped;
  reg        [34:0]   cmd_rsp_avst_check_channel_reg;
  reg        [15:0]   tmp_cmd_rsp_avst_check_pkt_size_payload;
  reg                 tmp_cmd_rsp_avst_check_pkt_size_valid;
  wire                cmd_rsp_rcv_len_err;

  assign tmp_cmdqe_phy_addr_1 = ({6'd0,db_id} <<< 3'd6);
  assign tmp_cmdqe_phy_addr = {53'd0, tmp_cmdqe_phy_addr_1};
  assign tmp_mb_dma_rreq_desc_length = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len - 32'h00000010);
  assign tmp_mb_dma_rreq_desc_tag = 1'b1;
  assign tmp_cmdqe_dma_rreq_desc_tag = 1'b0;
  assign tmp_cmdqe_check_err_cmdqe_dma_addr = (cmdq_phy_addr_reg + tmp_cmdqe_check_err_cmdqe_dma_addr_1);
  assign tmp_cmdqe_check_err_cmdqe_dma_addr_2 = ({6'd0,db_id_for_err_pop_payload} <<< 3'd6);
  assign tmp_cmdqe_check_err_cmdqe_dma_addr_1 = {53'd0, tmp_cmdqe_check_err_cmdqe_dma_addr_2};
  assign tmp_tmp_cmd_rsp_avst_check_pkt_size_payload = (cmd_rsp_avst_check_pkt_byte_cnt + 16'h0040);
  assign tmp_tmp_cmd_rsp_avst_check_pkt_size_payload_1 = {10'd0, cmd_rsp_payload_empty};
  assign tmp_cmd_rsp_rcv_len_err = {16'd0, cmd_rsp_avst_check_pkt_size_payload};
  rdma_ctyun_sfifo #(
    .DEPTH      (32),
    .DATA_WIDTH (5 )
  ) db_id_for_err_fifo (
    .clk          (clk                            ), //i
    .srst         (reset                          ), //i
    .wr_en        (db_id_for_err_push_valid       ), //i
    .din          (db_id_for_err_fifo_din[4:0]    ), //i
    .full         (db_id_for_err_fifo_full        ), //o
    .rd_en        (db_id_for_err_pop_ready        ), //i
    .dout         (db_id_for_err_fifo_dout[4:0]   ), //o
    .empty        (db_id_for_err_fifo_empty       ), //o
    .almost_empty (db_id_for_err_fifo_almost_empty), //o
    .almost_full  (db_id_for_err_fifo_almost_full ), //o
    .usedw        (db_id_for_err_fifo_usedw[4:0]  ), //o
    .overflow     (db_id_for_err_fifo_overflow    ), //o
    .underflow    (db_id_for_err_fifo_underflow   )  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (32),
    .DATA_WIDTH (5 )
  ) cmd_id_for_cmd_req_gen_fifo (
    .clk          (clk                                     ), //i
    .srst         (reset                                   ), //i
    .wr_en        (cmd_id_for_cmd_req_gen_push_valid       ), //i
    .din          (cmd_id_for_cmd_req_gen_fifo_din[4:0]    ), //i
    .full         (cmd_id_for_cmd_req_gen_fifo_full        ), //o
    .rd_en        (cmd_id_for_cmd_req_gen_pop_ready        ), //i
    .dout         (cmd_id_for_cmd_req_gen_fifo_dout[4:0]   ), //o
    .empty        (cmd_id_for_cmd_req_gen_fifo_empty       ), //o
    .almost_empty (cmd_id_for_cmd_req_gen_fifo_almost_empty), //o
    .almost_full  (cmd_id_for_cmd_req_gen_fifo_almost_full ), //o
    .usedw        (cmd_id_for_cmd_req_gen_fifo_usedw[4:0]  ), //o
    .overflow     (cmd_id_for_cmd_req_gen_fifo_overflow    ), //o
    .underflow    (cmd_id_for_cmd_req_gen_fifo_underflow   )  //o
  );
  cmdq_id_mngr cmd_id_mngr (
    .io_clear_valid   (cmd_id_fihish_arbi_valid         ), //i
    .io_clear_ready   (cmd_id_mngr_io_clear_ready       ), //o
    .io_clear_payload (cmd_id_fihish_arbi_payload[4:0]  ), //i
    .io_fetch_valid   (cmd_id_mngr_io_fetch_valid       ), //o
    .io_fetch_ready   (db_vec_s_fire                    ), //i
    .io_fetch_payload (cmd_id_mngr_io_fetch_payload[4:0]), //o
    .reset            (reset                            ), //i
    .clk              (clk                              )  //i
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (32),
    .DATA_WIDTH (5 )
  ) cmd_id_finish_err_cmdqe_fifo (
    .clk          (clk                                      ), //i
    .srst         (reset                                    ), //i
    .wr_en        (cmd_id_finish_err_cmdqe_push_valid       ), //i
    .din          (cmd_id_finish_err_cmdqe_fifo_din[4:0]    ), //i
    .full         (cmd_id_finish_err_cmdqe_fifo_full        ), //o
    .rd_en        (cmd_id_finish_err_cmdqe_pop_ready        ), //i
    .dout         (cmd_id_finish_err_cmdqe_fifo_dout[4:0]   ), //o
    .empty        (cmd_id_finish_err_cmdqe_fifo_empty       ), //o
    .almost_empty (cmd_id_finish_err_cmdqe_fifo_almost_empty), //o
    .almost_full  (cmd_id_finish_err_cmdqe_fifo_almost_full ), //o
    .usedw        (cmd_id_finish_err_cmdqe_fifo_usedw[4:0]  ), //o
    .overflow     (cmd_id_finish_err_cmdqe_fifo_overflow    ), //o
    .underflow    (cmd_id_finish_err_cmdqe_fifo_underflow   )  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (32),
    .DATA_WIDTH (5 )
  ) cmd_id_finish_cmd_rsp_fifo (
    .clk          (clk                                    ), //i
    .srst         (reset                                  ), //i
    .wr_en        (cmd_id_finish_cmd_rsp_push_valid       ), //i
    .din          (cmd_id_finish_cmd_rsp_fifo_din[4:0]    ), //i
    .full         (cmd_id_finish_cmd_rsp_fifo_full        ), //o
    .rd_en        (cmd_id_finish_cmd_rsp_pop_ready        ), //i
    .dout         (cmd_id_finish_cmd_rsp_fifo_dout[4:0]   ), //o
    .empty        (cmd_id_finish_cmd_rsp_fifo_empty       ), //o
    .almost_empty (cmd_id_finish_cmd_rsp_fifo_almost_empty), //o
    .almost_full  (cmd_id_finish_cmd_rsp_fifo_almost_full ), //o
    .usedw        (cmd_id_finish_cmd_rsp_fifo_usedw[4:0]  ), //o
    .overflow     (cmd_id_finish_cmd_rsp_fifo_overflow    ), //o
    .underflow    (cmd_id_finish_cmd_rsp_fifo_underflow   )  //o
  );
  cmdq_StreamArbiter_1 streamArbiter (
    .io_inputs_0_valid   (cmd_id_finish_err_cmdqe_pop_valid       ), //i
    .io_inputs_0_ready   (streamArbiter_io_inputs_0_ready         ), //o
    .io_inputs_0_payload (cmd_id_finish_err_cmdqe_pop_payload[4:0]), //i
    .io_inputs_1_valid   (cmd_id_finish_cmd_rsp_pop_valid         ), //i
    .io_inputs_1_ready   (streamArbiter_io_inputs_1_ready         ), //o
    .io_inputs_1_payload (cmd_id_finish_cmd_rsp_pop_payload[4:0]  ), //i
    .io_output_valid     (streamArbiter_io_output_valid           ), //o
    .io_output_ready     (cmd_id_fihish_arbi_ready                ), //i
    .io_output_payload   (streamArbiter_io_output_payload[4:0]    ), //o
    .io_chosen           (streamArbiter_io_chosen                 ), //o
    .io_chosenOH         (streamArbiter_io_chosenOH[1:0]          ), //o
    .clk                 (clk                                     ), //i
    .reset               (reset                                   )  //i
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (32 ),
    .DATA_WIDTH (141)
  ) cmd_req_cmdqe_elements_fifo (
    .clk          (clk                                     ), //i
    .srst         (reset                                   ), //i
    .wr_en        (cmd_req_cmdqe_elements_push_valid       ), //i
    .din          (cmd_req_cmdqe_elements_fifo_din[140:0]  ), //i
    .full         (cmd_req_cmdqe_elements_fifo_full        ), //o
    .rd_en        (cmd_req_cmdqe_elements_pop_ready        ), //i
    .dout         (cmd_req_cmdqe_elements_fifo_dout[140:0] ), //o
    .empty        (cmd_req_cmdqe_elements_fifo_empty       ), //o
    .almost_empty (cmd_req_cmdqe_elements_fifo_almost_empty), //o
    .almost_full  (cmd_req_cmdqe_elements_fifo_almost_full ), //o
    .usedw        (cmd_req_cmdqe_elements_fifo_usedw[4:0]  ), //o
    .overflow     (cmd_req_cmdqe_elements_fifo_overflow    ), //o
    .underflow    (cmd_req_cmdqe_elements_fifo_underflow   )  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (128),
    .DATA_WIDTH (545)
  ) cmd_req_fifo (
    .clk          (clk                      ), //i
    .srst         (reset                    ), //i
    .wr_en        (cmd_req_push_valid       ), //i
    .din          (cmd_req_fifo_din[544:0]  ), //i
    .full         (cmd_req_fifo_full        ), //o
    .rd_en        (cmd_req_pop_ready        ), //i
    .dout         (cmd_req_fifo_dout[544:0] ), //o
    .empty        (cmd_req_fifo_empty       ), //o
    .almost_empty (cmd_req_fifo_almost_empty), //o
    .almost_full  (cmd_req_fifo_almost_full ), //o
    .usedw        (cmd_req_fifo_usedw[6:0]  ), //o
    .overflow     (cmd_req_fifo_overflow    ), //o
    .underflow    (cmd_req_fifo_underflow   )  //o
  );
  cmdq_cmd_req_gen cmd_req_gen_inst (
    .cmdqe_elements_valid                              (cmd_req_cmdqe_elements_pop_valid                                   ), //i
    .cmdqe_elements_ready                              (cmd_req_gen_inst_cmdqe_elements_ready                              ), //o
    .cmdqe_elements_payload_cmd_id                     (cmd_req_cmdqe_elements_pop_payload_cmd_id[4:0]                     ), //i
    .cmdqe_elements_payload_input_len                  (cmd_req_cmdqe_elements_pop_payload_input_len[7:0]                  ), //i
    .cmdqe_elements_payload_cmd_inline_data_uid        (cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_uid[15:0]       ), //i
    .cmdqe_elements_payload_cmd_inline_data_opcode     (cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_opcode[15:0]    ), //i
    .cmdqe_elements_payload_cmd_inline_data_op_mod     (cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_op_mod[15:0]    ), //i
    .cmdqe_elements_payload_cmd_inline_data_rsv        (cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_rsv[15:0]       ), //i
    .cmdqe_elements_payload_cmd_inline_data_inline_cmd (cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_inline_cmd[63:0]), //i
    .mb_dma_rrsp_ready                                 (cmd_req_gen_inst_mb_dma_rrsp_ready                                 ), //o
    .mb_dma_rrsp_valid                                 (mb_dma_rrsp_fifo_st_valid                                          ), //i
    .mb_dma_rrsp_payload_data                          (mb_dma_rrsp_fifo_st_payload_data[511:0]                            ), //i
    .mb_dma_rrsp_payload_channel                       (mb_dma_rrsp_fifo_st_payload_channel[127:0]                         ), //i
    .mb_dma_rrsp_payload_empty                         (mb_dma_rrsp_fifo_st_payload_empty[5:0]                             ), //i
    .mb_dma_rrsp_payload_eop                           (mb_dma_rrsp_fifo_st_payload_eop                                    ), //i
    .mb_dma_rrsp_payload_sop                           (mb_dma_rrsp_fifo_st_payload_sop                                    ), //i
    .cmd_req_ready                                     (cmd_req_push_ready                                                 ), //i
    .cmd_req_valid                                     (cmd_req_gen_inst_cmd_req_valid                                     ), //o
    .cmd_req_payload_data                              (cmd_req_gen_inst_cmd_req_payload_data[511:0]                       ), //o
    .cmd_req_payload_channel                           (cmd_req_gen_inst_cmd_req_payload_channel[24:0]                     ), //o
    .cmd_req_payload_empty                             (cmd_req_gen_inst_cmd_req_payload_empty[5:0]                        ), //o
    .cmd_req_payload_eop                               (cmd_req_gen_inst_cmd_req_payload_eop                               ), //o
    .cmd_req_payload_sop                               (cmd_req_gen_inst_cmd_req_payload_sop                               ), //o
    .clk                                               (clk                                                                ), //i
    .reset                                             (reset                                                              )  //i
  );
  cmdq_cmdq_dma_ctrl cmdq_dma_ctrl_inst (
    .cmdqe_dma_rreq_s_valid                                               (cmdqe_dma_rreq_st_valid                                                                      ), //i
    .cmdqe_dma_rreq_s_ready                                               (cmdq_dma_ctrl_inst_cmdqe_dma_rreq_s_ready                                                    ), //o
    .cmdqe_dma_rreq_s_payload_addr                                        (cmdqe_dma_rreq_st_payload_addr[63:0]                                                         ), //i
    .cmdqe_dma_rreq_s_payload_length                                      (cmdqe_dma_rreq_st_payload_length[16:0]                                                       ), //i
    .cmdqe_dma_rreq_s_payload_queue_id                                    (cmdqe_dma_rreq_st_payload_queue_id[5:0]                                                      ), //i
    .cmdqe_dma_rreq_s_payload_vf_num                                      (cmdqe_dma_rreq_st_payload_vf_num[10:0]                                                       ), //i
    .cmdqe_dma_rreq_s_payload_vf_active                                   (cmdqe_dma_rreq_st_payload_vf_active                                                          ), //i
    .cmdqe_dma_rreq_s_payload_pf_num                                      (cmdqe_dma_rreq_st_payload_pf_num[4:0]                                                        ), //i
    .cmdqe_dma_rreq_s_payload_tag                                         (cmdqe_dma_rreq_st_payload_tag[8:0]                                                           ), //i
    .cmdqe_dma_rreq_s_payload_rdma_channel_id                             (cmdqe_dma_rreq_st_payload_rdma_channel_id[4:0]                                               ), //i
    .cmdqe_dma_rreq_s_payload_at                                          (cmdqe_dma_rreq_st_payload_at                                                                 ), //i
    .cmdqe_dma_rreq_s_payload_attr                                        (cmdqe_dma_rreq_st_payload_attr                                                               ), //i
    .cmdqe_dma_rreq_s_payload_channel_id                                  (cmdqe_dma_rreq_st_payload_channel_id[5:0]                                                    ), //i
    .cmdqe_dma_rreq_s_payload_rsv0                                        (cmdqe_dma_rreq_st_payload_rsv0[1:0]                                                          ), //i
    .mb_dma_dma_rreq_s_valid                                              (mb_dma_rreq_st_valid                                                                         ), //i
    .mb_dma_dma_rreq_s_ready                                              (cmdq_dma_ctrl_inst_mb_dma_dma_rreq_s_ready                                                   ), //o
    .mb_dma_dma_rreq_s_payload_addr                                       (mb_dma_rreq_st_payload_addr[63:0]                                                            ), //i
    .mb_dma_dma_rreq_s_payload_length                                     (mb_dma_rreq_st_payload_length[16:0]                                                          ), //i
    .mb_dma_dma_rreq_s_payload_queue_id                                   (mb_dma_rreq_st_payload_queue_id[5:0]                                                         ), //i
    .mb_dma_dma_rreq_s_payload_vf_num                                     (mb_dma_rreq_st_payload_vf_num[10:0]                                                          ), //i
    .mb_dma_dma_rreq_s_payload_vf_active                                  (mb_dma_rreq_st_payload_vf_active                                                             ), //i
    .mb_dma_dma_rreq_s_payload_pf_num                                     (mb_dma_rreq_st_payload_pf_num[4:0]                                                           ), //i
    .mb_dma_dma_rreq_s_payload_tag                                        (mb_dma_rreq_st_payload_tag[8:0]                                                              ), //i
    .mb_dma_dma_rreq_s_payload_rdma_channel_id                            (mb_dma_rreq_st_payload_rdma_channel_id[4:0]                                                  ), //i
    .mb_dma_dma_rreq_s_payload_at                                         (mb_dma_rreq_st_payload_at                                                                    ), //i
    .mb_dma_dma_rreq_s_payload_attr                                       (mb_dma_rreq_st_payload_attr                                                                  ), //i
    .mb_dma_dma_rreq_s_payload_channel_id                                 (mb_dma_rreq_st_payload_channel_id[5:0]                                                       ), //i
    .mb_dma_dma_rreq_s_payload_rsv0                                       (mb_dma_rreq_st_payload_rsv0[1:0]                                                             ), //i
    .dma_rreq_m_ready                                                     (dma_rreq_m_ready                                                                             ), //i
    .dma_rreq_m_valid                                                     (cmdq_dma_ctrl_inst_dma_rreq_m_valid                                                          ), //o
    .dma_rreq_m_payload_channel                                           (cmdq_dma_ctrl_inst_dma_rreq_m_payload_channel[127:0]                                         ), //o
    .cmdqe_dma_rrsp_m_valid                                               (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_valid                                                    ), //o
    .cmdqe_dma_rrsp_m_ready                                               (cmdqe_dma_rrsp_st_ready                                                                      ), //i
    .cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3                           (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3[23:0]                          ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_in_type_                          (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_type_[7:0]                          ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_len                      (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_len[31:0]                     ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_high            (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_high[31:0]           ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv2                           (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv2[8:0]                           ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_low             (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_low[22:0]            ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid          (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid[15:0]         ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_opcode       (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_opcode[15:0]      ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_op_mod       (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_op_mod[15:0]      ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_rsv          (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_rsv[15:0]         ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_inline_cmd   (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_inline_cmd[63:0]  ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv        (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv[23:0]       ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_status     (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_status[7:0]     ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_syndrome   (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_syndrome[31:0]  ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_cmd_output (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_cmd_output[63:0]), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high          (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high[31:0]         ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv1                          (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv1[8:0]                          ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_low           (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_low[22:0]          ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_length                 (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_length[31:0]                ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_own                           (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_own                                ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_status                        (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_status[6:0]                        ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv0                          (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv0[7:0]                          ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_signature                     (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_signature[7:0]                     ), //o
    .cmdqe_dma_rrsp_m_payload_cmd_entry_out_token                         (cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_token[7:0]                         ), //o
    .mb_dma_rrsp_m_ready                                                  (mb_dma_rrsp_fifo_st_ready                                                                    ), //i
    .mb_dma_rrsp_m_valid                                                  (cmdq_dma_ctrl_inst_mb_dma_rrsp_m_valid                                                       ), //o
    .mb_dma_rrsp_m_payload_data                                           (cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_data[511:0]                                         ), //o
    .mb_dma_rrsp_m_payload_channel                                        (cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_channel[127:0]                                      ), //o
    .mb_dma_rrsp_m_payload_empty                                          (cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_empty[5:0]                                          ), //o
    .mb_dma_rrsp_m_payload_eop                                            (cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_eop                                                 ), //o
    .mb_dma_rrsp_m_payload_sop                                            (cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_sop                                                 ), //o
    .dma_rrsp_s_ready                                                     (cmdq_dma_ctrl_inst_dma_rrsp_s_ready                                                          ), //o
    .dma_rrsp_s_valid                                                     (dma_rrsp_s_valid                                                                             ), //i
    .dma_rrsp_s_payload_data                                              (dma_rrsp_s_payload_data[511:0]                                                               ), //i
    .dma_rrsp_s_payload_channel                                           (dma_rrsp_s_payload_channel[127:0]                                                            ), //i
    .dma_rrsp_s_payload_empty                                             (dma_rrsp_s_payload_empty[5:0]                                                                ), //i
    .dma_rrsp_s_payload_eop                                               (dma_rrsp_s_payload_eop                                                                       ), //i
    .dma_rrsp_s_payload_sop                                               (dma_rrsp_s_payload_sop                                                                       ), //i
    .err_cmdqe_dma_wreq_s_valid                                           (err_cmdqe_dma_wreq_st_valid                                                                  ), //i
    .err_cmdqe_dma_wreq_s_ready                                           (cmdq_dma_ctrl_inst_err_cmdqe_dma_wreq_s_ready                                                ), //o
    .err_cmdqe_dma_wreq_s_payload_desc_addr                               (err_cmdqe_dma_wreq_st_payload_desc_addr[63:0]                                                ), //i
    .err_cmdqe_dma_wreq_s_payload_desc_length                             (err_cmdqe_dma_wreq_st_payload_desc_length[16:0]                                              ), //i
    .err_cmdqe_dma_wreq_s_payload_desc_queue_id                           (err_cmdqe_dma_wreq_st_payload_desc_queue_id[5:0]                                             ), //i
    .err_cmdqe_dma_wreq_s_payload_desc_vf_active                          (err_cmdqe_dma_wreq_st_payload_desc_vf_active                                                 ), //i
    .err_cmdqe_dma_wreq_s_payload_desc_vf_num                             (err_cmdqe_dma_wreq_st_payload_desc_vf_num[10:0]                                              ), //i
    .err_cmdqe_dma_wreq_s_payload_desc_pf_num                             (err_cmdqe_dma_wreq_st_payload_desc_pf_num[4:0]                                               ), //i
    .err_cmdqe_dma_wreq_s_payload_desc_desc_type                          (err_cmdqe_dma_wreq_st_payload_desc_desc_type[4:0]                                            ), //i
    .err_cmdqe_dma_wreq_s_payload_desc_rsv                                (err_cmdqe_dma_wreq_st_payload_desc_rsv[16:0]                                                 ), //i
    .err_cmdqe_dma_wreq_s_payload_desc_tlp_channel_id                     (err_cmdqe_dma_wreq_st_payload_desc_tlp_channel_id[1:0]                                       ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_rsv          (err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_rsv[23:0]                           ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_status       (err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_status[7:0]                         ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_syndrome     (err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_syndrome[31:0]                      ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_output_inline_data_cmd_output   (err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_cmd_output[63:0]                    ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_output_mb_point_high            (err_cmdqe_dma_wreq_st_payload_cmd_out_output_mb_point_high[31:0]                             ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_rsv1                            (err_cmdqe_dma_wreq_st_payload_cmd_out_rsv1[8:0]                                              ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_output_mb_point_low             (err_cmdqe_dma_wreq_st_payload_cmd_out_output_mb_point_low[22:0]                              ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_output_length                   (err_cmdqe_dma_wreq_st_payload_cmd_out_output_length[31:0]                                    ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_own                             (err_cmdqe_dma_wreq_st_payload_cmd_out_own                                                    ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_status                          (err_cmdqe_dma_wreq_st_payload_cmd_out_status[6:0]                                            ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_rsv0                            (err_cmdqe_dma_wreq_st_payload_cmd_out_rsv0[7:0]                                              ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_signature                       (err_cmdqe_dma_wreq_st_payload_cmd_out_signature[7:0]                                         ), //i
    .err_cmdqe_dma_wreq_s_payload_cmd_out_token                           (err_cmdqe_dma_wreq_st_payload_cmd_out_token[7:0]                                             ), //i
    .cmd_rsp_dma_wreq_s_ready                                             (cmdq_dma_ctrl_inst_cmd_rsp_dma_wreq_s_ready                                                  ), //o
    .cmd_rsp_dma_wreq_s_valid                                             (cmd_rsp_dma_wreq_avst_valid                                                                  ), //i
    .cmd_rsp_dma_wreq_s_payload_data                                      (cmd_rsp_dma_wreq_avst_payload_data[511:0]                                                    ), //i
    .cmd_rsp_dma_wreq_s_payload_channel                                   (cmd_rsp_dma_wreq_avst_payload_channel[127:0]                                                 ), //i
    .cmd_rsp_dma_wreq_s_payload_empty                                     (cmd_rsp_dma_wreq_avst_payload_empty[5:0]                                                     ), //i
    .cmd_rsp_dma_wreq_s_payload_eop                                       (cmd_rsp_dma_wreq_avst_payload_eop                                                            ), //i
    .cmd_rsp_dma_wreq_s_payload_sop                                       (cmd_rsp_dma_wreq_avst_payload_sop                                                            ), //i
    .dma_wreq_m_ready                                                     (dma_wreq_m_ready                                                                             ), //i
    .dma_wreq_m_valid                                                     (cmdq_dma_ctrl_inst_dma_wreq_m_valid                                                          ), //o
    .dma_wreq_m_payload_data                                              (cmdq_dma_ctrl_inst_dma_wreq_m_payload_data[511:0]                                            ), //o
    .dma_wreq_m_payload_channel                                           (cmdq_dma_ctrl_inst_dma_wreq_m_payload_channel[127:0]                                         ), //o
    .dma_wreq_m_payload_empty                                             (cmdq_dma_ctrl_inst_dma_wreq_m_payload_empty[5:0]                                             ), //o
    .dma_wreq_m_payload_eop                                               (cmdq_dma_ctrl_inst_dma_wreq_m_payload_eop                                                    ), //o
    .dma_wreq_m_payload_sop                                               (cmdq_dma_ctrl_inst_dma_wreq_m_payload_sop                                                    ), //o
    .reset                                                                (reset                                                                                        ), //i
    .clk                                                                  (clk                                                                                          )  //i
  );
  cmdq_cmd_rsp_divide cmd_rsp_divide_inst (
    .cmd_rsp_ready                        (cmd_rsp_divide_inst_cmd_rsp_ready                             ), //o
    .cmd_rsp_valid                        (cmd_rsp_valid                                                 ), //i
    .cmd_rsp_payload_data                 (cmd_rsp_payload_data[511:0]                                   ), //i
    .cmd_rsp_payload_channel              (cmd_rsp_payload_channel[34:0]                                 ), //i
    .cmd_rsp_payload_empty                (cmd_rsp_payload_empty[5:0]                                    ), //i
    .cmd_rsp_payload_eop                  (cmd_rsp_payload_eop                                           ), //i
    .cmd_rsp_payload_sop                  (cmd_rsp_payload_sop                                           ), //i
    .rd                                   (cmd_rsp_divide_inst_rd                                        ), //o
    .raddr                                (cmd_rsp_divide_inst_raddr[4:0]                                ), //o
    .db_id_dout                           (cmd_rsp_divide_inst_db_id_dout[4:0]                           ), //i
    .cmdq_phy_base_addr                   (cmdq_phy_addr_reg[63:0]                                       ), //i
    .cmd_out_entry_stored_output_mb_point (cmd_rsp_divide_inst_cmd_out_entry_stored_output_mb_point[63:0]), //i
    .cmd_out_entry_stored_output_length   (cmd_rsp_divide_inst_cmd_out_entry_stored_output_length[31:0]  ), //i
    .cmd_out_entry_stored_signature       (cmd_rsp_divide_inst_cmd_out_entry_stored_signature[7:0]       ), //i
    .cmd_out_entry_stored_token           (cmd_rsp_divide_inst_cmd_out_entry_stored_token[7:0]           ), //i
    .cmd_rsp_dma_wreq_ready               (cmd_rsp_dma_wreq_avst_ready                                   ), //i
    .cmd_rsp_dma_wreq_valid               (cmd_rsp_divide_inst_cmd_rsp_dma_wreq_valid                    ), //o
    .cmd_rsp_dma_wreq_payload_data        (cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_data[511:0]      ), //o
    .cmd_rsp_dma_wreq_payload_channel     (cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_channel[127:0]   ), //o
    .cmd_rsp_dma_wreq_payload_empty       (cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_empty[5:0]       ), //o
    .cmd_rsp_dma_wreq_payload_eop         (cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_eop              ), //o
    .cmd_rsp_dma_wreq_payload_sop         (cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_sop              ), //o
    .cmd_id_finish_valid                  (cmd_rsp_divide_inst_cmd_id_finish_valid                       ), //o
    .cmd_id_finish_ready                  (cmd_id_finish_cmd_rsp_push_ready                              ), //i
    .cmd_id_finish_payload                (cmd_rsp_divide_inst_cmd_id_finish_payload[4:0]                ), //o
    .reset                                (reset                                                         ), //i
    .clk                                  (clk                                                           )  //i
  );
  rdma_ctyun_sdpram #(
    .WR_ADDR_WIDTH     (5         ),
    .RD_ADDR_WIDTH     (5         ),
    .WR_DATA_WIDTH     (5         ),
    .RD_DATA_WIDTH     (5         ),
    .READ_LATENCY      (1         ),
    .RAM_TYPE          ("MLAB"    ),
    .READ_DURING_WRITE ("NEW_DATA"),
    .INIT_FILE         (""        )
  ) db_id_ram (
    .clock     (clk                              ), //i
    .wren      (db_vec_s_fire                    ), //i
    .rden      (cmd_rsp_divide_inst_rd           ), //i
    .byteena   (1'b1                             ), //i
    .din       (db_id_ram_din[4:0]               ), //i
    .rdaddress (cmd_rsp_divide_inst_raddr[4:0]   ), //i
    .wraddress (cmd_id_mngr_io_fetch_payload[4:0]), //i
    .dout      (db_id_ram_dout[4:0]              )  //o
  );
  rdma_ctyun_sdpram #(
    .WR_ADDR_WIDTH     (5         ),
    .RD_ADDR_WIDTH     (5         ),
    .WR_DATA_WIDTH     (112       ),
    .RD_DATA_WIDTH     (112       ),
    .READ_LATENCY      (1         ),
    .RAM_TYPE          ("AUTO"    ),
    .READ_DURING_WRITE ("OLD_DATA"),
    .INIT_FILE         (""        )
  ) cmd_entry_out_ram_din_ram (
    .clock     (clk                                    ), //i
    .wren      (cmd_entry_out_ram_din_ram_wren         ), //i
    .rden      (cmd_rsp_divide_inst_rd                 ), //i
    .byteena   (14'h3fff                               ), //i
    .din       (cmd_entry_out_ram_din_ram_din[111:0]   ), //i
    .rdaddress (cmd_rsp_divide_inst_raddr[4:0]         ), //i
    .wraddress (cmd_id_for_cmd_req_gen_pop_payload[4:0]), //i
    .dout      (cmd_entry_out_ram_din_ram_dout[111:0]  )  //o
  );
  assign db_id_for_err_fifo_din = db_id_for_err_push_payload; // @ rdma_ctyun_sfifo.scala l34
  assign db_id_for_err_push_ready = (! db_id_for_err_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign db_id_for_err_pop_valid = (! db_id_for_err_fifo_empty); // @ rdma_ctyun_sfifo.scala l39
  assign db_id_for_err_pop_payload = db_id_for_err_fifo_dout; // @ UInt.scala l381
  assign cmd_id_for_cmd_req_gen_fifo_din = cmd_id_for_cmd_req_gen_push_payload; // @ rdma_ctyun_sfifo.scala l34
  assign cmd_id_for_cmd_req_gen_push_ready = (! cmd_id_for_cmd_req_gen_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign cmd_id_for_cmd_req_gen_pop_valid = (! cmd_id_for_cmd_req_gen_fifo_empty); // @ rdma_ctyun_sfifo.scala l39
  assign cmd_id_for_cmd_req_gen_pop_payload = cmd_id_for_cmd_req_gen_fifo_dout; // @ UInt.scala l381
  assign tmp_db_id = db_vec_s_payload[3]; // @ BaseType.scala l305
  assign tmp_db_id_1 = db_vec_s_payload[5]; // @ BaseType.scala l305
  assign tmp_db_id_2 = db_vec_s_payload[6]; // @ BaseType.scala l305
  assign tmp_db_id_3 = db_vec_s_payload[7]; // @ BaseType.scala l305
  assign tmp_db_id_4 = db_vec_s_payload[9]; // @ BaseType.scala l305
  assign tmp_db_id_5 = db_vec_s_payload[10]; // @ BaseType.scala l305
  assign tmp_db_id_6 = db_vec_s_payload[11]; // @ BaseType.scala l305
  assign tmp_db_id_7 = db_vec_s_payload[12]; // @ BaseType.scala l305
  assign tmp_db_id_8 = db_vec_s_payload[13]; // @ BaseType.scala l305
  assign tmp_db_id_9 = db_vec_s_payload[14]; // @ BaseType.scala l305
  assign tmp_db_id_10 = db_vec_s_payload[15]; // @ BaseType.scala l305
  assign tmp_db_id_11 = db_vec_s_payload[17]; // @ BaseType.scala l305
  assign tmp_db_id_12 = db_vec_s_payload[18]; // @ BaseType.scala l305
  assign tmp_db_id_13 = db_vec_s_payload[19]; // @ BaseType.scala l305
  assign tmp_db_id_14 = db_vec_s_payload[20]; // @ BaseType.scala l305
  assign tmp_db_id_15 = db_vec_s_payload[21]; // @ BaseType.scala l305
  assign tmp_db_id_16 = db_vec_s_payload[22]; // @ BaseType.scala l305
  assign tmp_db_id_17 = db_vec_s_payload[23]; // @ BaseType.scala l305
  assign tmp_db_id_18 = db_vec_s_payload[24]; // @ BaseType.scala l305
  assign tmp_db_id_19 = db_vec_s_payload[25]; // @ BaseType.scala l305
  assign tmp_db_id_20 = db_vec_s_payload[26]; // @ BaseType.scala l305
  assign tmp_db_id_21 = db_vec_s_payload[27]; // @ BaseType.scala l305
  assign tmp_db_id_22 = db_vec_s_payload[28]; // @ BaseType.scala l305
  assign tmp_db_id_23 = db_vec_s_payload[29]; // @ BaseType.scala l305
  assign tmp_db_id_24 = db_vec_s_payload[30]; // @ BaseType.scala l305
  assign tmp_db_id_25 = db_vec_s_payload[31]; // @ BaseType.scala l305
  assign tmp_db_id_26 = (((((((((((((((db_vec_s_payload[1] || tmp_db_id) || tmp_db_id_1) || tmp_db_id_3) || tmp_db_id_4) || tmp_db_id_6) || tmp_db_id_8) || tmp_db_id_10) || tmp_db_id_11) || tmp_db_id_13) || tmp_db_id_15) || tmp_db_id_17) || tmp_db_id_19) || tmp_db_id_21) || tmp_db_id_23) || tmp_db_id_25); // @ BaseType.scala l305
  assign tmp_db_id_27 = (((((((((((((((db_vec_s_payload[2] || tmp_db_id) || tmp_db_id_2) || tmp_db_id_3) || tmp_db_id_5) || tmp_db_id_6) || tmp_db_id_9) || tmp_db_id_10) || tmp_db_id_12) || tmp_db_id_13) || tmp_db_id_16) || tmp_db_id_17) || tmp_db_id_20) || tmp_db_id_21) || tmp_db_id_24) || tmp_db_id_25); // @ BaseType.scala l305
  assign tmp_db_id_28 = (((((((((((((((db_vec_s_payload[4] || tmp_db_id_1) || tmp_db_id_2) || tmp_db_id_3) || tmp_db_id_7) || tmp_db_id_8) || tmp_db_id_9) || tmp_db_id_10) || tmp_db_id_14) || tmp_db_id_15) || tmp_db_id_16) || tmp_db_id_17) || tmp_db_id_22) || tmp_db_id_23) || tmp_db_id_24) || tmp_db_id_25); // @ BaseType.scala l305
  assign tmp_db_id_29 = (((((((((((((((db_vec_s_payload[8] || tmp_db_id_4) || tmp_db_id_5) || tmp_db_id_6) || tmp_db_id_7) || tmp_db_id_8) || tmp_db_id_9) || tmp_db_id_10) || tmp_db_id_18) || tmp_db_id_19) || tmp_db_id_20) || tmp_db_id_21) || tmp_db_id_22) || tmp_db_id_23) || tmp_db_id_24) || tmp_db_id_25); // @ BaseType.scala l305
  assign tmp_db_id_30 = (((((((((((((((db_vec_s_payload[16] || tmp_db_id_11) || tmp_db_id_12) || tmp_db_id_13) || tmp_db_id_14) || tmp_db_id_15) || tmp_db_id_16) || tmp_db_id_17) || tmp_db_id_18) || tmp_db_id_19) || tmp_db_id_20) || tmp_db_id_21) || tmp_db_id_22) || tmp_db_id_23) || tmp_db_id_24) || tmp_db_id_25); // @ BaseType.scala l305
  assign db_id = {tmp_db_id_30,{tmp_db_id_29,{tmp_db_id_28,{tmp_db_id_27,tmp_db_id_26}}}}; // @ BaseType.scala l318
  assign cmdqe_phy_addr = (cmdq_phy_addr_reg + tmp_cmdqe_phy_addr); // @ BaseType.scala l299
  assign cmd_id_finish_err_cmdqe_fifo_din = cmd_id_finish_err_cmdqe_push_payload; // @ rdma_ctyun_sfifo.scala l34
  assign cmd_id_finish_err_cmdqe_push_ready = (! cmd_id_finish_err_cmdqe_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign cmd_id_finish_err_cmdqe_pop_valid = (! cmd_id_finish_err_cmdqe_fifo_empty); // @ rdma_ctyun_sfifo.scala l39
  assign cmd_id_finish_err_cmdqe_pop_payload = cmd_id_finish_err_cmdqe_fifo_dout; // @ UInt.scala l381
  assign cmd_id_finish_cmd_rsp_fifo_din = cmd_id_finish_cmd_rsp_push_payload; // @ rdma_ctyun_sfifo.scala l34
  assign cmd_id_finish_cmd_rsp_push_ready = (! cmd_id_finish_cmd_rsp_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign cmd_id_finish_cmd_rsp_pop_valid = (! cmd_id_finish_cmd_rsp_fifo_empty); // @ rdma_ctyun_sfifo.scala l39
  assign cmd_id_finish_cmd_rsp_pop_payload = cmd_id_finish_cmd_rsp_fifo_dout; // @ UInt.scala l381
  assign cmd_id_finish_err_cmdqe_pop_ready = streamArbiter_io_inputs_0_ready; // @ Stream.scala l299
  assign cmd_id_finish_cmd_rsp_pop_ready = streamArbiter_io_inputs_1_ready; // @ Stream.scala l299
  assign cmd_id_fihish_arbi_valid = streamArbiter_io_output_valid; // @ Stream.scala l298
  assign cmd_id_fihish_arbi_payload = streamArbiter_io_output_payload; // @ Stream.scala l300
  assign tmp_mb_dma_rreq_desc_addr = 128'h0; // @ Expression.scala l2327
  always @(*) begin
    mb_dma_rreq_desc_addr = tmp_mb_dma_rreq_desc_addr[63 : 0]; // @ UInt.scala l381
    mb_dma_rreq_desc_addr = {{cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_mb_point_high,cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_mb_point_low},9'h0}; // @ CmdqBundles.scala l228
  end

  always @(*) begin
    mb_dma_rreq_desc_length = tmp_mb_dma_rreq_desc_addr[80 : 64]; // @ UInt.scala l381
    mb_dma_rreq_desc_length = tmp_mb_dma_rreq_desc_length[16:0]; // @ CmdqBundles.scala l229
  end

  assign mb_dma_rreq_desc_queue_id = tmp_mb_dma_rreq_desc_addr[86 : 81]; // @ Bits.scala l133
  assign mb_dma_rreq_desc_vf_num = tmp_mb_dma_rreq_desc_addr[97 : 87]; // @ Bits.scala l133
  assign mb_dma_rreq_desc_vf_active = tmp_mb_dma_rreq_desc_addr[98]; // @ Bool.scala l209
  always @(*) begin
    mb_dma_rreq_desc_pf_num = tmp_mb_dma_rreq_desc_addr[103 : 99]; // @ Bits.scala l133
    mb_dma_rreq_desc_pf_num = 5'h06; // @ CmdqBundles.scala l232
  end

  always @(*) begin
    mb_dma_rreq_desc_tag = tmp_mb_dma_rreq_desc_addr[112 : 104]; // @ Bits.scala l133
    mb_dma_rreq_desc_tag = {8'd0, tmp_mb_dma_rreq_desc_tag}; // @ CmdqBundles.scala l233
  end

  always @(*) begin
    mb_dma_rreq_desc_rdma_channel_id = tmp_mb_dma_rreq_desc_addr[117 : 113]; // @ Bits.scala l133
    mb_dma_rreq_desc_rdma_channel_id = 5'h09; // @ CmdqBundles.scala l230
  end

  assign mb_dma_rreq_desc_at = tmp_mb_dma_rreq_desc_addr[118]; // @ Bool.scala l209
  assign mb_dma_rreq_desc_attr = tmp_mb_dma_rreq_desc_addr[119]; // @ Bool.scala l209
  always @(*) begin
    mb_dma_rreq_desc_channel_id = tmp_mb_dma_rreq_desc_addr[125 : 120]; // @ UInt.scala l381
    mb_dma_rreq_desc_channel_id = 6'h09; // @ CmdqBundles.scala l231
  end

  assign mb_dma_rreq_desc_rsv0 = tmp_mb_dma_rreq_desc_addr[127 : 126]; // @ Bits.scala l133
  assign tmp_cmdqe_dma_rreq_desc_addr = 128'h0; // @ Expression.scala l2327
  always @(*) begin
    cmdqe_dma_rreq_desc_addr = tmp_cmdqe_dma_rreq_desc_addr[63 : 0]; // @ UInt.scala l381
    cmdqe_dma_rreq_desc_addr = cmdqe_phy_addr; // @ CmdqBundles.scala l228
  end

  always @(*) begin
    cmdqe_dma_rreq_desc_length = tmp_cmdqe_dma_rreq_desc_addr[80 : 64]; // @ UInt.scala l381
    cmdqe_dma_rreq_desc_length = 17'h00040; // @ CmdqBundles.scala l229
  end

  assign cmdqe_dma_rreq_desc_queue_id = tmp_cmdqe_dma_rreq_desc_addr[86 : 81]; // @ Bits.scala l133
  assign cmdqe_dma_rreq_desc_vf_num = tmp_cmdqe_dma_rreq_desc_addr[97 : 87]; // @ Bits.scala l133
  assign cmdqe_dma_rreq_desc_vf_active = tmp_cmdqe_dma_rreq_desc_addr[98]; // @ Bool.scala l209
  always @(*) begin
    cmdqe_dma_rreq_desc_pf_num = tmp_cmdqe_dma_rreq_desc_addr[103 : 99]; // @ Bits.scala l133
    cmdqe_dma_rreq_desc_pf_num = 5'h06; // @ CmdqBundles.scala l232
  end

  always @(*) begin
    cmdqe_dma_rreq_desc_tag = tmp_cmdqe_dma_rreq_desc_addr[112 : 104]; // @ Bits.scala l133
    cmdqe_dma_rreq_desc_tag = {8'd0, tmp_cmdqe_dma_rreq_desc_tag}; // @ CmdqBundles.scala l233
  end

  always @(*) begin
    cmdqe_dma_rreq_desc_rdma_channel_id = tmp_cmdqe_dma_rreq_desc_addr[117 : 113]; // @ Bits.scala l133
    cmdqe_dma_rreq_desc_rdma_channel_id = 5'h09; // @ CmdqBundles.scala l230
  end

  assign cmdqe_dma_rreq_desc_at = tmp_cmdqe_dma_rreq_desc_addr[118]; // @ Bool.scala l209
  assign cmdqe_dma_rreq_desc_attr = tmp_cmdqe_dma_rreq_desc_addr[119]; // @ Bool.scala l209
  always @(*) begin
    cmdqe_dma_rreq_desc_channel_id = tmp_cmdqe_dma_rreq_desc_addr[125 : 120]; // @ UInt.scala l381
    cmdqe_dma_rreq_desc_channel_id = 6'h09; // @ CmdqBundles.scala l231
  end

  assign cmdqe_dma_rreq_desc_rsv0 = tmp_cmdqe_dma_rreq_desc_addr[127 : 126]; // @ Bits.scala l133
  assign cmdqe_check_in_len_less_than_16 = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len < 32'h00000010); // @ BaseType.scala l305
  assign cmdqe_check_out_len_less_than_16 = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length < 32'h00000010); // @ BaseType.scala l305
  assign cmdqe_check_cmdqe_err = (((cmdqe_check_bad_opcode || cmdqe_check_out_len_less_than_16) || cmdqe_check_bad_input_len) || cmdqe_check_bad_output_len); // @ BaseType.scala l305
  assign cmdqe_check_err_cmdqe_dma_addr = (tmp_cmdqe_check_err_cmdqe_dma_addr + 64'h0000000000000020); // @ BaseType.scala l299
  assign tmp_cmdqe_check_err_cmdqe_wreq_desc_addr = 128'h0; // @ Expression.scala l2327
  always @(*) begin
    cmdqe_check_err_cmdqe_wreq_desc_addr = tmp_cmdqe_check_err_cmdqe_wreq_desc_addr[63 : 0]; // @ UInt.scala l381
    cmdqe_check_err_cmdqe_wreq_desc_addr = cmdqe_check_err_cmdqe_dma_addr; // @ CmdqBundles.scala l241
  end

  always @(*) begin
    cmdqe_check_err_cmdqe_wreq_desc_length = tmp_cmdqe_check_err_cmdqe_wreq_desc_addr[80 : 64]; // @ UInt.scala l381
    cmdqe_check_err_cmdqe_wreq_desc_length = 17'h00020; // @ CmdqBundles.scala l242
  end

  assign cmdqe_check_err_cmdqe_wreq_desc_queue_id = tmp_cmdqe_check_err_cmdqe_wreq_desc_addr[86 : 81]; // @ Bits.scala l133
  assign cmdqe_check_err_cmdqe_wreq_desc_vf_active = tmp_cmdqe_check_err_cmdqe_wreq_desc_addr[87]; // @ Bool.scala l209
  assign cmdqe_check_err_cmdqe_wreq_desc_vf_num = tmp_cmdqe_check_err_cmdqe_wreq_desc_addr[98 : 88]; // @ Bits.scala l133
  assign cmdqe_check_err_cmdqe_wreq_desc_pf_num = tmp_cmdqe_check_err_cmdqe_wreq_desc_addr[103 : 99]; // @ Bits.scala l133
  assign cmdqe_check_err_cmdqe_wreq_desc_desc_type = tmp_cmdqe_check_err_cmdqe_wreq_desc_addr[108 : 104]; // @ Bits.scala l133
  assign cmdqe_check_err_cmdqe_wreq_desc_rsv = tmp_cmdqe_check_err_cmdqe_wreq_desc_addr[125 : 109]; // @ Bits.scala l133
  always @(*) begin
    cmdqe_check_err_cmdqe_wreq_desc_tlp_channel_id = tmp_cmdqe_check_err_cmdqe_wreq_desc_addr[127 : 126]; // @ Bits.scala l133
    cmdqe_check_err_cmdqe_wreq_desc_tlp_channel_id = 2'b10; // @ CmdqBundles.scala l243
  end

  assign cmdqe_dma_rrsp_st_fire = (cmdqe_dma_rrsp_st_valid && cmdqe_dma_rrsp_st_ready); // @ BaseType.scala l305
  always @(*) begin
    cmdqe_check_bad_opcode = 1'b0; // @ Bool.scala l92
    case(cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_opcode)
      16'h0200 : begin
      end
      16'h0202 : begin
      end
      16'h0301 : begin
      end
      16'h0302 : begin
      end
      16'h0400 : begin
      end
      16'h0401 : begin
      end
      16'h0500 : begin
      end
      16'h0501 : begin
      end
      16'h0502 : begin
      end
      16'h0503 : begin
      end
      16'h0504 : begin
      end
      16'h050a : begin
      end
      16'h050b : begin
      end
      16'h0760 : begin
      end
      16'h0761 : begin
      end
      default : begin
        cmdqe_check_bad_opcode = 1'b1; // @ Bool.scala l90
      end
    endcase
  end

  always @(*) begin
    case(cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_opcode)
      16'h0200 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h00000050); // @ command_queue_proc.scala l80
      end
      16'h0202 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h00000010); // @ command_queue_proc.scala l80
      end
      16'h0301 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h00000078); // @ command_queue_proc.scala l80
      end
      16'h0302 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h00000010); // @ command_queue_proc.scala l80
      end
      16'h0400 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h00000050); // @ command_queue_proc.scala l80
      end
      16'h0401 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h00000010); // @ command_queue_proc.scala l80
      end
      16'h0500 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h000000d8); // @ command_queue_proc.scala l80
      end
      16'h0501 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h00000010); // @ command_queue_proc.scala l80
      end
      16'h0502 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h000000d8); // @ command_queue_proc.scala l80
      end
      16'h0503 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h000000d8); // @ command_queue_proc.scala l80
      end
      16'h0504 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h000000d8); // @ command_queue_proc.scala l80
      end
      16'h050a : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h00000010); // @ command_queue_proc.scala l80
      end
      16'h050b : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h00000010); // @ command_queue_proc.scala l80
      end
      16'h0760 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h00000010); // @ command_queue_proc.scala l80
      end
      16'h0761 : begin
        cmdqe_check_bad_input_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len != 32'h00000030); // @ command_queue_proc.scala l80
      end
      default : begin
        cmdqe_check_bad_input_len = 1'b0; // @ Bool.scala l92
      end
    endcase
  end

  always @(*) begin
    case(cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_opcode)
      16'h0200 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h0202 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h0301 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h0302 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h0400 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h0401 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h0500 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h0501 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h0502 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h0503 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h0504 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h050a : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      16'h050b : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h000000d8); // @ command_queue_proc.scala l81
      end
      16'h0760 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000030); // @ command_queue_proc.scala l81
      end
      16'h0761 : begin
        cmdqe_check_bad_output_len = (cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length != 32'h00000010); // @ command_queue_proc.scala l81
      end
      default : begin
        cmdqe_check_bad_output_len = 1'b0; // @ Bool.scala l92
      end
    endcase
  end

  assign cmdqe_check_err_cmdqe_out_output_inline_data_rsv = cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_rsv; // @ command_queue_proc.scala l91
  always @(*) begin
    cmdqe_check_err_cmdqe_out_output_inline_data_status = cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_status; // @ command_queue_proc.scala l91
    if(((cmdqe_check_bad_opcode || cmdqe_check_in_len_less_than_16) || cmdqe_check_out_len_less_than_16)) begin
      cmdqe_check_err_cmdqe_out_output_inline_data_status = 8'h0; // @ command_queue_proc.scala l102
    end else begin
      if(cmdqe_check_bad_input_len) begin
        cmdqe_check_err_cmdqe_out_output_inline_data_status = 8'h03; // @ command_queue_proc.scala l104
      end else begin
        if(cmdqe_check_bad_output_len) begin
          cmdqe_check_err_cmdqe_out_output_inline_data_status = 8'h04; // @ command_queue_proc.scala l106
        end else begin
          cmdqe_check_err_cmdqe_out_output_inline_data_status = 8'h0; // @ command_queue_proc.scala l108
        end
      end
    end
  end

  assign cmdqe_check_err_cmdqe_out_output_inline_data_syndrome = cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_syndrome; // @ command_queue_proc.scala l91
  assign cmdqe_check_err_cmdqe_out_output_inline_data_cmd_output = cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_cmd_output; // @ command_queue_proc.scala l91
  assign cmdqe_check_err_cmdqe_out_output_mb_point_high = cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_mb_point_high; // @ command_queue_proc.scala l91
  assign cmdqe_check_err_cmdqe_out_rsv1 = cmdqe_dma_rrsp_st_payload_cmd_entry_out_rsv1; // @ command_queue_proc.scala l91
  assign cmdqe_check_err_cmdqe_out_output_mb_point_low = cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_mb_point_low; // @ command_queue_proc.scala l91
  assign cmdqe_check_err_cmdqe_out_output_length = cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length; // @ command_queue_proc.scala l91
  assign cmdqe_check_err_cmdqe_out_own = cmdqe_dma_rrsp_st_payload_cmd_entry_out_own; // @ command_queue_proc.scala l91
  always @(*) begin
    cmdqe_check_err_cmdqe_out_status = cmdqe_dma_rrsp_st_payload_cmd_entry_out_status; // @ command_queue_proc.scala l91
    if(cmdqe_check_bad_opcode) begin
      cmdqe_check_err_cmdqe_out_status = 7'h0b; // @ command_queue_proc.scala l93
    end else begin
      if(cmdqe_check_in_len_less_than_16) begin
        cmdqe_check_err_cmdqe_out_status = 7'h07; // @ command_queue_proc.scala l95
      end else begin
        if(cmdqe_check_out_len_less_than_16) begin
          cmdqe_check_err_cmdqe_out_status = 7'h08; // @ command_queue_proc.scala l97
        end else begin
          cmdqe_check_err_cmdqe_out_status = 7'h0; // @ command_queue_proc.scala l99
        end
      end
    end
  end

  assign cmdqe_check_err_cmdqe_out_rsv0 = cmdqe_dma_rrsp_st_payload_cmd_entry_out_rsv0; // @ command_queue_proc.scala l91
  assign cmdqe_check_err_cmdqe_out_signature = cmdqe_dma_rrsp_st_payload_cmd_entry_out_signature; // @ command_queue_proc.scala l91
  assign cmdqe_check_err_cmdqe_out_token = cmdqe_dma_rrsp_st_payload_cmd_entry_out_token; // @ command_queue_proc.scala l91
  assign cmd_req_cmdqe_elements_fifo_din = {{cmd_req_cmdqe_elements_push_payload_cmd_inline_data_inline_cmd,{cmd_req_cmdqe_elements_push_payload_cmd_inline_data_rsv,{cmd_req_cmdqe_elements_push_payload_cmd_inline_data_op_mod,{cmd_req_cmdqe_elements_push_payload_cmd_inline_data_opcode,cmd_req_cmdqe_elements_push_payload_cmd_inline_data_uid}}}},{cmd_req_cmdqe_elements_push_payload_input_len,cmd_req_cmdqe_elements_push_payload_cmd_id}}; // @ rdma_ctyun_sfifo.scala l34
  assign cmd_req_cmdqe_elements_push_ready = (! cmd_req_cmdqe_elements_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign cmd_req_cmdqe_elements_pop_valid = (! cmd_req_cmdqe_elements_fifo_empty); // @ rdma_ctyun_sfifo.scala l39
  assign cmd_req_cmdqe_elements_pop_payload_cmd_id = cmd_req_cmdqe_elements_fifo_dout[4 : 0]; // @ UInt.scala l381
  assign cmd_req_cmdqe_elements_pop_payload_input_len = cmd_req_cmdqe_elements_fifo_dout[12 : 5]; // @ UInt.scala l381
  assign tmp_cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_uid = cmd_req_cmdqe_elements_fifo_dout[140 : 13]; // @ BaseType.scala l299
  assign cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_uid = tmp_cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_uid[15 : 0]; // @ Bits.scala l133
  assign cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_opcode = tmp_cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_uid[31 : 16]; // @ Bits.scala l133
  assign cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_op_mod = tmp_cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_uid[47 : 32]; // @ Bits.scala l133
  assign cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_rsv = tmp_cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_uid[63 : 48]; // @ Bits.scala l133
  assign cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_inline_cmd = tmp_cmd_req_cmdqe_elements_pop_payload_cmd_inline_data_uid[127 : 64]; // @ Bits.scala l133
  assign cmd_req_fifo_din = {cmd_req_push_payload_sop,{cmd_req_push_payload_eop,{cmd_req_push_payload_empty,{cmd_req_push_payload_channel,cmd_req_push_payload_data}}}}; // @ rdma_ctyun_sfifo.scala l46
  assign cmd_req_push_ready = (! cmd_req_fifo_full); // @ rdma_ctyun_sfifo.scala l47
  assign cmd_req_pop_valid = (! cmd_req_fifo_empty); // @ rdma_ctyun_sfifo.scala l51
  assign cmd_req_pop_payload_data = cmd_req_fifo_dout[511 : 0]; // @ Bits.scala l133
  assign cmd_req_pop_payload_channel = cmd_req_fifo_dout[536 : 512]; // @ UInt.scala l381
  assign cmd_req_pop_payload_empty = cmd_req_fifo_dout[542 : 537]; // @ UInt.scala l381
  assign cmd_req_pop_payload_eop = cmd_req_fifo_dout[543]; // @ Bool.scala l209
  assign cmd_req_pop_payload_sop = cmd_req_fifo_dout[544]; // @ Bool.scala l209
  assign cmd_req_cmdqe_elements_pop_ready = cmd_req_gen_inst_cmdqe_elements_ready; // @ cmd_req_gen.scala l71
  assign mb_dma_rrsp_fifo_st_ready = cmd_req_gen_inst_mb_dma_rrsp_ready; // @ cmd_req_gen.scala l72
  assign cmd_req_push_valid = cmd_req_gen_inst_cmd_req_valid; // @ cmd_req_gen.scala l73
  assign cmd_req_push_payload_data = cmd_req_gen_inst_cmd_req_payload_data; // @ cmd_req_gen.scala l73
  assign cmd_req_push_payload_channel = cmd_req_gen_inst_cmd_req_payload_channel; // @ cmd_req_gen.scala l73
  assign cmd_req_push_payload_empty = cmd_req_gen_inst_cmd_req_payload_empty; // @ cmd_req_gen.scala l73
  assign cmd_req_push_payload_eop = cmd_req_gen_inst_cmd_req_payload_eop; // @ cmd_req_gen.scala l73
  assign cmd_req_push_payload_sop = cmd_req_gen_inst_cmd_req_payload_sop; // @ cmd_req_gen.scala l73
  assign db_id_for_err_push_payload = db_id; // @ command_queue_proc.scala l125
  assign db_id_for_err_push_valid = db_vec_s_valid; // @ command_queue_proc.scala l126
  assign db_vec_s_ready = ((db_id_for_err_push_ready && cmd_id_mngr_io_fetch_valid) && cmdqe_dma_rreq_st_ready); // @ command_queue_proc.scala l127
  assign cmd_id_fihish_arbi_ready = cmd_id_mngr_io_clear_ready; // @ command_queue_proc.scala l129
  assign db_vec_s_fire = (db_vec_s_valid && db_vec_s_ready); // @ BaseType.scala l305
  assign cmd_id_for_cmd_req_gen_push_valid = (db_vec_s_fire && cmd_id_mngr_io_fetch_valid); // @ command_queue_proc.scala l131
  assign cmd_id_for_cmd_req_gen_push_payload = cmd_id_mngr_io_fetch_payload; // @ command_queue_proc.scala l132
  assign cmd_id_for_cmd_req_gen_pop_ready = (cmd_req_cmdqe_elements_push_ready && cmdqe_dma_rrsp_st_valid); // @ command_queue_proc.scala l133
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_rsv = cmdqe_check_err_cmdqe_out_output_inline_data_rsv; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_status = cmdqe_check_err_cmdqe_out_output_inline_data_status; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_syndrome = cmdqe_check_err_cmdqe_out_output_inline_data_syndrome; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_output_inline_data_cmd_output = cmdqe_check_err_cmdqe_out_output_inline_data_cmd_output; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_output_mb_point_high = cmdqe_check_err_cmdqe_out_output_mb_point_high; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_rsv1 = cmdqe_check_err_cmdqe_out_rsv1; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_output_mb_point_low = cmdqe_check_err_cmdqe_out_output_mb_point_low; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_output_length = cmdqe_check_err_cmdqe_out_output_length; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_own = cmdqe_check_err_cmdqe_out_own; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_status = cmdqe_check_err_cmdqe_out_status; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_rsv0 = cmdqe_check_err_cmdqe_out_rsv0; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_signature = cmdqe_check_err_cmdqe_out_signature; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_cmd_out_token = cmdqe_check_err_cmdqe_out_token; // @ Bundle.scala l129
  assign err_cmdqe_dma_wreq_st_payload_desc_addr = cmdqe_check_err_cmdqe_wreq_desc_addr; // @ command_queue_proc.scala l137
  assign err_cmdqe_dma_wreq_st_payload_desc_length = cmdqe_check_err_cmdqe_wreq_desc_length; // @ command_queue_proc.scala l137
  assign err_cmdqe_dma_wreq_st_payload_desc_queue_id = cmdqe_check_err_cmdqe_wreq_desc_queue_id; // @ command_queue_proc.scala l137
  assign err_cmdqe_dma_wreq_st_payload_desc_vf_active = cmdqe_check_err_cmdqe_wreq_desc_vf_active; // @ command_queue_proc.scala l137
  assign err_cmdqe_dma_wreq_st_payload_desc_vf_num = cmdqe_check_err_cmdqe_wreq_desc_vf_num; // @ command_queue_proc.scala l137
  assign err_cmdqe_dma_wreq_st_payload_desc_pf_num = cmdqe_check_err_cmdqe_wreq_desc_pf_num; // @ command_queue_proc.scala l137
  assign err_cmdqe_dma_wreq_st_payload_desc_desc_type = cmdqe_check_err_cmdqe_wreq_desc_desc_type; // @ command_queue_proc.scala l137
  assign err_cmdqe_dma_wreq_st_payload_desc_rsv = cmdqe_check_err_cmdqe_wreq_desc_rsv; // @ command_queue_proc.scala l137
  assign err_cmdqe_dma_wreq_st_payload_desc_tlp_channel_id = cmdqe_check_err_cmdqe_wreq_desc_tlp_channel_id; // @ command_queue_proc.scala l137
  assign err_cmdqe_dma_wreq_st_valid = (cmdqe_check_cmdqe_err && cmdqe_dma_rrsp_st_fire); // @ command_queue_proc.scala l138
  assign db_id_for_err_pop_ready = cmdqe_dma_rrsp_st_fire; // @ command_queue_proc.scala l139
  assign cmdqe_dma_rrsp_st_ready = (cmdqe_check_cmdqe_err || cmd_req_cmdqe_elements_push_ready); // @ command_queue_proc.scala l140
  assign cmd_id_finish_err_cmdqe_push_valid = (cmdqe_check_cmdqe_err && cmdqe_dma_rrsp_st_fire); // @ command_queue_proc.scala l141
  assign cmd_id_finish_err_cmdqe_push_payload = cmd_id_for_cmd_req_gen_pop_payload; // @ command_queue_proc.scala l142
  assign cmd_entry_out_ram_din_output_mb_point = {{cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_mb_point_high,cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_mb_point_low},9'h0}; // @ command_queue_proc.scala l145
  assign cmd_entry_out_ram_din_output_length = cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length; // @ command_queue_proc.scala l146
  assign cmd_entry_out_ram_din_signature = cmdqe_dma_rrsp_st_payload_cmd_entry_out_signature; // @ command_queue_proc.scala l147
  assign cmd_entry_out_ram_din_token = cmdqe_dma_rrsp_st_payload_cmd_entry_out_token; // @ command_queue_proc.scala l148
  assign cmdqe_dma_rreq_st_payload_addr = cmdqe_dma_rreq_desc_addr; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_payload_length = cmdqe_dma_rreq_desc_length; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_payload_queue_id = cmdqe_dma_rreq_desc_queue_id; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_payload_vf_num = cmdqe_dma_rreq_desc_vf_num; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_payload_vf_active = cmdqe_dma_rreq_desc_vf_active; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_payload_pf_num = cmdqe_dma_rreq_desc_pf_num; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_payload_tag = cmdqe_dma_rreq_desc_tag; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_payload_rdma_channel_id = cmdqe_dma_rreq_desc_rdma_channel_id; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_payload_at = cmdqe_dma_rreq_desc_at; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_payload_attr = cmdqe_dma_rreq_desc_attr; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_payload_channel_id = cmdqe_dma_rreq_desc_channel_id; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_payload_rsv0 = cmdqe_dma_rreq_desc_rsv0; // @ command_queue_proc.scala l151
  assign cmdqe_dma_rreq_st_valid = db_vec_s_fire; // @ command_queue_proc.scala l152
  assign mb_dma_rreq_st_payload_addr = mb_dma_rreq_desc_addr; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_payload_length = mb_dma_rreq_desc_length; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_payload_queue_id = mb_dma_rreq_desc_queue_id; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_payload_vf_num = mb_dma_rreq_desc_vf_num; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_payload_vf_active = mb_dma_rreq_desc_vf_active; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_payload_pf_num = mb_dma_rreq_desc_pf_num; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_payload_tag = mb_dma_rreq_desc_tag; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_payload_rdma_channel_id = mb_dma_rreq_desc_rdma_channel_id; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_payload_at = mb_dma_rreq_desc_at; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_payload_attr = mb_dma_rreq_desc_attr; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_payload_channel_id = mb_dma_rreq_desc_channel_id; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_payload_rsv0 = mb_dma_rreq_desc_rsv0; // @ command_queue_proc.scala l153
  assign mb_dma_rreq_st_valid = (((cmdqe_dma_rrsp_st_valid && cmdqe_dma_rrsp_st_valid) && (32'h00000010 < cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len)) && (! cmdqe_check_cmdqe_err)); // @ command_queue_proc.scala l154
  assign cmdqe_dma_rreq_st_ready = cmdq_dma_ctrl_inst_cmdqe_dma_rreq_s_ready; // @ command_queue_proc.scala l156
  assign mb_dma_rreq_st_ready = cmdq_dma_ctrl_inst_mb_dma_dma_rreq_s_ready; // @ command_queue_proc.scala l157
  assign dma_rreq_m_valid = cmdq_dma_ctrl_inst_dma_rreq_m_valid; // @ command_queue_proc.scala l158
  assign dma_rreq_m_payload_channel = cmdq_dma_ctrl_inst_dma_rreq_m_payload_channel; // @ command_queue_proc.scala l158
  assign dma_rrsp_s_ready = cmdq_dma_ctrl_inst_dma_rrsp_s_ready; // @ command_queue_proc.scala l159
  assign cmdqe_dma_rrsp_st_valid = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_valid; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_in_rsv3 = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv3; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_in_type_ = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_type_; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_len; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_mb_point_high = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_high; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_in_rsv2 = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_rsv2; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_mb_point_low = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_mb_point_low; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_uid = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_uid; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_opcode = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_opcode; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_op_mod = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_op_mod; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_rsv = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_rsv; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_inline_cmd = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_in_input_inline_data_inline_cmd; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_rsv = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_rsv; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_status = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_status; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_syndrome = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_syndrome; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_inline_data_cmd_output = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_inline_data_cmd_output; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_mb_point_high = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_high; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_rsv1 = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv1; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_mb_point_low = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_mb_point_low; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_output_length = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_output_length; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_own = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_own; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_status = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_status; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_rsv0 = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_rsv0; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_signature = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_signature; // @ command_queue_proc.scala l160
  assign cmdqe_dma_rrsp_st_payload_cmd_entry_out_token = cmdq_dma_ctrl_inst_cmdqe_dma_rrsp_m_payload_cmd_entry_out_token; // @ command_queue_proc.scala l160
  assign mb_dma_rrsp_fifo_st_valid = cmdq_dma_ctrl_inst_mb_dma_rrsp_m_valid; // @ command_queue_proc.scala l161
  assign mb_dma_rrsp_fifo_st_payload_data = cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_data; // @ command_queue_proc.scala l161
  assign mb_dma_rrsp_fifo_st_payload_channel = cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_channel; // @ command_queue_proc.scala l161
  assign mb_dma_rrsp_fifo_st_payload_empty = cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_empty; // @ command_queue_proc.scala l161
  assign mb_dma_rrsp_fifo_st_payload_eop = cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_eop; // @ command_queue_proc.scala l161
  assign mb_dma_rrsp_fifo_st_payload_sop = cmdq_dma_ctrl_inst_mb_dma_rrsp_m_payload_sop; // @ command_queue_proc.scala l161
  assign dma_wreq_m_valid = cmdq_dma_ctrl_inst_dma_wreq_m_valid; // @ command_queue_proc.scala l162
  assign dma_wreq_m_payload_data = cmdq_dma_ctrl_inst_dma_wreq_m_payload_data; // @ command_queue_proc.scala l162
  assign dma_wreq_m_payload_channel = cmdq_dma_ctrl_inst_dma_wreq_m_payload_channel; // @ command_queue_proc.scala l162
  assign dma_wreq_m_payload_empty = cmdq_dma_ctrl_inst_dma_wreq_m_payload_empty; // @ command_queue_proc.scala l162
  assign dma_wreq_m_payload_eop = cmdq_dma_ctrl_inst_dma_wreq_m_payload_eop; // @ command_queue_proc.scala l162
  assign dma_wreq_m_payload_sop = cmdq_dma_ctrl_inst_dma_wreq_m_payload_sop; // @ command_queue_proc.scala l162
  assign err_cmdqe_dma_wreq_st_ready = cmdq_dma_ctrl_inst_err_cmdqe_dma_wreq_s_ready; // @ command_queue_proc.scala l163
  assign cmd_rsp_dma_wreq_avst_ready = cmdq_dma_ctrl_inst_cmd_rsp_dma_wreq_s_ready; // @ command_queue_proc.scala l164
  assign cmd_req_cmdqe_elements_push_payload_cmd_id = cmd_id_for_cmd_req_gen_pop_payload; // @ command_queue_proc.scala l167
  assign cmd_req_cmdqe_elements_push_payload_input_len = cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_len[7:0]; // @ command_queue_proc.scala l168
  assign cmd_req_cmdqe_elements_push_payload_cmd_inline_data_uid = cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_uid; // @ command_queue_proc.scala l169
  assign cmd_req_cmdqe_elements_push_payload_cmd_inline_data_opcode = cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_opcode; // @ command_queue_proc.scala l169
  assign cmd_req_cmdqe_elements_push_payload_cmd_inline_data_op_mod = cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_op_mod; // @ command_queue_proc.scala l169
  assign cmd_req_cmdqe_elements_push_payload_cmd_inline_data_rsv = cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_rsv; // @ command_queue_proc.scala l169
  assign cmd_req_cmdqe_elements_push_payload_cmd_inline_data_inline_cmd = cmdqe_dma_rrsp_st_payload_cmd_entry_in_input_inline_data_inline_cmd; // @ command_queue_proc.scala l169
  assign cmd_req_cmdqe_elements_push_valid = ((! cmdqe_check_cmdqe_err) && cmdqe_dma_rrsp_st_valid); // @ command_queue_proc.scala l170
  assign cmd_rsp_ready = cmd_rsp_divide_inst_cmd_rsp_ready; // @ command_queue_proc.scala l173
  assign cmd_rsp_dma_wreq_avst_valid = cmd_rsp_divide_inst_cmd_rsp_dma_wreq_valid; // @ command_queue_proc.scala l174
  assign cmd_rsp_dma_wreq_avst_payload_data = cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_data; // @ command_queue_proc.scala l174
  assign cmd_rsp_dma_wreq_avst_payload_channel = cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_channel; // @ command_queue_proc.scala l174
  assign cmd_rsp_dma_wreq_avst_payload_empty = cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_empty; // @ command_queue_proc.scala l174
  assign cmd_rsp_dma_wreq_avst_payload_eop = cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_eop; // @ command_queue_proc.scala l174
  assign cmd_rsp_dma_wreq_avst_payload_sop = cmd_rsp_divide_inst_cmd_rsp_dma_wreq_payload_sop; // @ command_queue_proc.scala l174
  assign cmd_id_finish_cmd_rsp_push_valid = cmd_rsp_divide_inst_cmd_id_finish_valid; // @ command_queue_proc.scala l175
  assign cmd_id_finish_cmd_rsp_push_payload = cmd_rsp_divide_inst_cmd_id_finish_payload; // @ command_queue_proc.scala l175
  assign db_id_ram_din = db_id; // @ rdma_ctyun_sdpram.scala l59
  assign cmd_rsp_divide_inst_db_id_dout = db_id_ram_dout; // @ command_queue_proc.scala l176
  assign cmd_entry_out_ram_din_ram_wren = (cmdqe_dma_rrsp_st_valid && (! cmdqe_check_cmdqe_err)); // @ rdma_ctyun_sdpram.scala l57
  assign cmd_entry_out_ram_din_ram_din = {cmd_entry_out_ram_din_token,{cmd_entry_out_ram_din_signature,{cmd_entry_out_ram_din_output_length,cmd_entry_out_ram_din_output_mb_point}}}; // @ rdma_ctyun_sdpram.scala l59
  assign cmd_rsp_divide_inst_cmd_out_entry_stored_output_mb_point = cmd_entry_out_ram_din_ram_dout[63 : 0]; // @ UInt.scala l381
  assign cmd_rsp_divide_inst_cmd_out_entry_stored_output_length = cmd_entry_out_ram_din_ram_dout[95 : 64]; // @ UInt.scala l381
  assign cmd_rsp_divide_inst_cmd_out_entry_stored_signature = cmd_entry_out_ram_din_ram_dout[103 : 96]; // @ Bits.scala l133
  assign cmd_rsp_divide_inst_cmd_out_entry_stored_token = cmd_entry_out_ram_din_ram_dout[111 : 104]; // @ Bits.scala l133
  assign cmd_req_pop_ready = cmd_req_ready; // @ command_queue_proc.scala l190
  assign cmd_req_valid = cmd_req_pop_valid; // @ command_queue_proc.scala l190
  assign cmd_req_payload_data = cmd_req_pop_payload_data; // @ command_queue_proc.scala l190
  assign cmd_req_payload_channel = cmd_req_pop_payload_channel; // @ command_queue_proc.scala l190
  assign cmd_req_payload_empty = cmd_req_pop_payload_empty; // @ command_queue_proc.scala l190
  assign cmd_req_payload_eop = cmd_req_pop_payload_eop; // @ command_queue_proc.scala l190
  assign cmd_req_payload_sop = cmd_req_pop_payload_sop; // @ command_queue_proc.scala l190
  assign cmd_rsp_avst_check_fire = (cmd_rsp_valid && (cmd_rsp_ready || cmd_rsp_ready)); // @ BaseType.scala l305
  assign cmd_rsp_avst_check_pkt_size_payload = tmp_cmd_rsp_avst_check_pkt_size_payload; // @ BusExt.scala l187
  assign cmd_rsp_avst_check_pkt_size_valid = tmp_cmd_rsp_avst_check_pkt_size_valid; // @ BusExt.scala l191
  assign cmd_rsp_rcv_len_err = (cmd_rsp_avst_check_pkt_size_valid && (tmp_cmd_rsp_rcv_len_err != cmd_rsp_divide_inst_cmd_out_entry_stored_output_length)); // @ BaseType.scala l305
  always @(posedge clk) begin
    if(reset) begin
      cmdq_phy_addr_reg <= 64'h0; // @ Data.scala l409
      cmd_rsp_avst_check_dup_sop <= 1'b0; // @ Data.scala l409
      cmd_rsp_avst_check_channel_changed <= 1'b0; // @ Data.scala l409
      cmd_rsp_avst_check_trans_outside <= 1'b0; // @ Data.scala l409
      cmd_rsp_avst_check_pkt_byte_cnt <= 16'h0; // @ Data.scala l409
      cmd_rsp_avst_check_pkt_count <= 32'h0; // @ Data.scala l409
      cmd_rsp_avst_check_soped <= 1'b0; // @ Data.scala l409
      tmp_cmd_rsp_avst_check_pkt_size_payload <= 16'h0; // @ Data.scala l409
      tmp_cmd_rsp_avst_check_pkt_size_valid <= 1'b0; // @ Data.scala l409
    end else begin
      cmdq_phy_addr_reg <= cmdq_phy_addr_i; // @ Reg.scala l39
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! (cmdqe_check_cmdqe_err && cmdqe_dma_rrsp_st_fire))); // command_queue_proc.scala:L70
        `else
          if(!(! (cmdqe_check_cmdqe_err && cmdqe_dma_rrsp_st_fire))) begin
            $display("WARNING %t bad_opcode:%x, in_less:%x, out_less:%x,bad_in_len:%x, out_len:%x", $time, cmdqe_check_bad_opcode, cmdqe_check_in_len_less_than_16, cmdqe_check_out_len_less_than_16, cmdqe_check_bad_input_len, cmdqe_check_bad_output_len); // command_queue_proc.scala:L70
          end
        `endif
      `endif
      if((cmd_rsp_payload_eop && cmd_rsp_avst_check_fire)) begin
        cmd_rsp_avst_check_soped <= 1'b0; // @ BusExt.scala l170
      end
      if(((cmd_rsp_payload_sop && (! cmd_rsp_payload_eop)) && cmd_rsp_avst_check_fire)) begin
        cmd_rsp_avst_check_soped <= 1'b1; // @ BusExt.scala l170
      end
      cmd_rsp_avst_check_dup_sop <= ((cmd_rsp_avst_check_fire && cmd_rsp_payload_sop) && cmd_rsp_avst_check_soped); // @ BusExt.scala l171
      cmd_rsp_avst_check_channel_changed <= ((cmd_rsp_avst_check_fire && cmd_rsp_avst_check_soped) && (cmd_rsp_avst_check_channel_reg != cmd_rsp_payload_channel)); // @ BusExt.scala l173
      cmd_rsp_avst_check_trans_outside <= ((cmd_rsp_avst_check_fire && (! cmd_rsp_avst_check_soped)) && (! cmd_rsp_payload_sop)); // @ BusExt.scala l174
      if((cmd_rsp_payload_eop && cmd_rsp_avst_check_fire)) begin
        cmd_rsp_avst_check_pkt_count <= (cmd_rsp_avst_check_pkt_count + 32'h00000001); // @ BusExt.scala l176
      end
      if(cmd_rsp_avst_check_fire) begin
        if(cmd_rsp_payload_eop) begin
          cmd_rsp_avst_check_pkt_byte_cnt <= 16'h0; // @ BitVector.scala l494
        end else begin
          cmd_rsp_avst_check_pkt_byte_cnt <= (cmd_rsp_avst_check_pkt_byte_cnt + 16'h0040); // @ BusExt.scala l183
        end
      end
      tmp_cmd_rsp_avst_check_pkt_size_payload <= (tmp_tmp_cmd_rsp_avst_check_pkt_size_payload - tmp_tmp_cmd_rsp_avst_check_pkt_size_payload_1); // @ Reg.scala l39
      tmp_cmd_rsp_avst_check_pkt_size_valid <= (cmd_rsp_payload_eop && cmd_rsp_avst_check_fire); // @ Reg.scala l39
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! cmd_rsp_avst_check_dup_sop)); // BusExt.scala:L192
        `else
          if(!(! cmd_rsp_avst_check_dup_sop)) begin
            $display("WARNING %t cmd_rsp received duplicated sop!", $time); // BusExt.scala:L192
          end
        `endif
      `endif
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! cmd_rsp_avst_check_channel_changed)); // BusExt.scala:L193
        `else
          if(!(! cmd_rsp_avst_check_channel_changed)) begin
            $display("WARNING %t cmd_rsp channel changed during trans!", $time); // BusExt.scala:L193
          end
        `endif
      `endif
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! cmd_rsp_avst_check_trans_outside)); // BusExt.scala:L194
        `else
          if(!(! cmd_rsp_avst_check_trans_outside)) begin
            $display("WARNING %t cmd_rsp transfer a word outside!", $time); // BusExt.scala:L194
          end
        `endif
      `endif
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! cmd_rsp_rcv_len_err)); // command_queue_proc.scala:L196
        `else
          if(!(! cmd_rsp_rcv_len_err)) begin
            $display("WARNING %t, Scheduled cmd_rsp rcv length not equal to relative output_length! %x", $time, cmd_rsp_avst_check_pkt_size_payload); // command_queue_proc.scala:L196
          end
        `endif
      `endif
    end
  end

  always @(posedge clk) begin
    cmd_rsp_avst_check_channel_reg <= cmd_rsp_payload_channel; // @ Reg.scala l39
  end


endmodule
