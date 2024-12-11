// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : AvstArbiterDemo
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766


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
  assign st_a_ready = streamArbiter_1_io_inputs_0_ready; // @ AvstArbiterDemo.scala l42
  assign tmp_io_inputs_1_payload_data = {st_b_startofpacket,{st_b_endofpacket,{st_b_empty,{st_b_channel,st_b_data}}}}; // @ BaseType.scala l299
  assign streamArbiter_1_io_inputs_1_payload_data = tmp_io_inputs_1_payload_data[15 : 0]; // @ Bits.scala l133
  assign streamArbiter_1_io_inputs_1_payload_channel = tmp_io_inputs_1_payload_data[40 : 16]; // @ UInt.scala l381
  assign streamArbiter_1_io_inputs_1_payload_empty = tmp_io_inputs_1_payload_data[41 : 41]; // @ UInt.scala l381
  assign streamArbiter_1_io_inputs_1_payload_eop = tmp_io_inputs_1_payload_data[42]; // @ Bool.scala l209
  assign streamArbiter_1_io_inputs_1_payload_sop = tmp_io_inputs_1_payload_data[43]; // @ Bool.scala l209
  assign st_b_ready = streamArbiter_1_io_inputs_1_ready; // @ AvstArbiterDemo.scala l42
  assign tmp_io_inputs_2_payload_data = {st_c_startofpacket,{st_c_endofpacket,{st_c_empty,{st_c_channel,st_c_data}}}}; // @ BaseType.scala l299
  assign streamArbiter_1_io_inputs_2_payload_data = tmp_io_inputs_2_payload_data[15 : 0]; // @ Bits.scala l133
  assign streamArbiter_1_io_inputs_2_payload_channel = tmp_io_inputs_2_payload_data[40 : 16]; // @ UInt.scala l381
  assign streamArbiter_1_io_inputs_2_payload_empty = tmp_io_inputs_2_payload_data[41 : 41]; // @ UInt.scala l381
  assign streamArbiter_1_io_inputs_2_payload_eop = tmp_io_inputs_2_payload_data[42]; // @ Bool.scala l209
  assign streamArbiter_1_io_inputs_2_payload_sop = tmp_io_inputs_2_payload_data[43]; // @ Bool.scala l209
  assign st_c_ready = streamArbiter_1_io_inputs_2_ready; // @ AvstArbiterDemo.scala l42
  assign sel = (streamArbiter_1_io_output_payload_channel >>> 5'd16); // @ BaseType.scala l299
  assign streamDemux_1_io_select = tmp_io_select[1:0]; // @ Stream.scala l931
  assign tmp_st_a_o_data = {streamDemux_1_io_outputs_0_payload_sop,{streamDemux_1_io_outputs_0_payload_eop,{streamDemux_1_io_outputs_0_payload_empty,{streamDemux_1_io_outputs_0_payload_channel,streamDemux_1_io_outputs_0_payload_data}}}}; // @ BaseType.scala l299
  assign st_a_o_valid = streamDemux_1_io_outputs_0_valid; // @ AvstArbiterDemo.scala l48
  assign st_a_o_data = tmp_st_a_o_data[15 : 0]; // @ AvstArbiterDemo.scala l48
  assign st_a_o_channel = tmp_st_a_o_data[40 : 16]; // @ AvstArbiterDemo.scala l48
  assign st_a_o_empty = tmp_st_a_o_data[41 : 41]; // @ AvstArbiterDemo.scala l48
  assign st_a_o_endofpacket = tmp_st_a_o_data[42]; // @ AvstArbiterDemo.scala l48
  assign st_a_o_startofpacket = tmp_st_a_o_data[43]; // @ AvstArbiterDemo.scala l48
  assign tmp_st_b_o_data = {streamDemux_1_io_outputs_1_payload_sop,{streamDemux_1_io_outputs_1_payload_eop,{streamDemux_1_io_outputs_1_payload_empty,{streamDemux_1_io_outputs_1_payload_channel,streamDemux_1_io_outputs_1_payload_data}}}}; // @ BaseType.scala l299
  assign st_b_o_valid = streamDemux_1_io_outputs_1_valid; // @ AvstArbiterDemo.scala l48
  assign st_b_o_data = tmp_st_b_o_data[15 : 0]; // @ AvstArbiterDemo.scala l48
  assign st_b_o_channel = tmp_st_b_o_data[40 : 16]; // @ AvstArbiterDemo.scala l48
  assign st_b_o_empty = tmp_st_b_o_data[41 : 41]; // @ AvstArbiterDemo.scala l48
  assign st_b_o_endofpacket = tmp_st_b_o_data[42]; // @ AvstArbiterDemo.scala l48
  assign st_b_o_startofpacket = tmp_st_b_o_data[43]; // @ AvstArbiterDemo.scala l48
  assign tmp_st_c_o_data = {streamDemux_1_io_outputs_2_payload_sop,{streamDemux_1_io_outputs_2_payload_eop,{streamDemux_1_io_outputs_2_payload_empty,{streamDemux_1_io_outputs_2_payload_channel,streamDemux_1_io_outputs_2_payload_data}}}}; // @ BaseType.scala l299
  assign st_c_o_valid = streamDemux_1_io_outputs_2_valid; // @ AvstArbiterDemo.scala l48
  assign st_c_o_data = tmp_st_c_o_data[15 : 0]; // @ AvstArbiterDemo.scala l48
  assign st_c_o_channel = tmp_st_c_o_data[40 : 16]; // @ AvstArbiterDemo.scala l48
  assign st_c_o_empty = tmp_st_c_o_data[41 : 41]; // @ AvstArbiterDemo.scala l48
  assign st_c_o_endofpacket = tmp_st_c_o_data[42]; // @ AvstArbiterDemo.scala l48
  assign st_c_o_startofpacket = tmp_st_c_o_data[43]; // @ AvstArbiterDemo.scala l48

endmodule
