// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : command_queue_top
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766
// Gen time  : 2024-11-25 11:51:40


module command_queue_top (
  input  wire          db_vec_s_valid,
  output wire          db_vec_s_ready,
  input  wire [31:0]   db_vec_s_data,
  input  wire          dma_rreq_m_ready,
  output wire          dma_rreq_m_valid,
  output wire [127:0]  dma_rreq_m_desc,
  output wire          dma_rrsp_s_ready,
  input  wire          dma_rrsp_s_valid,
  input  wire [511:0]  dma_rrsp_s_data,
  input  wire [127:0]  dma_rrsp_s_desc,
  input  wire [5:0]    dma_rrsp_s_empty,
  input  wire          dma_rrsp_s_eop,
  input  wire          dma_rrsp_s_sop,
  input  wire          dma_wreq_m_ready,
  output wire          dma_wreq_m_valid,
  output wire [511:0]  dma_wreq_m_data,
  output wire [127:0]  dma_wreq_m_desc,
  output wire [5:0]    dma_wreq_m_empty,
  output wire          dma_wreq_m_eop,
  output wire          dma_wreq_m_sop,
  input  wire [63:0]   cmdq_phy_addr_i,
  input  wire          cq_cmd_req_ready,
  output wire          cq_cmd_req_valid,
  output wire [511:0]  cq_cmd_req_data,
  output wire [24:0]   cq_cmd_req_sdb,
  output wire [5:0]    cq_cmd_req_empty,
  output wire          cq_cmd_req_eop,
  output wire          cq_cmd_req_sop,
  input  wire          eq_cmd_req_ready,
  output wire          eq_cmd_req_valid,
  output wire [511:0]  eq_cmd_req_data,
  output wire [24:0]   eq_cmd_req_sdb,
  output wire [5:0]    eq_cmd_req_empty,
  output wire          eq_cmd_req_eop,
  output wire          eq_cmd_req_sop,
  input  wire          mr_cmd_req_ready,
  output wire          mr_cmd_req_valid,
  output wire [511:0]  mr_cmd_req_data,
  output wire [24:0]   mr_cmd_req_sdb,
  output wire [5:0]    mr_cmd_req_empty,
  output wire          mr_cmd_req_eop,
  output wire          mr_cmd_req_sop,
  input  wire          qp_cmd_req_ready,
  output wire          qp_cmd_req_valid,
  output wire [255:0]  qp_cmd_req_data,
  output wire [24:0]   qp_cmd_req_sdb,
  output wire [4:0]    qp_cmd_req_empty,
  output wire          qp_cmd_req_eop,
  output wire          qp_cmd_req_sop,
  output wire          cq_cmd_rsp_ready,
  input  wire          cq_cmd_rsp_valid,
  input  wire [511:0]  cq_cmd_rsp_data,
  input  wire [34:0]   cq_cmd_rsp_sdb,
  input  wire [5:0]    cq_cmd_rsp_empty,
  input  wire          cq_cmd_rsp_eop,
  input  wire          cq_cmd_rsp_sop,
  output wire          eq_cmd_rsp_ready,
  input  wire          eq_cmd_rsp_valid,
  input  wire [511:0]  eq_cmd_rsp_data,
  input  wire [34:0]   eq_cmd_rsp_sdb,
  input  wire [5:0]    eq_cmd_rsp_empty,
  input  wire          eq_cmd_rsp_eop,
  input  wire          eq_cmd_rsp_sop,
  output wire          mr_cmd_rsp_ready,
  input  wire          mr_cmd_rsp_valid,
  input  wire [511:0]  mr_cmd_rsp_data,
  input  wire [34:0]   mr_cmd_rsp_sdb,
  input  wire [5:0]    mr_cmd_rsp_empty,
  input  wire          mr_cmd_rsp_eop,
  input  wire          mr_cmd_rsp_sop,
  output wire          qp_cmd_rsp_ready,
  input  wire          qp_cmd_rsp_valid,
  input  wire [255:0]  qp_cmd_rsp_data,
  input  wire [34:0]   qp_cmd_rsp_sdb,
  input  wire [4:0]    qp_cmd_rsp_empty,
  input  wire          qp_cmd_rsp_eop,
  input  wire          qp_cmd_rsp_sop,
  output wire          err_cmdqe_dma_wreq_ready,
  output wire          err_cmdqe_dma_wreq_valid,
  output wire [511:0]  err_cmdqe_dma_wreq_payload_data,
  output wire [127:0]  err_cmdqe_dma_wreq_payload_channel,
  output wire [5:0]    err_cmdqe_dma_wreq_payload_empty,
  output wire          err_cmdqe_dma_wreq_payload_eop,
  output wire          err_cmdqe_dma_wreq_payload_sop,
  output wire          cmd_rsp_dma_wreq_ready,
  output wire          cmd_rsp_dma_wreq_valid,
  output wire [511:0]  cmd_rsp_dma_wreq_payload_data,
  output wire [127:0]  cmd_rsp_dma_wreq_payload_channel,
  output wire [5:0]    cmd_rsp_dma_wreq_payload_empty,
  output wire          cmd_rsp_dma_wreq_payload_eop,
  output wire          cmd_rsp_dma_wreq_payload_sop,
  input  wire          reset,
  input  wire          clk
);

  wire       [511:0]  cmdq_proc_cmd_rsp_payload_data;
  wire       [34:0]   cmdq_proc_cmd_rsp_payload_channel;
  wire       [5:0]    cmdq_proc_cmd_rsp_payload_empty;
  wire                cmdq_proc_cmd_rsp_payload_eop;
  wire                cmdq_proc_cmd_rsp_payload_sop;
  wire       [544:0]  streamDemux_io_input_payload;
  wire                streamDemux_io_outputs_3_ready;
  wire                cmdq_proc_db_vec_s_ready;
  wire                cmdq_proc_dma_rreq_m_valid;
  wire       [127:0]  cmdq_proc_dma_rreq_m_payload_channel;
  wire                cmdq_proc_dma_rrsp_s_ready;
  wire                cmdq_proc_dma_wreq_m_valid;
  wire       [511:0]  cmdq_proc_dma_wreq_m_payload_data;
  wire       [127:0]  cmdq_proc_dma_wreq_m_payload_channel;
  wire       [5:0]    cmdq_proc_dma_wreq_m_payload_empty;
  wire                cmdq_proc_dma_wreq_m_payload_eop;
  wire                cmdq_proc_dma_wreq_m_payload_sop;
  wire                cmdq_proc_cmd_req_valid;
  wire       [511:0]  cmdq_proc_cmd_req_payload_data;
  wire       [24:0]   cmdq_proc_cmd_req_payload_channel;
  wire       [5:0]    cmdq_proc_cmd_req_payload_empty;
  wire                cmdq_proc_cmd_req_payload_eop;
  wire                cmdq_proc_cmd_req_payload_sop;
  wire                cmdq_proc_cmd_rsp_ready;
  wire                streamDemux_io_input_ready;
  wire                streamDemux_io_outputs_0_valid;
  wire       [544:0]  streamDemux_io_outputs_0_payload;
  wire                streamDemux_io_outputs_1_valid;
  wire       [544:0]  streamDemux_io_outputs_1_payload;
  wire                streamDemux_io_outputs_2_valid;
  wire       [544:0]  streamDemux_io_outputs_2_payload;
  wire                streamDemux_io_outputs_3_valid;
  wire       [544:0]  streamDemux_io_outputs_3_payload;
  wire                cmd_rsp_sche_io_inputs_0_ready;
  wire                cmd_rsp_sche_io_inputs_1_ready;
  wire                cmd_rsp_sche_io_inputs_2_ready;
  wire                cmd_rsp_sche_io_inputs_3_ready;
  wire                cmd_rsp_sche_io_output_valid;
  wire       [511:0]  cmd_rsp_sche_io_output_payload_data;
  wire       [34:0]   cmd_rsp_sche_io_output_payload_channel;
  wire       [5:0]    cmd_rsp_sche_io_output_payload_empty;
  wire                cmd_rsp_sche_io_output_payload_eop;
  wire                cmd_rsp_sche_io_output_payload_sop;
  wire       [1:0]    cmd_rsp_sche_io_chosen;
  wire       [3:0]    cmd_rsp_sche_io_chosenOH;
  wire       [10:0]   tmp_qp_cmd_rsp_expand_bytes_num;
  wire       [1:0]    tmp_qp_cmd_rsp_expand_bytes_num_1;
  wire       [11:0]   tmp_qp_cmd_rsp_expand_bytes_num_2;
  wire       [8:0]    tmp_qp_cmd_rsp_expand_bytes_num_3;
  wire       [7:0]    tmp_qp_cmd_rsp_expand_bytes_num_4;
  wire                tmp_when;
  wire                tmp_when_1;
  wire       [7:0]    tmp_qp_cmd_rsp_expand_ret_payload_empty_1;
  wire       [6:0]    tmp_qp_cmd_rsp_expand_ret_payload_empty_2;
  wire       [0:0]    tmp_qp_cmd_rsp_expand_ret_payload_empty_3;
  wire       [7:0]    tmp_qp_cmd_rsp_expand_ret_payload_empty_4;
  wire       [5:0]    tmp_qp_cmd_rsp_expand_ret_payload_empty_5;
  wire       [10:0]   tmp_qp_cmd_req_divide_bytes_num;
  wire       [1:0]    tmp_qp_cmd_req_divide_bytes_num_1;
  wire       [11:0]   tmp_qp_cmd_req_divide_bytes_num_2;
  wire       [9:0]    tmp_qp_cmd_req_divide_bytes_num_3;
  wire       [8:0]    tmp_qp_cmd_req_divide_bytes_num_4;
  wire                tmp_when_2;
  reg        [255:0]  tmp_qp_cmd_req_divide_ret_payload_data;
  wire       [4:0]    tmp_qp_cmd_req_divide_ret_payload_empty_1;
  wire       [5:0]    tmp_qp_cmd_req_divide_ret_payload_empty_2;
  wire       [51:0]   tmp_dma_hit;
  wire       [51:0]   tmp_dma_hit_1;
  reg        [1:0]    cmd_req_sel;
  reg                 tmp_qp_cmd_rsp_ready;
  wire                tmp_qp_cmd_rsp_expand_ret_valid;
  reg                 tmp_qp_cmd_rsp_expand_ret_valid_1;
  reg        [255:0]  tmp_qp_cmd_rsp_expand_ret_payload_channel;
  reg        [34:0]   tmp_qp_cmd_rsp_expand_ret_payload_channel_1;
  reg        [4:0]    tmp_qp_cmd_rsp_expand_ret_payload_channel_2;
  reg                 tmp_qp_cmd_rsp_expand_ret_payload_channel_3;
  reg                 tmp_qp_cmd_rsp_expand_ret_payload_channel_4;
  wire                tmp_qp_cmd_rsp_ready_1;
  wire                tmp_qp_cmd_rsp_expand_ret_valid_2;
  wire       [255:0]  tmp_qp_cmd_rsp_expand_data_regs_0;
  wire       [4:0]    tmp_qp_cmd_rsp_expand_ret_payload_empty;
  wire                tmp_qp_cmd_rsp_expand_ret_valid_3;
  wire                tmp_qp_cmd_rsp_expand_ret_payload_sop;
  wire       [297:0]  tmp_qp_cmd_rsp_expand_ret_payload_channel_5;
  wire                qp_cmd_rsp_expand_ret_ready;
  wire                qp_cmd_rsp_expand_ret_valid;
  reg        [511:0]  qp_cmd_rsp_expand_ret_payload_data;
  wire       [34:0]   qp_cmd_rsp_expand_ret_payload_channel;
  wire       [5:0]    qp_cmd_rsp_expand_ret_payload_empty;
  wire                qp_cmd_rsp_expand_ret_payload_eop;
  wire                qp_cmd_rsp_expand_ret_payload_sop;
  reg                 qp_cmd_rsp_expand_step_willIncrement;
  reg                 qp_cmd_rsp_expand_step_willClear;
  reg        [0:0]    qp_cmd_rsp_expand_step_valueNext;
  reg        [0:0]    qp_cmd_rsp_expand_step_value;
  wire                qp_cmd_rsp_expand_step_willOverflowIfInc;
  wire                qp_cmd_rsp_expand_step_willOverflow;
  reg        [255:0]  qp_cmd_rsp_expand_data_regs_0;
  wire       [11:0]   qp_cmd_rsp_expand_bytes_num;
  wire                qp_cmd_rsp_expand_overflow;
  reg                 qp_cmd_rsp_expand_sop_reg;
  wire       [511:0]  qp_cmd_rsp_expand_ret_data;
  wire       [554:0]  tmp_cmd_rsp_payload_data;
  wire       [7:0]    cmd_req_sdb_cmd_id;
  wire       [11:0]   cmd_req_sdb_opcode;
  wire       [4:0]    cmd_req_sdb_blk_num;
  wire       [24:0]   tmp_cmd_req_sdb_cmd_id;
  wire       [544:0]  tmp_cq_cmd_req_data;
  wire       [544:0]  tmp_eq_cmd_req_data;
  wire       [544:0]  tmp_mr_cmd_req_data;
  wire       [511:0]  tmp_qp_cmd_req_divide_datas_0;
  wire       [5:0]    tmp_qp_cmd_req_divide_ret_payload_empty;
  wire       [544:0]  tmp_qp_cmd_req_divide_ret_payload_channel;
  wire                qp_cmd_req_divide_ret_ready;
  wire                qp_cmd_req_divide_ret_valid;
  wire       [255:0]  qp_cmd_req_divide_ret_payload_data;
  wire       [24:0]   qp_cmd_req_divide_ret_payload_channel;
  wire       [4:0]    qp_cmd_req_divide_ret_payload_empty;
  wire                qp_cmd_req_divide_ret_payload_eop;
  wire                qp_cmd_req_divide_ret_payload_sop;
  reg                 qp_cmd_req_divide_step_willIncrement;
  reg                 qp_cmd_req_divide_step_willClear;
  reg        [0:0]    qp_cmd_req_divide_step_valueNext;
  reg        [0:0]    qp_cmd_req_divide_step_value;
  wire                qp_cmd_req_divide_step_willOverflowIfInc;
  wire                qp_cmd_req_divide_step_willOverflow;
  wire       [255:0]  qp_cmd_req_divide_datas_0;
  wire       [255:0]  qp_cmd_req_divide_datas_1;
  wire       [11:0]   qp_cmd_req_divide_bytes_num;
  wire                qp_cmd_req_divide_overflow;
  wire                qp_cmd_req_divide_ret_m2sPipe_ready;
  wire                qp_cmd_req_divide_ret_m2sPipe_valid;
  wire       [255:0]  qp_cmd_req_divide_ret_m2sPipe_payload_data;
  wire       [24:0]   qp_cmd_req_divide_ret_m2sPipe_payload_channel;
  wire       [4:0]    qp_cmd_req_divide_ret_m2sPipe_payload_empty;
  wire                qp_cmd_req_divide_ret_m2sPipe_payload_eop;
  wire                qp_cmd_req_divide_ret_m2sPipe_payload_sop;
  reg        [255:0]  qp_cmd_req_divide_ret_rPayload_data;
  reg        [24:0]   qp_cmd_req_divide_ret_rPayload_channel;
  reg        [4:0]    qp_cmd_req_divide_ret_rPayload_empty;
  reg                 qp_cmd_req_divide_ret_rPayload_eop;
  reg                 qp_cmd_req_divide_ret_rPayload_sop;
  reg                 qp_cmd_req_divide_ret_valid_regNext;
  wire       [23:0]   cmdqe_out_output_inline_data_rsv;
  wire       [7:0]    cmdqe_out_output_inline_data_status;
  wire       [31:0]   cmdqe_out_output_inline_data_syndrome;
  wire       [63:0]   cmdqe_out_output_inline_data_cmd_output;
  wire       [31:0]   cmdqe_out_output_mb_point_high;
  wire       [8:0]    cmdqe_out_rsv1;
  wire       [22:0]   cmdqe_out_output_mb_point_low;
  wire       [31:0]   cmdqe_out_output_length;
  wire                cmdqe_out_own;
  wire       [6:0]    cmdqe_out_status;
  wire       [7:0]    cmdqe_out_rsv0;
  wire       [7:0]    cmdqe_out_signature;
  wire       [7:0]    cmdqe_out_token;
  wire                dma_hit;
  wire                err_cmdqe_out;
  wire                err_cmdqe_flag;
  wire       [255:0]  tmp_cmdqe_out_output_mb_point_high;
  wire       [127:0]  tmp_cmdqe_out_output_inline_data_rsv;

  assign tmp_when = (tmp_qp_cmd_rsp_expand_ret_valid_2 && (tmp_qp_cmd_rsp_ready_1 || tmp_qp_cmd_rsp_ready_1));
  assign tmp_when_1 = (qp_cmd_rsp_expand_overflow || tmp_qp_cmd_rsp_expand_ret_valid_3);
  assign tmp_when_2 = (qp_cmd_req_divide_ret_valid && (qp_cmd_req_divide_ret_ready || qp_cmd_req_divide_ret_ready));
  assign tmp_qp_cmd_rsp_expand_bytes_num = (tmp_qp_cmd_rsp_expand_bytes_num_1 * 9'h100);
  assign tmp_qp_cmd_rsp_expand_bytes_num_1 = ({1'b0,qp_cmd_rsp_expand_step_value} + {1'b0,1'b1});
  assign tmp_qp_cmd_rsp_expand_bytes_num_3 = {1'b0,tmp_qp_cmd_rsp_expand_bytes_num_4};
  assign tmp_qp_cmd_rsp_expand_bytes_num_2 = {3'd0, tmp_qp_cmd_rsp_expand_bytes_num_3};
  assign tmp_qp_cmd_rsp_expand_bytes_num_4 = ({3'd0,tmp_qp_cmd_rsp_expand_ret_payload_empty} <<< 2'd3);
  assign tmp_qp_cmd_rsp_expand_ret_payload_empty_1 = ({1'b0,tmp_qp_cmd_rsp_expand_ret_payload_empty_2} + tmp_qp_cmd_rsp_expand_ret_payload_empty_4);
  assign tmp_qp_cmd_rsp_expand_ret_payload_empty_2 = (tmp_qp_cmd_rsp_expand_ret_payload_empty_3 * 6'h20);
  assign tmp_qp_cmd_rsp_expand_ret_payload_empty_3 = (1'b1 - qp_cmd_rsp_expand_step_value);
  assign tmp_qp_cmd_rsp_expand_ret_payload_empty_5 = {1'b0,tmp_qp_cmd_rsp_expand_ret_payload_empty};
  assign tmp_qp_cmd_rsp_expand_ret_payload_empty_4 = {2'd0, tmp_qp_cmd_rsp_expand_ret_payload_empty_5};
  assign tmp_qp_cmd_req_divide_bytes_num = (tmp_qp_cmd_req_divide_bytes_num_1 * 9'h100);
  assign tmp_qp_cmd_req_divide_bytes_num_1 = ({1'b0,qp_cmd_req_divide_step_value} + {1'b0,1'b1});
  assign tmp_qp_cmd_req_divide_bytes_num_3 = {1'b0,tmp_qp_cmd_req_divide_bytes_num_4};
  assign tmp_qp_cmd_req_divide_bytes_num_2 = {2'd0, tmp_qp_cmd_req_divide_bytes_num_3};
  assign tmp_qp_cmd_req_divide_bytes_num_4 = ({3'd0,tmp_qp_cmd_req_divide_ret_payload_empty} <<< 2'd3);
  assign tmp_qp_cmd_req_divide_ret_payload_empty_2 = (tmp_qp_cmd_req_divide_ret_payload_empty % 9'h100);
  assign tmp_qp_cmd_req_divide_ret_payload_empty_1 = tmp_qp_cmd_req_divide_ret_payload_empty_2[4:0];
  assign tmp_dma_hit = (dma_wreq_m_desc[63 : 0] >>> 4'd12);
  assign tmp_dma_hit_1 = (cmdq_phy_addr_i >>> 4'd12);
  cmdq_command_queue_proc cmdq_proc (
    .db_vec_s_valid             (db_vec_s_valid                             ), //i
    .db_vec_s_ready             (cmdq_proc_db_vec_s_ready                   ), //o
    .db_vec_s_payload           (db_vec_s_data[31:0]                        ), //i
    .dma_rreq_m_ready           (dma_rreq_m_ready                           ), //i
    .dma_rreq_m_valid           (cmdq_proc_dma_rreq_m_valid                 ), //o
    .dma_rreq_m_payload_channel (cmdq_proc_dma_rreq_m_payload_channel[127:0]), //o
    .dma_rrsp_s_ready           (cmdq_proc_dma_rrsp_s_ready                 ), //o
    .dma_rrsp_s_valid           (dma_rrsp_s_valid                           ), //i
    .dma_rrsp_s_payload_data    (dma_rrsp_s_data[511:0]                     ), //i
    .dma_rrsp_s_payload_channel (dma_rrsp_s_desc[127:0]                     ), //i
    .dma_rrsp_s_payload_empty   (dma_rrsp_s_empty[5:0]                      ), //i
    .dma_rrsp_s_payload_eop     (dma_rrsp_s_eop                             ), //i
    .dma_rrsp_s_payload_sop     (dma_rrsp_s_sop                             ), //i
    .dma_wreq_m_ready           (dma_wreq_m_ready                           ), //i
    .dma_wreq_m_valid           (cmdq_proc_dma_wreq_m_valid                 ), //o
    .dma_wreq_m_payload_data    (cmdq_proc_dma_wreq_m_payload_data[511:0]   ), //o
    .dma_wreq_m_payload_channel (cmdq_proc_dma_wreq_m_payload_channel[127:0]), //o
    .dma_wreq_m_payload_empty   (cmdq_proc_dma_wreq_m_payload_empty[5:0]    ), //o
    .dma_wreq_m_payload_eop     (cmdq_proc_dma_wreq_m_payload_eop           ), //o
    .dma_wreq_m_payload_sop     (cmdq_proc_dma_wreq_m_payload_sop           ), //o
    .cmdq_phy_addr_i            (cmdq_phy_addr_i[63:0]                      ), //i
    .cmd_req_ready              (streamDemux_io_input_ready                 ), //i
    .cmd_req_valid              (cmdq_proc_cmd_req_valid                    ), //o
    .cmd_req_payload_data       (cmdq_proc_cmd_req_payload_data[511:0]      ), //o
    .cmd_req_payload_channel    (cmdq_proc_cmd_req_payload_channel[24:0]    ), //o
    .cmd_req_payload_empty      (cmdq_proc_cmd_req_payload_empty[5:0]       ), //o
    .cmd_req_payload_eop        (cmdq_proc_cmd_req_payload_eop              ), //o
    .cmd_req_payload_sop        (cmdq_proc_cmd_req_payload_sop              ), //o
    .cmd_rsp_ready              (cmdq_proc_cmd_rsp_ready                    ), //o
    .cmd_rsp_valid              (cmd_rsp_sche_io_output_valid               ), //i
    .cmd_rsp_payload_data       (cmdq_proc_cmd_rsp_payload_data[511:0]      ), //i
    .cmd_rsp_payload_channel    (cmdq_proc_cmd_rsp_payload_channel[34:0]    ), //i
    .cmd_rsp_payload_empty      (cmdq_proc_cmd_rsp_payload_empty[5:0]       ), //i
    .cmd_rsp_payload_eop        (cmdq_proc_cmd_rsp_payload_eop              ), //i
    .cmd_rsp_payload_sop        (cmdq_proc_cmd_rsp_payload_sop              ), //i
    .reset                      (reset                                      ), //i
    .clk                        (clk                                        )  //i
  );
  cmdq_StreamDemux streamDemux (
    .io_select            (cmd_req_sel[1:0]                       ), //i
    .io_input_valid       (cmdq_proc_cmd_req_valid                ), //i
    .io_input_ready       (streamDemux_io_input_ready             ), //o
    .io_input_payload     (streamDemux_io_input_payload[544:0]    ), //i
    .io_outputs_0_valid   (streamDemux_io_outputs_0_valid         ), //o
    .io_outputs_0_ready   (cq_cmd_req_ready                       ), //i
    .io_outputs_0_payload (streamDemux_io_outputs_0_payload[544:0]), //o
    .io_outputs_1_valid   (streamDemux_io_outputs_1_valid         ), //o
    .io_outputs_1_ready   (eq_cmd_req_ready                       ), //i
    .io_outputs_1_payload (streamDemux_io_outputs_1_payload[544:0]), //o
    .io_outputs_2_valid   (streamDemux_io_outputs_2_valid         ), //o
    .io_outputs_2_ready   (mr_cmd_req_ready                       ), //i
    .io_outputs_2_payload (streamDemux_io_outputs_2_payload[544:0]), //o
    .io_outputs_3_valid   (streamDemux_io_outputs_3_valid         ), //o
    .io_outputs_3_ready   (streamDemux_io_outputs_3_ready         ), //i
    .io_outputs_3_payload (streamDemux_io_outputs_3_payload[544:0])  //o
  );
  cmdq_StreamArbiter cmd_rsp_sche (
    .io_inputs_0_valid           (cq_cmd_rsp_valid                            ), //i
    .io_inputs_0_ready           (cmd_rsp_sche_io_inputs_0_ready              ), //o
    .io_inputs_0_payload_data    (cq_cmd_rsp_data[511:0]                      ), //i
    .io_inputs_0_payload_channel (cq_cmd_rsp_sdb[34:0]                        ), //i
    .io_inputs_0_payload_empty   (cq_cmd_rsp_empty[5:0]                       ), //i
    .io_inputs_0_payload_eop     (cq_cmd_rsp_eop                              ), //i
    .io_inputs_0_payload_sop     (cq_cmd_rsp_sop                              ), //i
    .io_inputs_1_valid           (eq_cmd_rsp_valid                            ), //i
    .io_inputs_1_ready           (cmd_rsp_sche_io_inputs_1_ready              ), //o
    .io_inputs_1_payload_data    (eq_cmd_rsp_data[511:0]                      ), //i
    .io_inputs_1_payload_channel (eq_cmd_rsp_sdb[34:0]                        ), //i
    .io_inputs_1_payload_empty   (eq_cmd_rsp_empty[5:0]                       ), //i
    .io_inputs_1_payload_eop     (eq_cmd_rsp_eop                              ), //i
    .io_inputs_1_payload_sop     (eq_cmd_rsp_sop                              ), //i
    .io_inputs_2_valid           (mr_cmd_rsp_valid                            ), //i
    .io_inputs_2_ready           (cmd_rsp_sche_io_inputs_2_ready              ), //o
    .io_inputs_2_payload_data    (mr_cmd_rsp_data[511:0]                      ), //i
    .io_inputs_2_payload_channel (mr_cmd_rsp_sdb[34:0]                        ), //i
    .io_inputs_2_payload_empty   (mr_cmd_rsp_empty[5:0]                       ), //i
    .io_inputs_2_payload_eop     (mr_cmd_rsp_eop                              ), //i
    .io_inputs_2_payload_sop     (mr_cmd_rsp_sop                              ), //i
    .io_inputs_3_valid           (qp_cmd_rsp_expand_ret_valid                 ), //i
    .io_inputs_3_ready           (cmd_rsp_sche_io_inputs_3_ready              ), //o
    .io_inputs_3_payload_data    (qp_cmd_rsp_expand_ret_payload_data[511:0]   ), //i
    .io_inputs_3_payload_channel (qp_cmd_rsp_expand_ret_payload_channel[34:0] ), //i
    .io_inputs_3_payload_empty   (qp_cmd_rsp_expand_ret_payload_empty[5:0]    ), //i
    .io_inputs_3_payload_eop     (qp_cmd_rsp_expand_ret_payload_eop           ), //i
    .io_inputs_3_payload_sop     (qp_cmd_rsp_expand_ret_payload_sop           ), //i
    .io_output_valid             (cmd_rsp_sche_io_output_valid                ), //o
    .io_output_ready             (cmdq_proc_cmd_rsp_ready                     ), //i
    .io_output_payload_data      (cmd_rsp_sche_io_output_payload_data[511:0]  ), //o
    .io_output_payload_channel   (cmd_rsp_sche_io_output_payload_channel[34:0]), //o
    .io_output_payload_empty     (cmd_rsp_sche_io_output_payload_empty[5:0]   ), //o
    .io_output_payload_eop       (cmd_rsp_sche_io_output_payload_eop          ), //o
    .io_output_payload_sop       (cmd_rsp_sche_io_output_payload_sop          ), //o
    .io_chosen                   (cmd_rsp_sche_io_chosen[1:0]                 ), //o
    .io_chosenOH                 (cmd_rsp_sche_io_chosenOH[3:0]               ), //o
    .clk                         (clk                                         ), //i
    .reset                       (reset                                       )  //i
  );
  always @(*) begin
    case(qp_cmd_req_divide_step_value)
      1'b0 : tmp_qp_cmd_req_divide_ret_payload_data = qp_cmd_req_divide_datas_0;
      default : tmp_qp_cmd_req_divide_ret_payload_data = qp_cmd_req_divide_datas_1;
    endcase
  end

  assign streamDemux_io_input_payload = {cmdq_proc_cmd_req_payload_sop,{cmdq_proc_cmd_req_payload_eop,{cmdq_proc_cmd_req_payload_empty,{cmdq_proc_cmd_req_payload_channel,cmdq_proc_cmd_req_payload_data}}}}; // @ Stream.scala l300
  assign db_vec_s_ready = cmdq_proc_db_vec_s_ready; // @ command_queue_proc_top.scala l42
  assign dma_rreq_m_valid = cmdq_proc_dma_rreq_m_valid; // @ command_queue_proc_top.scala l43
  assign dma_rreq_m_desc = cmdq_proc_dma_rreq_m_payload_channel; // @ command_queue_proc_top.scala l43
  assign dma_rrsp_s_ready = cmdq_proc_dma_rrsp_s_ready; // @ command_queue_proc_top.scala l44
  assign dma_wreq_m_valid = cmdq_proc_dma_wreq_m_valid; // @ command_queue_proc_top.scala l45
  assign dma_wreq_m_data = cmdq_proc_dma_wreq_m_payload_data; // @ command_queue_proc_top.scala l45
  assign dma_wreq_m_desc = cmdq_proc_dma_wreq_m_payload_channel; // @ command_queue_proc_top.scala l45
  assign dma_wreq_m_empty = cmdq_proc_dma_wreq_m_payload_empty; // @ command_queue_proc_top.scala l45
  assign dma_wreq_m_eop = cmdq_proc_dma_wreq_m_payload_eop; // @ command_queue_proc_top.scala l45
  assign dma_wreq_m_sop = cmdq_proc_dma_wreq_m_payload_sop; // @ command_queue_proc_top.scala l45
  assign qp_cmd_rsp_ready = tmp_qp_cmd_rsp_ready; // @ BusExt.scala l121
  always @(*) begin
    tmp_qp_cmd_rsp_ready = tmp_qp_cmd_rsp_ready_1; // @ Stream.scala l374
    if((! tmp_qp_cmd_rsp_expand_ret_valid)) begin
      tmp_qp_cmd_rsp_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign tmp_qp_cmd_rsp_expand_ret_valid = tmp_qp_cmd_rsp_expand_ret_valid_1; // @ Stream.scala l377
  assign tmp_qp_cmd_rsp_expand_ret_valid_2 = tmp_qp_cmd_rsp_expand_ret_valid; // @ BusExt.scala l226
  assign tmp_qp_cmd_rsp_expand_ret_payload_channel_5 = {tmp_qp_cmd_rsp_expand_ret_payload_channel_4,{tmp_qp_cmd_rsp_expand_ret_payload_channel_3,{tmp_qp_cmd_rsp_expand_ret_payload_channel_2,{tmp_qp_cmd_rsp_expand_ret_payload_channel_1,tmp_qp_cmd_rsp_expand_ret_payload_channel}}}}; // @ BaseType.scala l299
  assign tmp_qp_cmd_rsp_expand_data_regs_0 = tmp_qp_cmd_rsp_expand_ret_payload_channel_5[255 : 0]; // @ Bits.scala l133
  assign tmp_qp_cmd_rsp_expand_ret_payload_empty = tmp_qp_cmd_rsp_expand_ret_payload_channel_5[295 : 291]; // @ UInt.scala l381
  assign tmp_qp_cmd_rsp_expand_ret_valid_3 = tmp_qp_cmd_rsp_expand_ret_payload_channel_5[296]; // @ Bool.scala l209
  assign tmp_qp_cmd_rsp_expand_ret_payload_sop = tmp_qp_cmd_rsp_expand_ret_payload_channel_5[297]; // @ Bool.scala l209
  always @(*) begin
    qp_cmd_rsp_expand_step_willIncrement = 1'b0; // @ Utils.scala l594
    if(tmp_when) begin
      if(!tmp_when_1) begin
        qp_cmd_rsp_expand_step_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  always @(*) begin
    qp_cmd_rsp_expand_step_willClear = 1'b0; // @ Utils.scala l595
    if(tmp_when) begin
      if(tmp_when_1) begin
        qp_cmd_rsp_expand_step_willClear = 1'b1; // @ Utils.scala l597
      end
    end
  end

  assign qp_cmd_rsp_expand_step_willOverflowIfInc = (qp_cmd_rsp_expand_step_value == 1'b1); // @ BaseType.scala l305
  assign qp_cmd_rsp_expand_step_willOverflow = (qp_cmd_rsp_expand_step_willOverflowIfInc && qp_cmd_rsp_expand_step_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    qp_cmd_rsp_expand_step_valueNext = (qp_cmd_rsp_expand_step_value + qp_cmd_rsp_expand_step_willIncrement); // @ Utils.scala l606
    if(qp_cmd_rsp_expand_step_willClear) begin
      qp_cmd_rsp_expand_step_valueNext = 1'b0; // @ Utils.scala l616
    end
  end

  assign qp_cmd_rsp_expand_bytes_num = ({1'b0,tmp_qp_cmd_rsp_expand_bytes_num} + tmp_qp_cmd_rsp_expand_bytes_num_2); // @ BaseType.scala l299
  assign qp_cmd_rsp_expand_overflow = (12'h200 <= qp_cmd_rsp_expand_bytes_num); // @ BaseType.scala l305
  assign qp_cmd_rsp_expand_ret_data = {tmp_qp_cmd_rsp_expand_data_regs_0,qp_cmd_rsp_expand_data_regs_0}; // @ BaseType.scala l299
  assign qp_cmd_rsp_expand_ret_valid = (tmp_qp_cmd_rsp_expand_ret_valid_2 && (qp_cmd_rsp_expand_overflow || tmp_qp_cmd_rsp_expand_ret_valid_3)); // @ BusExt.scala l54
  assign qp_cmd_rsp_expand_ret_payload_sop = (tmp_qp_cmd_rsp_expand_ret_payload_sop || qp_cmd_rsp_expand_sop_reg); // @ BusExt.scala l55
  assign qp_cmd_rsp_expand_ret_payload_eop = tmp_qp_cmd_rsp_expand_ret_valid_3; // @ BusExt.scala l56
  assign qp_cmd_rsp_expand_ret_payload_empty = tmp_qp_cmd_rsp_expand_ret_payload_empty_1[5:0]; // @ BusExt.scala l57
  always @(*) begin
    case(qp_cmd_rsp_expand_step_value)
      1'b0 : begin
        qp_cmd_rsp_expand_ret_payload_data = (qp_cmd_rsp_expand_ret_data >>> 256); // @ BusExt.scala l61
      end
      default : begin
        qp_cmd_rsp_expand_ret_payload_data = (qp_cmd_rsp_expand_ret_data >>> 0); // @ BusExt.scala l61
      end
    endcase
  end

  assign qp_cmd_rsp_expand_ret_payload_channel = tmp_qp_cmd_rsp_expand_ret_payload_channel_5[290 : 256]; // @ BusExt.scala l66
  assign tmp_qp_cmd_rsp_ready_1 = ((qp_cmd_rsp_expand_overflow || tmp_qp_cmd_rsp_expand_ret_valid_3) ? qp_cmd_rsp_expand_ret_ready : 1'b1); // @ BusExt.scala l68
  assign cq_cmd_rsp_ready = cmd_rsp_sche_io_inputs_0_ready; // @ BusExt.scala l121
  assign eq_cmd_rsp_ready = cmd_rsp_sche_io_inputs_1_ready; // @ BusExt.scala l121
  assign mr_cmd_rsp_ready = cmd_rsp_sche_io_inputs_2_ready; // @ BusExt.scala l121
  assign qp_cmd_rsp_expand_ret_ready = cmd_rsp_sche_io_inputs_3_ready; // @ BusExt.scala l121
  assign tmp_cmd_rsp_payload_data = {cmd_rsp_sche_io_output_payload_sop,{cmd_rsp_sche_io_output_payload_eop,{cmd_rsp_sche_io_output_payload_empty,{cmd_rsp_sche_io_output_payload_channel,cmd_rsp_sche_io_output_payload_data}}}}; // @ BaseType.scala l299
  assign cmdq_proc_cmd_rsp_payload_data = tmp_cmd_rsp_payload_data[511 : 0]; // @ command_queue_proc_top.scala l50
  assign cmdq_proc_cmd_rsp_payload_channel = tmp_cmd_rsp_payload_data[546 : 512]; // @ command_queue_proc_top.scala l50
  assign cmdq_proc_cmd_rsp_payload_empty = tmp_cmd_rsp_payload_data[552 : 547]; // @ command_queue_proc_top.scala l50
  assign cmdq_proc_cmd_rsp_payload_eop = tmp_cmd_rsp_payload_data[553]; // @ command_queue_proc_top.scala l50
  assign cmdq_proc_cmd_rsp_payload_sop = tmp_cmd_rsp_payload_data[554]; // @ command_queue_proc_top.scala l50
  assign tmp_cmd_req_sdb_cmd_id = cmdq_proc_cmd_req_payload_channel; // @ BaseType.scala l318
  assign cmd_req_sdb_cmd_id = tmp_cmd_req_sdb_cmd_id[7 : 0]; // @ UInt.scala l381
  assign cmd_req_sdb_opcode = tmp_cmd_req_sdb_cmd_id[19 : 8]; // @ Bits.scala l133
  assign cmd_req_sdb_blk_num = tmp_cmd_req_sdb_cmd_id[24 : 20]; // @ UInt.scala l381
  always @(*) begin
    case(cmd_req_sdb_opcode)
      12'h400 : begin
        cmd_req_sel = 2'b00; // @ command_queue_proc_top.scala l55
      end
      12'h401 : begin
        cmd_req_sel = 2'b00; // @ command_queue_proc_top.scala l56
      end
      12'h301 : begin
        cmd_req_sel = 2'b01; // @ command_queue_proc_top.scala l57
      end
      12'h302 : begin
        cmd_req_sel = 2'b01; // @ command_queue_proc_top.scala l58
      end
      12'h200 : begin
        cmd_req_sel = 2'b10; // @ command_queue_proc_top.scala l59
      end
      12'h202 : begin
        cmd_req_sel = 2'b10; // @ command_queue_proc_top.scala l60
      end
      12'h761 : begin
        cmd_req_sel = 2'b11; // @ command_queue_proc_top.scala l61
      end
      12'h760 : begin
        cmd_req_sel = 2'b11; // @ command_queue_proc_top.scala l62
      end
      12'h500 : begin
        cmd_req_sel = 2'b11; // @ command_queue_proc_top.scala l63
      end
      12'h501 : begin
        cmd_req_sel = 2'b11; // @ command_queue_proc_top.scala l64
      end
      12'h502 : begin
        cmd_req_sel = 2'b11; // @ command_queue_proc_top.scala l65
      end
      12'h503 : begin
        cmd_req_sel = 2'b11; // @ command_queue_proc_top.scala l66
      end
      12'h504 : begin
        cmd_req_sel = 2'b11; // @ command_queue_proc_top.scala l67
      end
      12'h50a : begin
        cmd_req_sel = 2'b11; // @ command_queue_proc_top.scala l68
      end
      12'h50b : begin
        cmd_req_sel = 2'b11; // @ command_queue_proc_top.scala l69
      end
      default : begin
        cmd_req_sel = 2'b00; // @ command_queue_proc_top.scala l70
      end
    endcase
  end

  assign tmp_cq_cmd_req_data = streamDemux_io_outputs_0_payload; // @ Bits.scala l152
  assign cq_cmd_req_valid = streamDemux_io_outputs_0_valid; // @ command_queue_proc_top.scala l72
  assign cq_cmd_req_data = tmp_cq_cmd_req_data[511 : 0]; // @ command_queue_proc_top.scala l72
  assign cq_cmd_req_sdb = tmp_cq_cmd_req_data[536 : 512]; // @ command_queue_proc_top.scala l72
  assign cq_cmd_req_empty = tmp_cq_cmd_req_data[542 : 537]; // @ command_queue_proc_top.scala l72
  assign cq_cmd_req_eop = tmp_cq_cmd_req_data[543]; // @ command_queue_proc_top.scala l72
  assign cq_cmd_req_sop = tmp_cq_cmd_req_data[544]; // @ command_queue_proc_top.scala l72
  assign tmp_eq_cmd_req_data = streamDemux_io_outputs_1_payload; // @ Bits.scala l152
  assign eq_cmd_req_valid = streamDemux_io_outputs_1_valid; // @ command_queue_proc_top.scala l72
  assign eq_cmd_req_data = tmp_eq_cmd_req_data[511 : 0]; // @ command_queue_proc_top.scala l72
  assign eq_cmd_req_sdb = tmp_eq_cmd_req_data[536 : 512]; // @ command_queue_proc_top.scala l72
  assign eq_cmd_req_empty = tmp_eq_cmd_req_data[542 : 537]; // @ command_queue_proc_top.scala l72
  assign eq_cmd_req_eop = tmp_eq_cmd_req_data[543]; // @ command_queue_proc_top.scala l72
  assign eq_cmd_req_sop = tmp_eq_cmd_req_data[544]; // @ command_queue_proc_top.scala l72
  assign tmp_mr_cmd_req_data = streamDemux_io_outputs_2_payload; // @ Bits.scala l152
  assign mr_cmd_req_valid = streamDemux_io_outputs_2_valid; // @ command_queue_proc_top.scala l72
  assign mr_cmd_req_data = tmp_mr_cmd_req_data[511 : 0]; // @ command_queue_proc_top.scala l72
  assign mr_cmd_req_sdb = tmp_mr_cmd_req_data[536 : 512]; // @ command_queue_proc_top.scala l72
  assign mr_cmd_req_empty = tmp_mr_cmd_req_data[542 : 537]; // @ command_queue_proc_top.scala l72
  assign mr_cmd_req_eop = tmp_mr_cmd_req_data[543]; // @ command_queue_proc_top.scala l72
  assign mr_cmd_req_sop = tmp_mr_cmd_req_data[544]; // @ command_queue_proc_top.scala l72
  assign streamDemux_io_outputs_3_ready = (qp_cmd_req_divide_ret_ready && qp_cmd_req_divide_overflow); // @ BusExt.scala l227
  assign tmp_qp_cmd_req_divide_ret_payload_channel = streamDemux_io_outputs_3_payload; // @ Bits.scala l152
  assign tmp_qp_cmd_req_divide_datas_0 = tmp_qp_cmd_req_divide_ret_payload_channel[511 : 0]; // @ Bits.scala l133
  assign tmp_qp_cmd_req_divide_ret_payload_empty = tmp_qp_cmd_req_divide_ret_payload_channel[542 : 537]; // @ UInt.scala l381
  always @(*) begin
    qp_cmd_req_divide_step_willIncrement = 1'b0; // @ Utils.scala l594
    if(tmp_when_2) begin
      if(!qp_cmd_req_divide_ret_payload_eop) begin
        qp_cmd_req_divide_step_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  always @(*) begin
    qp_cmd_req_divide_step_willClear = 1'b0; // @ Utils.scala l595
    if(tmp_when_2) begin
      if(qp_cmd_req_divide_ret_payload_eop) begin
        qp_cmd_req_divide_step_willClear = 1'b1; // @ Utils.scala l597
      end
    end
  end

  assign qp_cmd_req_divide_step_willOverflowIfInc = (qp_cmd_req_divide_step_value == 1'b1); // @ BaseType.scala l305
  assign qp_cmd_req_divide_step_willOverflow = (qp_cmd_req_divide_step_willOverflowIfInc && qp_cmd_req_divide_step_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    qp_cmd_req_divide_step_valueNext = (qp_cmd_req_divide_step_value + qp_cmd_req_divide_step_willIncrement); // @ Utils.scala l606
    if(qp_cmd_req_divide_step_willClear) begin
      qp_cmd_req_divide_step_valueNext = 1'b0; // @ Utils.scala l616
    end
  end

  assign qp_cmd_req_divide_datas_0 = tmp_qp_cmd_req_divide_datas_0[255 : 0]; // @ BaseType.scala l299
  assign qp_cmd_req_divide_datas_1 = tmp_qp_cmd_req_divide_datas_0[511 : 256]; // @ BaseType.scala l299
  assign qp_cmd_req_divide_bytes_num = ({1'b0,tmp_qp_cmd_req_divide_bytes_num} + tmp_qp_cmd_req_divide_bytes_num_2); // @ BaseType.scala l299
  assign qp_cmd_req_divide_overflow = (12'h200 <= qp_cmd_req_divide_bytes_num); // @ BaseType.scala l305
  assign qp_cmd_req_divide_ret_valid = streamDemux_io_outputs_3_valid; // @ BusExt.scala l97
  assign qp_cmd_req_divide_ret_payload_data = tmp_qp_cmd_req_divide_ret_payload_data; // @ BusExt.scala l98
  assign qp_cmd_req_divide_ret_payload_sop = (tmp_qp_cmd_req_divide_ret_payload_channel[544] && (qp_cmd_req_divide_step_value == 1'b0)); // @ BusExt.scala l99
  assign qp_cmd_req_divide_ret_payload_eop = (tmp_qp_cmd_req_divide_ret_payload_channel[543] && qp_cmd_req_divide_overflow); // @ BusExt.scala l100
  assign qp_cmd_req_divide_ret_payload_empty = (qp_cmd_req_divide_ret_payload_eop ? tmp_qp_cmd_req_divide_ret_payload_empty_1 : 5'h0); // @ BusExt.scala l101
  assign qp_cmd_req_divide_ret_payload_channel = tmp_qp_cmd_req_divide_ret_payload_channel[536 : 512]; // @ BusExt.scala l103
  assign qp_cmd_req_divide_ret_m2sPipe_valid = qp_cmd_req_divide_ret_valid_regNext; // @ AvalonST.scala l151
  assign qp_cmd_req_divide_ret_m2sPipe_payload_data = qp_cmd_req_divide_ret_rPayload_data; // @ AvalonST.scala l154
  assign qp_cmd_req_divide_ret_m2sPipe_payload_channel = qp_cmd_req_divide_ret_rPayload_channel; // @ AvalonST.scala l154
  assign qp_cmd_req_divide_ret_m2sPipe_payload_empty = qp_cmd_req_divide_ret_rPayload_empty; // @ AvalonST.scala l154
  assign qp_cmd_req_divide_ret_m2sPipe_payload_eop = qp_cmd_req_divide_ret_rPayload_eop; // @ AvalonST.scala l154
  assign qp_cmd_req_divide_ret_m2sPipe_payload_sop = qp_cmd_req_divide_ret_rPayload_sop; // @ AvalonST.scala l154
  assign qp_cmd_req_divide_ret_ready = qp_cmd_req_divide_ret_m2sPipe_ready; // @ AvalonST.scala l67
  assign qp_cmd_req_divide_ret_m2sPipe_ready = qp_cmd_req_ready; // @ command_queue_proc_top.scala l73
  assign qp_cmd_req_valid = qp_cmd_req_divide_ret_m2sPipe_valid; // @ command_queue_proc_top.scala l73
  assign qp_cmd_req_data = qp_cmd_req_divide_ret_m2sPipe_payload_data; // @ command_queue_proc_top.scala l73
  assign qp_cmd_req_sdb = qp_cmd_req_divide_ret_m2sPipe_payload_channel; // @ command_queue_proc_top.scala l73
  assign qp_cmd_req_empty = qp_cmd_req_divide_ret_m2sPipe_payload_empty; // @ command_queue_proc_top.scala l73
  assign qp_cmd_req_eop = qp_cmd_req_divide_ret_m2sPipe_payload_eop; // @ command_queue_proc_top.scala l73
  assign qp_cmd_req_sop = qp_cmd_req_divide_ret_m2sPipe_payload_sop; // @ command_queue_proc_top.scala l73
  assign dma_hit = (((dma_wreq_m_sop && dma_wreq_m_eop) && (dma_wreq_m_empty == 6'h20)) && (tmp_dma_hit == tmp_dma_hit_1)); // @ BaseType.scala l305
  assign err_cmdqe_out = ((cmdqe_out_status != 7'h0) || (cmdqe_out_output_inline_data_status != 8'h0)); // @ BaseType.scala l305
  assign err_cmdqe_flag = (dma_hit && err_cmdqe_out); // @ BaseType.scala l305
  assign tmp_cmdqe_out_output_mb_point_high = dma_wreq_m_data[255 : 0]; // @ BaseType.scala l299
  assign tmp_cmdqe_out_output_inline_data_rsv = tmp_cmdqe_out_output_mb_point_high[127 : 0]; // @ BaseType.scala l299
  assign cmdqe_out_output_inline_data_rsv = tmp_cmdqe_out_output_inline_data_rsv[23 : 0]; // @ Bits.scala l133
  assign cmdqe_out_output_inline_data_status = tmp_cmdqe_out_output_inline_data_rsv[31 : 24]; // @ Bits.scala l133
  assign cmdqe_out_output_inline_data_syndrome = tmp_cmdqe_out_output_inline_data_rsv[63 : 32]; // @ Bits.scala l133
  assign cmdqe_out_output_inline_data_cmd_output = tmp_cmdqe_out_output_inline_data_rsv[127 : 64]; // @ Bits.scala l133
  assign cmdqe_out_output_mb_point_high = tmp_cmdqe_out_output_mb_point_high[159 : 128]; // @ Bits.scala l133
  assign cmdqe_out_rsv1 = tmp_cmdqe_out_output_mb_point_high[168 : 160]; // @ Bits.scala l133
  assign cmdqe_out_output_mb_point_low = tmp_cmdqe_out_output_mb_point_high[191 : 169]; // @ Bits.scala l133
  assign cmdqe_out_output_length = tmp_cmdqe_out_output_mb_point_high[223 : 192]; // @ UInt.scala l381
  assign cmdqe_out_own = tmp_cmdqe_out_output_mb_point_high[224]; // @ Bool.scala l209
  assign cmdqe_out_status = tmp_cmdqe_out_output_mb_point_high[231 : 225]; // @ Bits.scala l133
  assign cmdqe_out_rsv0 = tmp_cmdqe_out_output_mb_point_high[239 : 232]; // @ Bits.scala l133
  assign cmdqe_out_signature = tmp_cmdqe_out_output_mb_point_high[247 : 240]; // @ Bits.scala l133
  assign cmdqe_out_token = tmp_cmdqe_out_output_mb_point_high[255 : 248]; // @ Bits.scala l133
  assign err_cmdqe_dma_wreq_payload_data = dma_wreq_m_data; // @ command_queue_proc_top.scala l85
  assign err_cmdqe_dma_wreq_payload_channel = dma_wreq_m_desc; // @ command_queue_proc_top.scala l85
  assign err_cmdqe_dma_wreq_payload_empty = dma_wreq_m_empty; // @ command_queue_proc_top.scala l85
  assign err_cmdqe_dma_wreq_payload_eop = dma_wreq_m_eop; // @ command_queue_proc_top.scala l85
  assign err_cmdqe_dma_wreq_payload_sop = dma_wreq_m_sop; // @ command_queue_proc_top.scala l85
  assign cmd_rsp_dma_wreq_payload_data = dma_wreq_m_data; // @ command_queue_proc_top.scala l86
  assign cmd_rsp_dma_wreq_payload_channel = dma_wreq_m_desc; // @ command_queue_proc_top.scala l86
  assign cmd_rsp_dma_wreq_payload_empty = dma_wreq_m_empty; // @ command_queue_proc_top.scala l86
  assign cmd_rsp_dma_wreq_payload_eop = dma_wreq_m_eop; // @ command_queue_proc_top.scala l86
  assign cmd_rsp_dma_wreq_payload_sop = dma_wreq_m_sop; // @ command_queue_proc_top.scala l86
  assign err_cmdqe_dma_wreq_ready = dma_wreq_m_ready; // @ command_queue_proc_top.scala l87
  assign cmd_rsp_dma_wreq_ready = dma_wreq_m_ready; // @ command_queue_proc_top.scala l88
  assign err_cmdqe_dma_wreq_valid = (err_cmdqe_flag && dma_wreq_m_valid); // @ command_queue_proc_top.scala l89
  assign cmd_rsp_dma_wreq_valid = ((! err_cmdqe_flag) && dma_wreq_m_valid); // @ command_queue_proc_top.scala l90
  always @(posedge clk) begin
    if(reset) begin
      tmp_qp_cmd_rsp_expand_ret_valid_1 <= 1'b0; // @ Data.scala l409
      qp_cmd_rsp_expand_step_value <= 1'b0; // @ Data.scala l409
      qp_cmd_rsp_expand_sop_reg <= 1'b0; // @ Data.scala l409
      qp_cmd_req_divide_step_value <= 1'b0; // @ Data.scala l409
      qp_cmd_req_divide_ret_valid_regNext <= 1'b0; // @ Data.scala l409
    end else begin
      if(tmp_qp_cmd_rsp_ready) begin
        tmp_qp_cmd_rsp_expand_ret_valid_1 <= qp_cmd_rsp_valid; // @ Stream.scala l365
      end
      qp_cmd_rsp_expand_step_value <= qp_cmd_rsp_expand_step_valueNext; // @ Reg.scala l39
      if((tmp_qp_cmd_rsp_expand_ret_valid_2 && (tmp_qp_cmd_rsp_ready_1 || tmp_qp_cmd_rsp_ready_1))) begin
        if(qp_cmd_rsp_expand_overflow) begin
          qp_cmd_rsp_expand_sop_reg <= 1'b0; // @ Bool.scala l92
        end else begin
          if(tmp_qp_cmd_rsp_expand_ret_payload_sop) begin
            qp_cmd_rsp_expand_sop_reg <= 1'b1; // @ Bool.scala l90
          end
        end
      end
      qp_cmd_req_divide_step_value <= qp_cmd_req_divide_step_valueNext; // @ Reg.scala l39
      qp_cmd_req_divide_ret_valid_regNext <= qp_cmd_req_divide_ret_valid; // @ Reg.scala l39
    end
  end

  always @(posedge clk) begin
    if(tmp_qp_cmd_rsp_ready) begin
      tmp_qp_cmd_rsp_expand_ret_payload_channel <= qp_cmd_rsp_data; // @ Stream.scala l366
      tmp_qp_cmd_rsp_expand_ret_payload_channel_1 <= qp_cmd_rsp_sdb; // @ Stream.scala l366
      tmp_qp_cmd_rsp_expand_ret_payload_channel_2 <= qp_cmd_rsp_empty; // @ Stream.scala l366
      tmp_qp_cmd_rsp_expand_ret_payload_channel_3 <= qp_cmd_rsp_eop; // @ Stream.scala l366
      tmp_qp_cmd_rsp_expand_ret_payload_channel_4 <= qp_cmd_rsp_sop; // @ Stream.scala l366
    end
    if((tmp_qp_cmd_rsp_expand_ret_valid_2 && (tmp_qp_cmd_rsp_ready_1 || tmp_qp_cmd_rsp_ready_1))) begin
      qp_cmd_rsp_expand_data_regs_0 <= tmp_qp_cmd_rsp_expand_data_regs_0; // @ BusExt.scala l34
    end
    if(1'b1) begin
      qp_cmd_req_divide_ret_rPayload_data <= qp_cmd_req_divide_ret_payload_data; // @ AvalonST.scala l146
      qp_cmd_req_divide_ret_rPayload_channel <= qp_cmd_req_divide_ret_payload_channel; // @ AvalonST.scala l146
      qp_cmd_req_divide_ret_rPayload_empty <= qp_cmd_req_divide_ret_payload_empty; // @ AvalonST.scala l146
      qp_cmd_req_divide_ret_rPayload_eop <= qp_cmd_req_divide_ret_payload_eop; // @ AvalonST.scala l146
      qp_cmd_req_divide_ret_rPayload_sop <= qp_cmd_req_divide_ret_payload_sop; // @ AvalonST.scala l146
    end
  end


endmodule
