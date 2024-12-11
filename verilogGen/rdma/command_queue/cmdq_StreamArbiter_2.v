// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : cmdq_StreamArbiter_2
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766
// Gen time  : 2024-11-25 11:51:40


module cmdq_StreamArbiter_2 (
  input  wire          io_inputs_0_valid,
  output wire          io_inputs_0_ready,
  input  wire [127:0]  io_inputs_0_payload,
  input  wire          io_inputs_1_valid,
  output wire          io_inputs_1_ready,
  input  wire [127:0]  io_inputs_1_payload,
  output wire          io_output_valid,
  input  wire          io_output_ready,
  output wire [127:0]  io_output_payload,
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
  assign io_output_payload = (maskRouted_0 ? io_inputs_0_payload : io_inputs_1_payload); // @ Stream.scala l715
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready); // @ Stream.scala l716
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready); // @ Stream.scala l716
  assign io_chosenOH = {maskRouted_1,maskRouted_0}; // @ Stream.scala l718
  assign tmp_io_chosen = io_chosenOH[1]; // @ BaseType.scala l305
  assign io_chosen = tmp_io_chosen; // @ Stream.scala l719
  always @(posedge clk) begin
    if(reset) begin
      locked <= 1'b0; // @ Data.scala l409
    end else begin
      if(io_output_valid) begin
        locked <= 1'b1; // @ Stream.scala l670
      end
      if(io_output_fire) begin
        locked <= 1'b0; // @ Stream.scala l671
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
