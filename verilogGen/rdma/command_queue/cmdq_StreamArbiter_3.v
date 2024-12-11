// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : cmdq_StreamArbiter_3
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766
// Gen time  : 2024-11-25 11:51:40


module cmdq_StreamArbiter_3 (
  input  wire          io_inputs_0_valid,
  output wire          io_inputs_0_ready,
  input  wire [511:0]  io_inputs_0_payload_data,
  input  wire [127:0]  io_inputs_0_payload_channel,
  input  wire [5:0]    io_inputs_0_payload_empty,
  input  wire          io_inputs_0_payload_eop,
  input  wire          io_inputs_0_payload_sop,
  input  wire          io_inputs_1_valid,
  output wire          io_inputs_1_ready,
  input  wire [511:0]  io_inputs_1_payload_data,
  input  wire [127:0]  io_inputs_1_payload_channel,
  input  wire [5:0]    io_inputs_1_payload_empty,
  input  wire          io_inputs_1_payload_eop,
  input  wire          io_inputs_1_payload_sop,
  output wire          io_output_valid,
  input  wire          io_output_ready,
  output wire [511:0]  io_output_payload_data,
  output wire [127:0]  io_output_payload_channel,
  output wire [5:0]    io_output_payload_empty,
  output wire          io_output_payload_eop,
  output wire          io_output_payload_sop,
  output wire [0:0]    io_chosen,
  output wire [1:0]    io_chosenOH,
  input  wire          clk,
  input  wire          reset
);

  wire       [1:0]    tmp_maskProposal_1_1;
  wire       [1:0]    tmp_maskProposal_1_2;
  reg                 locked;
  wire                maskProposal_0;
  wire                maskProposal_1;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire       [1:0]    tmp_maskProposal_1;
  wire                io_output_fire;
  wire                tmp_io_chosen;

  assign tmp_maskProposal_1_1 = (tmp_maskProposal_1 & (~ tmp_maskProposal_1_2));
  assign tmp_maskProposal_1_2 = (tmp_maskProposal_1 - 2'b01);
  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0); // @ Expression.scala l1444
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1); // @ Expression.scala l1444
  assign tmp_maskProposal_1 = {io_inputs_1_valid,io_inputs_0_valid}; // @ BaseType.scala l318
  assign maskProposal_0 = io_inputs_0_valid; // @ Stream.scala l633
  assign maskProposal_1 = tmp_maskProposal_1_1[1]; // @ Stream.scala l633
  assign io_output_fire = (io_output_valid && io_output_ready); // @ BaseType.scala l305
  assign io_output_valid = ((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1)); // @ Stream.scala l714
  assign io_output_payload_data = (maskRouted_0 ? io_inputs_0_payload_data : io_inputs_1_payload_data); // @ Stream.scala l715
  assign io_output_payload_channel = (maskRouted_0 ? io_inputs_0_payload_channel : io_inputs_1_payload_channel); // @ Stream.scala l715
  assign io_output_payload_empty = (maskRouted_0 ? io_inputs_0_payload_empty : io_inputs_1_payload_empty); // @ Stream.scala l715
  assign io_output_payload_eop = (maskRouted_0 ? io_inputs_0_payload_eop : io_inputs_1_payload_eop); // @ Stream.scala l715
  assign io_output_payload_sop = (maskRouted_0 ? io_inputs_0_payload_sop : io_inputs_1_payload_sop); // @ Stream.scala l715
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready); // @ Stream.scala l716
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready); // @ Stream.scala l716
  assign io_chosenOH = {maskRouted_1,maskRouted_0}; // @ Stream.scala l718
  assign tmp_io_chosen = io_chosenOH[1]; // @ BaseType.scala l305
  assign io_chosen = tmp_io_chosen; // @ Stream.scala l719
  always @(posedge clk) begin
    if(reset) begin
      locked <= 1'b0; // @ Data.scala l409
    end else begin
      if((io_output_fire && io_output_payload_eop)) begin
        locked <= 1'b0; // @ BusExt.scala l112
      end
      if(((io_output_fire && io_output_payload_sop) && (! io_output_payload_eop))) begin
        locked <= 1'b1; // @ BusExt.scala l112
      end
    end
  end

  always @(posedge clk) begin
    if(io_output_valid) begin
      maskLocked_0 <= maskRouted_0; // @ Stream.scala l708
      maskLocked_1 <= maskRouted_1; // @ Stream.scala l708
    end
  end


endmodule
