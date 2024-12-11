// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : crrl_StreamArbiter
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766


module crrl_StreamArbiter (
  input  wire          io_inputs_0_valid,
  output wire          io_inputs_0_ready,
  input  wire [282:0]  io_inputs_0_payload,
  input  wire          io_inputs_1_valid,
  output wire          io_inputs_1_ready,
  input  wire [282:0]  io_inputs_1_payload,
  input  wire          io_inputs_2_valid,
  output wire          io_inputs_2_ready,
  input  wire [282:0]  io_inputs_2_payload,
  input  wire          io_inputs_3_valid,
  output wire          io_inputs_3_ready,
  input  wire [282:0]  io_inputs_3_payload,
  input  wire          io_inputs_4_valid,
  output wire          io_inputs_4_ready,
  input  wire [282:0]  io_inputs_4_payload,
  output wire          io_output_valid,
  input  wire          io_output_ready,
  output wire [282:0]  io_output_payload,
  output wire [2:0]    io_chosen,
  output wire [4:0]    io_chosenOH,
  input  wire          clk,
  input  wire          reset
);

  wire       [9:0]    tmp_tmp_maskProposal_0_2;
  wire       [9:0]    tmp_tmp_maskProposal_0_2_1;
  wire       [4:0]    tmp_tmp_maskProposal_0_2_2;
  reg        [282:0]  tmp_io_output_payload_2;
  wire       [2:0]    tmp_io_output_payload_3;
  reg                 locked;
  wire                maskProposal_0;
  wire                maskProposal_1;
  wire                maskProposal_2;
  wire                maskProposal_3;
  wire                maskProposal_4;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  reg                 maskLocked_2;
  reg                 maskLocked_3;
  reg                 maskLocked_4;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire                maskRouted_2;
  wire                maskRouted_3;
  wire                maskRouted_4;
  wire       [4:0]    tmp_maskProposal_0;
  wire       [9:0]    tmp_maskProposal_0_1;
  wire       [9:0]    tmp_maskProposal_0_2;
  wire       [4:0]    tmp_maskProposal_0_3;
  wire                io_output_fire;
  wire                tmp_io_output_payload;
  wire                tmp_io_output_payload_1;
  wire                tmp_io_chosen;
  wire                tmp_io_chosen_1;
  wire                tmp_io_chosen_2;
  wire                tmp_io_chosen_3;

  assign tmp_tmp_maskProposal_0_2 = (tmp_maskProposal_0_1 - tmp_tmp_maskProposal_0_2_1);
  assign tmp_tmp_maskProposal_0_2_2 = {maskLocked_3,{maskLocked_2,{maskLocked_1,{maskLocked_0,maskLocked_4}}}};
  assign tmp_tmp_maskProposal_0_2_1 = {5'd0, tmp_tmp_maskProposal_0_2_2};
  assign tmp_io_output_payload_3 = {maskRouted_4,{tmp_io_output_payload_1,tmp_io_output_payload}};
  always @(*) begin
    case(tmp_io_output_payload_3)
      3'b000 : tmp_io_output_payload_2 = io_inputs_0_payload;
      3'b001 : tmp_io_output_payload_2 = io_inputs_1_payload;
      3'b010 : tmp_io_output_payload_2 = io_inputs_2_payload;
      3'b011 : tmp_io_output_payload_2 = io_inputs_3_payload;
      default : tmp_io_output_payload_2 = io_inputs_4_payload;
    endcase
  end

  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0); // @ Expression.scala l1444
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1); // @ Expression.scala l1444
  assign maskRouted_2 = (locked ? maskLocked_2 : maskProposal_2); // @ Expression.scala l1444
  assign maskRouted_3 = (locked ? maskLocked_3 : maskProposal_3); // @ Expression.scala l1444
  assign maskRouted_4 = (locked ? maskLocked_4 : maskProposal_4); // @ Expression.scala l1444
  assign tmp_maskProposal_0 = {io_inputs_4_valid,{io_inputs_3_valid,{io_inputs_2_valid,{io_inputs_1_valid,io_inputs_0_valid}}}}; // @ BaseType.scala l318
  assign tmp_maskProposal_0_1 = {tmp_maskProposal_0,tmp_maskProposal_0}; // @ BaseType.scala l318
  assign tmp_maskProposal_0_2 = (tmp_maskProposal_0_1 & (~ tmp_tmp_maskProposal_0_2)); // @ BaseType.scala l299
  assign tmp_maskProposal_0_3 = (tmp_maskProposal_0_2[9 : 5] | tmp_maskProposal_0_2[4 : 0]); // @ BaseType.scala l318
  assign maskProposal_0 = tmp_maskProposal_0_3[0]; // @ Stream.scala l652
  assign maskProposal_1 = tmp_maskProposal_0_3[1]; // @ Stream.scala l652
  assign maskProposal_2 = tmp_maskProposal_0_3[2]; // @ Stream.scala l652
  assign maskProposal_3 = tmp_maskProposal_0_3[3]; // @ Stream.scala l652
  assign maskProposal_4 = tmp_maskProposal_0_3[4]; // @ Stream.scala l652
  assign io_output_fire = (io_output_valid && io_output_ready); // @ BaseType.scala l305
  assign io_output_valid = (((((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1)) || (io_inputs_2_valid && maskRouted_2)) || (io_inputs_3_valid && maskRouted_3)) || (io_inputs_4_valid && maskRouted_4)); // @ Stream.scala l714
  assign tmp_io_output_payload = (maskRouted_1 || maskRouted_3); // @ BaseType.scala l305
  assign tmp_io_output_payload_1 = (maskRouted_2 || maskRouted_3); // @ BaseType.scala l305
  assign io_output_payload = tmp_io_output_payload_2; // @ Stream.scala l715
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready); // @ Stream.scala l716
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready); // @ Stream.scala l716
  assign io_inputs_2_ready = (maskRouted_2 && io_output_ready); // @ Stream.scala l716
  assign io_inputs_3_ready = (maskRouted_3 && io_output_ready); // @ Stream.scala l716
  assign io_inputs_4_ready = (maskRouted_4 && io_output_ready); // @ Stream.scala l716
  assign io_chosenOH = {maskRouted_4,{maskRouted_3,{maskRouted_2,{maskRouted_1,maskRouted_0}}}}; // @ Stream.scala l718
  assign tmp_io_chosen = io_chosenOH[3]; // @ BaseType.scala l305
  assign tmp_io_chosen_1 = io_chosenOH[4]; // @ BaseType.scala l305
  assign tmp_io_chosen_2 = (io_chosenOH[1] || tmp_io_chosen); // @ BaseType.scala l305
  assign tmp_io_chosen_3 = (io_chosenOH[2] || tmp_io_chosen); // @ BaseType.scala l305
  assign io_chosen = {tmp_io_chosen_1,{tmp_io_chosen_3,tmp_io_chosen_2}}; // @ Stream.scala l719
  always @(posedge clk) begin
    if(reset) begin
      locked <= 1'b0; // @ Data.scala l409
      maskLocked_0 <= 1'b0; // @ Data.scala l409
      maskLocked_1 <= 1'b0; // @ Data.scala l409
      maskLocked_2 <= 1'b0; // @ Data.scala l409
      maskLocked_3 <= 1'b0; // @ Data.scala l409
      maskLocked_4 <= 1'b1; // @ Data.scala l409
    end else begin
      if(io_output_valid) begin
        maskLocked_0 <= maskRouted_0; // @ Stream.scala l708
        maskLocked_1 <= maskRouted_1; // @ Stream.scala l708
        maskLocked_2 <= maskRouted_2; // @ Stream.scala l708
        maskLocked_3 <= maskRouted_3; // @ Stream.scala l708
        maskLocked_4 <= maskRouted_4; // @ Stream.scala l708
      end
      if(io_output_valid) begin
        locked <= 1'b1; // @ Stream.scala l670
      end
      if(io_output_fire) begin
        locked <= 1'b0; // @ Stream.scala l671
      end
    end
  end


endmodule
