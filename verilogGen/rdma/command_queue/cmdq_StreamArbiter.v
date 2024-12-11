// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : cmdq_StreamArbiter
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766
// Gen time  : 2024-11-25 11:51:40


module cmdq_StreamArbiter (
  input  wire          io_inputs_0_valid,
  output wire          io_inputs_0_ready,
  input  wire [511:0]  io_inputs_0_payload_data,
  input  wire [34:0]   io_inputs_0_payload_channel,
  input  wire [5:0]    io_inputs_0_payload_empty,
  input  wire          io_inputs_0_payload_eop,
  input  wire          io_inputs_0_payload_sop,
  input  wire          io_inputs_1_valid,
  output wire          io_inputs_1_ready,
  input  wire [511:0]  io_inputs_1_payload_data,
  input  wire [34:0]   io_inputs_1_payload_channel,
  input  wire [5:0]    io_inputs_1_payload_empty,
  input  wire          io_inputs_1_payload_eop,
  input  wire          io_inputs_1_payload_sop,
  input  wire          io_inputs_2_valid,
  output wire          io_inputs_2_ready,
  input  wire [511:0]  io_inputs_2_payload_data,
  input  wire [34:0]   io_inputs_2_payload_channel,
  input  wire [5:0]    io_inputs_2_payload_empty,
  input  wire          io_inputs_2_payload_eop,
  input  wire          io_inputs_2_payload_sop,
  input  wire          io_inputs_3_valid,
  output wire          io_inputs_3_ready,
  input  wire [511:0]  io_inputs_3_payload_data,
  input  wire [34:0]   io_inputs_3_payload_channel,
  input  wire [5:0]    io_inputs_3_payload_empty,
  input  wire          io_inputs_3_payload_eop,
  input  wire          io_inputs_3_payload_sop,
  output wire          io_output_valid,
  input  wire          io_output_ready,
  output wire [511:0]  io_output_payload_data,
  output wire [34:0]   io_output_payload_channel,
  output wire [5:0]    io_output_payload_empty,
  output wire          io_output_payload_eop,
  output wire          io_output_payload_sop,
  output wire [1:0]    io_chosen,
  output wire [3:0]    io_chosenOH,
  input  wire          clk,
  input  wire          reset
);

  wire       [7:0]    tmp_tmp_maskProposal_0_2;
  wire       [7:0]    tmp_tmp_maskProposal_0_2_1;
  wire       [3:0]    tmp_tmp_maskProposal_0_2_2;
  reg        [511:0]  tmp_io_output_payload_data_3;
  reg        [34:0]   tmp_io_output_payload_channel;
  reg        [5:0]    tmp_io_output_payload_empty;
  reg                 tmp_io_output_payload_eop;
  reg                 tmp_io_output_payload_sop;
  reg                 locked;
  wire                maskProposal_0;
  wire                maskProposal_1;
  wire                maskProposal_2;
  wire                maskProposal_3;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  reg                 maskLocked_2;
  reg                 maskLocked_3;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire                maskRouted_2;
  wire                maskRouted_3;
  wire                io_output_fire;
  wire       [3:0]    tmp_maskProposal_0;
  wire       [7:0]    tmp_maskProposal_0_1;
  wire       [7:0]    tmp_maskProposal_0_2;
  wire       [3:0]    tmp_maskProposal_0_3;
  wire                tmp_io_output_payload_data;
  wire                tmp_io_output_payload_data_1;
  wire       [1:0]    tmp_io_output_payload_data_2;
  wire                tmp_io_chosen;
  wire                tmp_io_chosen_1;
  wire                tmp_io_chosen_2;

  assign tmp_tmp_maskProposal_0_2 = (tmp_maskProposal_0_1 - tmp_tmp_maskProposal_0_2_1);
  assign tmp_tmp_maskProposal_0_2_2 = {maskLocked_2,{maskLocked_1,{maskLocked_0,maskLocked_3}}};
  assign tmp_tmp_maskProposal_0_2_1 = {4'd0, tmp_tmp_maskProposal_0_2_2};
  always @(*) begin
    case(tmp_io_output_payload_data_2)
      2'b00 : begin
        tmp_io_output_payload_data_3 = io_inputs_0_payload_data;
        tmp_io_output_payload_channel = io_inputs_0_payload_channel;
        tmp_io_output_payload_empty = io_inputs_0_payload_empty;
        tmp_io_output_payload_eop = io_inputs_0_payload_eop;
        tmp_io_output_payload_sop = io_inputs_0_payload_sop;
      end
      2'b01 : begin
        tmp_io_output_payload_data_3 = io_inputs_1_payload_data;
        tmp_io_output_payload_channel = io_inputs_1_payload_channel;
        tmp_io_output_payload_empty = io_inputs_1_payload_empty;
        tmp_io_output_payload_eop = io_inputs_1_payload_eop;
        tmp_io_output_payload_sop = io_inputs_1_payload_sop;
      end
      2'b10 : begin
        tmp_io_output_payload_data_3 = io_inputs_2_payload_data;
        tmp_io_output_payload_channel = io_inputs_2_payload_channel;
        tmp_io_output_payload_empty = io_inputs_2_payload_empty;
        tmp_io_output_payload_eop = io_inputs_2_payload_eop;
        tmp_io_output_payload_sop = io_inputs_2_payload_sop;
      end
      default : begin
        tmp_io_output_payload_data_3 = io_inputs_3_payload_data;
        tmp_io_output_payload_channel = io_inputs_3_payload_channel;
        tmp_io_output_payload_empty = io_inputs_3_payload_empty;
        tmp_io_output_payload_eop = io_inputs_3_payload_eop;
        tmp_io_output_payload_sop = io_inputs_3_payload_sop;
      end
    endcase
  end

  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0); // @ Expression.scala l1444
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1); // @ Expression.scala l1444
  assign maskRouted_2 = (locked ? maskLocked_2 : maskProposal_2); // @ Expression.scala l1444
  assign maskRouted_3 = (locked ? maskLocked_3 : maskProposal_3); // @ Expression.scala l1444
  assign io_output_fire = (io_output_valid && io_output_ready); // @ BaseType.scala l305
  assign tmp_maskProposal_0 = {io_inputs_3_valid,{io_inputs_2_valid,{io_inputs_1_valid,io_inputs_0_valid}}}; // @ BaseType.scala l318
  assign tmp_maskProposal_0_1 = {tmp_maskProposal_0,tmp_maskProposal_0}; // @ BaseType.scala l318
  assign tmp_maskProposal_0_2 = (tmp_maskProposal_0_1 & (~ tmp_tmp_maskProposal_0_2)); // @ BaseType.scala l299
  assign tmp_maskProposal_0_3 = (tmp_maskProposal_0_2[7 : 4] | tmp_maskProposal_0_2[3 : 0]); // @ BaseType.scala l318
  assign maskProposal_0 = tmp_maskProposal_0_3[0]; // @ Stream.scala l652
  assign maskProposal_1 = tmp_maskProposal_0_3[1]; // @ Stream.scala l652
  assign maskProposal_2 = tmp_maskProposal_0_3[2]; // @ Stream.scala l652
  assign maskProposal_3 = tmp_maskProposal_0_3[3]; // @ Stream.scala l652
  assign io_output_valid = ((((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1)) || (io_inputs_2_valid && maskRouted_2)) || (io_inputs_3_valid && maskRouted_3)); // @ Stream.scala l714
  assign tmp_io_output_payload_data = (maskRouted_1 || maskRouted_3); // @ BaseType.scala l305
  assign tmp_io_output_payload_data_1 = (maskRouted_2 || maskRouted_3); // @ BaseType.scala l305
  assign tmp_io_output_payload_data_2 = {tmp_io_output_payload_data_1,tmp_io_output_payload_data}; // @ BaseType.scala l318
  assign io_output_payload_data = tmp_io_output_payload_data_3; // @ Stream.scala l715
  assign io_output_payload_channel = tmp_io_output_payload_channel; // @ Stream.scala l715
  assign io_output_payload_empty = tmp_io_output_payload_empty; // @ Stream.scala l715
  assign io_output_payload_eop = tmp_io_output_payload_eop; // @ Stream.scala l715
  assign io_output_payload_sop = tmp_io_output_payload_sop; // @ Stream.scala l715
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready); // @ Stream.scala l716
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready); // @ Stream.scala l716
  assign io_inputs_2_ready = (maskRouted_2 && io_output_ready); // @ Stream.scala l716
  assign io_inputs_3_ready = (maskRouted_3 && io_output_ready); // @ Stream.scala l716
  assign io_chosenOH = {maskRouted_3,{maskRouted_2,{maskRouted_1,maskRouted_0}}}; // @ Stream.scala l718
  assign tmp_io_chosen = io_chosenOH[3]; // @ BaseType.scala l305
  assign tmp_io_chosen_1 = (io_chosenOH[1] || tmp_io_chosen); // @ BaseType.scala l305
  assign tmp_io_chosen_2 = (io_chosenOH[2] || tmp_io_chosen); // @ BaseType.scala l305
  assign io_chosen = {tmp_io_chosen_2,tmp_io_chosen_1}; // @ Stream.scala l719
  always @(posedge clk) begin
    if(reset) begin
      locked <= 1'b0; // @ Data.scala l409
      maskLocked_0 <= 1'b0; // @ Data.scala l409
      maskLocked_1 <= 1'b0; // @ Data.scala l409
      maskLocked_2 <= 1'b0; // @ Data.scala l409
      maskLocked_3 <= 1'b1; // @ Data.scala l409
    end else begin
      if(io_output_valid) begin
        maskLocked_0 <= maskRouted_0; // @ Stream.scala l708
        maskLocked_1 <= maskRouted_1; // @ Stream.scala l708
        maskLocked_2 <= maskRouted_2; // @ Stream.scala l708
        maskLocked_3 <= maskRouted_3; // @ Stream.scala l708
      end
      if((io_output_fire && io_output_payload_eop)) begin
        locked <= 1'b0; // @ BusExt.scala l112
      end
      if(((io_output_fire && io_output_payload_sop) && (! io_output_payload_eop))) begin
        locked <= 1'b1; // @ BusExt.scala l112
      end
    end
  end


endmodule
