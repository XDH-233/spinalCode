// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : cmdq_cmd_rsp_divide
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766
// Gen time  : 2024-11-25 11:51:40


module cmdq_cmd_rsp_divide (
  output wire          cmd_rsp_ready,
  input  wire          cmd_rsp_valid,
  input  wire [511:0]  cmd_rsp_payload_data,
  input  wire [34:0]   cmd_rsp_payload_channel,
  input  wire [5:0]    cmd_rsp_payload_empty,
  input  wire          cmd_rsp_payload_eop,
  input  wire          cmd_rsp_payload_sop,
  output wire          rd,
  output wire [4:0]    raddr,
  input  wire [4:0]    db_id_dout,
  input  wire [63:0]   cmdq_phy_base_addr,
  input  wire [63:0]   cmd_out_entry_stored_output_mb_point,
  input  wire [31:0]   cmd_out_entry_stored_output_length,
  input  wire [7:0]    cmd_out_entry_stored_signature,
  input  wire [7:0]    cmd_out_entry_stored_token,
  input  wire          cmd_rsp_dma_wreq_ready,
  output wire          cmd_rsp_dma_wreq_valid,
  output wire [511:0]  cmd_rsp_dma_wreq_payload_data,
  output wire [127:0]  cmd_rsp_dma_wreq_payload_channel,
  output wire [5:0]    cmd_rsp_dma_wreq_payload_empty,
  output wire          cmd_rsp_dma_wreq_payload_eop,
  output wire          cmd_rsp_dma_wreq_payload_sop,
  output wire          cmd_id_finish_valid,
  input  wire          cmd_id_finish_ready,
  output wire [4:0]    cmd_id_finish_payload,
  input  wire          reset,
  input  wire          clk
);

  wire       [223:0]  cmd_rsp_hd_fifo_din;
  wire       [519:0]  cmd_rsp_mb_fifo_din;
  wire                cmd_rsp_hd_fifo_full;
  wire       [223:0]  cmd_rsp_hd_fifo_dout;
  wire                cmd_rsp_hd_fifo_empty;
  wire                cmd_rsp_hd_fifo_almost_empty;
  wire                cmd_rsp_hd_fifo_almost_full;
  wire       [4:0]    cmd_rsp_hd_fifo_usedw;
  wire                cmd_rsp_hd_fifo_overflow;
  wire                cmd_rsp_hd_fifo_underflow;
  wire                cmd_rsp_mb_fifo_full;
  wire       [519:0]  cmd_rsp_mb_fifo_dout;
  wire                cmd_rsp_mb_fifo_empty;
  wire                cmd_rsp_mb_fifo_almost_empty;
  wire                cmd_rsp_mb_fifo_almost_full;
  wire       [4:0]    cmd_rsp_mb_fifo_usedw;
  wire                cmd_rsp_mb_fifo_overflow;
  wire                cmd_rsp_mb_fifo_underflow;
  wire       [5:0]    tmp_divide_cmd_rsp_mb_push_payload_empty;
  wire       [5:0]    tmp_divide_cmd_rsp_mb_push_payload_empty_1;
  wire       [63:0]   tmp_dma_wreq_gen_cmd_hd_dma_addr;
  wire       [63:0]   tmp_dma_wreq_gen_cmd_hd_dma_addr_1;
  wire       [10:0]   tmp_dma_wreq_gen_cmd_hd_dma_addr_2;
  wire       [9:0]    tmp_dma_wreq_gen_cmd_mb_dma_desc_length;
  wire       [0:0]    tmp_cmd_rsp_dma_wreq_payload_channel;
  wire       [86:0]   tmp_cmd_rsp_dma_wreq_payload_channel_1;
  wire       [0:0]    tmp_cmd_rsp_dma_wreq_payload_channel_2;
  wire       [86:0]   tmp_cmd_rsp_dma_wreq_payload_channel_3;
  wire       [31:0]   tmp_cmd_rsp_dma_wreq_payload_data;
  wire       [5:0]    tmp_cmd_rsp_dma_wreq_payload_empty;
  wire       [6:0]    tmp_cmd_rsp_dma_wreq_payload_empty_1;
  wire       [6:0]    tmp_cmd_rsp_dma_wreq_payload_empty_2;
  wire       [5:0]    tmp_cmd_rsp_dma_wreq_payload_empty_3;
  wire       [10:0]   tmp_cmd_rsp_dma_wreq_payload_empty_4;
  wire       [10:0]   tmp_cmd_rsp_dma_wreq_payload_empty_5;
  wire       [6:0]    tmp_cmd_rsp_dma_wreq_payload_empty_6;
  wire       [7:0]    cmd_rsp_sdb_cmd_id;
  wire       [11:0]   cmd_rsp_sdb_opcode;
  wire       [4:0]    cmd_rsp_sdb_blk_num;
  wire       [9:0]    cmd_rsp_sdb_data_len;
  reg                 tmp_cmd_rsp_ready;
  wire                divide_cmd_rsp_pipe_valid;
  reg                 divide_cmd_rsp_pipe_ready;
  wire       [511:0]  divide_cmd_rsp_pipe_payload_data;
  wire       [34:0]   divide_cmd_rsp_pipe_payload_channel;
  wire       [5:0]    divide_cmd_rsp_pipe_payload_empty;
  wire                divide_cmd_rsp_pipe_payload_eop;
  wire                divide_cmd_rsp_pipe_payload_sop;
  reg                 tmp_divide_cmd_rsp_pipe_valid;
  reg        [511:0]  tmp_divide_cmd_rsp_pipe_payload_data;
  reg        [34:0]   tmp_divide_cmd_rsp_pipe_payload_channel;
  reg        [5:0]    tmp_divide_cmd_rsp_pipe_payload_empty;
  reg                 tmp_divide_cmd_rsp_pipe_payload_eop;
  reg                 tmp_divide_cmd_rsp_pipe_payload_sop;
  wire       [127:0]  divide_cmd_rsp_pip_out_inline_data;
  wire       [7:0]    divide_cmd_rsp_pipe_sdb_cmd_id;
  wire       [11:0]   divide_cmd_rsp_pipe_sdb_opcode;
  wire       [4:0]    divide_cmd_rsp_pipe_sdb_blk_num;
  wire       [9:0]    divide_cmd_rsp_pipe_sdb_data_len;
  wire                divide_with_mb_pipe;
  wire                divide_no_eop;
  wire                divide_no_eop_pipe;
  wire       [4:0]    divide_cmd_rsp_header_cmd_id;
  wire       [11:0]   divide_cmd_rsp_header_opcode;
  wire       [9:0]    divide_cmd_rsp_header_data_len;
  wire       [127:0]  divide_cmd_rsp_header_out_inline_data;
  wire       [4:0]    divide_cmd_rsp_header_db_id;
  wire       [63:0]   divide_cmd_rsp_header_out_mb_point;
  wire       [511:0]  divide_cmd_rsp_mb_dat;
  wire                divide_cmd_rsp_hd_push_valid;
  wire                divide_cmd_rsp_hd_push_ready;
  wire       [4:0]    divide_cmd_rsp_hd_push_payload_cmd_id;
  wire       [11:0]   divide_cmd_rsp_hd_push_payload_opcode;
  wire       [9:0]    divide_cmd_rsp_hd_push_payload_data_len;
  wire       [127:0]  divide_cmd_rsp_hd_push_payload_out_inline_data;
  wire       [4:0]    divide_cmd_rsp_hd_push_payload_db_id;
  wire       [63:0]   divide_cmd_rsp_hd_push_payload_out_mb_point;
  wire                divide_cmd_rsp_mb_push_ready;
  reg                 divide_cmd_rsp_mb_push_valid;
  wire       [511:0]  divide_cmd_rsp_mb_push_payload_data;
  wire       [5:0]    divide_cmd_rsp_mb_push_payload_empty;
  reg                 divide_cmd_rsp_mb_push_payload_eop;
  wire                divide_cmd_rsp_mb_push_payload_sop;
  wire                divide_cmd_rsp_with_mb;
  wire       [34:0]   tmp_divide_cmd_rsp_pipe_sdb_cmd_id;
  wire                divide_cmd_rsp_pipe_fire;
  wire                dma_wreq_gen_cmd_rsp_hd_pop_valid;
  wire                dma_wreq_gen_cmd_rsp_hd_pop_ready;
  wire       [4:0]    dma_wreq_gen_cmd_rsp_hd_pop_payload_cmd_id;
  wire       [11:0]   dma_wreq_gen_cmd_rsp_hd_pop_payload_opcode;
  wire       [9:0]    dma_wreq_gen_cmd_rsp_hd_pop_payload_data_len;
  wire       [127:0]  dma_wreq_gen_cmd_rsp_hd_pop_payload_out_inline_data;
  wire       [4:0]    dma_wreq_gen_cmd_rsp_hd_pop_payload_db_id;
  wire       [63:0]   dma_wreq_gen_cmd_rsp_hd_pop_payload_out_mb_point;
  wire                dma_wreq_gen_cmd_rsp_mb_pop_ready;
  wire                dma_wreq_gen_cmd_rsp_mb_pop_valid;
  wire       [511:0]  dma_wreq_gen_cmd_rsp_mb_pop_payload_data;
  wire       [5:0]    dma_wreq_gen_cmd_rsp_mb_pop_payload_empty;
  wire                dma_wreq_gen_cmd_rsp_mb_pop_payload_eop;
  wire                dma_wreq_gen_cmd_rsp_mb_pop_payload_sop;
  wire       [63:0]   dma_wreq_gen_cmd_hd_dma_addr;
  reg        [63:0]   dma_wreq_gen_cmd_hd_dma_desc_addr;
  reg        [16:0]   dma_wreq_gen_cmd_hd_dma_desc_length;
  wire       [5:0]    dma_wreq_gen_cmd_hd_dma_desc_queue_id;
  wire                dma_wreq_gen_cmd_hd_dma_desc_vf_active;
  wire       [10:0]   dma_wreq_gen_cmd_hd_dma_desc_vf_num;
  wire       [4:0]    dma_wreq_gen_cmd_hd_dma_desc_pf_num;
  wire       [4:0]    dma_wreq_gen_cmd_hd_dma_desc_desc_type;
  wire       [16:0]   dma_wreq_gen_cmd_hd_dma_desc_rsv;
  reg        [1:0]    dma_wreq_gen_cmd_hd_dma_desc_tlp_channel_id;
  wire       [127:0]  tmp_dma_wreq_gen_cmd_hd_dma_desc_addr;
  reg        [63:0]   dma_wreq_gen_cmd_mb_dma_desc_addr;
  reg        [16:0]   dma_wreq_gen_cmd_mb_dma_desc_length;
  wire       [5:0]    dma_wreq_gen_cmd_mb_dma_desc_queue_id;
  wire                dma_wreq_gen_cmd_mb_dma_desc_vf_active;
  wire       [10:0]   dma_wreq_gen_cmd_mb_dma_desc_vf_num;
  wire       [4:0]    dma_wreq_gen_cmd_mb_dma_desc_pf_num;
  wire       [4:0]    dma_wreq_gen_cmd_mb_dma_desc_desc_type;
  wire       [16:0]   dma_wreq_gen_cmd_mb_dma_desc_rsv;
  reg        [1:0]    dma_wreq_gen_cmd_mb_dma_desc_tlp_channel_id;
  wire       [127:0]  tmp_dma_wreq_gen_cmd_mb_dma_desc_addr;
  reg        [23:0]   dma_wreq_gen_cmd_hd_dma_data_output_inline_data_rsv;
  reg        [7:0]    dma_wreq_gen_cmd_hd_dma_data_output_inline_data_status;
  reg        [31:0]   dma_wreq_gen_cmd_hd_dma_data_output_inline_data_syndrome;
  reg        [63:0]   dma_wreq_gen_cmd_hd_dma_data_output_inline_data_cmd_output;
  reg        [31:0]   dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high;
  wire       [8:0]    dma_wreq_gen_cmd_hd_dma_data_rsv1;
  reg        [22:0]   dma_wreq_gen_cmd_hd_dma_data_output_mb_point_low;
  reg        [31:0]   dma_wreq_gen_cmd_hd_dma_data_output_length;
  wire                dma_wreq_gen_cmd_hd_dma_data_own;
  wire       [6:0]    dma_wreq_gen_cmd_hd_dma_data_status;
  wire       [7:0]    dma_wreq_gen_cmd_hd_dma_data_rsv0;
  wire       [7:0]    dma_wreq_gen_cmd_hd_dma_data_signature;
  wire       [7:0]    dma_wreq_gen_cmd_hd_dma_data_token;
  reg                 dma_wreq_gen_hd_pop_flag;
  wire                dma_wreq_gen_with_mb_hd_pop;
  wire       [255:0]  tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high;
  wire       [127:0]  tmp_dma_wreq_gen_cmd_hd_dma_data_output_inline_data_rsv;
  wire                dma_wreq_gen_cmd_rsp_hd_pop_fire;
  wire       [34:0]   tmp_cmd_rsp_sdb_cmd_id;
  wire       [23:0]   out_inline_rsv;
  wire       [7:0]    out_inline_status;
  wire       [31:0]   out_inline_syndrome;
  wire       [63:0]   out_inline_cmd_output;

  assign tmp_divide_cmd_rsp_mb_push_payload_empty = (cmd_rsp_payload_empty + 6'h10);
  assign tmp_divide_cmd_rsp_mb_push_payload_empty_1 = (divide_cmd_rsp_pipe_payload_empty + 6'h10);
  assign tmp_dma_wreq_gen_cmd_hd_dma_addr = (cmdq_phy_base_addr + tmp_dma_wreq_gen_cmd_hd_dma_addr_1);
  assign tmp_dma_wreq_gen_cmd_hd_dma_addr_2 = ({6'd0,dma_wreq_gen_cmd_rsp_hd_pop_payload_db_id} <<< 3'd6);
  assign tmp_dma_wreq_gen_cmd_hd_dma_addr_1 = {53'd0, tmp_dma_wreq_gen_cmd_hd_dma_addr_2};
  assign tmp_dma_wreq_gen_cmd_mb_dma_desc_length = (dma_wreq_gen_cmd_rsp_hd_pop_payload_data_len - 10'h010);
  assign tmp_cmd_rsp_dma_wreq_payload_empty_1 = (7'h40 - tmp_cmd_rsp_dma_wreq_payload_empty_2);
  assign tmp_cmd_rsp_dma_wreq_payload_empty = tmp_cmd_rsp_dma_wreq_payload_empty_1[5:0];
  assign tmp_cmd_rsp_dma_wreq_payload_empty_3 = tmp_cmd_rsp_dma_wreq_payload_empty_4[5:0];
  assign tmp_cmd_rsp_dma_wreq_payload_empty_2 = {1'd0, tmp_cmd_rsp_dma_wreq_payload_empty_3};
  assign tmp_cmd_rsp_dma_wreq_payload_empty_4 = ({1'b0,dma_wreq_gen_cmd_rsp_hd_pop_payload_data_len} + tmp_cmd_rsp_dma_wreq_payload_empty_5);
  assign tmp_cmd_rsp_dma_wreq_payload_empty_6 = {1'b0,6'h30};
  assign tmp_cmd_rsp_dma_wreq_payload_empty_5 = {4'd0, tmp_cmd_rsp_dma_wreq_payload_empty_6};
  assign tmp_cmd_rsp_dma_wreq_payload_channel = dma_wreq_gen_cmd_hd_dma_desc_vf_active;
  assign tmp_cmd_rsp_dma_wreq_payload_channel_1 = {dma_wreq_gen_cmd_hd_dma_desc_queue_id,{dma_wreq_gen_cmd_hd_dma_desc_length,dma_wreq_gen_cmd_hd_dma_desc_addr}};
  assign tmp_cmd_rsp_dma_wreq_payload_channel_2 = dma_wreq_gen_cmd_mb_dma_desc_vf_active;
  assign tmp_cmd_rsp_dma_wreq_payload_channel_3 = {dma_wreq_gen_cmd_mb_dma_desc_queue_id,{dma_wreq_gen_cmd_mb_dma_desc_length,dma_wreq_gen_cmd_mb_dma_desc_addr}};
  assign tmp_cmd_rsp_dma_wreq_payload_data = {dma_wreq_gen_cmd_hd_dma_data_output_inline_data_status,dma_wreq_gen_cmd_hd_dma_data_output_inline_data_rsv};
  rdma_ctyun_sfifo #(
    .DEPTH      (32 ),
    .DATA_WIDTH (224)
  ) cmd_rsp_hd_fifo (
    .clk          (clk                              ), //i
    .srst         (reset                            ), //i
    .wr_en        (divide_cmd_rsp_hd_push_valid     ), //i
    .din          (cmd_rsp_hd_fifo_din[223:0]       ), //i
    .full         (cmd_rsp_hd_fifo_full             ), //o
    .rd_en        (dma_wreq_gen_cmd_rsp_hd_pop_ready), //i
    .dout         (cmd_rsp_hd_fifo_dout[223:0]      ), //o
    .empty        (cmd_rsp_hd_fifo_empty            ), //o
    .almost_empty (cmd_rsp_hd_fifo_almost_empty     ), //o
    .almost_full  (cmd_rsp_hd_fifo_almost_full      ), //o
    .usedw        (cmd_rsp_hd_fifo_usedw[4:0]       ), //o
    .overflow     (cmd_rsp_hd_fifo_overflow         ), //o
    .underflow    (cmd_rsp_hd_fifo_underflow        )  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (32 ),
    .DATA_WIDTH (520)
  ) cmd_rsp_mb_fifo (
    .clk          (clk                              ), //i
    .srst         (reset                            ), //i
    .wr_en        (divide_cmd_rsp_mb_push_valid     ), //i
    .din          (cmd_rsp_mb_fifo_din[519:0]       ), //i
    .full         (cmd_rsp_mb_fifo_full             ), //o
    .rd_en        (dma_wreq_gen_cmd_rsp_mb_pop_ready), //i
    .dout         (cmd_rsp_mb_fifo_dout[519:0]      ), //o
    .empty        (cmd_rsp_mb_fifo_empty            ), //o
    .almost_empty (cmd_rsp_mb_fifo_almost_empty     ), //o
    .almost_full  (cmd_rsp_mb_fifo_almost_full      ), //o
    .usedw        (cmd_rsp_mb_fifo_usedw[4:0]       ), //o
    .overflow     (cmd_rsp_mb_fifo_overflow         ), //o
    .underflow    (cmd_rsp_mb_fifo_underflow        )  //o
  );
  assign cmd_rsp_ready = tmp_cmd_rsp_ready; // @ BusExt.scala l121
  always @(*) begin
    tmp_cmd_rsp_ready = divide_cmd_rsp_pipe_ready; // @ Stream.scala l374
    if((! divide_cmd_rsp_pipe_valid)) begin
      tmp_cmd_rsp_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign divide_cmd_rsp_pipe_valid = tmp_divide_cmd_rsp_pipe_valid; // @ Stream.scala l377
  assign divide_cmd_rsp_pipe_payload_data = tmp_divide_cmd_rsp_pipe_payload_data; // @ Stream.scala l378
  assign divide_cmd_rsp_pipe_payload_channel = tmp_divide_cmd_rsp_pipe_payload_channel; // @ Stream.scala l378
  assign divide_cmd_rsp_pipe_payload_empty = tmp_divide_cmd_rsp_pipe_payload_empty; // @ Stream.scala l378
  assign divide_cmd_rsp_pipe_payload_eop = tmp_divide_cmd_rsp_pipe_payload_eop; // @ Stream.scala l378
  assign divide_cmd_rsp_pipe_payload_sop = tmp_divide_cmd_rsp_pipe_payload_sop; // @ Stream.scala l378
  assign divide_cmd_rsp_pip_out_inline_data = divide_cmd_rsp_pipe_payload_data[127 : 0]; // @ BaseType.scala l299
  assign divide_with_mb_pipe = (10'h010 < divide_cmd_rsp_pipe_sdb_data_len); // @ BaseType.scala l305
  assign divide_no_eop = ((cmd_rsp_payload_eop && (6'h30 <= cmd_rsp_payload_empty)) && (! cmd_rsp_payload_sop)); // @ BaseType.scala l305
  assign divide_no_eop_pipe = (divide_cmd_rsp_pipe_payload_eop && (6'h30 <= divide_cmd_rsp_pipe_payload_empty)); // @ BaseType.scala l305
  assign divide_cmd_rsp_with_mb = (10'h010 < cmd_rsp_sdb_data_len); // @ BaseType.scala l305
  assign tmp_divide_cmd_rsp_pipe_sdb_cmd_id = divide_cmd_rsp_pipe_payload_channel; // @ BaseType.scala l318
  assign divide_cmd_rsp_pipe_sdb_cmd_id = tmp_divide_cmd_rsp_pipe_sdb_cmd_id[7 : 0]; // @ UInt.scala l381
  assign divide_cmd_rsp_pipe_sdb_opcode = tmp_divide_cmd_rsp_pipe_sdb_cmd_id[19 : 8]; // @ Bits.scala l133
  assign divide_cmd_rsp_pipe_sdb_blk_num = tmp_divide_cmd_rsp_pipe_sdb_cmd_id[24 : 20]; // @ UInt.scala l381
  assign divide_cmd_rsp_pipe_sdb_data_len = tmp_divide_cmd_rsp_pipe_sdb_cmd_id[34 : 25]; // @ UInt.scala l381
  assign divide_cmd_rsp_header_cmd_id = divide_cmd_rsp_pipe_sdb_cmd_id[4:0]; // @ cmd_rsp_divide.scala l38
  assign divide_cmd_rsp_header_opcode = divide_cmd_rsp_pipe_sdb_opcode; // @ cmd_rsp_divide.scala l39
  assign divide_cmd_rsp_header_data_len = divide_cmd_rsp_pipe_sdb_data_len; // @ cmd_rsp_divide.scala l40
  assign divide_cmd_rsp_header_out_inline_data = divide_cmd_rsp_pip_out_inline_data; // @ cmd_rsp_divide.scala l41
  assign divide_cmd_rsp_header_db_id = db_id_dout; // @ cmd_rsp_divide.scala l42
  assign divide_cmd_rsp_header_out_mb_point = cmd_out_entry_stored_output_mb_point; // @ cmd_rsp_divide.scala l43
  assign divide_cmd_rsp_hd_push_payload_cmd_id = divide_cmd_rsp_header_cmd_id; // @ cmd_rsp_divide.scala l44
  assign divide_cmd_rsp_hd_push_payload_opcode = divide_cmd_rsp_header_opcode; // @ cmd_rsp_divide.scala l44
  assign divide_cmd_rsp_hd_push_payload_data_len = divide_cmd_rsp_header_data_len; // @ cmd_rsp_divide.scala l44
  assign divide_cmd_rsp_hd_push_payload_out_inline_data = divide_cmd_rsp_header_out_inline_data; // @ cmd_rsp_divide.scala l44
  assign divide_cmd_rsp_hd_push_payload_db_id = divide_cmd_rsp_header_db_id; // @ cmd_rsp_divide.scala l44
  assign divide_cmd_rsp_hd_push_payload_out_mb_point = divide_cmd_rsp_header_out_mb_point; // @ cmd_rsp_divide.scala l44
  assign divide_cmd_rsp_pipe_fire = (divide_cmd_rsp_pipe_valid && divide_cmd_rsp_pipe_ready); // @ BaseType.scala l305
  assign divide_cmd_rsp_hd_push_valid = (divide_cmd_rsp_pipe_fire && divide_cmd_rsp_pipe_payload_sop); // @ cmd_rsp_divide.scala l45
  assign divide_cmd_rsp_mb_dat = {cmd_rsp_payload_data[127 : 0],divide_cmd_rsp_pipe_payload_data[511 : 128]}; // @ cmd_rsp_divide.scala l47
  assign divide_cmd_rsp_mb_push_payload_sop = divide_cmd_rsp_pipe_payload_sop; // @ cmd_rsp_divide.scala l48
  assign divide_cmd_rsp_mb_push_payload_data = divide_cmd_rsp_mb_dat; // @ cmd_rsp_divide.scala l49
  assign divide_cmd_rsp_mb_push_payload_empty = (divide_cmd_rsp_mb_push_payload_eop ? (divide_no_eop_pipe ? tmp_divide_cmd_rsp_mb_push_payload_empty : tmp_divide_cmd_rsp_mb_push_payload_empty_1) : 6'h0); // @ cmd_rsp_divide.scala l50
  always @(*) begin
    if(divide_with_mb_pipe) begin
      if(divide_cmd_rsp_pipe_payload_eop) begin
        divide_cmd_rsp_mb_push_payload_eop = (! divide_no_eop_pipe); // @ cmd_rsp_divide.scala l54
      end else begin
        if(cmd_rsp_payload_eop) begin
          divide_cmd_rsp_mb_push_payload_eop = divide_no_eop; // @ cmd_rsp_divide.scala l56
        end else begin
          divide_cmd_rsp_mb_push_payload_eop = 1'b0; // @ Bool.scala l92
        end
      end
    end else begin
      divide_cmd_rsp_mb_push_payload_eop = 1'b1; // @ Bool.scala l90
    end
  end

  always @(*) begin
    if(divide_with_mb_pipe) begin
      if(divide_cmd_rsp_pipe_payload_eop) begin
        divide_cmd_rsp_mb_push_valid = ((! divide_no_eop_pipe) && divide_cmd_rsp_pipe_valid); // @ cmd_rsp_divide.scala l66
      end else begin
        divide_cmd_rsp_mb_push_valid = (divide_cmd_rsp_pipe_valid && divide_cmd_rsp_pipe_valid); // @ cmd_rsp_divide.scala l68
      end
    end else begin
      divide_cmd_rsp_mb_push_valid = 1'b0; // @ Bool.scala l92
    end
  end

  always @(*) begin
    if(divide_cmd_rsp_pipe_payload_sop) begin
      if(divide_with_mb_pipe) begin
        divide_cmd_rsp_pipe_ready = (divide_cmd_rsp_hd_push_ready && divide_cmd_rsp_mb_push_ready); // @ cmd_rsp_divide.scala l76
      end else begin
        divide_cmd_rsp_pipe_ready = divide_cmd_rsp_mb_push_ready; // @ cmd_rsp_divide.scala l78
      end
    end else begin
      divide_cmd_rsp_pipe_ready = (divide_cmd_rsp_mb_push_ready || divide_no_eop_pipe); // @ cmd_rsp_divide.scala l81
    end
  end

  assign cmd_rsp_hd_fifo_din = {divide_cmd_rsp_hd_push_payload_out_mb_point,{divide_cmd_rsp_hd_push_payload_db_id,{divide_cmd_rsp_hd_push_payload_out_inline_data,{divide_cmd_rsp_hd_push_payload_data_len,{divide_cmd_rsp_hd_push_payload_opcode,divide_cmd_rsp_hd_push_payload_cmd_id}}}}}; // @ rdma_ctyun_sfifo.scala l34
  assign divide_cmd_rsp_hd_push_ready = (! cmd_rsp_hd_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign dma_wreq_gen_cmd_rsp_hd_pop_valid = (! cmd_rsp_hd_fifo_empty); // @ rdma_ctyun_sfifo.scala l39
  assign dma_wreq_gen_cmd_rsp_hd_pop_payload_cmd_id = cmd_rsp_hd_fifo_dout[4 : 0]; // @ UInt.scala l381
  assign dma_wreq_gen_cmd_rsp_hd_pop_payload_opcode = cmd_rsp_hd_fifo_dout[16 : 5]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_rsp_hd_pop_payload_data_len = cmd_rsp_hd_fifo_dout[26 : 17]; // @ UInt.scala l381
  assign dma_wreq_gen_cmd_rsp_hd_pop_payload_out_inline_data = cmd_rsp_hd_fifo_dout[154 : 27]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_rsp_hd_pop_payload_db_id = cmd_rsp_hd_fifo_dout[159 : 155]; // @ UInt.scala l381
  assign dma_wreq_gen_cmd_rsp_hd_pop_payload_out_mb_point = cmd_rsp_hd_fifo_dout[223 : 160]; // @ UInt.scala l381
  assign cmd_rsp_mb_fifo_din = {divide_cmd_rsp_mb_push_payload_sop,{divide_cmd_rsp_mb_push_payload_eop,{divide_cmd_rsp_mb_push_payload_empty,divide_cmd_rsp_mb_push_payload_data}}}; // @ rdma_ctyun_sfifo.scala l46
  assign divide_cmd_rsp_mb_push_ready = (! cmd_rsp_mb_fifo_full); // @ rdma_ctyun_sfifo.scala l47
  assign dma_wreq_gen_cmd_rsp_mb_pop_valid = (! cmd_rsp_mb_fifo_empty); // @ rdma_ctyun_sfifo.scala l51
  assign dma_wreq_gen_cmd_rsp_mb_pop_payload_data = cmd_rsp_mb_fifo_dout[511 : 0]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_rsp_mb_pop_payload_empty = cmd_rsp_mb_fifo_dout[517 : 512]; // @ UInt.scala l381
  assign dma_wreq_gen_cmd_rsp_mb_pop_payload_eop = cmd_rsp_mb_fifo_dout[518]; // @ Bool.scala l209
  assign dma_wreq_gen_cmd_rsp_mb_pop_payload_sop = cmd_rsp_mb_fifo_dout[519]; // @ Bool.scala l209
  assign dma_wreq_gen_cmd_hd_dma_addr = (tmp_dma_wreq_gen_cmd_hd_dma_addr + 64'h0000000000000020); // @ BaseType.scala l299
  assign tmp_dma_wreq_gen_cmd_hd_dma_desc_addr = 128'h0; // @ Expression.scala l2327
  always @(*) begin
    dma_wreq_gen_cmd_hd_dma_desc_addr = tmp_dma_wreq_gen_cmd_hd_dma_desc_addr[63 : 0]; // @ UInt.scala l381
    dma_wreq_gen_cmd_hd_dma_desc_addr = dma_wreq_gen_cmd_hd_dma_addr; // @ CmdqBundles.scala l241
  end

  always @(*) begin
    dma_wreq_gen_cmd_hd_dma_desc_length = tmp_dma_wreq_gen_cmd_hd_dma_desc_addr[80 : 64]; // @ UInt.scala l381
    dma_wreq_gen_cmd_hd_dma_desc_length = 17'h00020; // @ CmdqBundles.scala l242
  end

  assign dma_wreq_gen_cmd_hd_dma_desc_queue_id = tmp_dma_wreq_gen_cmd_hd_dma_desc_addr[86 : 81]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_hd_dma_desc_vf_active = tmp_dma_wreq_gen_cmd_hd_dma_desc_addr[87]; // @ Bool.scala l209
  assign dma_wreq_gen_cmd_hd_dma_desc_vf_num = tmp_dma_wreq_gen_cmd_hd_dma_desc_addr[98 : 88]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_hd_dma_desc_pf_num = tmp_dma_wreq_gen_cmd_hd_dma_desc_addr[103 : 99]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_hd_dma_desc_desc_type = tmp_dma_wreq_gen_cmd_hd_dma_desc_addr[108 : 104]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_hd_dma_desc_rsv = tmp_dma_wreq_gen_cmd_hd_dma_desc_addr[125 : 109]; // @ Bits.scala l133
  always @(*) begin
    dma_wreq_gen_cmd_hd_dma_desc_tlp_channel_id = tmp_dma_wreq_gen_cmd_hd_dma_desc_addr[127 : 126]; // @ Bits.scala l133
    dma_wreq_gen_cmd_hd_dma_desc_tlp_channel_id = 2'b10; // @ CmdqBundles.scala l243
  end

  assign tmp_dma_wreq_gen_cmd_mb_dma_desc_addr = 128'h0; // @ Expression.scala l2327
  always @(*) begin
    dma_wreq_gen_cmd_mb_dma_desc_addr = tmp_dma_wreq_gen_cmd_mb_dma_desc_addr[63 : 0]; // @ UInt.scala l381
    dma_wreq_gen_cmd_mb_dma_desc_addr = dma_wreq_gen_cmd_rsp_hd_pop_payload_out_mb_point; // @ CmdqBundles.scala l241
  end

  always @(*) begin
    dma_wreq_gen_cmd_mb_dma_desc_length = tmp_dma_wreq_gen_cmd_mb_dma_desc_addr[80 : 64]; // @ UInt.scala l381
    dma_wreq_gen_cmd_mb_dma_desc_length = {7'd0, tmp_dma_wreq_gen_cmd_mb_dma_desc_length}; // @ CmdqBundles.scala l242
  end

  assign dma_wreq_gen_cmd_mb_dma_desc_queue_id = tmp_dma_wreq_gen_cmd_mb_dma_desc_addr[86 : 81]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_mb_dma_desc_vf_active = tmp_dma_wreq_gen_cmd_mb_dma_desc_addr[87]; // @ Bool.scala l209
  assign dma_wreq_gen_cmd_mb_dma_desc_vf_num = tmp_dma_wreq_gen_cmd_mb_dma_desc_addr[98 : 88]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_mb_dma_desc_pf_num = tmp_dma_wreq_gen_cmd_mb_dma_desc_addr[103 : 99]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_mb_dma_desc_desc_type = tmp_dma_wreq_gen_cmd_mb_dma_desc_addr[108 : 104]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_mb_dma_desc_rsv = tmp_dma_wreq_gen_cmd_mb_dma_desc_addr[125 : 109]; // @ Bits.scala l133
  always @(*) begin
    dma_wreq_gen_cmd_mb_dma_desc_tlp_channel_id = tmp_dma_wreq_gen_cmd_mb_dma_desc_addr[127 : 126]; // @ Bits.scala l133
    dma_wreq_gen_cmd_mb_dma_desc_tlp_channel_id = 2'b10; // @ CmdqBundles.scala l243
  end

  assign dma_wreq_gen_with_mb_hd_pop = (10'h011 < dma_wreq_gen_cmd_rsp_hd_pop_payload_data_len); // @ BaseType.scala l305
  assign tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high = 256'h0; // @ BitVector.scala l494
  assign tmp_dma_wreq_gen_cmd_hd_dma_data_output_inline_data_rsv = tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high[127 : 0]; // @ BaseType.scala l299
  always @(*) begin
    dma_wreq_gen_cmd_hd_dma_data_output_inline_data_rsv = tmp_dma_wreq_gen_cmd_hd_dma_data_output_inline_data_rsv[23 : 0]; // @ Bits.scala l133
    dma_wreq_gen_cmd_hd_dma_data_output_inline_data_rsv = dma_wreq_gen_cmd_rsp_hd_pop_payload_out_inline_data[23 : 0]; // @ Bits.scala l133
  end

  always @(*) begin
    dma_wreq_gen_cmd_hd_dma_data_output_inline_data_status = tmp_dma_wreq_gen_cmd_hd_dma_data_output_inline_data_rsv[31 : 24]; // @ Bits.scala l133
    dma_wreq_gen_cmd_hd_dma_data_output_inline_data_status = dma_wreq_gen_cmd_rsp_hd_pop_payload_out_inline_data[31 : 24]; // @ Bits.scala l133
  end

  always @(*) begin
    dma_wreq_gen_cmd_hd_dma_data_output_inline_data_syndrome = tmp_dma_wreq_gen_cmd_hd_dma_data_output_inline_data_rsv[63 : 32]; // @ Bits.scala l133
    dma_wreq_gen_cmd_hd_dma_data_output_inline_data_syndrome = dma_wreq_gen_cmd_rsp_hd_pop_payload_out_inline_data[63 : 32]; // @ Bits.scala l133
  end

  always @(*) begin
    dma_wreq_gen_cmd_hd_dma_data_output_inline_data_cmd_output = tmp_dma_wreq_gen_cmd_hd_dma_data_output_inline_data_rsv[127 : 64]; // @ Bits.scala l133
    dma_wreq_gen_cmd_hd_dma_data_output_inline_data_cmd_output = dma_wreq_gen_cmd_rsp_hd_pop_payload_out_inline_data[127 : 64]; // @ Bits.scala l133
  end

  always @(*) begin
    dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high = tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high[159 : 128]; // @ Bits.scala l133
    dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high = dma_wreq_gen_cmd_rsp_hd_pop_payload_out_mb_point[63 : 32]; // @ cmd_rsp_divide.scala l101
  end

  assign dma_wreq_gen_cmd_hd_dma_data_rsv1 = tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high[168 : 160]; // @ Bits.scala l133
  always @(*) begin
    dma_wreq_gen_cmd_hd_dma_data_output_mb_point_low = tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high[191 : 169]; // @ Bits.scala l133
    dma_wreq_gen_cmd_hd_dma_data_output_mb_point_low = dma_wreq_gen_cmd_rsp_hd_pop_payload_out_mb_point[31 : 9]; // @ cmd_rsp_divide.scala l102
  end

  always @(*) begin
    dma_wreq_gen_cmd_hd_dma_data_output_length = tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high[223 : 192]; // @ UInt.scala l381
    dma_wreq_gen_cmd_hd_dma_data_output_length = {22'd0, dma_wreq_gen_cmd_rsp_hd_pop_payload_data_len}; // @ cmd_rsp_divide.scala l100
  end

  assign dma_wreq_gen_cmd_hd_dma_data_own = tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high[224]; // @ Bool.scala l209
  assign dma_wreq_gen_cmd_hd_dma_data_status = tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high[231 : 225]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_hd_dma_data_rsv0 = tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high[239 : 232]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_hd_dma_data_signature = tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high[247 : 240]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_hd_dma_data_token = tmp_dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high[255 : 248]; // @ Bits.scala l133
  assign dma_wreq_gen_cmd_rsp_hd_pop_fire = (dma_wreq_gen_cmd_rsp_hd_pop_valid && dma_wreq_gen_cmd_rsp_hd_pop_ready); // @ BaseType.scala l305
  assign dma_wreq_gen_cmd_rsp_hd_pop_ready = ((dma_wreq_gen_with_mb_hd_pop ? dma_wreq_gen_hd_pop_flag : 1'b1) && cmd_rsp_dma_wreq_ready); // @ cmd_rsp_divide.scala l110
  assign dma_wreq_gen_cmd_rsp_mb_pop_ready = ((cmd_rsp_dma_wreq_ready && dma_wreq_gen_with_mb_hd_pop) && (! dma_wreq_gen_hd_pop_flag)); // @ cmd_rsp_divide.scala l112
  assign cmd_rsp_dma_wreq_payload_sop = (dma_wreq_gen_with_mb_hd_pop ? (dma_wreq_gen_cmd_rsp_mb_pop_payload_sop || dma_wreq_gen_hd_pop_flag) : 1'b1); // @ cmd_rsp_divide.scala l113
  assign cmd_rsp_dma_wreq_payload_eop = (dma_wreq_gen_with_mb_hd_pop ? (dma_wreq_gen_hd_pop_flag ? 1'b1 : dma_wreq_gen_cmd_rsp_mb_pop_payload_eop) : 1'b1); // @ cmd_rsp_divide.scala l114
  assign cmd_rsp_dma_wreq_payload_channel = (((! dma_wreq_gen_with_mb_hd_pop) || dma_wreq_gen_hd_pop_flag) ? {dma_wreq_gen_cmd_hd_dma_desc_tlp_channel_id,{dma_wreq_gen_cmd_hd_dma_desc_rsv,{dma_wreq_gen_cmd_hd_dma_desc_desc_type,{dma_wreq_gen_cmd_hd_dma_desc_pf_num,{dma_wreq_gen_cmd_hd_dma_desc_vf_num,{tmp_cmd_rsp_dma_wreq_payload_channel,tmp_cmd_rsp_dma_wreq_payload_channel_1}}}}}} : {dma_wreq_gen_cmd_mb_dma_desc_tlp_channel_id,{dma_wreq_gen_cmd_mb_dma_desc_rsv,{dma_wreq_gen_cmd_mb_dma_desc_desc_type,{dma_wreq_gen_cmd_mb_dma_desc_pf_num,{dma_wreq_gen_cmd_mb_dma_desc_vf_num,{tmp_cmd_rsp_dma_wreq_payload_channel_2,tmp_cmd_rsp_dma_wreq_payload_channel_3}}}}}}); // @ cmd_rsp_divide.scala l115
  assign cmd_rsp_dma_wreq_payload_data = (((! dma_wreq_gen_with_mb_hd_pop) || dma_wreq_gen_hd_pop_flag) ? {256'h0,{dma_wreq_gen_cmd_hd_dma_data_token,{dma_wreq_gen_cmd_hd_dma_data_signature,{dma_wreq_gen_cmd_hd_dma_data_rsv0,{dma_wreq_gen_cmd_hd_dma_data_status,{dma_wreq_gen_cmd_hd_dma_data_own,{dma_wreq_gen_cmd_hd_dma_data_output_length,{dma_wreq_gen_cmd_hd_dma_data_output_mb_point_low,{dma_wreq_gen_cmd_hd_dma_data_rsv1,{dma_wreq_gen_cmd_hd_dma_data_output_mb_point_high,{dma_wreq_gen_cmd_hd_dma_data_output_inline_data_cmd_output,{dma_wreq_gen_cmd_hd_dma_data_output_inline_data_syndrome,tmp_cmd_rsp_dma_wreq_payload_data}}}}}}}}}}}} : dma_wreq_gen_cmd_rsp_mb_pop_payload_data); // @ cmd_rsp_divide.scala l116
  assign cmd_rsp_dma_wreq_payload_empty = (cmd_rsp_dma_wreq_payload_eop ? (((! dma_wreq_gen_with_mb_hd_pop) || dma_wreq_gen_hd_pop_flag) ? 6'h20 : tmp_cmd_rsp_dma_wreq_payload_empty) : 6'h0); // @ cmd_rsp_divide.scala l117
  assign cmd_rsp_dma_wreq_valid = ((dma_wreq_gen_with_mb_hd_pop && (! dma_wreq_gen_hd_pop_flag)) ? dma_wreq_gen_cmd_rsp_mb_pop_valid : dma_wreq_gen_cmd_rsp_hd_pop_valid); // @ cmd_rsp_divide.scala l122
  assign rd = (cmd_rsp_payload_sop && cmd_rsp_valid); // @ cmd_rsp_divide.scala l125
  assign raddr = cmd_rsp_sdb_cmd_id[4:0]; // @ cmd_rsp_divide.scala l126
  assign tmp_cmd_rsp_sdb_cmd_id = cmd_rsp_payload_channel; // @ BaseType.scala l318
  assign cmd_rsp_sdb_cmd_id = tmp_cmd_rsp_sdb_cmd_id[7 : 0]; // @ UInt.scala l381
  assign cmd_rsp_sdb_opcode = tmp_cmd_rsp_sdb_cmd_id[19 : 8]; // @ Bits.scala l133
  assign cmd_rsp_sdb_blk_num = tmp_cmd_rsp_sdb_cmd_id[24 : 20]; // @ UInt.scala l381
  assign cmd_rsp_sdb_data_len = tmp_cmd_rsp_sdb_cmd_id[34 : 25]; // @ UInt.scala l381
  assign cmd_id_finish_valid = dma_wreq_gen_cmd_rsp_hd_pop_fire; // @ cmd_rsp_divide.scala l129
  assign cmd_id_finish_payload = dma_wreq_gen_cmd_rsp_hd_pop_payload_cmd_id; // @ cmd_rsp_divide.scala l130
  assign out_inline_rsv = dma_wreq_gen_cmd_rsp_hd_pop_payload_out_inline_data[23 : 0]; // @ Bits.scala l133
  assign out_inline_status = dma_wreq_gen_cmd_rsp_hd_pop_payload_out_inline_data[31 : 24]; // @ Bits.scala l133
  assign out_inline_syndrome = dma_wreq_gen_cmd_rsp_hd_pop_payload_out_inline_data[63 : 32]; // @ Bits.scala l133
  assign out_inline_cmd_output = dma_wreq_gen_cmd_rsp_hd_pop_payload_out_inline_data[127 : 64]; // @ Bits.scala l133
  always @(posedge clk) begin
    if(reset) begin
      tmp_divide_cmd_rsp_pipe_valid <= 1'b0; // @ Data.scala l409
      dma_wreq_gen_hd_pop_flag <= 1'b0; // @ Data.scala l409
    end else begin
      if(tmp_cmd_rsp_ready) begin
        tmp_divide_cmd_rsp_pipe_valid <= cmd_rsp_valid; // @ Stream.scala l365
      end
      if(((dma_wreq_gen_with_mb_hd_pop && dma_wreq_gen_cmd_rsp_mb_pop_payload_eop) && (dma_wreq_gen_cmd_rsp_mb_pop_valid && (dma_wreq_gen_cmd_rsp_mb_pop_ready || dma_wreq_gen_cmd_rsp_mb_pop_ready)))) begin
        dma_wreq_gen_hd_pop_flag <= 1'b1; // @ Bool.scala l90
      end else begin
        if(dma_wreq_gen_cmd_rsp_hd_pop_fire) begin
          dma_wreq_gen_hd_pop_flag <= 1'b0; // @ Bool.scala l92
        end
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! (dma_wreq_gen_cmd_rsp_hd_pop_fire && ((out_inline_status != 8'h0) || (out_inline_syndrome != 32'h0))))); // cmd_rsp_divide.scala:L135
        `else
          if(!(! (dma_wreq_gen_cmd_rsp_hd_pop_fire && ((out_inline_status != 8'h0) || (out_inline_syndrome != 32'h0))))) begin
            $display("WARNING %t Cmd rsp error: status:%x, syndrome:%x", $time, out_inline_status, out_inline_syndrome); // cmd_rsp_divide.scala:L135
          end
        `endif
      `endif
    end
  end

  always @(posedge clk) begin
    if(tmp_cmd_rsp_ready) begin
      tmp_divide_cmd_rsp_pipe_payload_data <= cmd_rsp_payload_data; // @ Stream.scala l366
      tmp_divide_cmd_rsp_pipe_payload_channel <= cmd_rsp_payload_channel; // @ Stream.scala l366
      tmp_divide_cmd_rsp_pipe_payload_empty <= cmd_rsp_payload_empty; // @ Stream.scala l366
      tmp_divide_cmd_rsp_pipe_payload_eop <= cmd_rsp_payload_eop; // @ Stream.scala l366
      tmp_divide_cmd_rsp_pipe_payload_sop <= cmd_rsp_payload_sop; // @ Stream.scala l366
    end
  end


endmodule
