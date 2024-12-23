// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : AvstArbiterDemo
// Git hash  : 3e8d19ef98f6d94a68a2d7d71f2a41505d3b1e1b
// Gen time  : 2024-12-23 09:59:01



module AvstArbiterDemo (
  output wire          st_a_ready,
  input  wire          st_a_valid,
  input  wire [15:0]   st_a_data,
  input  wire [24:0]   st_a_channel,
  input  wire [0:0]    st_a_empty,
  input  wire          st_a_endofpacket,
  input  wire          st_a_startofpacket,
  output wire          st_b_ready,
  input  wire          st_b_valid,
  input  wire [15:0]   st_b_data,
  input  wire [24:0]   st_b_channel,
  input  wire [0:0]    st_b_empty,
  input  wire          st_b_endofpacket,
  input  wire          st_b_startofpacket,
  output wire          st_c_ready,
  input  wire          st_c_valid,
  input  wire [15:0]   st_c_data,
  input  wire [24:0]   st_c_channel,
  input  wire [0:0]    st_c_empty,
  input  wire          st_c_endofpacket,
  input  wire          st_c_startofpacket,
  input  wire          st_a_o_ready,
  output wire          st_a_o_valid,
  output wire [15:0]   st_a_o_data,
  output wire [24:0]   st_a_o_channel,
  output wire [0:0]    st_a_o_empty,
  output wire          st_a_o_endofpacket,
  output wire          st_a_o_startofpacket,
  input  wire          st_b_o_ready,
  output wire          st_b_o_valid,
  output wire [15:0]   st_b_o_data,
  output wire [24:0]   st_b_o_channel,
  output wire [0:0]    st_b_o_empty,
  output wire          st_b_o_endofpacket,
  output wire          st_b_o_startofpacket,
  input  wire          st_c_o_ready,
  output wire          st_c_o_valid,
  output wire [15:0]   st_c_o_data,
  output wire [24:0]   st_c_o_channel,
  output wire [0:0]    st_c_o_empty,
  output wire          st_c_o_endofpacket,
  output wire          st_c_o_startofpacket,
  input  wire          clk,
  input  wire          reset
);

  wire       [15:0]   streamArbiter_1_io_inputs_0_payload_data;
  wire       [24:0]   streamArbiter_1_io_inputs_0_payload_channel;
  wire       [0:0]    streamArbiter_1_io_inputs_0_payload_empty;
  wire                streamArbiter_1_io_inputs_0_payload_eop;
  wire                streamArbiter_1_io_inputs_0_payload_sop;
  wire       [15:0]   streamArbiter_1_io_inputs_1_payload_data;
  wire       [24:0]   streamArbiter_1_io_inputs_1_payload_channel;
  wire       [0:0]    streamArbiter_1_io_inputs_1_payload_empty;
  wire                streamArbiter_1_io_inputs_1_payload_eop;
  wire                streamArbiter_1_io_inputs_1_payload_sop;
  wire       [15:0]   streamArbiter_1_io_inputs_2_payload_data;
  wire       [24:0]   streamArbiter_1_io_inputs_2_payload_channel;
  wire       [0:0]    streamArbiter_1_io_inputs_2_payload_empty;
  wire                streamArbiter_1_io_inputs_2_payload_eop;
  wire                streamArbiter_1_io_inputs_2_payload_sop;
  wire       [1:0]    streamDemux_1_io_select;
  wire                streamArbiter_1_io_inputs_0_ready;
  wire                streamArbiter_1_io_inputs_1_ready;
  wire                streamArbiter_1_io_inputs_2_ready;
  wire                streamArbiter_1_io_output_valid;
  wire       [15:0]   streamArbiter_1_io_output_payload_data;
  wire       [24:0]   streamArbiter_1_io_output_payload_channel;
  wire       [0:0]    streamArbiter_1_io_output_payload_empty;
  wire                streamArbiter_1_io_output_payload_eop;
  wire                streamArbiter_1_io_output_payload_sop;
  wire       [1:0]    streamArbiter_1_io_chosen;
  wire       [2:0]    streamArbiter_1_io_chosenOH;
  wire                streamDemux_1_io_input_ready;
  wire                streamDemux_1_io_outputs_0_valid;
  wire       [15:0]   streamDemux_1_io_outputs_0_payload_data;
  wire       [24:0]   streamDemux_1_io_outputs_0_payload_channel;
  wire       [0:0]    streamDemux_1_io_outputs_0_payload_empty;
  wire                streamDemux_1_io_outputs_0_payload_eop;
  wire                streamDemux_1_io_outputs_0_payload_sop;
  wire                streamDemux_1_io_outputs_1_valid;
  wire       [15:0]   streamDemux_1_io_outputs_1_payload_data;
  wire       [24:0]   streamDemux_1_io_outputs_1_payload_channel;
  wire       [0:0]    streamDemux_1_io_outputs_1_payload_empty;
  wire                streamDemux_1_io_outputs_1_payload_eop;
  wire                streamDemux_1_io_outputs_1_payload_sop;
  wire                streamDemux_1_io_outputs_2_valid;
  wire       [15:0]   streamDemux_1_io_outputs_2_payload_data;
  wire       [24:0]   streamDemux_1_io_outputs_2_payload_channel;
  wire       [0:0]    streamDemux_1_io_outputs_2_payload_empty;
  wire                streamDemux_1_io_outputs_2_payload_eop;
  wire                streamDemux_1_io_outputs_2_payload_sop;
  wire       [8:0]    tmp_io_select;
  wire       [43:0]   tmp_io_inputs_0_payload_data;
  wire       [43:0]   tmp_io_inputs_1_payload_data;
  wire       [43:0]   tmp_io_inputs_2_payload_data;
  wire       [8:0]    sel;
  wire       [43:0]   tmp_st_a_o_data;
  wire       [43:0]   tmp_st_b_o_data;
  wire       [43:0]   tmp_st_c_o_data;

  assign tmp_io_select = (sel - 9'h001);
  StreamArbiter streamArbiter_1 (
    .io_inputs_0_valid           (st_a_valid                                       ), //i
    .io_inputs_0_ready           (streamArbiter_1_io_inputs_0_ready                ), //o
    .io_inputs_0_payload_data    (streamArbiter_1_io_inputs_0_payload_data[15:0]   ), //i
    .io_inputs_0_payload_channel (streamArbiter_1_io_inputs_0_payload_channel[24:0]), //i
    .io_inputs_0_payload_empty   (streamArbiter_1_io_inputs_0_payload_empty        ), //i
    .io_inputs_0_payload_eop     (streamArbiter_1_io_inputs_0_payload_eop          ), //i
    .io_inputs_0_payload_sop     (streamArbiter_1_io_inputs_0_payload_sop          ), //i
    .io_inputs_1_valid           (st_b_valid                                       ), //i
    .io_inputs_1_ready           (streamArbiter_1_io_inputs_1_ready                ), //o
    .io_inputs_1_payload_data    (streamArbiter_1_io_inputs_1_payload_data[15:0]   ), //i
    .io_inputs_1_payload_channel (streamArbiter_1_io_inputs_1_payload_channel[24:0]), //i
    .io_inputs_1_payload_empty   (streamArbiter_1_io_inputs_1_payload_empty        ), //i
    .io_inputs_1_payload_eop     (streamArbiter_1_io_inputs_1_payload_eop          ), //i
    .io_inputs_1_payload_sop     (streamArbiter_1_io_inputs_1_payload_sop          ), //i
    .io_inputs_2_valid           (st_c_valid                                       ), //i
    .io_inputs_2_ready           (streamArbiter_1_io_inputs_2_ready                ), //o
    .io_inputs_2_payload_data    (streamArbiter_1_io_inputs_2_payload_data[15:0]   ), //i
    .io_inputs_2_payload_channel (streamArbiter_1_io_inputs_2_payload_channel[24:0]), //i
    .io_inputs_2_payload_empty   (streamArbiter_1_io_inputs_2_payload_empty        ), //i
    .io_inputs_2_payload_eop     (streamArbiter_1_io_inputs_2_payload_eop          ), //i
    .io_inputs_2_payload_sop     (streamArbiter_1_io_inputs_2_payload_sop          ), //i
    .io_output_valid             (streamArbiter_1_io_output_valid                  ), //o
    .io_output_ready             (streamDemux_1_io_input_ready                     ), //i
    .io_output_payload_data      (streamArbiter_1_io_output_payload_data[15:0]     ), //o
    .io_output_payload_channel   (streamArbiter_1_io_output_payload_channel[24:0]  ), //o
    .io_output_payload_empty     (streamArbiter_1_io_output_payload_empty          ), //o
    .io_output_payload_eop       (streamArbiter_1_io_output_payload_eop            ), //o
    .io_output_payload_sop       (streamArbiter_1_io_output_payload_sop            ), //o
    .io_chosen                   (streamArbiter_1_io_chosen[1:0]                   ), //o
    .io_chosenOH                 (streamArbiter_1_io_chosenOH[2:0]                 ), //o
    .clk                         (clk                                              ), //i
    .reset                       (reset                                            )  //i
  );
  StreamDemux streamDemux_1 (
    .io_select                    (streamDemux_1_io_select[1:0]                    ), //i
    .io_input_valid               (streamArbiter_1_io_output_valid                 ), //i
    .io_input_ready               (streamDemux_1_io_input_ready                    ), //o
    .io_input_payload_data        (streamArbiter_1_io_output_payload_data[15:0]    ), //i
    .io_input_payload_channel     (streamArbiter_1_io_output_payload_channel[24:0] ), //i
    .io_input_payload_empty       (streamArbiter_1_io_output_payload_empty         ), //i
    .io_input_payload_eop         (streamArbiter_1_io_output_payload_eop           ), //i
    .io_input_payload_sop         (streamArbiter_1_io_output_payload_sop           ), //i
    .io_outputs_0_valid           (streamDemux_1_io_outputs_0_valid                ), //o
    .io_outputs_0_ready           (st_a_o_ready                                    ), //i
    .io_outputs_0_payload_data    (streamDemux_1_io_outputs_0_payload_data[15:0]   ), //o
    .io_outputs_0_payload_channel (streamDemux_1_io_outputs_0_payload_channel[24:0]), //o
    .io_outputs_0_payload_empty   (streamDemux_1_io_outputs_0_payload_empty        ), //o
    .io_outputs_0_payload_eop     (streamDemux_1_io_outputs_0_payload_eop          ), //o
    .io_outputs_0_payload_sop     (streamDemux_1_io_outputs_0_payload_sop          ), //o
    .io_outputs_1_valid           (streamDemux_1_io_outputs_1_valid                ), //o
    .io_outputs_1_ready           (st_b_o_ready                                    ), //i
    .io_outputs_1_payload_data    (streamDemux_1_io_outputs_1_payload_data[15:0]   ), //o
    .io_outputs_1_payload_channel (streamDemux_1_io_outputs_1_payload_channel[24:0]), //o
    .io_outputs_1_payload_empty   (streamDemux_1_io_outputs_1_payload_empty        ), //o
    .io_outputs_1_payload_eop     (streamDemux_1_io_outputs_1_payload_eop          ), //o
    .io_outputs_1_payload_sop     (streamDemux_1_io_outputs_1_payload_sop          ), //o
    .io_outputs_2_valid           (streamDemux_1_io_outputs_2_valid                ), //o
    .io_outputs_2_ready           (st_c_o_ready                                    ), //i
    .io_outputs_2_payload_data    (streamDemux_1_io_outputs_2_payload_data[15:0]   ), //o
    .io_outputs_2_payload_channel (streamDemux_1_io_outputs_2_payload_channel[24:0]), //o
    .io_outputs_2_payload_empty   (streamDemux_1_io_outputs_2_payload_empty        ), //o
    .io_outputs_2_payload_eop     (streamDemux_1_io_outputs_2_payload_eop          ), //o
    .io_outputs_2_payload_sop     (streamDemux_1_io_outputs_2_payload_sop          )  //o
  );
  assign tmp_io_inputs_0_payload_data = {st_a_startofpacket,{st_a_endofpacket,{st_a_empty,{st_a_channel,st_a_data}}}}; // @ BaseType.scala l299
  assign streamArbiter_1_io_inputs_0_payload_data = tmp_io_inputs_0_payload_data[15 : 0]; // @ Bits.scala l133
  assign streamArbiter_1_io_inputs_0_payload_channel = tmp_io_inputs_0_payload_data[40 : 16]; // @ UInt.scala l381
  assign streamArbiter_1_io_inputs_0_payload_empty = tmp_io_inputs_0_payload_data[41 : 41]; // @ UInt.scala l381
  assign streamArbiter_1_io_inputs_0_payload_eop = tmp_io_inputs_0_payload_data[42]; // @ Bool.scala l209
  assign streamArbiter_1_io_inputs_0_payload_sop = tmp_io_inputs_0_payload_data[43]; // @ Bool.scala l209
  assign st_a_ready = streamArbiter_1_io_inputs_0_ready; // @ AvstArbiterDemo.scala l19
  assign tmp_io_inputs_1_payload_data = {st_b_startofpacket,{st_b_endofpacket,{st_b_empty,{st_b_channel,st_b_data}}}}; // @ BaseType.scala l299
  assign streamArbiter_1_io_inputs_1_payload_data = tmp_io_inputs_1_payload_data[15 : 0]; // @ Bits.scala l133
  assign streamArbiter_1_io_inputs_1_payload_channel = tmp_io_inputs_1_payload_data[40 : 16]; // @ UInt.scala l381
  assign streamArbiter_1_io_inputs_1_payload_empty = tmp_io_inputs_1_payload_data[41 : 41]; // @ UInt.scala l381
  assign streamArbiter_1_io_inputs_1_payload_eop = tmp_io_inputs_1_payload_data[42]; // @ Bool.scala l209
  assign streamArbiter_1_io_inputs_1_payload_sop = tmp_io_inputs_1_payload_data[43]; // @ Bool.scala l209
  assign st_b_ready = streamArbiter_1_io_inputs_1_ready; // @ AvstArbiterDemo.scala l19
  assign tmp_io_inputs_2_payload_data = {st_c_startofpacket,{st_c_endofpacket,{st_c_empty,{st_c_channel,st_c_data}}}}; // @ BaseType.scala l299
  assign streamArbiter_1_io_inputs_2_payload_data = tmp_io_inputs_2_payload_data[15 : 0]; // @ Bits.scala l133
  assign streamArbiter_1_io_inputs_2_payload_channel = tmp_io_inputs_2_payload_data[40 : 16]; // @ UInt.scala l381
  assign streamArbiter_1_io_inputs_2_payload_empty = tmp_io_inputs_2_payload_data[41 : 41]; // @ UInt.scala l381
  assign streamArbiter_1_io_inputs_2_payload_eop = tmp_io_inputs_2_payload_data[42]; // @ Bool.scala l209
  assign streamArbiter_1_io_inputs_2_payload_sop = tmp_io_inputs_2_payload_data[43]; // @ Bool.scala l209
  assign st_c_ready = streamArbiter_1_io_inputs_2_ready; // @ AvstArbiterDemo.scala l19
  assign sel = (streamArbiter_1_io_output_payload_channel >>> 5'd16); // @ BaseType.scala l299
  assign streamDemux_1_io_select = tmp_io_select[1:0]; // @ Stream.scala l931
  assign tmp_st_a_o_data = {streamDemux_1_io_outputs_0_payload_sop,{streamDemux_1_io_outputs_0_payload_eop,{streamDemux_1_io_outputs_0_payload_empty,{streamDemux_1_io_outputs_0_payload_channel,streamDemux_1_io_outputs_0_payload_data}}}}; // @ BaseType.scala l299
  assign st_a_o_valid = streamDemux_1_io_outputs_0_valid; // @ AvstArbiterDemo.scala l25
  assign st_a_o_data = tmp_st_a_o_data[15 : 0]; // @ AvstArbiterDemo.scala l25
  assign st_a_o_channel = tmp_st_a_o_data[40 : 16]; // @ AvstArbiterDemo.scala l25
  assign st_a_o_empty = tmp_st_a_o_data[41 : 41]; // @ AvstArbiterDemo.scala l25
  assign st_a_o_endofpacket = tmp_st_a_o_data[42]; // @ AvstArbiterDemo.scala l25
  assign st_a_o_startofpacket = tmp_st_a_o_data[43]; // @ AvstArbiterDemo.scala l25
  assign tmp_st_b_o_data = {streamDemux_1_io_outputs_1_payload_sop,{streamDemux_1_io_outputs_1_payload_eop,{streamDemux_1_io_outputs_1_payload_empty,{streamDemux_1_io_outputs_1_payload_channel,streamDemux_1_io_outputs_1_payload_data}}}}; // @ BaseType.scala l299
  assign st_b_o_valid = streamDemux_1_io_outputs_1_valid; // @ AvstArbiterDemo.scala l25
  assign st_b_o_data = tmp_st_b_o_data[15 : 0]; // @ AvstArbiterDemo.scala l25
  assign st_b_o_channel = tmp_st_b_o_data[40 : 16]; // @ AvstArbiterDemo.scala l25
  assign st_b_o_empty = tmp_st_b_o_data[41 : 41]; // @ AvstArbiterDemo.scala l25
  assign st_b_o_endofpacket = tmp_st_b_o_data[42]; // @ AvstArbiterDemo.scala l25
  assign st_b_o_startofpacket = tmp_st_b_o_data[43]; // @ AvstArbiterDemo.scala l25
  assign tmp_st_c_o_data = {streamDemux_1_io_outputs_2_payload_sop,{streamDemux_1_io_outputs_2_payload_eop,{streamDemux_1_io_outputs_2_payload_empty,{streamDemux_1_io_outputs_2_payload_channel,streamDemux_1_io_outputs_2_payload_data}}}}; // @ BaseType.scala l299
  assign st_c_o_valid = streamDemux_1_io_outputs_2_valid; // @ AvstArbiterDemo.scala l25
  assign st_c_o_data = tmp_st_c_o_data[15 : 0]; // @ AvstArbiterDemo.scala l25
  assign st_c_o_channel = tmp_st_c_o_data[40 : 16]; // @ AvstArbiterDemo.scala l25
  assign st_c_o_empty = tmp_st_c_o_data[41 : 41]; // @ AvstArbiterDemo.scala l25
  assign st_c_o_endofpacket = tmp_st_c_o_data[42]; // @ AvstArbiterDemo.scala l25
  assign st_c_o_startofpacket = tmp_st_c_o_data[43]; // @ AvstArbiterDemo.scala l25

endmodule

module StreamDemux (
  input  wire [1:0]    io_select,
  input  wire          io_input_valid,
  output reg           io_input_ready,
  input  wire [15:0]   io_input_payload_data,
  input  wire [24:0]   io_input_payload_channel,
  input  wire [0:0]    io_input_payload_empty,
  input  wire          io_input_payload_eop,
  input  wire          io_input_payload_sop,
  output reg           io_outputs_0_valid,
  input  wire          io_outputs_0_ready,
  output wire [15:0]   io_outputs_0_payload_data,
  output wire [24:0]   io_outputs_0_payload_channel,
  output wire [0:0]    io_outputs_0_payload_empty,
  output wire          io_outputs_0_payload_eop,
  output wire          io_outputs_0_payload_sop,
  output reg           io_outputs_1_valid,
  input  wire          io_outputs_1_ready,
  output wire [15:0]   io_outputs_1_payload_data,
  output wire [24:0]   io_outputs_1_payload_channel,
  output wire [0:0]    io_outputs_1_payload_empty,
  output wire          io_outputs_1_payload_eop,
  output wire          io_outputs_1_payload_sop,
  output reg           io_outputs_2_valid,
  input  wire          io_outputs_2_ready,
  output wire [15:0]   io_outputs_2_payload_data,
  output wire [24:0]   io_outputs_2_payload_channel,
  output wire [0:0]    io_outputs_2_payload_empty,
  output wire          io_outputs_2_payload_eop,
  output wire          io_outputs_2_payload_sop
);

  wire                tmp_when;
  wire                tmp_when_1;
  wire                tmp_when_2;

  assign tmp_when = (2'b00 != io_select);
  assign tmp_when_1 = (2'b01 != io_select);
  assign tmp_when_2 = (2'b10 != io_select);
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
  end

  assign io_outputs_0_payload_data = io_input_payload_data; // @ Stream.scala l977
  assign io_outputs_0_payload_channel = io_input_payload_channel; // @ Stream.scala l977
  assign io_outputs_0_payload_empty = io_input_payload_empty; // @ Stream.scala l977
  assign io_outputs_0_payload_eop = io_input_payload_eop; // @ Stream.scala l977
  assign io_outputs_0_payload_sop = io_input_payload_sop; // @ Stream.scala l977
  always @(*) begin
    if(tmp_when) begin
      io_outputs_0_valid = 1'b0; // @ Stream.scala l979
    end else begin
      io_outputs_0_valid = io_input_valid; // @ Stream.scala l981
    end
  end

  assign io_outputs_1_payload_data = io_input_payload_data; // @ Stream.scala l977
  assign io_outputs_1_payload_channel = io_input_payload_channel; // @ Stream.scala l977
  assign io_outputs_1_payload_empty = io_input_payload_empty; // @ Stream.scala l977
  assign io_outputs_1_payload_eop = io_input_payload_eop; // @ Stream.scala l977
  assign io_outputs_1_payload_sop = io_input_payload_sop; // @ Stream.scala l977
  always @(*) begin
    if(tmp_when_1) begin
      io_outputs_1_valid = 1'b0; // @ Stream.scala l979
    end else begin
      io_outputs_1_valid = io_input_valid; // @ Stream.scala l981
    end
  end

  assign io_outputs_2_payload_data = io_input_payload_data; // @ Stream.scala l977
  assign io_outputs_2_payload_channel = io_input_payload_channel; // @ Stream.scala l977
  assign io_outputs_2_payload_empty = io_input_payload_empty; // @ Stream.scala l977
  assign io_outputs_2_payload_eop = io_input_payload_eop; // @ Stream.scala l977
  assign io_outputs_2_payload_sop = io_input_payload_sop; // @ Stream.scala l977
  always @(*) begin
    if(tmp_when_2) begin
      io_outputs_2_valid = 1'b0; // @ Stream.scala l979
    end else begin
      io_outputs_2_valid = io_input_valid; // @ Stream.scala l981
    end
  end


endmodule

module StreamArbiter (
  input  wire          io_inputs_0_valid,
  output wire          io_inputs_0_ready,
  input  wire [15:0]   io_inputs_0_payload_data,
  input  wire [24:0]   io_inputs_0_payload_channel,
  input  wire [0:0]    io_inputs_0_payload_empty,
  input  wire          io_inputs_0_payload_eop,
  input  wire          io_inputs_0_payload_sop,
  input  wire          io_inputs_1_valid,
  output wire          io_inputs_1_ready,
  input  wire [15:0]   io_inputs_1_payload_data,
  input  wire [24:0]   io_inputs_1_payload_channel,
  input  wire [0:0]    io_inputs_1_payload_empty,
  input  wire          io_inputs_1_payload_eop,
  input  wire          io_inputs_1_payload_sop,
  input  wire          io_inputs_2_valid,
  output wire          io_inputs_2_ready,
  input  wire [15:0]   io_inputs_2_payload_data,
  input  wire [24:0]   io_inputs_2_payload_channel,
  input  wire [0:0]    io_inputs_2_payload_empty,
  input  wire          io_inputs_2_payload_eop,
  input  wire          io_inputs_2_payload_sop,
  output wire          io_output_valid,
  input  wire          io_output_ready,
  output wire [15:0]   io_output_payload_data,
  output wire [24:0]   io_output_payload_channel,
  output wire [0:0]    io_output_payload_empty,
  output wire          io_output_payload_eop,
  output wire          io_output_payload_sop,
  output wire [1:0]    io_chosen,
  output wire [2:0]    io_chosenOH,
  input  wire          clk,
  input  wire          reset
);

  wire       [5:0]    tmp_tmp_maskProposal_0_2;
  wire       [5:0]    tmp_tmp_maskProposal_0_2_1;
  wire       [2:0]    tmp_tmp_maskProposal_0_2_2;
  reg        [15:0]   tmp_io_output_payload_data_1;
  reg        [24:0]   tmp_io_output_payload_channel;
  reg        [0:0]    tmp_io_output_payload_empty;
  reg                 tmp_io_output_payload_eop;
  reg                 tmp_io_output_payload_sop;
  reg                 locked;
  wire                maskProposal_0;
  wire                maskProposal_1;
  wire                maskProposal_2;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  reg                 maskLocked_2;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire                maskRouted_2;
  wire       [2:0]    tmp_maskProposal_0;
  wire       [5:0]    tmp_maskProposal_0_1;
  wire       [5:0]    tmp_maskProposal_0_2;
  wire       [2:0]    tmp_maskProposal_0_3;
  wire                io_output_fire;
  wire       [1:0]    tmp_io_output_payload_data;
  wire                tmp_io_chosen;
  wire                tmp_io_chosen_1;

  assign tmp_tmp_maskProposal_0_2 = (tmp_maskProposal_0_1 - tmp_tmp_maskProposal_0_2_1);
  assign tmp_tmp_maskProposal_0_2_2 = {maskLocked_1,{maskLocked_0,maskLocked_2}};
  assign tmp_tmp_maskProposal_0_2_1 = {3'd0, tmp_tmp_maskProposal_0_2_2};
  always @(*) begin
    case(tmp_io_output_payload_data)
      2'b00 : begin
        tmp_io_output_payload_data_1 = io_inputs_0_payload_data;
        tmp_io_output_payload_channel = io_inputs_0_payload_channel;
        tmp_io_output_payload_empty = io_inputs_0_payload_empty;
        tmp_io_output_payload_eop = io_inputs_0_payload_eop;
        tmp_io_output_payload_sop = io_inputs_0_payload_sop;
      end
      2'b01 : begin
        tmp_io_output_payload_data_1 = io_inputs_1_payload_data;
        tmp_io_output_payload_channel = io_inputs_1_payload_channel;
        tmp_io_output_payload_empty = io_inputs_1_payload_empty;
        tmp_io_output_payload_eop = io_inputs_1_payload_eop;
        tmp_io_output_payload_sop = io_inputs_1_payload_sop;
      end
      default : begin
        tmp_io_output_payload_data_1 = io_inputs_2_payload_data;
        tmp_io_output_payload_channel = io_inputs_2_payload_channel;
        tmp_io_output_payload_empty = io_inputs_2_payload_empty;
        tmp_io_output_payload_eop = io_inputs_2_payload_eop;
        tmp_io_output_payload_sop = io_inputs_2_payload_sop;
      end
    endcase
  end

  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0); // @ Expression.scala l1444
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1); // @ Expression.scala l1444
  assign maskRouted_2 = (locked ? maskLocked_2 : maskProposal_2); // @ Expression.scala l1444
  assign tmp_maskProposal_0 = {io_inputs_2_valid,{io_inputs_1_valid,io_inputs_0_valid}}; // @ BaseType.scala l318
  assign tmp_maskProposal_0_1 = {tmp_maskProposal_0,tmp_maskProposal_0}; // @ BaseType.scala l318
  assign tmp_maskProposal_0_2 = (tmp_maskProposal_0_1 & (~ tmp_tmp_maskProposal_0_2)); // @ BaseType.scala l299
  assign tmp_maskProposal_0_3 = (tmp_maskProposal_0_2[5 : 3] | tmp_maskProposal_0_2[2 : 0]); // @ BaseType.scala l318
  assign maskProposal_0 = tmp_maskProposal_0_3[0]; // @ Stream.scala l652
  assign maskProposal_1 = tmp_maskProposal_0_3[1]; // @ Stream.scala l652
  assign maskProposal_2 = tmp_maskProposal_0_3[2]; // @ Stream.scala l652
  assign io_output_fire = (io_output_valid && io_output_ready); // @ BaseType.scala l305
  assign io_output_valid = (((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1)) || (io_inputs_2_valid && maskRouted_2)); // @ Stream.scala l714
  assign tmp_io_output_payload_data = {maskRouted_2,maskRouted_1}; // @ BaseType.scala l318
  assign io_output_payload_data = tmp_io_output_payload_data_1; // @ Stream.scala l715
  assign io_output_payload_channel = tmp_io_output_payload_channel; // @ Stream.scala l715
  assign io_output_payload_empty = tmp_io_output_payload_empty; // @ Stream.scala l715
  assign io_output_payload_eop = tmp_io_output_payload_eop; // @ Stream.scala l715
  assign io_output_payload_sop = tmp_io_output_payload_sop; // @ Stream.scala l715
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready); // @ Stream.scala l716
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready); // @ Stream.scala l716
  assign io_inputs_2_ready = (maskRouted_2 && io_output_ready); // @ Stream.scala l716
  assign io_chosenOH = {maskRouted_2,{maskRouted_1,maskRouted_0}}; // @ Stream.scala l718
  assign tmp_io_chosen = io_chosenOH[1]; // @ BaseType.scala l305
  assign tmp_io_chosen_1 = io_chosenOH[2]; // @ BaseType.scala l305
  assign io_chosen = {tmp_io_chosen_1,tmp_io_chosen}; // @ Stream.scala l719
  always @(posedge clk) begin
    if(reset) begin
      locked <= 1'b0; // @ Data.scala l409
      maskLocked_0 <= 1'b0; // @ Data.scala l409
      maskLocked_1 <= 1'b0; // @ Data.scala l409
      maskLocked_2 <= 1'b1; // @ Data.scala l409
    end else begin
      if(io_output_valid) begin
        maskLocked_0 <= maskRouted_0; // @ Stream.scala l708
        maskLocked_1 <= maskRouted_1; // @ Stream.scala l708
        maskLocked_2 <= maskRouted_2; // @ Stream.scala l708
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
