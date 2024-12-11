// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : cmdq_cmd_req_gen
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766
// Gen time  : 2024-11-25 11:51:40


module cmdq_cmd_req_gen (
  input  wire          cmdqe_elements_valid,
  output wire          cmdqe_elements_ready,
  input  wire [4:0]    cmdqe_elements_payload_cmd_id,
  input  wire [7:0]    cmdqe_elements_payload_input_len,
  input  wire [15:0]   cmdqe_elements_payload_cmd_inline_data_uid,
  input  wire [15:0]   cmdqe_elements_payload_cmd_inline_data_opcode,
  input  wire [15:0]   cmdqe_elements_payload_cmd_inline_data_op_mod,
  input  wire [15:0]   cmdqe_elements_payload_cmd_inline_data_rsv,
  input  wire [63:0]   cmdqe_elements_payload_cmd_inline_data_inline_cmd,
  output wire          mb_dma_rrsp_ready,
  input  wire          mb_dma_rrsp_valid,
  input  wire [511:0]  mb_dma_rrsp_payload_data,
  input  wire [127:0]  mb_dma_rrsp_payload_channel,
  input  wire [5:0]    mb_dma_rrsp_payload_empty,
  input  wire          mb_dma_rrsp_payload_eop,
  input  wire          mb_dma_rrsp_payload_sop,
  input  wire          cmd_req_ready,
  output wire          cmd_req_valid,
  output wire [511:0]  cmd_req_payload_data,
  output wire [24:0]   cmd_req_payload_channel,
  output reg  [5:0]    cmd_req_payload_empty,
  output wire          cmd_req_payload_eop,
  output wire          cmd_req_payload_sop,
  input  wire          clk,
  input  wire          reset
);

  wire       [15:0]   tmp_tmp_mb_check_pkt_size_payload;
  wire       [15:0]   tmp_tmp_mb_check_pkt_size_payload_1;
  wire       [15:0]   tmp_mb_len_err;
  wire       [15:0]   tmp_mb_len_err_1;
  wire       [127:0]  header;
  wire       [383:0]  low_part;
  reg        [127:0]  high_tail;
  wire                with_mb_i;
  wire                concat_done;
  wire       [511:0]  cmd_req_data;
  wire                empty_overflow;
  reg                 extra_blk;
  wire       [7:0]    cmd_req_sdb_cmd_id;
  wire       [11:0]   cmd_req_sdb_opcode;
  wire       [4:0]    cmd_req_sdb_blk_num;
  reg        [5:0]    tmp_cmd_req_payload_empty;
  reg                 mb_check_dup_sop;
  reg                 mb_check_channel_changed;
  reg                 mb_check_trans_outside;
  reg        [15:0]   mb_check_pkt_byte_cnt;
  wire                mb_check_pkt_size_valid;
  wire       [15:0]   mb_check_pkt_size_payload;
  reg        [31:0]   mb_check_pkt_count;
  wire                mb_check_fire;
  reg                 mb_check_soped;
  reg        [127:0]  mb_check_channel_reg;
  reg        [15:0]   tmp_mb_check_pkt_size_payload;
  reg                 tmp_mb_check_pkt_size_valid;
  reg        [7:0]    input_len_reg;
  wire                mb_len_err;

  assign tmp_tmp_mb_check_pkt_size_payload = (mb_check_pkt_byte_cnt + 16'h0040);
  assign tmp_tmp_mb_check_pkt_size_payload_1 = {10'd0, mb_dma_rrsp_payload_empty};
  assign tmp_mb_len_err = {8'd0, input_len_reg};
  assign tmp_mb_len_err_1 = (mb_check_pkt_size_payload + 16'h0010);
  assign with_mb_i = (8'h10 < cmdqe_elements_payload_input_len); // @ BaseType.scala l305
  assign empty_overflow = ((mb_dma_rrsp_payload_eop && (6'h10 <= mb_dma_rrsp_payload_empty)) && mb_dma_rrsp_valid); // @ BaseType.scala l305
  assign low_part = mb_dma_rrsp_payload_data[383 : 0]; // @ cmd_req_gen.scala l31
  assign header = (mb_dma_rrsp_payload_sop ? {cmdqe_elements_payload_cmd_inline_data_inline_cmd,{cmdqe_elements_payload_cmd_inline_data_rsv,{cmdqe_elements_payload_cmd_inline_data_op_mod,{cmdqe_elements_payload_cmd_inline_data_opcode,cmdqe_elements_payload_cmd_inline_data_uid}}}} : high_tail); // @ cmd_req_gen.scala l32
  assign cmd_req_data = (extra_blk ? {384'h0,high_tail} : (with_mb_i ? {low_part,header} : {384'h0,{cmdqe_elements_payload_cmd_inline_data_inline_cmd,{cmdqe_elements_payload_cmd_inline_data_rsv,{cmdqe_elements_payload_cmd_inline_data_op_mod,{cmdqe_elements_payload_cmd_inline_data_opcode,cmdqe_elements_payload_cmd_inline_data_uid}}}}})); // @ cmd_req_gen.scala l33
  assign cmd_req_sdb_cmd_id = {3'd0, cmdqe_elements_payload_cmd_id}; // @ cmd_req_gen.scala l35
  assign cmd_req_sdb_blk_num = 5'h0; // @ BitVector.scala l494
  assign cmd_req_sdb_opcode = cmdqe_elements_payload_cmd_inline_data_opcode[11:0]; // @ cmd_req_gen.scala l37
  assign concat_done = (empty_overflow || extra_blk); // @ cmd_req_gen.scala l39
  assign cmdqe_elements_ready = ((((! with_mb_i) || concat_done) && cmd_req_ready) && cmdqe_elements_valid); // @ cmd_req_gen.scala l40
  assign mb_dma_rrsp_ready = (cmd_req_ready && (! extra_blk)); // @ cmd_req_gen.scala l41
  assign cmd_req_payload_data = cmd_req_data; // @ cmd_req_gen.scala l43
  assign cmd_req_payload_sop = (with_mb_i ? (mb_dma_rrsp_payload_sop && mb_dma_rrsp_valid) : 1'b1); // @ cmd_req_gen.scala l44
  assign cmd_req_payload_eop = ((! with_mb_i) || concat_done); // @ cmd_req_gen.scala l45
  assign cmd_req_payload_channel = {cmd_req_sdb_blk_num,{cmd_req_sdb_opcode,cmd_req_sdb_cmd_id}}; // @ cmd_req_gen.scala l46
  assign cmd_req_valid = (with_mb_i ? ((cmdqe_elements_valid && mb_dma_rrsp_valid) || extra_blk) : cmdqe_elements_valid); // @ cmd_req_gen.scala l47
  always @(*) begin
    if(cmd_req_payload_eop) begin
      if(with_mb_i) begin
        if(empty_overflow) begin
          cmd_req_payload_empty = (mb_dma_rrsp_payload_empty + 6'h30); // @ cmd_req_gen.scala l51
        end else begin
          cmd_req_payload_empty = tmp_cmd_req_payload_empty; // @ cmd_req_gen.scala l53
        end
      end else begin
        cmd_req_payload_empty = 6'h30; // @ cmd_req_gen.scala l56
      end
    end else begin
      cmd_req_payload_empty = 6'h0; // @ BitVector.scala l494
    end
  end

  assign mb_check_fire = (mb_dma_rrsp_valid && (mb_dma_rrsp_ready || mb_dma_rrsp_ready)); // @ BaseType.scala l305
  assign mb_check_pkt_size_payload = tmp_mb_check_pkt_size_payload; // @ BusExt.scala l187
  assign mb_check_pkt_size_valid = tmp_mb_check_pkt_size_valid; // @ BusExt.scala l191
  assign mb_len_err = (mb_check_pkt_size_valid && (tmp_mb_len_err != tmp_mb_len_err_1)); // @ BaseType.scala l305
  always @(posedge clk) begin
    if((mb_dma_rrsp_valid && (mb_dma_rrsp_ready || mb_dma_rrsp_ready))) begin
      high_tail <= mb_dma_rrsp_payload_data[511 : 384]; // @ cmd_req_gen.scala l23
    end
    extra_blk <= ((mb_dma_rrsp_payload_eop && (mb_dma_rrsp_payload_empty < 6'h10)) && (mb_dma_rrsp_valid && (mb_dma_rrsp_ready || mb_dma_rrsp_ready))); // @ Reg.scala l39
    mb_check_channel_reg <= mb_dma_rrsp_payload_channel; // @ Reg.scala l39
    input_len_reg <= cmdqe_elements_payload_input_len; // @ Reg.scala l39
  end

  always @(posedge clk) begin
    tmp_cmd_req_payload_empty <= (mb_dma_rrsp_payload_empty + 6'h30); // @ Reg.scala l39
  end

  always @(posedge clk) begin
    if(reset) begin
      mb_check_dup_sop <= 1'b0; // @ Data.scala l409
      mb_check_channel_changed <= 1'b0; // @ Data.scala l409
      mb_check_trans_outside <= 1'b0; // @ Data.scala l409
      mb_check_pkt_byte_cnt <= 16'h0; // @ Data.scala l409
      mb_check_pkt_count <= 32'h0; // @ Data.scala l409
      mb_check_soped <= 1'b0; // @ Data.scala l409
      tmp_mb_check_pkt_size_payload <= 16'h0; // @ Data.scala l409
      tmp_mb_check_pkt_size_valid <= 1'b0; // @ Data.scala l409
    end else begin
      if((mb_dma_rrsp_payload_eop && mb_check_fire)) begin
        mb_check_soped <= 1'b0; // @ BusExt.scala l170
      end
      if(((mb_dma_rrsp_payload_sop && (! mb_dma_rrsp_payload_eop)) && mb_check_fire)) begin
        mb_check_soped <= 1'b1; // @ BusExt.scala l170
      end
      mb_check_dup_sop <= ((mb_check_fire && mb_dma_rrsp_payload_sop) && mb_check_soped); // @ BusExt.scala l171
      mb_check_channel_changed <= ((mb_check_fire && mb_check_soped) && (mb_check_channel_reg != mb_dma_rrsp_payload_channel)); // @ BusExt.scala l173
      mb_check_trans_outside <= ((mb_check_fire && (! mb_check_soped)) && (! mb_dma_rrsp_payload_sop)); // @ BusExt.scala l174
      if((mb_dma_rrsp_payload_eop && mb_check_fire)) begin
        mb_check_pkt_count <= (mb_check_pkt_count + 32'h00000001); // @ BusExt.scala l176
      end
      if(mb_check_fire) begin
        if(mb_dma_rrsp_payload_eop) begin
          mb_check_pkt_byte_cnt <= 16'h0; // @ BitVector.scala l494
        end else begin
          mb_check_pkt_byte_cnt <= (mb_check_pkt_byte_cnt + 16'h0040); // @ BusExt.scala l183
        end
      end
      tmp_mb_check_pkt_size_payload <= (tmp_tmp_mb_check_pkt_size_payload - tmp_tmp_mb_check_pkt_size_payload_1); // @ Reg.scala l39
      tmp_mb_check_pkt_size_valid <= (mb_dma_rrsp_payload_eop && mb_check_fire); // @ Reg.scala l39
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! mb_check_dup_sop)); // BusExt.scala:L192
        `else
          if(!(! mb_check_dup_sop)) begin
            $display("WARNING %t mb_dma_rrsp received duplicated sop!", $time); // BusExt.scala:L192
          end
        `endif
      `endif
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! mb_check_channel_changed)); // BusExt.scala:L193
        `else
          if(!(! mb_check_channel_changed)) begin
            $display("WARNING %t mb_dma_rrsp channel changed during trans!", $time); // BusExt.scala:L193
          end
        `endif
      `endif
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! mb_check_trans_outside)); // BusExt.scala:L194
        `else
          if(!(! mb_check_trans_outside)) begin
            $display("WARNING %t mb_dma_rrsp transfer a word outside!", $time); // BusExt.scala:L194
          end
        `endif
      `endif
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! mb_len_err)); // cmd_req_gen.scala:L65
        `else
          if(!(! mb_len_err)) begin
            $display("WARNING %t Mb received data size err: %x", $time, mb_check_pkt_size_payload); // cmd_req_gen.scala:L65
          end
        `endif
      `endif
    end
  end


endmodule
