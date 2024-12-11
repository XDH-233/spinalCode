// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : cmdq_StreamDemux
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766
// Gen time  : 2024-11-25 11:51:40


module cmdq_StreamDemux (
  input  wire [1:0]    io_select,
  input  wire          io_input_valid,
  output reg           io_input_ready,
  input  wire [544:0]  io_input_payload,
  output reg           io_outputs_0_valid,
  input  wire          io_outputs_0_ready,
  output wire [544:0]  io_outputs_0_payload,
  output reg           io_outputs_1_valid,
  input  wire          io_outputs_1_ready,
  output wire [544:0]  io_outputs_1_payload,
  output reg           io_outputs_2_valid,
  input  wire          io_outputs_2_ready,
  output wire [544:0]  io_outputs_2_payload,
  output reg           io_outputs_3_valid,
  input  wire          io_outputs_3_ready,
  output wire [544:0]  io_outputs_3_payload
);

  wire                tmp_when;
  wire                tmp_when_1;
  wire                tmp_when_2;
  wire                tmp_when_3;

  assign tmp_when = (2'b00 != io_select);
  assign tmp_when_1 = (2'b01 != io_select);
  assign tmp_when_2 = (2'b10 != io_select);
  assign tmp_when_3 = (2'b11 != io_select);
  always @(*) begin
    io_input_ready = 1'b0; // @ Stream.scala l975
    if(!tmp_when) begin
      io_input_ready = io_outputs_0_ready; // @ Stream.scala l982
    end
    if(!tmp_when_1) begin
      io_input_ready = io_outputs_1_ready; // @ Stream.scala l982
    end
    if(!tmp_when_2) begin
      io_input_ready = io_outputs_2_ready; // @ Stream.scala l982
    end
    if(!tmp_when_3) begin
      io_input_ready = io_outputs_3_ready; // @ Stream.scala l982
    end
  end

  assign io_outputs_0_payload = io_input_payload; // @ Stream.scala l977
  always @(*) begin
    if(tmp_when) begin
      io_outputs_0_valid = 1'b0; // @ Stream.scala l979
    end else begin
      io_outputs_0_valid = io_input_valid; // @ Stream.scala l981
    end
  end

  assign io_outputs_1_payload = io_input_payload; // @ Stream.scala l977
  always @(*) begin
    if(tmp_when_1) begin
      io_outputs_1_valid = 1'b0; // @ Stream.scala l979
    end else begin
      io_outputs_1_valid = io_input_valid; // @ Stream.scala l981
    end
  end

  assign io_outputs_2_payload = io_input_payload; // @ Stream.scala l977
  always @(*) begin
    if(tmp_when_2) begin
      io_outputs_2_valid = 1'b0; // @ Stream.scala l979
    end else begin
      io_outputs_2_valid = io_input_valid; // @ Stream.scala l981
    end
  end

  assign io_outputs_3_payload = io_input_payload; // @ Stream.scala l977
  always @(*) begin
    if(tmp_when_3) begin
      io_outputs_3_valid = 1'b0; // @ Stream.scala l979
    end else begin
      io_outputs_3_valid = io_input_valid; // @ Stream.scala l981
    end
  end


endmodule
