// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : crrl_top
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766


module crrl_top (
  input  wire          create_qp_clr_req_valid,
  output wire          create_qp_clr_req_ready,
  input  wire [282:0]  create_qp_clr_req_payload,
  input  wire          tx_wqe_wr_req_valid,
  output wire          tx_wqe_wr_req_ready,
  input  wire [282:0]  tx_wqe_wr_req_payload,
  input  wire          rx_pkt_rd_req_valid,
  output wire          rx_pkt_rd_req_ready,
  input  wire [282:0]  rx_pkt_rd_req_payload,
  input  wire          rx_wqe_wr_req_valid,
  output wire          rx_wqe_wr_req_ready,
  input  wire [282:0]  rx_wqe_wr_req_payload,
  input  wire          db_sche_rd_req_valid,
  output wire          db_sche_rd_req_ready,
  input  wire [282:0]  db_sche_rd_req_payload,
  output wire          creat_qp_clr_rsp_valid,
  input  wire          creat_qp_clr_rsp_ready,
  output wire [282:0]  creat_qp_clr_rsp_payload,
  output wire          tx_wqe_wr_rsp_valid,
  input  wire          tx_wqe_wr_rsp_ready,
  output wire [282:0]  tx_wqe_wr_rsp_payload,
  output wire          rx_pkt_rd_rsp_valid,
  input  wire          rx_pkt_rd_rsp_ready,
  output wire [282:0]  rx_pkt_rd_rsp_payload,
  output wire          rx_wqe_wr_rsp_valid,
  input  wire          rx_wqe_wr_rsp_ready,
  output wire [282:0]  rx_wqe_wr_rsp_payload,
  output wire          db_sche_rd_rsp_valid,
  input  wire          db_sche_rd_rsp_ready,
  output wire [282:0]  db_sche_rd_rsp_payload,
  input  wire          clk,
  input  wire          reset
);

  wire       [282:0]  streamDemux_io_input_payload;
  wire                streamArbiter_io_inputs_0_ready;
  wire                streamArbiter_io_inputs_1_ready;
  wire                streamArbiter_io_inputs_2_ready;
  wire                streamArbiter_io_inputs_3_ready;
  wire                streamArbiter_io_inputs_4_ready;
  wire                streamArbiter_io_output_valid;
  wire       [282:0]  streamArbiter_io_output_payload;
  wire       [2:0]    streamArbiter_io_chosen;
  wire       [4:0]    streamArbiter_io_chosenOH;
  wire                crrl_update_inst_crrl_req_ready;
  wire                crrl_update_inst_crrl_rsp_valid;
  wire       [4:0]    crrl_update_inst_crrl_rsp_payload_crr_state_id_state_crrl_cnt;
  wire       [23:0]   crrl_update_inst_crrl_rsp_payload_crr_state_id_state_ssn;
  wire                crrl_update_inst_crrl_rsp_payload_crr_state_id_state_ce_bit;
  wire       [23:0]   crrl_update_inst_crrl_rsp_payload_crr_state_id_state_last_psn;
  wire       [23:0]   crrl_update_inst_crrl_rsp_payload_crr_state_id_state_first_psn;
  wire                crrl_update_inst_crrl_rsp_payload_crr_state_it_state_finish_flag;
  wire                crrl_update_inst_crrl_rsp_payload_crr_state_it_state_interrupt_bit;
  wire       [31:0]   crrl_update_inst_crrl_rsp_payload_crr_state_it_state_dma_length;
  wire       [31:0]   crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sqe_rkey;
  wire       [63:0]   crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sqe_va;
  wire       [2:0]    crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sge_num;
  wire       [7:0]    crrl_update_inst_crrl_rsp_payload_crr_state_it_state_last_rd_rsp_opcode;
  wire       [15:0]   crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sq_wqe_index;
  wire       [3:0]    crrl_update_inst_crrl_rsp_payload_crrl_sdb_module_id;
  wire       [11:0]   crrl_update_inst_crrl_rsp_payload_crrl_sdb_req_id;
  wire       [23:0]   crrl_update_inst_crrl_rsp_payload_crrl_sdb_qpn;
  wire       [3:0]    crrl_update_inst_crrl_rsp_payload_crrl_sdb_req_type;
  wire       [3:0]    crrl_update_inst_crrl_rsp_payload_crrl_sdb_status;
  wire                streamDemux_io_input_ready;
  wire                streamDemux_io_outputs_0_valid;
  wire       [282:0]  streamDemux_io_outputs_0_payload;
  wire                streamDemux_io_outputs_1_valid;
  wire       [282:0]  streamDemux_io_outputs_1_payload;
  wire                streamDemux_io_outputs_2_valid;
  wire       [282:0]  streamDemux_io_outputs_2_payload;
  wire                streamDemux_io_outputs_3_valid;
  wire       [282:0]  streamDemux_io_outputs_3_payload;
  wire                streamDemux_io_outputs_4_valid;
  wire       [282:0]  streamDemux_io_outputs_4_payload;
  wire       [63:0]   tmp_io_input_payload;
  wire       [65:0]   tmp_io_input_payload_1;
  wire       [23:0]   tmp_io_input_payload_2;
  wire       [4:0]    tmp_io_input_payload_3;
  wire                sched_req_bits_valid;
  wire                sched_req_bits_ready;
  wire       [282:0]  sched_req_bits_payload;
  reg        [2:0]    sel;
  wire                sched_req_bits_bits_valid;
  wire                sched_req_bits_bits_ready;
  wire       [4:0]    sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt;
  wire       [23:0]   sched_req_bits_bits_payload_crr_state_id_state_ssn;
  wire                sched_req_bits_bits_payload_crr_state_id_state_ce_bit;
  wire       [23:0]   sched_req_bits_bits_payload_crr_state_id_state_last_psn;
  wire       [23:0]   sched_req_bits_bits_payload_crr_state_id_state_first_psn;
  wire                sched_req_bits_bits_payload_crr_state_it_state_finish_flag;
  wire                sched_req_bits_bits_payload_crr_state_it_state_interrupt_bit;
  wire       [31:0]   sched_req_bits_bits_payload_crr_state_it_state_dma_length;
  wire       [31:0]   sched_req_bits_bits_payload_crr_state_it_state_sqe_rkey;
  wire       [63:0]   sched_req_bits_bits_payload_crr_state_it_state_sqe_va;
  wire       [2:0]    sched_req_bits_bits_payload_crr_state_it_state_sge_num;
  wire       [7:0]    sched_req_bits_bits_payload_crr_state_it_state_last_rd_rsp_opcode;
  wire       [15:0]   sched_req_bits_bits_payload_crr_state_it_state_sq_wqe_index;
  wire       [3:0]    sched_req_bits_bits_payload_crrl_sdb_module_id;
  wire       [11:0]   sched_req_bits_bits_payload_crrl_sdb_req_id;
  wire       [23:0]   sched_req_bits_bits_payload_crrl_sdb_qpn;
  wire       [3:0]    sched_req_bits_bits_payload_crrl_sdb_req_type;
  wire       [3:0]    sched_req_bits_bits_payload_crrl_sdb_status;
  wire       [234:0]  tmp_sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt;
  wire       [77:0]   tmp_sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt_1;
  wire       [156:0]  tmp_sched_req_bits_bits_payload_crr_state_it_state_finish_flag;
  wire       [47:0]   tmp_sched_req_bits_bits_payload_crrl_sdb_module_id;

  assign tmp_io_input_payload = crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sqe_va;
  assign tmp_io_input_payload_1 = {crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sqe_rkey,{crrl_update_inst_crrl_rsp_payload_crr_state_it_state_dma_length,{crrl_update_inst_crrl_rsp_payload_crr_state_it_state_interrupt_bit,crrl_update_inst_crrl_rsp_payload_crr_state_it_state_finish_flag}}};
  assign tmp_io_input_payload_2 = crrl_update_inst_crrl_rsp_payload_crr_state_id_state_ssn;
  assign tmp_io_input_payload_3 = crrl_update_inst_crrl_rsp_payload_crr_state_id_state_crrl_cnt;
  crrl_StreamArbiter streamArbiter (
    .io_inputs_0_valid   (create_qp_clr_req_valid               ), //i
    .io_inputs_0_ready   (streamArbiter_io_inputs_0_ready       ), //o
    .io_inputs_0_payload (create_qp_clr_req_payload[282:0]      ), //i
    .io_inputs_1_valid   (tx_wqe_wr_req_valid                   ), //i
    .io_inputs_1_ready   (streamArbiter_io_inputs_1_ready       ), //o
    .io_inputs_1_payload (tx_wqe_wr_req_payload[282:0]          ), //i
    .io_inputs_2_valid   (rx_pkt_rd_req_valid                   ), //i
    .io_inputs_2_ready   (streamArbiter_io_inputs_2_ready       ), //o
    .io_inputs_2_payload (rx_pkt_rd_req_payload[282:0]          ), //i
    .io_inputs_3_valid   (rx_wqe_wr_req_valid                   ), //i
    .io_inputs_3_ready   (streamArbiter_io_inputs_3_ready       ), //o
    .io_inputs_3_payload (rx_wqe_wr_req_payload[282:0]          ), //i
    .io_inputs_4_valid   (db_sche_rd_req_valid                  ), //i
    .io_inputs_4_ready   (streamArbiter_io_inputs_4_ready       ), //o
    .io_inputs_4_payload (db_sche_rd_req_payload[282:0]         ), //i
    .io_output_valid     (streamArbiter_io_output_valid         ), //o
    .io_output_ready     (sched_req_bits_ready                  ), //i
    .io_output_payload   (streamArbiter_io_output_payload[282:0]), //o
    .io_chosen           (streamArbiter_io_chosen[2:0]          ), //o
    .io_chosenOH         (streamArbiter_io_chosenOH[4:0]        ), //o
    .clk                 (clk                                   ), //i
    .reset               (reset                                 )  //i
  );
  crrl_update crrl_update_inst (
    .crrl_req_valid                                         (sched_req_bits_bits_valid                                                   ), //i
    .crrl_req_ready                                         (crrl_update_inst_crrl_req_ready                                             ), //o
    .crrl_req_payload_crr_state_id_state_crrl_cnt           (sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt[4:0]                ), //i
    .crrl_req_payload_crr_state_id_state_ssn                (sched_req_bits_bits_payload_crr_state_id_state_ssn[23:0]                    ), //i
    .crrl_req_payload_crr_state_id_state_ce_bit             (sched_req_bits_bits_payload_crr_state_id_state_ce_bit                       ), //i
    .crrl_req_payload_crr_state_id_state_last_psn           (sched_req_bits_bits_payload_crr_state_id_state_last_psn[23:0]               ), //i
    .crrl_req_payload_crr_state_id_state_first_psn          (sched_req_bits_bits_payload_crr_state_id_state_first_psn[23:0]              ), //i
    .crrl_req_payload_crr_state_it_state_finish_flag        (sched_req_bits_bits_payload_crr_state_it_state_finish_flag                  ), //i
    .crrl_req_payload_crr_state_it_state_interrupt_bit      (sched_req_bits_bits_payload_crr_state_it_state_interrupt_bit                ), //i
    .crrl_req_payload_crr_state_it_state_dma_length         (sched_req_bits_bits_payload_crr_state_it_state_dma_length[31:0]             ), //i
    .crrl_req_payload_crr_state_it_state_sqe_rkey           (sched_req_bits_bits_payload_crr_state_it_state_sqe_rkey[31:0]               ), //i
    .crrl_req_payload_crr_state_it_state_sqe_va             (sched_req_bits_bits_payload_crr_state_it_state_sqe_va[63:0]                 ), //i
    .crrl_req_payload_crr_state_it_state_sge_num            (sched_req_bits_bits_payload_crr_state_it_state_sge_num[2:0]                 ), //i
    .crrl_req_payload_crr_state_it_state_last_rd_rsp_opcode (sched_req_bits_bits_payload_crr_state_it_state_last_rd_rsp_opcode[7:0]      ), //i
    .crrl_req_payload_crr_state_it_state_sq_wqe_index       (sched_req_bits_bits_payload_crr_state_it_state_sq_wqe_index[15:0]           ), //i
    .crrl_req_payload_crrl_sdb_module_id                    (sched_req_bits_bits_payload_crrl_sdb_module_id[3:0]                         ), //i
    .crrl_req_payload_crrl_sdb_req_id                       (sched_req_bits_bits_payload_crrl_sdb_req_id[11:0]                           ), //i
    .crrl_req_payload_crrl_sdb_qpn                          (sched_req_bits_bits_payload_crrl_sdb_qpn[23:0]                              ), //i
    .crrl_req_payload_crrl_sdb_req_type                     (sched_req_bits_bits_payload_crrl_sdb_req_type[3:0]                          ), //i
    .crrl_req_payload_crrl_sdb_status                       (sched_req_bits_bits_payload_crrl_sdb_status[3:0]                            ), //i
    .crrl_rsp_valid                                         (crrl_update_inst_crrl_rsp_valid                                             ), //o
    .crrl_rsp_ready                                         (streamDemux_io_input_ready                                                  ), //i
    .crrl_rsp_payload_crr_state_id_state_crrl_cnt           (crrl_update_inst_crrl_rsp_payload_crr_state_id_state_crrl_cnt[4:0]          ), //o
    .crrl_rsp_payload_crr_state_id_state_ssn                (crrl_update_inst_crrl_rsp_payload_crr_state_id_state_ssn[23:0]              ), //o
    .crrl_rsp_payload_crr_state_id_state_ce_bit             (crrl_update_inst_crrl_rsp_payload_crr_state_id_state_ce_bit                 ), //o
    .crrl_rsp_payload_crr_state_id_state_last_psn           (crrl_update_inst_crrl_rsp_payload_crr_state_id_state_last_psn[23:0]         ), //o
    .crrl_rsp_payload_crr_state_id_state_first_psn          (crrl_update_inst_crrl_rsp_payload_crr_state_id_state_first_psn[23:0]        ), //o
    .crrl_rsp_payload_crr_state_it_state_finish_flag        (crrl_update_inst_crrl_rsp_payload_crr_state_it_state_finish_flag            ), //o
    .crrl_rsp_payload_crr_state_it_state_interrupt_bit      (crrl_update_inst_crrl_rsp_payload_crr_state_it_state_interrupt_bit          ), //o
    .crrl_rsp_payload_crr_state_it_state_dma_length         (crrl_update_inst_crrl_rsp_payload_crr_state_it_state_dma_length[31:0]       ), //o
    .crrl_rsp_payload_crr_state_it_state_sqe_rkey           (crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sqe_rkey[31:0]         ), //o
    .crrl_rsp_payload_crr_state_it_state_sqe_va             (crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sqe_va[63:0]           ), //o
    .crrl_rsp_payload_crr_state_it_state_sge_num            (crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sge_num[2:0]           ), //o
    .crrl_rsp_payload_crr_state_it_state_last_rd_rsp_opcode (crrl_update_inst_crrl_rsp_payload_crr_state_it_state_last_rd_rsp_opcode[7:0]), //o
    .crrl_rsp_payload_crr_state_it_state_sq_wqe_index       (crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sq_wqe_index[15:0]     ), //o
    .crrl_rsp_payload_crrl_sdb_module_id                    (crrl_update_inst_crrl_rsp_payload_crrl_sdb_module_id[3:0]                   ), //o
    .crrl_rsp_payload_crrl_sdb_req_id                       (crrl_update_inst_crrl_rsp_payload_crrl_sdb_req_id[11:0]                     ), //o
    .crrl_rsp_payload_crrl_sdb_qpn                          (crrl_update_inst_crrl_rsp_payload_crrl_sdb_qpn[23:0]                        ), //o
    .crrl_rsp_payload_crrl_sdb_req_type                     (crrl_update_inst_crrl_rsp_payload_crrl_sdb_req_type[3:0]                    ), //o
    .crrl_rsp_payload_crrl_sdb_status                       (crrl_update_inst_crrl_rsp_payload_crrl_sdb_status[3:0]                      ), //o
    .clk                                                    (clk                                                                         ), //i
    .reset                                                  (reset                                                                       )  //i
  );
  crrl_StreamDemux streamDemux (
    .io_select            (sel[2:0]                               ), //i
    .io_input_valid       (crrl_update_inst_crrl_rsp_valid        ), //i
    .io_input_ready       (streamDemux_io_input_ready             ), //o
    .io_input_payload     (streamDemux_io_input_payload[282:0]    ), //i
    .io_outputs_0_valid   (streamDemux_io_outputs_0_valid         ), //o
    .io_outputs_0_ready   (creat_qp_clr_rsp_ready                 ), //i
    .io_outputs_0_payload (streamDemux_io_outputs_0_payload[282:0]), //o
    .io_outputs_1_valid   (streamDemux_io_outputs_1_valid         ), //o
    .io_outputs_1_ready   (tx_wqe_wr_rsp_ready                    ), //i
    .io_outputs_1_payload (streamDemux_io_outputs_1_payload[282:0]), //o
    .io_outputs_2_valid   (streamDemux_io_outputs_2_valid         ), //o
    .io_outputs_2_ready   (rx_pkt_rd_rsp_ready                    ), //i
    .io_outputs_2_payload (streamDemux_io_outputs_2_payload[282:0]), //o
    .io_outputs_3_valid   (streamDemux_io_outputs_3_valid         ), //o
    .io_outputs_3_ready   (rx_wqe_wr_rsp_ready                    ), //i
    .io_outputs_3_payload (streamDemux_io_outputs_3_payload[282:0]), //o
    .io_outputs_4_valid   (streamDemux_io_outputs_4_valid         ), //o
    .io_outputs_4_ready   (db_sche_rd_rsp_ready                   ), //i
    .io_outputs_4_payload (streamDemux_io_outputs_4_payload[282:0])  //o
  );
  assign create_qp_clr_req_ready = streamArbiter_io_inputs_0_ready; // @ Stream.scala l299
  assign tx_wqe_wr_req_ready = streamArbiter_io_inputs_1_ready; // @ Stream.scala l299
  assign rx_pkt_rd_req_ready = streamArbiter_io_inputs_2_ready; // @ Stream.scala l299
  assign rx_wqe_wr_req_ready = streamArbiter_io_inputs_3_ready; // @ Stream.scala l299
  assign db_sche_rd_req_ready = streamArbiter_io_inputs_4_ready; // @ Stream.scala l299
  assign sched_req_bits_valid = streamArbiter_io_output_valid; // @ Stream.scala l298
  assign sched_req_bits_payload = streamArbiter_io_output_payload; // @ Stream.scala l300
  assign streamDemux_io_input_payload = {{crrl_update_inst_crrl_rsp_payload_crrl_sdb_status,{crrl_update_inst_crrl_rsp_payload_crrl_sdb_req_type,{crrl_update_inst_crrl_rsp_payload_crrl_sdb_qpn,{crrl_update_inst_crrl_rsp_payload_crrl_sdb_req_id,crrl_update_inst_crrl_rsp_payload_crrl_sdb_module_id}}}},{{crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sq_wqe_index,{crrl_update_inst_crrl_rsp_payload_crr_state_it_state_last_rd_rsp_opcode,{crrl_update_inst_crrl_rsp_payload_crr_state_it_state_sge_num,{tmp_io_input_payload,tmp_io_input_payload_1}}}},{crrl_update_inst_crrl_rsp_payload_crr_state_id_state_first_psn,{crrl_update_inst_crrl_rsp_payload_crr_state_id_state_last_psn,{crrl_update_inst_crrl_rsp_payload_crr_state_id_state_ce_bit,{tmp_io_input_payload_2,tmp_io_input_payload_3}}}}}}; // @ Stream.scala l300
  assign sched_req_bits_bits_valid = sched_req_bits_valid; // @ BusExt.scala l24
  assign tmp_sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt = sched_req_bits_payload[234 : 0]; // @ BaseType.scala l299
  assign tmp_sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt_1 = tmp_sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt[77 : 0]; // @ BaseType.scala l299
  assign sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt = tmp_sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt_1[4 : 0]; // @ UInt.scala l381
  assign sched_req_bits_bits_payload_crr_state_id_state_ssn = tmp_sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt_1[28 : 5]; // @ UInt.scala l381
  assign sched_req_bits_bits_payload_crr_state_id_state_ce_bit = tmp_sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt_1[29]; // @ Bool.scala l209
  assign sched_req_bits_bits_payload_crr_state_id_state_last_psn = tmp_sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt_1[53 : 30]; // @ UInt.scala l381
  assign sched_req_bits_bits_payload_crr_state_id_state_first_psn = tmp_sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt_1[77 : 54]; // @ UInt.scala l381
  assign tmp_sched_req_bits_bits_payload_crr_state_it_state_finish_flag = tmp_sched_req_bits_bits_payload_crr_state_id_state_crrl_cnt[234 : 78]; // @ BaseType.scala l299
  assign sched_req_bits_bits_payload_crr_state_it_state_finish_flag = tmp_sched_req_bits_bits_payload_crr_state_it_state_finish_flag[0]; // @ Bool.scala l209
  assign sched_req_bits_bits_payload_crr_state_it_state_interrupt_bit = tmp_sched_req_bits_bits_payload_crr_state_it_state_finish_flag[1]; // @ Bool.scala l209
  assign sched_req_bits_bits_payload_crr_state_it_state_dma_length = tmp_sched_req_bits_bits_payload_crr_state_it_state_finish_flag[33 : 2]; // @ UInt.scala l381
  assign sched_req_bits_bits_payload_crr_state_it_state_sqe_rkey = tmp_sched_req_bits_bits_payload_crr_state_it_state_finish_flag[65 : 34]; // @ Bits.scala l133
  assign sched_req_bits_bits_payload_crr_state_it_state_sqe_va = tmp_sched_req_bits_bits_payload_crr_state_it_state_finish_flag[129 : 66]; // @ UInt.scala l381
  assign sched_req_bits_bits_payload_crr_state_it_state_sge_num = tmp_sched_req_bits_bits_payload_crr_state_it_state_finish_flag[132 : 130]; // @ UInt.scala l381
  assign sched_req_bits_bits_payload_crr_state_it_state_last_rd_rsp_opcode = tmp_sched_req_bits_bits_payload_crr_state_it_state_finish_flag[140 : 133]; // @ Bits.scala l133
  assign sched_req_bits_bits_payload_crr_state_it_state_sq_wqe_index = tmp_sched_req_bits_bits_payload_crr_state_it_state_finish_flag[156 : 141]; // @ UInt.scala l381
  assign tmp_sched_req_bits_bits_payload_crrl_sdb_module_id = sched_req_bits_payload[282 : 235]; // @ BaseType.scala l299
  assign sched_req_bits_bits_payload_crrl_sdb_module_id = tmp_sched_req_bits_bits_payload_crrl_sdb_module_id[3 : 0]; // @ Bits.scala l133
  assign sched_req_bits_bits_payload_crrl_sdb_req_id = tmp_sched_req_bits_bits_payload_crrl_sdb_module_id[15 : 4]; // @ Bits.scala l133
  assign sched_req_bits_bits_payload_crrl_sdb_qpn = tmp_sched_req_bits_bits_payload_crrl_sdb_module_id[39 : 16]; // @ Bits.scala l133
  assign sched_req_bits_bits_payload_crrl_sdb_req_type = tmp_sched_req_bits_bits_payload_crrl_sdb_module_id[43 : 40]; // @ Bits.scala l133
  assign sched_req_bits_bits_payload_crrl_sdb_status = tmp_sched_req_bits_bits_payload_crrl_sdb_module_id[47 : 44]; // @ Bits.scala l133
  assign sched_req_bits_ready = sched_req_bits_bits_ready; // @ BusExt.scala l26
  assign sched_req_bits_bits_ready = crrl_update_inst_crrl_req_ready; // @ crrl_top.scala l33
  always @(*) begin
    case(crrl_update_inst_crrl_rsp_payload_crrl_sdb_module_id)
      4'b0110 : begin
        sel = 3'b000; // @ crrl_top.scala l35
      end
      4'b0011 : begin
        sel = 3'b001; // @ crrl_top.scala l36
      end
      4'b0001 : begin
        sel = 3'b010; // @ crrl_top.scala l37
      end
      4'b0100 : begin
        sel = 3'b011; // @ crrl_top.scala l38
      end
      4'b0000 : begin
        sel = 3'b100; // @ crrl_top.scala l39
      end
      default : begin
        sel = 3'b111; // @ crrl_top.scala l40
      end
    endcase
  end

  assign creat_qp_clr_rsp_valid = streamDemux_io_outputs_0_valid; // @ crrl_top.scala l42
  assign creat_qp_clr_rsp_payload = streamDemux_io_outputs_0_payload; // @ crrl_top.scala l42
  assign tx_wqe_wr_rsp_valid = streamDemux_io_outputs_1_valid; // @ crrl_top.scala l43
  assign tx_wqe_wr_rsp_payload = streamDemux_io_outputs_1_payload; // @ crrl_top.scala l43
  assign rx_pkt_rd_rsp_valid = streamDemux_io_outputs_2_valid; // @ crrl_top.scala l44
  assign rx_pkt_rd_rsp_payload = streamDemux_io_outputs_2_payload; // @ crrl_top.scala l44
  assign rx_wqe_wr_rsp_valid = streamDemux_io_outputs_3_valid; // @ crrl_top.scala l45
  assign rx_wqe_wr_rsp_payload = streamDemux_io_outputs_3_payload; // @ crrl_top.scala l45
  assign db_sche_rd_rsp_valid = streamDemux_io_outputs_4_valid; // @ crrl_top.scala l46
  assign db_sche_rd_rsp_payload = streamDemux_io_outputs_4_payload; // @ crrl_top.scala l46

endmodule
