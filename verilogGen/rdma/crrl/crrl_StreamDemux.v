// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : crrl_StreamDemux
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766


module crrl_StreamDemux (
  input  wire [2:0]    io_select,
  input  wire          io_input_valid,
  output reg           io_input_ready,
  input  wire [282:0]  io_input_payload,
  output reg           io_outputs_0_valid,
  input  wire          io_outputs_0_ready,
  output wire [282:0]  io_outputs_0_payload,
  output reg           io_outputs_1_valid,
  input  wire          io_outputs_1_ready,
  output wire [282:0]  io_outputs_1_payload,
  output reg           io_outputs_2_valid,
  input  wire          io_outputs_2_ready,
  output wire [282:0]  io_outputs_2_payload,
  output reg           io_outputs_3_valid,
  input  wire          io_outputs_3_ready,
  output wire [282:0]  io_outputs_3_payload,
  output reg           io_outputs_4_valid,
  input  wire          io_outputs_4_ready,
  output wire [282:0]  io_outputs_4_payload
);

  wire                tmp_when;
  wire                tmp_when_1;
  wire                tmp_when_2;
  wire                tmp_when_3;
  wire                tmp_when_4;

  assign tmp_when = (3'b000 != io_select);
  assign tmp_when_1 = (3'b001 != io_select);
  assign tmp_when_2 = (3'b010 != io_select);
  assign tmp_when_3 = (3'b011 != io_select);
  assign tmp_when_4 = (3'b100 != io_select);
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
    if(!tmp_when_4) begin
      io_input_ready = io_outputs_4_ready; // @ Stream.scala l982
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

  assign io_outputs_4_payload = io_input_payload; // @ Stream.scala l977
  always @(*) begin
    if(tmp_when_4) begin
      io_outputs_4_valid = 1'b0; // @ Stream.scala l979
    end else begin
      io_outputs_4_valid = io_input_valid; // @ Stream.scala l981
    end
  end


endmodule
