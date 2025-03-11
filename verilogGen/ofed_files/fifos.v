// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : fifos
// Git hash  : 49efc9243c37053f9cb9628511cfed8eea9c0c37



module fifos (
);

  wire                fifo_clock;
  wire                fifo_1_clock;
  wire                fifo_2_clock;
  wire                fifo_3_clock;
  wire                fifo_4_clock;
  wire                fifo_5_clock;
  wire                fifo_6_clock;
  wire                fifo_7_clock;
  wire                fifo_8_clock;
  wire                fifo_9_clock;
  wire                fifo_10_clock;
  wire                fifo_11_clock;
  wire                fifo_12_clock;
  wire                fifo_13_clock;
  wire                fifo_14_clock;
  wire                fifo_15_clock;
  wire                fifo_16_clock;
  wire                fifo_17_clock;
  wire                fifo_18_clock;
  wire                fifo_19_clock;
  wire                fifo_20_clock;
  wire       [63:0]   fifo_q;
  wire                fifo_full;
  wire                fifo_empty;
  wire                fifo_perror;
  wire                fifo_almost_full;
  wire                fifo_almostfull;
  wire       [63:0]   fifo_1_q;
  wire                fifo_1_full;
  wire                fifo_1_empty;
  wire                fifo_1_perror;
  wire                fifo_1_almost_full;
  wire                fifo_1_almostfull;
  wire       [7:0]    fifo_2_q;
  wire                fifo_2_full;
  wire                fifo_2_empty;
  wire                fifo_2_perror;
  wire                fifo_2_almost_full;
  wire                fifo_2_almostfull;
  wire       [7:0]    fifo_3_q;
  wire                fifo_3_full;
  wire                fifo_3_empty;
  wire                fifo_3_perror;
  wire                fifo_3_almost_full;
  wire                fifo_3_almostfull;
  wire       [7:0]    fifo_4_q;
  wire                fifo_4_full;
  wire                fifo_4_empty;
  wire                fifo_4_perror;
  wire                fifo_4_almost_full;
  wire                fifo_4_almostfull;
  wire       [1023:0] fifo_5_q;
  wire                fifo_5_full;
  wire                fifo_5_empty;
  wire                fifo_5_perror;
  wire                fifo_5_almost_full;
  wire                fifo_5_almostfull;
  wire       [307:0]  fifo_6_q;
  wire                fifo_6_full;
  wire                fifo_6_empty;
  wire                fifo_6_perror;
  wire                fifo_6_almost_full;
  wire                fifo_6_almostfull;
  wire       [127:0]  fifo_7_q;
  wire                fifo_7_full;
  wire                fifo_7_empty;
  wire                fifo_7_perror;
  wire                fifo_7_almost_full;
  wire                fifo_7_almostfull;
  wire       [23:0]   fifo_8_q;
  wire                fifo_8_full;
  wire                fifo_8_empty;
  wire                fifo_8_perror;
  wire                fifo_8_almost_full;
  wire                fifo_8_almostfull;
  wire       [23:0]   fifo_9_q;
  wire                fifo_9_full;
  wire                fifo_9_empty;
  wire                fifo_9_perror;
  wire                fifo_9_almost_full;
  wire                fifo_9_almostfull;
  wire       [31:0]   fifo_10_q;
  wire                fifo_10_full;
  wire                fifo_10_empty;
  wire                fifo_10_perror;
  wire                fifo_10_almost_full;
  wire                fifo_10_almostfull;
  wire       [255:0]  fifo_11_q;
  wire                fifo_11_full;
  wire                fifo_11_empty;
  wire                fifo_11_perror;
  wire                fifo_11_almost_full;
  wire                fifo_11_almostfull;
  wire       [264:0]  fifo_12_q;
  wire                fifo_12_full;
  wire                fifo_12_empty;
  wire                fifo_12_perror;
  wire                fifo_12_almost_full;
  wire                fifo_12_almostfull;
  wire       [39:0]   fifo_13_q;
  wire                fifo_13_full;
  wire                fifo_13_empty;
  wire                fifo_13_perror;
  wire                fifo_13_almost_full;
  wire                fifo_13_almostfull;
  wire       [10:0]   fifo_14_q;
  wire                fifo_14_full;
  wire                fifo_14_empty;
  wire                fifo_14_perror;
  wire                fifo_14_almost_full;
  wire                fifo_14_almostfull;
  wire       [511:0]  fifo_15_q;
  wire                fifo_15_full;
  wire                fifo_15_empty;
  wire                fifo_15_perror;
  wire                fifo_15_almost_full;
  wire                fifo_15_almostfull;
  wire       [127:0]  fifo_16_q;
  wire                fifo_16_full;
  wire                fifo_16_empty;
  wire                fifo_16_perror;
  wire                fifo_16_almost_full;
  wire                fifo_16_almostfull;
  wire       [95:0]   fifo_17_q;
  wire                fifo_17_full;
  wire                fifo_17_empty;
  wire                fifo_17_perror;
  wire                fifo_17_almost_full;
  wire                fifo_17_almostfull;
  wire       [103:0]  fifo_18_q;
  wire                fifo_18_full;
  wire                fifo_18_empty;
  wire                fifo_18_perror;
  wire                fifo_18_almost_full;
  wire                fifo_18_almostfull;
  wire       [264:0]  fifo_19_q;
  wire                fifo_19_full;
  wire                fifo_19_empty;
  wire                fifo_19_perror;
  wire                fifo_19_almost_full;
  wire                fifo_19_almostfull;
  wire       [255:0]  fifo_20_q;
  wire                fifo_20_full;
  wire                fifo_20_empty;
  wire                fifo_20_perror;
  wire                fifo_20_almost_full;
  wire                fifo_20_almostfull;
  wire       [127:0]  dcfifo_q;
  wire                dcfifo_full;
  wire                dcfifo_empty;
  wire                dcfifo_perror;
  wire                dcfifo_fault;
  wire                dcfifo_almost_full;
  wire       [39:0]   dcfifo_1_q;
  wire                dcfifo_1_full;
  wire                dcfifo_1_empty;
  wire                dcfifo_1_perror;
  wire                dcfifo_1_fault;
  wire                dcfifo_1_almost_full;
  wire       [521:0]  dcfifo_2_q;
  wire                dcfifo_2_full;
  wire                dcfifo_2_empty;
  wire                dcfifo_2_perror;
  wire                dcfifo_2_fault;
  wire                dcfifo_2_almost_full;
  wire       [0:0]    dcfifo_3_q;
  wire                dcfifo_3_full;
  wire                dcfifo_3_empty;
  wire                dcfifo_3_perror;
  wire                dcfifo_3_fault;
  wire                dcfifo_3_almost_full;
  wire       [7:0]    dcfifo_4_q;
  wire                dcfifo_4_full;
  wire                dcfifo_4_empty;
  wire                dcfifo_4_perror;
  wire                dcfifo_4_fault;
  wire                dcfifo_4_almost_full;
  wire       [55:0]   dcfifo_5_q;
  wire                dcfifo_5_full;
  wire                dcfifo_5_empty;
  wire                dcfifo_5_perror;
  wire                dcfifo_5_fault;
  wire                dcfifo_5_almost_full;

  fifo8x64 fifo (
    .fifo_error_enable (1'b0            ), //i
    .core_clock        (1'b0            ), //i
    .data              (64'h0           ), //i
    .wrreq             (1'b0            ), //i
    .rdreq             (1'b0            ), //i
    .clock             (fifo_clock      ), //i
    .aclr              (1'b0            ), //i
    .sclr              (1'b0            ), //i
    .q                 (fifo_q[63:0]    ), //o
    .full              (fifo_full       ), //o
    .empty             (fifo_empty      ), //o
    .perror            (fifo_perror     ), //o
    .almost_full       (fifo_almost_full), //o
    .almostfull        (fifo_almostfull )  //o
  );
  fifo32x64 fifo_1 (
    .fifo_error_enable (1'b0              ), //i
    .core_clock        (1'b0              ), //i
    .data              (64'h0             ), //i
    .wrreq             (1'b0              ), //i
    .rdreq             (1'b0              ), //i
    .clock             (fifo_1_clock      ), //i
    .aclr              (1'b0              ), //i
    .sclr              (1'b0              ), //i
    .q                 (fifo_1_q[63:0]    ), //o
    .full              (fifo_1_full       ), //o
    .empty             (fifo_1_empty      ), //o
    .perror            (fifo_1_perror     ), //o
    .almost_full       (fifo_1_almost_full), //o
    .almostfull        (fifo_1_almostfull )  //o
  );
  fifo8x8 fifo_2 (
    .fifo_error_enable (1'b0              ), //i
    .core_clock        (1'b0              ), //i
    .data              (8'h0              ), //i
    .wrreq             (1'b0              ), //i
    .rdreq             (1'b0              ), //i
    .clock             (fifo_2_clock      ), //i
    .aclr              (1'b0              ), //i
    .sclr              (1'b0              ), //i
    .q                 (fifo_2_q[7:0]     ), //o
    .full              (fifo_2_full       ), //o
    .empty             (fifo_2_empty      ), //o
    .perror            (fifo_2_perror     ), //o
    .almost_full       (fifo_2_almost_full), //o
    .almostfull        (fifo_2_almostfull )  //o
  );
  fifo128x8 fifo_3 (
    .fifo_error_enable (1'b0              ), //i
    .core_clock        (1'b0              ), //i
    .data              (8'h0              ), //i
    .wrreq             (1'b0              ), //i
    .rdreq             (1'b0              ), //i
    .clock             (fifo_3_clock      ), //i
    .aclr              (1'b0              ), //i
    .sclr              (1'b0              ), //i
    .q                 (fifo_3_q[7:0]     ), //o
    .full              (fifo_3_full       ), //o
    .empty             (fifo_3_empty      ), //o
    .perror            (fifo_3_perror     ), //o
    .almost_full       (fifo_3_almost_full), //o
    .almostfull        (fifo_3_almostfull )  //o
  );
  fifo16x8 fifo_4 (
    .fifo_error_enable (1'b0              ), //i
    .core_clock        (1'b0              ), //i
    .data              (8'h0              ), //i
    .wrreq             (1'b0              ), //i
    .rdreq             (1'b0              ), //i
    .clock             (fifo_4_clock      ), //i
    .aclr              (1'b0              ), //i
    .sclr              (1'b0              ), //i
    .q                 (fifo_4_q[7:0]     ), //o
    .full              (fifo_4_full       ), //o
    .empty             (fifo_4_empty      ), //o
    .perror            (fifo_4_perror     ), //o
    .almost_full       (fifo_4_almost_full), //o
    .almostfull        (fifo_4_almostfull )  //o
  );
  fifo32x1024 fifo_5 (
    .fifo_error_enable (1'b0              ), //i
    .core_clock        (1'b0              ), //i
    .data              (1024'h0           ), //i
    .wrreq             (1'b0              ), //i
    .rdreq             (1'b0              ), //i
    .clock             (fifo_5_clock      ), //i
    .aclr              (1'b0              ), //i
    .sclr              (1'b0              ), //i
    .q                 (fifo_5_q[1023:0]  ), //o
    .full              (fifo_5_full       ), //o
    .empty             (fifo_5_empty      ), //o
    .perror            (fifo_5_perror     ), //o
    .almost_full       (fifo_5_almost_full), //o
    .almostfull        (fifo_5_almostfull )  //o
  );
  fifo32x308 fifo_6 (
    .fifo_error_enable (1'b0              ), //i
    .core_clock        (1'b0              ), //i
    .data              (308'h0            ), //i
    .wrreq             (1'b0              ), //i
    .rdreq             (1'b0              ), //i
    .clock             (fifo_6_clock      ), //i
    .aclr              (1'b0              ), //i
    .sclr              (1'b0              ), //i
    .q                 (fifo_6_q[307:0]   ), //o
    .full              (fifo_6_full       ), //o
    .empty             (fifo_6_empty      ), //o
    .perror            (fifo_6_perror     ), //o
    .almost_full       (fifo_6_almost_full), //o
    .almostfull        (fifo_6_almostfull )  //o
  );
  fifo32x128 fifo_7 (
    .fifo_error_enable (1'b0              ), //i
    .core_clock        (1'b0              ), //i
    .data              (128'h0            ), //i
    .wrreq             (1'b0              ), //i
    .rdreq             (1'b0              ), //i
    .clock             (fifo_7_clock      ), //i
    .aclr              (1'b0              ), //i
    .sclr              (1'b0              ), //i
    .q                 (fifo_7_q[127:0]   ), //o
    .full              (fifo_7_full       ), //o
    .empty             (fifo_7_empty      ), //o
    .perror            (fifo_7_perror     ), //o
    .almost_full       (fifo_7_almost_full), //o
    .almostfull        (fifo_7_almostfull )  //o
  );
  fifo8x24 fifo_8 (
    .fifo_error_enable (1'b0              ), //i
    .core_clock        (1'b0              ), //i
    .data              (24'h0             ), //i
    .wrreq             (1'b0              ), //i
    .rdreq             (1'b0              ), //i
    .clock             (fifo_8_clock      ), //i
    .aclr              (1'b0              ), //i
    .sclr              (1'b0              ), //i
    .q                 (fifo_8_q[23:0]    ), //o
    .full              (fifo_8_full       ), //o
    .empty             (fifo_8_empty      ), //o
    .perror            (fifo_8_perror     ), //o
    .almost_full       (fifo_8_almost_full), //o
    .almostfull        (fifo_8_almostfull )  //o
  );
  fifo1Kx24 fifo_9 (
    .fifo_error_enable (1'b0              ), //i
    .core_clock        (1'b0              ), //i
    .data              (24'h0             ), //i
    .wrreq             (1'b0              ), //i
    .rdreq             (1'b0              ), //i
    .clock             (fifo_9_clock      ), //i
    .aclr              (1'b0              ), //i
    .sclr              (1'b0              ), //i
    .q                 (fifo_9_q[23:0]    ), //o
    .full              (fifo_9_full       ), //o
    .empty             (fifo_9_empty      ), //o
    .perror            (fifo_9_perror     ), //o
    .almost_full       (fifo_9_almost_full), //o
    .almostfull        (fifo_9_almostfull )  //o
  );
  fifo32x32 fifo_10 (
    .fifo_error_enable (1'b0               ), //i
    .core_clock        (1'b0               ), //i
    .data              (32'h0              ), //i
    .wrreq             (1'b0               ), //i
    .rdreq             (1'b0               ), //i
    .clock             (fifo_10_clock      ), //i
    .aclr              (1'b0               ), //i
    .sclr              (1'b0               ), //i
    .q                 (fifo_10_q[31:0]    ), //o
    .full              (fifo_10_full       ), //o
    .empty             (fifo_10_empty      ), //o
    .perror            (fifo_10_perror     ), //o
    .almost_full       (fifo_10_almost_full), //o
    .almostfull        (fifo_10_almostfull )  //o
  );
  fifo32x256 fifo_11 (
    .fifo_error_enable (1'b0               ), //i
    .core_clock        (1'b0               ), //i
    .data              (256'h0             ), //i
    .wrreq             (1'b0               ), //i
    .rdreq             (1'b0               ), //i
    .clock             (fifo_11_clock      ), //i
    .aclr              (1'b0               ), //i
    .sclr              (1'b0               ), //i
    .q                 (fifo_11_q[255:0]   ), //o
    .full              (fifo_11_full       ), //o
    .empty             (fifo_11_empty      ), //o
    .perror            (fifo_11_perror     ), //o
    .almost_full       (fifo_11_almost_full), //o
    .almostfull        (fifo_11_almostfull )  //o
  );
  fifo32x265 fifo_12 (
    .fifo_error_enable (1'b0               ), //i
    .core_clock        (1'b0               ), //i
    .data              (265'h0             ), //i
    .wrreq             (1'b0               ), //i
    .rdreq             (1'b0               ), //i
    .clock             (fifo_12_clock      ), //i
    .aclr              (1'b0               ), //i
    .sclr              (1'b0               ), //i
    .q                 (fifo_12_q[264:0]   ), //o
    .full              (fifo_12_full       ), //o
    .empty             (fifo_12_empty      ), //o
    .perror            (fifo_12_perror     ), //o
    .almost_full       (fifo_12_almost_full), //o
    .almostfull        (fifo_12_almostfull )  //o
  );
  fifo32x40 fifo_13 (
    .fifo_error_enable (1'b0               ), //i
    .core_clock        (1'b0               ), //i
    .data              (40'h0              ), //i
    .wrreq             (1'b0               ), //i
    .rdreq             (1'b0               ), //i
    .clock             (fifo_13_clock      ), //i
    .aclr              (1'b0               ), //i
    .sclr              (1'b0               ), //i
    .q                 (fifo_13_q[39:0]    ), //o
    .full              (fifo_13_full       ), //o
    .empty             (fifo_13_empty      ), //o
    .perror            (fifo_13_perror     ), //o
    .almost_full       (fifo_13_almost_full), //o
    .almostfull        (fifo_13_almostfull )  //o
  );
  fifo32x11 fifo_14 (
    .fifo_error_enable (1'b0               ), //i
    .core_clock        (1'b0               ), //i
    .data              (11'h0              ), //i
    .wrreq             (1'b0               ), //i
    .rdreq             (1'b0               ), //i
    .clock             (fifo_14_clock      ), //i
    .aclr              (1'b0               ), //i
    .sclr              (1'b0               ), //i
    .q                 (fifo_14_q[10:0]    ), //o
    .full              (fifo_14_full       ), //o
    .empty             (fifo_14_empty      ), //o
    .perror            (fifo_14_perror     ), //o
    .almost_full       (fifo_14_almost_full), //o
    .almostfull        (fifo_14_almostfull )  //o
  );
  fifo8x512 fifo_15 (
    .fifo_error_enable (1'b0               ), //i
    .core_clock        (1'b0               ), //i
    .data              (512'h0             ), //i
    .wrreq             (1'b0               ), //i
    .rdreq             (1'b0               ), //i
    .clock             (fifo_15_clock      ), //i
    .aclr              (1'b0               ), //i
    .sclr              (1'b0               ), //i
    .q                 (fifo_15_q[511:0]   ), //o
    .full              (fifo_15_full       ), //o
    .empty             (fifo_15_empty      ), //o
    .perror            (fifo_15_perror     ), //o
    .almost_full       (fifo_15_almost_full), //o
    .almostfull        (fifo_15_almostfull )  //o
  );
  fifo64x128 fifo_16 (
    .fifo_error_enable (1'b0               ), //i
    .core_clock        (1'b0               ), //i
    .data              (128'h0             ), //i
    .wrreq             (1'b0               ), //i
    .rdreq             (1'b0               ), //i
    .clock             (fifo_16_clock      ), //i
    .aclr              (1'b0               ), //i
    .sclr              (1'b0               ), //i
    .q                 (fifo_16_q[127:0]   ), //o
    .full              (fifo_16_full       ), //o
    .empty             (fifo_16_empty      ), //o
    .perror            (fifo_16_perror     ), //o
    .almost_full       (fifo_16_almost_full), //o
    .almostfull        (fifo_16_almostfull )  //o
  );
  fifo32x96 fifo_17 (
    .fifo_error_enable (1'b0               ), //i
    .core_clock        (1'b0               ), //i
    .data              (96'h0              ), //i
    .wrreq             (1'b0               ), //i
    .rdreq             (1'b0               ), //i
    .clock             (fifo_17_clock      ), //i
    .aclr              (1'b0               ), //i
    .sclr              (1'b0               ), //i
    .q                 (fifo_17_q[95:0]    ), //o
    .full              (fifo_17_full       ), //o
    .empty             (fifo_17_empty      ), //o
    .perror            (fifo_17_perror     ), //o
    .almost_full       (fifo_17_almost_full), //o
    .almostfull        (fifo_17_almostfull )  //o
  );
  fifo32x104 fifo_18 (
    .fifo_error_enable (1'b0               ), //i
    .core_clock        (1'b0               ), //i
    .data              (104'h0             ), //i
    .wrreq             (1'b0               ), //i
    .rdreq             (1'b0               ), //i
    .clock             (fifo_18_clock      ), //i
    .aclr              (1'b0               ), //i
    .sclr              (1'b0               ), //i
    .q                 (fifo_18_q[103:0]   ), //o
    .full              (fifo_18_full       ), //o
    .empty             (fifo_18_empty      ), //o
    .perror            (fifo_18_perror     ), //o
    .almost_full       (fifo_18_almost_full), //o
    .almostfull        (fifo_18_almostfull )  //o
  );
  fifo64x265 fifo_19 (
    .fifo_error_enable (1'b0               ), //i
    .core_clock        (1'b0               ), //i
    .data              (265'h0             ), //i
    .wrreq             (1'b0               ), //i
    .rdreq             (1'b0               ), //i
    .clock             (fifo_19_clock      ), //i
    .aclr              (1'b0               ), //i
    .sclr              (1'b0               ), //i
    .q                 (fifo_19_q[264:0]   ), //o
    .full              (fifo_19_full       ), //o
    .empty             (fifo_19_empty      ), //o
    .perror            (fifo_19_perror     ), //o
    .almost_full       (fifo_19_almost_full), //o
    .almostfull        (fifo_19_almostfull )  //o
  );
  fifo64x256 fifo_20 (
    .fifo_error_enable (1'b0               ), //i
    .core_clock        (1'b0               ), //i
    .data              (256'h0             ), //i
    .wrreq             (1'b0               ), //i
    .rdreq             (1'b0               ), //i
    .clock             (fifo_20_clock      ), //i
    .aclr              (1'b0               ), //i
    .sclr              (1'b0               ), //i
    .q                 (fifo_20_q[255:0]   ), //o
    .full              (fifo_20_full       ), //o
    .empty             (fifo_20_empty      ), //o
    .perror            (fifo_20_perror     ), //o
    .almost_full       (fifo_20_almost_full), //o
    .almostfull        (fifo_20_almostfull )  //o
  );
  dcfifo8x128 dcfifo (
    .fifo_error_enable (1'b0              ), //i
    .core_clock        (1'b0              ), //i
    .data              (128'h0            ), //i
    .wrreq             (1'b0              ), //i
    .rdreq             (1'b0              ), //i
    .wrclk             (1'b0              ), //i
    .rdclk_srstn       (1'b0              ), //i
    .wrclk_srstn       (1'b0              ), //i
    .rdclk             (1'b0              ), //i
    .aclr              (1'b0              ), //i
    .q                 (dcfifo_q[127:0]   ), //o
    .full              (dcfifo_full       ), //o
    .empty             (dcfifo_empty      ), //o
    .perror            (dcfifo_perror     ), //o
    .fault             (dcfifo_fault      ), //o
    .almost_full       (dcfifo_almost_full)  //o
  );
  dcfifo32x40 dcfifo_1 (
    .fifo_error_enable (1'b0                ), //i
    .core_clock        (1'b0                ), //i
    .data              (40'h0               ), //i
    .wrreq             (1'b0                ), //i
    .rdreq             (1'b0                ), //i
    .wrclk             (1'b0                ), //i
    .rdclk_srstn       (1'b0                ), //i
    .wrclk_srstn       (1'b0                ), //i
    .rdclk             (1'b0                ), //i
    .aclr              (1'b0                ), //i
    .q                 (dcfifo_1_q[39:0]    ), //o
    .full              (dcfifo_1_full       ), //o
    .empty             (dcfifo_1_empty      ), //o
    .perror            (dcfifo_1_perror     ), //o
    .fault             (dcfifo_1_fault      ), //o
    .almost_full       (dcfifo_1_almost_full)  //o
  );
  dcfifo128x522 dcfifo_2 (
    .fifo_error_enable (1'b0                ), //i
    .core_clock        (1'b0                ), //i
    .data              (522'h0              ), //i
    .wrreq             (1'b0                ), //i
    .rdreq             (1'b0                ), //i
    .wrclk             (1'b0                ), //i
    .rdclk_srstn       (1'b0                ), //i
    .wrclk_srstn       (1'b0                ), //i
    .rdclk             (1'b0                ), //i
    .aclr              (1'b0                ), //i
    .q                 (dcfifo_2_q[521:0]   ), //o
    .full              (dcfifo_2_full       ), //o
    .empty             (dcfifo_2_empty      ), //o
    .perror            (dcfifo_2_perror     ), //o
    .fault             (dcfifo_2_fault      ), //o
    .almost_full       (dcfifo_2_almost_full)  //o
  );
  dcfifo16x1 dcfifo_3 (
    .fifo_error_enable (1'b0                ), //i
    .core_clock        (1'b0                ), //i
    .data              (1'b0                ), //i
    .wrreq             (1'b0                ), //i
    .rdreq             (1'b0                ), //i
    .wrclk             (1'b0                ), //i
    .rdclk_srstn       (1'b0                ), //i
    .wrclk_srstn       (1'b0                ), //i
    .rdclk             (1'b0                ), //i
    .aclr              (1'b0                ), //i
    .q                 (dcfifo_3_q          ), //o
    .full              (dcfifo_3_full       ), //o
    .empty             (dcfifo_3_empty      ), //o
    .perror            (dcfifo_3_perror     ), //o
    .fault             (dcfifo_3_fault      ), //o
    .almost_full       (dcfifo_3_almost_full)  //o
  );
  dcfifo16x8 dcfifo_4 (
    .fifo_error_enable (1'b0                ), //i
    .core_clock        (1'b0                ), //i
    .data              (8'h0                ), //i
    .wrreq             (1'b0                ), //i
    .rdreq             (1'b0                ), //i
    .wrclk             (1'b0                ), //i
    .rdclk_srstn       (1'b0                ), //i
    .wrclk_srstn       (1'b0                ), //i
    .rdclk             (1'b0                ), //i
    .aclr              (1'b0                ), //i
    .q                 (dcfifo_4_q[7:0]     ), //o
    .full              (dcfifo_4_full       ), //o
    .empty             (dcfifo_4_empty      ), //o
    .perror            (dcfifo_4_perror     ), //o
    .fault             (dcfifo_4_fault      ), //o
    .almost_full       (dcfifo_4_almost_full)  //o
  );
  dcfifo32x56 dcfifo_5 (
    .fifo_error_enable (1'b0                ), //i
    .core_clock        (1'b0                ), //i
    .data              (56'h0               ), //i
    .wrreq             (1'b0                ), //i
    .rdreq             (1'b0                ), //i
    .wrclk             (1'b0                ), //i
    .rdclk_srstn       (1'b0                ), //i
    .wrclk_srstn       (1'b0                ), //i
    .rdclk             (1'b0                ), //i
    .aclr              (1'b0                ), //i
    .q                 (dcfifo_5_q[55:0]    ), //o
    .full              (dcfifo_5_full       ), //o
    .empty             (dcfifo_5_empty      ), //o
    .perror            (dcfifo_5_perror     ), //o
    .fault             (dcfifo_5_fault      ), //o
    .almost_full       (dcfifo_5_almost_full)  //o
  );

endmodule

module dcfifo32x56 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [55:0]   data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          wrclk,
  input  wire          rdclk_srstn,
  input  wire          wrclk_srstn,
  input  wire          rdclk,
  input  wire          aclr,
  output wire [55:0]   q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          fault,
  output wire          almost_full
);

  wire                fifo_cc_io_push_ready;
  wire                fifo_cc_io_pop_valid;
  wire       [55:0]   fifo_cc_io_pop_payload;
  wire       [5:0]    fifo_cc_io_pushOccupancy;
  wire       [5:0]    fifo_cc_io_popOccupancy;
  wire                push_valid;
  wire                push_ready;
  wire       [55:0]   push_payload;
  wire                pop_valid;
  wire                pop_ready;
  wire       [55:0]   pop_payload;

  StreamFifoCC fifo_cc (
    .io_push_valid    (push_valid                   ), //i
    .io_push_ready    (fifo_cc_io_push_ready        ), //o
    .io_push_payload  (push_payload[55:0]           ), //i
    .io_pop_valid     (fifo_cc_io_pop_valid         ), //o
    .io_pop_ready     (pop_ready                    ), //i
    .io_pop_payload   (fifo_cc_io_pop_payload[55:0] ), //o
    .io_pushOccupancy (fifo_cc_io_pushOccupancy[5:0]), //o
    .io_popOccupancy  (fifo_cc_io_popOccupancy[5:0] ), //o
    .wrclk            (wrclk                        ), //i
    .wrclk_srstn      (wrclk_srstn                  ), //i
    .rdclk            (rdclk                        )  //i
  );
  assign push_ready = fifo_cc_io_push_ready; // @ Stream.scala l299
  assign pop_valid = fifo_cc_io_pop_valid; // @ Stream.scala l298
  assign pop_payload = fifo_cc_io_pop_payload; // @ Stream.scala l300
  assign push_valid = wrreq; // @ fifos.scala l72
  assign push_payload = data; // @ fifos.scala l73
  assign full = (! push_ready); // @ fifos.scala l74
  assign empty = (! pop_valid); // @ fifos.scala l75
  assign q = pop_payload; // @ fifos.scala l76
  assign pop_ready = rdreq; // @ fifos.scala l77
  assign perror = 1'b0; // @ Bool.scala l92
  assign fault = 1'b0; // @ Bool.scala l92
  assign almost_full = 1'b0; // @ Bool.scala l92

endmodule

module dcfifo16x8 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [7:0]    data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          wrclk,
  input  wire          rdclk_srstn,
  input  wire          wrclk_srstn,
  input  wire          rdclk,
  input  wire          aclr,
  output wire [7:0]    q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          fault,
  output wire          almost_full
);

  wire                fifo_cc_io_push_ready;
  wire                fifo_cc_io_pop_valid;
  wire       [7:0]    fifo_cc_io_pop_payload;
  wire       [4:0]    fifo_cc_io_pushOccupancy;
  wire       [4:0]    fifo_cc_io_popOccupancy;
  wire                push_valid;
  wire                push_ready;
  wire       [7:0]    push_payload;
  wire                pop_valid;
  wire                pop_ready;
  wire       [7:0]    pop_payload;

  StreamFifoCC_1 fifo_cc (
    .io_push_valid    (push_valid                   ), //i
    .io_push_ready    (fifo_cc_io_push_ready        ), //o
    .io_push_payload  (push_payload[7:0]            ), //i
    .io_pop_valid     (fifo_cc_io_pop_valid         ), //o
    .io_pop_ready     (pop_ready                    ), //i
    .io_pop_payload   (fifo_cc_io_pop_payload[7:0]  ), //o
    .io_pushOccupancy (fifo_cc_io_pushOccupancy[4:0]), //o
    .io_popOccupancy  (fifo_cc_io_popOccupancy[4:0] ), //o
    .wrclk            (wrclk                        ), //i
    .wrclk_srstn      (wrclk_srstn                  ), //i
    .rdclk            (rdclk                        )  //i
  );
  assign push_ready = fifo_cc_io_push_ready; // @ Stream.scala l299
  assign pop_valid = fifo_cc_io_pop_valid; // @ Stream.scala l298
  assign pop_payload = fifo_cc_io_pop_payload; // @ Stream.scala l300
  assign push_valid = wrreq; // @ fifos.scala l72
  assign push_payload = data; // @ fifos.scala l73
  assign full = (! push_ready); // @ fifos.scala l74
  assign empty = (! pop_valid); // @ fifos.scala l75
  assign q = pop_payload; // @ fifos.scala l76
  assign pop_ready = rdreq; // @ fifos.scala l77
  assign perror = 1'b0; // @ Bool.scala l92
  assign fault = 1'b0; // @ Bool.scala l92
  assign almost_full = 1'b0; // @ Bool.scala l92

endmodule

module dcfifo16x1 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [0:0]    data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          wrclk,
  input  wire          rdclk_srstn,
  input  wire          wrclk_srstn,
  input  wire          rdclk,
  input  wire          aclr,
  output wire [0:0]    q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          fault,
  output wire          almost_full
);

  wire                fifo_cc_io_push_ready;
  wire                fifo_cc_io_pop_valid;
  wire       [0:0]    fifo_cc_io_pop_payload;
  wire       [4:0]    fifo_cc_io_pushOccupancy;
  wire       [4:0]    fifo_cc_io_popOccupancy;
  wire                push_valid;
  wire                push_ready;
  wire       [0:0]    push_payload;
  wire                pop_valid;
  wire                pop_ready;
  wire       [0:0]    pop_payload;

  StreamFifoCC_2 fifo_cc (
    .io_push_valid    (push_valid                   ), //i
    .io_push_ready    (fifo_cc_io_push_ready        ), //o
    .io_push_payload  (push_payload                 ), //i
    .io_pop_valid     (fifo_cc_io_pop_valid         ), //o
    .io_pop_ready     (pop_ready                    ), //i
    .io_pop_payload   (fifo_cc_io_pop_payload       ), //o
    .io_pushOccupancy (fifo_cc_io_pushOccupancy[4:0]), //o
    .io_popOccupancy  (fifo_cc_io_popOccupancy[4:0] ), //o
    .wrclk            (wrclk                        ), //i
    .wrclk_srstn      (wrclk_srstn                  ), //i
    .rdclk            (rdclk                        )  //i
  );
  assign push_ready = fifo_cc_io_push_ready; // @ Stream.scala l299
  assign pop_valid = fifo_cc_io_pop_valid; // @ Stream.scala l298
  assign pop_payload = fifo_cc_io_pop_payload; // @ Stream.scala l300
  assign push_valid = wrreq; // @ fifos.scala l72
  assign push_payload = data; // @ fifos.scala l73
  assign full = (! push_ready); // @ fifos.scala l74
  assign empty = (! pop_valid); // @ fifos.scala l75
  assign q = pop_payload; // @ fifos.scala l76
  assign pop_ready = rdreq; // @ fifos.scala l77
  assign perror = 1'b0; // @ Bool.scala l92
  assign fault = 1'b0; // @ Bool.scala l92
  assign almost_full = 1'b0; // @ Bool.scala l92

endmodule

module dcfifo128x522 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [521:0]  data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          wrclk,
  input  wire          rdclk_srstn,
  input  wire          wrclk_srstn,
  input  wire          rdclk,
  input  wire          aclr,
  output wire [521:0]  q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          fault,
  output wire          almost_full
);

  wire                fifo_cc_io_push_ready;
  wire                fifo_cc_io_pop_valid;
  wire       [521:0]  fifo_cc_io_pop_payload;
  wire       [7:0]    fifo_cc_io_pushOccupancy;
  wire       [7:0]    fifo_cc_io_popOccupancy;
  wire                push_valid;
  wire                push_ready;
  wire       [521:0]  push_payload;
  wire                pop_valid;
  wire                pop_ready;
  wire       [521:0]  pop_payload;

  StreamFifoCC_3 fifo_cc (
    .io_push_valid    (push_valid                   ), //i
    .io_push_ready    (fifo_cc_io_push_ready        ), //o
    .io_push_payload  (push_payload[521:0]          ), //i
    .io_pop_valid     (fifo_cc_io_pop_valid         ), //o
    .io_pop_ready     (pop_ready                    ), //i
    .io_pop_payload   (fifo_cc_io_pop_payload[521:0]), //o
    .io_pushOccupancy (fifo_cc_io_pushOccupancy[7:0]), //o
    .io_popOccupancy  (fifo_cc_io_popOccupancy[7:0] ), //o
    .wrclk            (wrclk                        ), //i
    .wrclk_srstn      (wrclk_srstn                  ), //i
    .rdclk            (rdclk                        )  //i
  );
  assign push_ready = fifo_cc_io_push_ready; // @ Stream.scala l299
  assign pop_valid = fifo_cc_io_pop_valid; // @ Stream.scala l298
  assign pop_payload = fifo_cc_io_pop_payload; // @ Stream.scala l300
  assign push_valid = wrreq; // @ fifos.scala l72
  assign push_payload = data; // @ fifos.scala l73
  assign full = (! push_ready); // @ fifos.scala l74
  assign empty = (! pop_valid); // @ fifos.scala l75
  assign q = pop_payload; // @ fifos.scala l76
  assign pop_ready = rdreq; // @ fifos.scala l77
  assign perror = 1'b0; // @ Bool.scala l92
  assign fault = 1'b0; // @ Bool.scala l92
  assign almost_full = 1'b0; // @ Bool.scala l92

endmodule

module dcfifo32x40 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [39:0]   data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          wrclk,
  input  wire          rdclk_srstn,
  input  wire          wrclk_srstn,
  input  wire          rdclk,
  input  wire          aclr,
  output wire [39:0]   q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          fault,
  output wire          almost_full
);

  wire                fifo_cc_io_push_ready;
  wire                fifo_cc_io_pop_valid;
  wire       [39:0]   fifo_cc_io_pop_payload;
  wire       [5:0]    fifo_cc_io_pushOccupancy;
  wire       [5:0]    fifo_cc_io_popOccupancy;
  wire                push_valid;
  wire                push_ready;
  wire       [39:0]   push_payload;
  wire                pop_valid;
  wire                pop_ready;
  wire       [39:0]   pop_payload;

  StreamFifoCC_4 fifo_cc (
    .io_push_valid    (push_valid                   ), //i
    .io_push_ready    (fifo_cc_io_push_ready        ), //o
    .io_push_payload  (push_payload[39:0]           ), //i
    .io_pop_valid     (fifo_cc_io_pop_valid         ), //o
    .io_pop_ready     (pop_ready                    ), //i
    .io_pop_payload   (fifo_cc_io_pop_payload[39:0] ), //o
    .io_pushOccupancy (fifo_cc_io_pushOccupancy[5:0]), //o
    .io_popOccupancy  (fifo_cc_io_popOccupancy[5:0] ), //o
    .wrclk            (wrclk                        ), //i
    .wrclk_srstn      (wrclk_srstn                  ), //i
    .rdclk            (rdclk                        )  //i
  );
  assign push_ready = fifo_cc_io_push_ready; // @ Stream.scala l299
  assign pop_valid = fifo_cc_io_pop_valid; // @ Stream.scala l298
  assign pop_payload = fifo_cc_io_pop_payload; // @ Stream.scala l300
  assign push_valid = wrreq; // @ fifos.scala l72
  assign push_payload = data; // @ fifos.scala l73
  assign full = (! push_ready); // @ fifos.scala l74
  assign empty = (! pop_valid); // @ fifos.scala l75
  assign q = pop_payload; // @ fifos.scala l76
  assign pop_ready = rdreq; // @ fifos.scala l77
  assign perror = 1'b0; // @ Bool.scala l92
  assign fault = 1'b0; // @ Bool.scala l92
  assign almost_full = 1'b0; // @ Bool.scala l92

endmodule

module dcfifo8x128 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [127:0]  data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          wrclk,
  input  wire          rdclk_srstn,
  input  wire          wrclk_srstn,
  input  wire          rdclk,
  input  wire          aclr,
  output wire [127:0]  q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          fault,
  output wire          almost_full
);

  wire                fifo_cc_io_push_ready;
  wire                fifo_cc_io_pop_valid;
  wire       [127:0]  fifo_cc_io_pop_payload;
  wire       [3:0]    fifo_cc_io_pushOccupancy;
  wire       [3:0]    fifo_cc_io_popOccupancy;
  wire                push_valid;
  wire                push_ready;
  wire       [127:0]  push_payload;
  wire                pop_valid;
  wire                pop_ready;
  wire       [127:0]  pop_payload;

  StreamFifoCC_5 fifo_cc (
    .io_push_valid    (push_valid                   ), //i
    .io_push_ready    (fifo_cc_io_push_ready        ), //o
    .io_push_payload  (push_payload[127:0]          ), //i
    .io_pop_valid     (fifo_cc_io_pop_valid         ), //o
    .io_pop_ready     (pop_ready                    ), //i
    .io_pop_payload   (fifo_cc_io_pop_payload[127:0]), //o
    .io_pushOccupancy (fifo_cc_io_pushOccupancy[3:0]), //o
    .io_popOccupancy  (fifo_cc_io_popOccupancy[3:0] ), //o
    .wrclk            (wrclk                        ), //i
    .wrclk_srstn      (wrclk_srstn                  ), //i
    .rdclk            (rdclk                        )  //i
  );
  assign push_ready = fifo_cc_io_push_ready; // @ Stream.scala l299
  assign pop_valid = fifo_cc_io_pop_valid; // @ Stream.scala l298
  assign pop_payload = fifo_cc_io_pop_payload; // @ Stream.scala l300
  assign push_valid = wrreq; // @ fifos.scala l72
  assign push_payload = data; // @ fifos.scala l73
  assign full = (! push_ready); // @ fifos.scala l74
  assign empty = (! pop_valid); // @ fifos.scala l75
  assign q = pop_payload; // @ fifos.scala l76
  assign pop_ready = rdreq; // @ fifos.scala l77
  assign perror = 1'b0; // @ Bool.scala l92
  assign fault = 1'b0; // @ Bool.scala l92
  assign almost_full = 1'b0; // @ Bool.scala l92

endmodule

module fifo64x256 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [255:0]  data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [255:0]  q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [255:0]  cldArea_stream_fifo_io_pop_payload;
  wire       [6:0]    cldArea_stream_fifo_io_occupancy;
  wire       [6:0]    cldArea_stream_fifo_io_availability;

  StreamFifo cldArea_stream_fifo (
    .io_push_valid   (wrreq                                    ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready        ), //o
    .io_push_payload (data[255:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid         ), //o
    .io_pop_ready    (rdreq                                    ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[255:0]), //o
    .io_flush        (1'b0                                     ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[6:0]    ), //o
    .io_availability (cldArea_stream_fifo_io_availability[6:0] ), //o
    .clock           (clock                                    ), //i
    .aclr            (aclr                                     )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo64x265 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [264:0]  data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [264:0]  q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [264:0]  cldArea_stream_fifo_io_pop_payload;
  wire       [6:0]    cldArea_stream_fifo_io_occupancy;
  wire       [6:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_1 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                    ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready        ), //o
    .io_push_payload (data[264:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid         ), //o
    .io_pop_ready    (rdreq                                    ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[264:0]), //o
    .io_flush        (1'b0                                     ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[6:0]    ), //o
    .io_availability (cldArea_stream_fifo_io_availability[6:0] ), //o
    .clock           (clock                                    ), //i
    .aclr            (aclr                                     )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo32x104 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [103:0]  data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [103:0]  q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [103:0]  cldArea_stream_fifo_io_pop_payload;
  wire       [5:0]    cldArea_stream_fifo_io_occupancy;
  wire       [5:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_2 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                    ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready        ), //o
    .io_push_payload (data[103:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid         ), //o
    .io_pop_ready    (rdreq                                    ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[103:0]), //o
    .io_flush        (1'b0                                     ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[5:0]    ), //o
    .io_availability (cldArea_stream_fifo_io_availability[5:0] ), //o
    .clock           (clock                                    ), //i
    .aclr            (aclr                                     )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo32x96 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [95:0]   data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [95:0]   q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [95:0]   cldArea_stream_fifo_io_pop_payload;
  wire       [5:0]    cldArea_stream_fifo_io_occupancy;
  wire       [5:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_3 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                   ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready       ), //o
    .io_push_payload (data[95:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid        ), //o
    .io_pop_ready    (rdreq                                   ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[95:0]), //o
    .io_flush        (1'b0                                    ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[5:0]   ), //o
    .io_availability (cldArea_stream_fifo_io_availability[5:0]), //o
    .clock           (clock                                   ), //i
    .aclr            (aclr                                    )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo64x128 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [127:0]  data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [127:0]  q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [127:0]  cldArea_stream_fifo_io_pop_payload;
  wire       [6:0]    cldArea_stream_fifo_io_occupancy;
  wire       [6:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_4 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                    ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready        ), //o
    .io_push_payload (data[127:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid         ), //o
    .io_pop_ready    (rdreq                                    ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[127:0]), //o
    .io_flush        (1'b0                                     ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[6:0]    ), //o
    .io_availability (cldArea_stream_fifo_io_availability[6:0] ), //o
    .clock           (clock                                    ), //i
    .aclr            (aclr                                     )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo8x512 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [511:0]  data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [511:0]  q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [511:0]  cldArea_stream_fifo_io_pop_payload;
  wire       [3:0]    cldArea_stream_fifo_io_occupancy;
  wire       [3:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_5 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                    ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready        ), //o
    .io_push_payload (data[511:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid         ), //o
    .io_pop_ready    (rdreq                                    ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[511:0]), //o
    .io_flush        (1'b0                                     ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[3:0]    ), //o
    .io_availability (cldArea_stream_fifo_io_availability[3:0] ), //o
    .clock           (clock                                    ), //i
    .aclr            (aclr                                     )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo32x11 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [10:0]   data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [10:0]   q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [10:0]   cldArea_stream_fifo_io_pop_payload;
  wire       [5:0]    cldArea_stream_fifo_io_occupancy;
  wire       [5:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_6 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                   ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready       ), //o
    .io_push_payload (data[10:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid        ), //o
    .io_pop_ready    (rdreq                                   ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[10:0]), //o
    .io_flush        (1'b0                                    ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[5:0]   ), //o
    .io_availability (cldArea_stream_fifo_io_availability[5:0]), //o
    .clock           (clock                                   ), //i
    .aclr            (aclr                                    )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo32x40 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [39:0]   data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [39:0]   q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [39:0]   cldArea_stream_fifo_io_pop_payload;
  wire       [5:0]    cldArea_stream_fifo_io_occupancy;
  wire       [5:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_7 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                   ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready       ), //o
    .io_push_payload (data[39:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid        ), //o
    .io_pop_ready    (rdreq                                   ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[39:0]), //o
    .io_flush        (1'b0                                    ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[5:0]   ), //o
    .io_availability (cldArea_stream_fifo_io_availability[5:0]), //o
    .clock           (clock                                   ), //i
    .aclr            (aclr                                    )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo32x265 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [264:0]  data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [264:0]  q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [264:0]  cldArea_stream_fifo_io_pop_payload;
  wire       [5:0]    cldArea_stream_fifo_io_occupancy;
  wire       [5:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_8 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                    ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready        ), //o
    .io_push_payload (data[264:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid         ), //o
    .io_pop_ready    (rdreq                                    ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[264:0]), //o
    .io_flush        (1'b0                                     ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[5:0]    ), //o
    .io_availability (cldArea_stream_fifo_io_availability[5:0] ), //o
    .clock           (clock                                    ), //i
    .aclr            (aclr                                     )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo32x256 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [255:0]  data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [255:0]  q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [255:0]  cldArea_stream_fifo_io_pop_payload;
  wire       [5:0]    cldArea_stream_fifo_io_occupancy;
  wire       [5:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_9 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                    ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready        ), //o
    .io_push_payload (data[255:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid         ), //o
    .io_pop_ready    (rdreq                                    ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[255:0]), //o
    .io_flush        (1'b0                                     ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[5:0]    ), //o
    .io_availability (cldArea_stream_fifo_io_availability[5:0] ), //o
    .clock           (clock                                    ), //i
    .aclr            (aclr                                     )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo32x32 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [31:0]   data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [31:0]   q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [31:0]   cldArea_stream_fifo_io_pop_payload;
  wire       [5:0]    cldArea_stream_fifo_io_occupancy;
  wire       [5:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_10 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                   ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready       ), //o
    .io_push_payload (data[31:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid        ), //o
    .io_pop_ready    (rdreq                                   ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[31:0]), //o
    .io_flush        (1'b0                                    ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[5:0]   ), //o
    .io_availability (cldArea_stream_fifo_io_availability[5:0]), //o
    .clock           (clock                                   ), //i
    .aclr            (aclr                                    )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo1Kx24 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [23:0]   data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [23:0]   q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [23:0]   cldArea_stream_fifo_io_pop_payload;
  wire       [10:0]   cldArea_stream_fifo_io_occupancy;
  wire       [10:0]   cldArea_stream_fifo_io_availability;

  StreamFifo_11 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                    ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready        ), //o
    .io_push_payload (data[23:0]                               ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid         ), //o
    .io_pop_ready    (rdreq                                    ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[23:0] ), //o
    .io_flush        (1'b0                                     ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[10:0]   ), //o
    .io_availability (cldArea_stream_fifo_io_availability[10:0]), //o
    .clock           (clock                                    ), //i
    .aclr            (aclr                                     )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo8x24 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [23:0]   data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [23:0]   q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [23:0]   cldArea_stream_fifo_io_pop_payload;
  wire       [3:0]    cldArea_stream_fifo_io_occupancy;
  wire       [3:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_12 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                   ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready       ), //o
    .io_push_payload (data[23:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid        ), //o
    .io_pop_ready    (rdreq                                   ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[23:0]), //o
    .io_flush        (1'b0                                    ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[3:0]   ), //o
    .io_availability (cldArea_stream_fifo_io_availability[3:0]), //o
    .clock           (clock                                   ), //i
    .aclr            (aclr                                    )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo32x128 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [127:0]  data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [127:0]  q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [127:0]  cldArea_stream_fifo_io_pop_payload;
  wire       [5:0]    cldArea_stream_fifo_io_occupancy;
  wire       [5:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_13 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                    ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready        ), //o
    .io_push_payload (data[127:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid         ), //o
    .io_pop_ready    (rdreq                                    ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[127:0]), //o
    .io_flush        (1'b0                                     ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[5:0]    ), //o
    .io_availability (cldArea_stream_fifo_io_availability[5:0] ), //o
    .clock           (clock                                    ), //i
    .aclr            (aclr                                     )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo32x308 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [307:0]  data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [307:0]  q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [307:0]  cldArea_stream_fifo_io_pop_payload;
  wire       [5:0]    cldArea_stream_fifo_io_occupancy;
  wire       [5:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_14 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                    ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready        ), //o
    .io_push_payload (data[307:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid         ), //o
    .io_pop_ready    (rdreq                                    ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[307:0]), //o
    .io_flush        (1'b0                                     ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[5:0]    ), //o
    .io_availability (cldArea_stream_fifo_io_availability[5:0] ), //o
    .clock           (clock                                    ), //i
    .aclr            (aclr                                     )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo32x1024 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [1023:0] data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [1023:0] q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [1023:0] cldArea_stream_fifo_io_pop_payload;
  wire       [5:0]    cldArea_stream_fifo_io_occupancy;
  wire       [5:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_15 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                     ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready         ), //o
    .io_push_payload (data[1023:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid          ), //o
    .io_pop_ready    (rdreq                                     ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[1023:0]), //o
    .io_flush        (1'b0                                      ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[5:0]     ), //o
    .io_availability (cldArea_stream_fifo_io_availability[5:0]  ), //o
    .clock           (clock                                     ), //i
    .aclr            (aclr                                      )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo16x8 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [7:0]    data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [7:0]    q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [7:0]    cldArea_stream_fifo_io_pop_payload;
  wire       [4:0]    cldArea_stream_fifo_io_occupancy;
  wire       [4:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_16 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                   ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready       ), //o
    .io_push_payload (data[7:0]                               ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid        ), //o
    .io_pop_ready    (rdreq                                   ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[7:0] ), //o
    .io_flush        (1'b0                                    ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[4:0]   ), //o
    .io_availability (cldArea_stream_fifo_io_availability[4:0]), //o
    .clock           (clock                                   ), //i
    .aclr            (aclr                                    )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo128x8 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [7:0]    data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [7:0]    q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [7:0]    cldArea_stream_fifo_io_pop_payload;
  wire       [7:0]    cldArea_stream_fifo_io_occupancy;
  wire       [7:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_17 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                   ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready       ), //o
    .io_push_payload (data[7:0]                               ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid        ), //o
    .io_pop_ready    (rdreq                                   ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[7:0] ), //o
    .io_flush        (1'b0                                    ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[7:0]   ), //o
    .io_availability (cldArea_stream_fifo_io_availability[7:0]), //o
    .clock           (clock                                   ), //i
    .aclr            (aclr                                    )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo8x8 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [7:0]    data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [7:0]    q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [7:0]    cldArea_stream_fifo_io_pop_payload;
  wire       [3:0]    cldArea_stream_fifo_io_occupancy;
  wire       [3:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_18 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                   ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready       ), //o
    .io_push_payload (data[7:0]                               ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid        ), //o
    .io_pop_ready    (rdreq                                   ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[7:0] ), //o
    .io_flush        (1'b0                                    ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[3:0]   ), //o
    .io_availability (cldArea_stream_fifo_io_availability[3:0]), //o
    .clock           (clock                                   ), //i
    .aclr            (aclr                                    )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo32x64 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [63:0]   data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [63:0]   q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [63:0]   cldArea_stream_fifo_io_pop_payload;
  wire       [5:0]    cldArea_stream_fifo_io_occupancy;
  wire       [5:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_19 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                   ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready       ), //o
    .io_push_payload (data[63:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid        ), //o
    .io_pop_ready    (rdreq                                   ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[63:0]), //o
    .io_flush        (1'b0                                    ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[5:0]   ), //o
    .io_availability (cldArea_stream_fifo_io_availability[5:0]), //o
    .clock           (clock                                   ), //i
    .aclr            (aclr                                    )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module fifo8x64 (
  input  wire          fifo_error_enable,
  input  wire          core_clock,
  input  wire [63:0]   data,
  input  wire          wrreq,
  input  wire          rdreq,
  input  wire          clock,
  input  wire          aclr,
  input  wire          sclr,
  output wire [63:0]   q,
  output wire          full,
  output wire          empty,
  output wire          perror,
  output wire          almost_full,
  output wire          almostfull
);

  wire                cldArea_stream_fifo_io_push_ready;
  wire                cldArea_stream_fifo_io_pop_valid;
  wire       [63:0]   cldArea_stream_fifo_io_pop_payload;
  wire       [3:0]    cldArea_stream_fifo_io_occupancy;
  wire       [3:0]    cldArea_stream_fifo_io_availability;

  StreamFifo_20 cldArea_stream_fifo (
    .io_push_valid   (wrreq                                   ), //i
    .io_push_ready   (cldArea_stream_fifo_io_push_ready       ), //o
    .io_push_payload (data[63:0]                              ), //i
    .io_pop_valid    (cldArea_stream_fifo_io_pop_valid        ), //o
    .io_pop_ready    (rdreq                                   ), //i
    .io_pop_payload  (cldArea_stream_fifo_io_pop_payload[63:0]), //o
    .io_flush        (1'b0                                    ), //i
    .io_occupancy    (cldArea_stream_fifo_io_occupancy[3:0]   ), //o
    .io_availability (cldArea_stream_fifo_io_availability[3:0]), //o
    .clock           (clock                                   ), //i
    .aclr            (aclr                                    )  //i
  );
  assign full = (! cldArea_stream_fifo_io_push_ready); // @ fifos.scala l30
  assign q = cldArea_stream_fifo_io_pop_payload; // @ fifos.scala l32
  assign empty = (! cldArea_stream_fifo_io_pop_valid); // @ fifos.scala l33
  assign almost_full = 1'b0; // @ Bool.scala l92
  assign almostfull = 1'b0; // @ Bool.scala l92
  assign perror = 1'b0; // @ Bool.scala l92

endmodule

module StreamFifoCC (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [55:0]   io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [55:0]   io_pop_payload,
  output wire [5:0]    io_pushOccupancy,
  output wire [5:0]    io_popOccupancy,
  input  wire          wrclk,
  input  wire          wrclk_srstn,
  input  wire          rdclk
);

  wire                bufferCC_18_io_dataIn;
  reg        [55:0]   ram_spinal_port1;
  wire       [5:0]    popToPushGray_buffercc_io_dataOut;
  wire                bufferCC_18_io_dataOut;
  wire       [5:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [5:0]    tmp_pushCC_pushPtrGray;
  wire       [4:0]    tmp_ram_port;
  wire       [5:0]    tmp_popCC_popPtrGray;
  reg                 tmp_1;
  wire       [5:0]    popToPushGray;
  wire       [5:0]    pushToPopGray;
  reg        [5:0]    pushCC_pushPtr;
  wire       [5:0]    pushCC_pushPtrPlus;
  wire                io_push_fire;
  reg        [5:0]    pushCC_pushPtrGray;
  wire       [5:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                tmp_io_pushOccupancy;
  wire                tmp_io_pushOccupancy_1;
  wire                tmp_io_pushOccupancy_2;
  wire                tmp_io_pushOccupancy_3;
  wire                tmp_io_pushOccupancy_4;
  wire                fifo_cc_dcfifo_5_wrclk_srstn_synchronized;
  reg        [5:0]    popCC_popPtr;
  (* keep , syn_keep *) wire       [5:0]    popCC_popPtrPlus /* synthesis syn_keep = 1 */ ;
  wire       [5:0]    popCC_popPtrGray;
  wire       [5:0]    popCC_pushPtrGray;
  wire                popCC_addressGen_valid;
  reg                 popCC_addressGen_ready;
  wire       [4:0]    popCC_addressGen_payload;
  wire                popCC_empty;
  wire                popCC_addressGen_fire;
  wire                popCC_readArbitation_valid;
  wire                popCC_readArbitation_ready;
  wire       [4:0]    popCC_readArbitation_payload;
  reg                 popCC_addressGen_rValid;
  reg        [4:0]    popCC_addressGen_rData;
  wire                popCC_readPort_cmd_valid;
  wire       [4:0]    popCC_readPort_cmd_payload;
  wire       [55:0]   popCC_readPort_rsp;
  wire                popCC_readArbitation_translated_valid;
  wire                popCC_readArbitation_translated_ready;
  wire       [55:0]   popCC_readArbitation_translated_payload;
  wire                popCC_readArbitation_fire;
  reg        [5:0]    popCC_ptrToPush;
  reg        [5:0]    popCC_ptrToOccupancy;
  wire                tmp_io_popOccupancy;
  wire                tmp_io_popOccupancy_1;
  wire                tmp_io_popOccupancy_2;
  wire                tmp_io_popOccupancy_3;
  wire                tmp_io_popOccupancy_4;
  reg [55:0] ram [0:31];

  assign tmp_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign tmp_ram_port = pushCC_pushPtr[4:0];
  assign tmp_popCC_popPtrGray = (popCC_popPtr >>> 1'b1);
  always @(posedge wrclk) begin
    if(tmp_1) begin
      ram[tmp_ram_port] <= io_push_payload;
    end
  end

  always @(posedge rdclk) begin
    if(popCC_readPort_cmd_valid) begin
      ram_spinal_port1 <= ram[popCC_readPort_cmd_payload];
    end
  end

  (* keep_hierarchy = "TRUE" *) BufferCC_12 popToPushGray_buffercc (
    .io_dataIn   (popToPushGray[5:0]                    ), //i
    .io_dataOut  (popToPushGray_buffercc_io_dataOut[5:0]), //o
    .wrclk       (wrclk                                 ), //i
    .wrclk_srstn (wrclk_srstn                           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_16 bufferCC_18 (
    .io_dataIn   (bufferCC_18_io_dataIn ), //i
    .io_dataOut  (bufferCC_18_io_dataOut), //o
    .rdclk       (rdclk                 ), //i
    .wrclk_srstn (wrclk_srstn           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_2 pushToPopGray_buffercc (
    .io_dataIn                                 (pushToPopGray[5:0]                       ), //i
    .io_dataOut                                (pushToPopGray_buffercc_io_dataOut[5:0]   ), //o
    .rdclk                                     (rdclk                                    ), //i
    .fifo_cc_dcfifo_5_wrclk_srstn_synchronized (fifo_cc_dcfifo_5_wrclk_srstn_synchronized)  //i
  );
  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(io_push_fire) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 6'h01); // @ BaseType.scala l299
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign pushCC_full = ((pushCC_pushPtrGray[5 : 4] == (~ pushCC_popPtrGray[5 : 4])) && (pushCC_pushPtrGray[3 : 0] == pushCC_popPtrGray[3 : 0])); // @ BaseType.scala l305
  assign io_push_ready = (! pushCC_full); // @ Stream.scala l1579
  assign tmp_io_pushOccupancy = (pushCC_popPtrGray[1] ^ tmp_io_pushOccupancy_1); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ tmp_io_pushOccupancy_2); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_2 = (pushCC_popPtrGray[3] ^ tmp_io_pushOccupancy_3); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_3 = (pushCC_popPtrGray[4] ^ tmp_io_pushOccupancy_4); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_4 = pushCC_popPtrGray[5]; // @ Utils.scala l433
  assign io_pushOccupancy = (pushCC_pushPtr - {tmp_io_pushOccupancy_4,{tmp_io_pushOccupancy_3,{tmp_io_pushOccupancy_2,{tmp_io_pushOccupancy_1,{tmp_io_pushOccupancy,(pushCC_popPtrGray[0] ^ tmp_io_pushOccupancy)}}}}}); // @ Stream.scala l1586
  assign bufferCC_18_io_dataIn = (1'b1 ^ 1'b0); // @ CrossClock.scala l15
  assign fifo_cc_dcfifo_5_wrclk_srstn_synchronized = bufferCC_18_io_dataOut; // @ CrossClock.scala l18
  assign popCC_popPtrPlus = (popCC_popPtr + 6'h01); // @ BaseType.scala l299
  assign popCC_popPtrGray = (tmp_popCC_popPtrGray ^ popCC_popPtr); // @ BaseType.scala l318
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray); // @ BaseType.scala l305
  assign popCC_addressGen_valid = (! popCC_empty); // @ Stream.scala l1597
  assign popCC_addressGen_payload = popCC_popPtr[4:0]; // @ Stream.scala l1598
  assign popCC_addressGen_fire = (popCC_addressGen_valid && popCC_addressGen_ready); // @ BaseType.scala l305
  always @(*) begin
    popCC_addressGen_ready = popCC_readArbitation_ready; // @ Stream.scala l374
    if((! popCC_readArbitation_valid)) begin
      popCC_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign popCC_readArbitation_valid = popCC_addressGen_rValid; // @ Stream.scala l377
  assign popCC_readArbitation_payload = popCC_addressGen_rData; // @ Stream.scala l378
  assign popCC_readPort_rsp = ram_spinal_port1; // @ Mem.scala l123
  assign popCC_readPort_cmd_valid = popCC_addressGen_fire; // @ Stream.scala l1606
  assign popCC_readPort_cmd_payload = popCC_addressGen_payload; // @ Stream.scala l1606
  assign popCC_readArbitation_translated_valid = popCC_readArbitation_valid; // @ Stream.scala l307
  assign popCC_readArbitation_ready = popCC_readArbitation_translated_ready; // @ Stream.scala l308
  assign popCC_readArbitation_translated_payload = popCC_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = popCC_readArbitation_translated_valid; // @ Stream.scala l298
  assign popCC_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = popCC_readArbitation_translated_payload; // @ Stream.scala l300
  assign popCC_readArbitation_fire = (popCC_readArbitation_valid && popCC_readArbitation_ready); // @ BaseType.scala l305
  assign tmp_io_popOccupancy = (popCC_pushPtrGray[1] ^ tmp_io_popOccupancy_1); // @ Utils.scala l431
  assign tmp_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ tmp_io_popOccupancy_2); // @ Utils.scala l431
  assign tmp_io_popOccupancy_2 = (popCC_pushPtrGray[3] ^ tmp_io_popOccupancy_3); // @ Utils.scala l431
  assign tmp_io_popOccupancy_3 = (popCC_pushPtrGray[4] ^ tmp_io_popOccupancy_4); // @ Utils.scala l431
  assign tmp_io_popOccupancy_4 = popCC_pushPtrGray[5]; // @ Utils.scala l433
  assign io_popOccupancy = ({tmp_io_popOccupancy_4,{tmp_io_popOccupancy_3,{tmp_io_popOccupancy_2,{tmp_io_popOccupancy_1,{tmp_io_popOccupancy,(popCC_pushPtrGray[0] ^ tmp_io_popOccupancy)}}}}} - popCC_ptrToOccupancy); // @ Stream.scala l1611
  assign pushToPopGray = pushCC_pushPtrGray; // @ Stream.scala l1614
  assign popToPushGray = popCC_ptrToPush; // @ Stream.scala l1615
  always @(posedge wrclk or negedge wrclk_srstn) begin
    if(!wrclk_srstn) begin
      pushCC_pushPtr <= 6'h0; // @ Data.scala l409
      pushCC_pushPtrGray <= 6'h0; // @ Data.scala l409
    end else begin
      if(io_push_fire) begin
        pushCC_pushPtrGray <= (tmp_pushCC_pushPtrGray ^ pushCC_pushPtrPlus); // @ Stream.scala l1575
      end
      if(io_push_fire) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus; // @ Stream.scala l1583
      end
    end
  end

  always @(posedge rdclk or negedge fifo_cc_dcfifo_5_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_5_wrclk_srstn_synchronized) begin
      popCC_popPtr <= 6'h0; // @ Data.scala l409
      popCC_addressGen_rValid <= 1'b0; // @ Data.scala l409
      popCC_ptrToPush <= 6'h0; // @ Data.scala l409
      popCC_ptrToOccupancy <= 6'h0; // @ Data.scala l409
    end else begin
      if(popCC_addressGen_fire) begin
        popCC_popPtr <= popCC_popPtrPlus; // @ Stream.scala l1601
      end
      if(popCC_addressGen_ready) begin
        popCC_addressGen_rValid <= popCC_addressGen_valid; // @ Stream.scala l365
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToPush <= popCC_popPtrGray; // @ Stream.scala l1609
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToOccupancy <= popCC_popPtr; // @ Stream.scala l1610
      end
    end
  end

  always @(posedge rdclk) begin
    if(popCC_addressGen_ready) begin
      popCC_addressGen_rData <= popCC_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifoCC_1 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [7:0]    io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [7:0]    io_pop_payload,
  output wire [4:0]    io_pushOccupancy,
  output wire [4:0]    io_popOccupancy,
  input  wire          wrclk,
  input  wire          wrclk_srstn,
  input  wire          rdclk
);

  wire                bufferCC_18_io_dataIn;
  reg        [7:0]    ram_spinal_port1;
  wire       [4:0]    popToPushGray_buffercc_io_dataOut;
  wire                bufferCC_18_io_dataOut;
  wire       [4:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [4:0]    tmp_pushCC_pushPtrGray;
  wire       [3:0]    tmp_ram_port;
  wire       [4:0]    tmp_popCC_popPtrGray;
  reg                 tmp_1;
  wire       [4:0]    popToPushGray;
  wire       [4:0]    pushToPopGray;
  reg        [4:0]    pushCC_pushPtr;
  wire       [4:0]    pushCC_pushPtrPlus;
  wire                io_push_fire;
  reg        [4:0]    pushCC_pushPtrGray;
  wire       [4:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                tmp_io_pushOccupancy;
  wire                tmp_io_pushOccupancy_1;
  wire                tmp_io_pushOccupancy_2;
  wire                tmp_io_pushOccupancy_3;
  wire                fifo_cc_dcfifo_4_wrclk_srstn_synchronized;
  reg        [4:0]    popCC_popPtr;
  (* keep , syn_keep *) wire       [4:0]    popCC_popPtrPlus /* synthesis syn_keep = 1 */ ;
  wire       [4:0]    popCC_popPtrGray;
  wire       [4:0]    popCC_pushPtrGray;
  wire                popCC_addressGen_valid;
  reg                 popCC_addressGen_ready;
  wire       [3:0]    popCC_addressGen_payload;
  wire                popCC_empty;
  wire                popCC_addressGen_fire;
  wire                popCC_readArbitation_valid;
  wire                popCC_readArbitation_ready;
  wire       [3:0]    popCC_readArbitation_payload;
  reg                 popCC_addressGen_rValid;
  reg        [3:0]    popCC_addressGen_rData;
  wire                popCC_readPort_cmd_valid;
  wire       [3:0]    popCC_readPort_cmd_payload;
  wire       [7:0]    popCC_readPort_rsp;
  wire                popCC_readArbitation_translated_valid;
  wire                popCC_readArbitation_translated_ready;
  wire       [7:0]    popCC_readArbitation_translated_payload;
  wire                popCC_readArbitation_fire;
  reg        [4:0]    popCC_ptrToPush;
  reg        [4:0]    popCC_ptrToOccupancy;
  wire                tmp_io_popOccupancy;
  wire                tmp_io_popOccupancy_1;
  wire                tmp_io_popOccupancy_2;
  wire                tmp_io_popOccupancy_3;
  reg [7:0] ram [0:15];

  assign tmp_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign tmp_ram_port = pushCC_pushPtr[3:0];
  assign tmp_popCC_popPtrGray = (popCC_popPtr >>> 1'b1);
  always @(posedge wrclk) begin
    if(tmp_1) begin
      ram[tmp_ram_port] <= io_push_payload;
    end
  end

  always @(posedge rdclk) begin
    if(popCC_readPort_cmd_valid) begin
      ram_spinal_port1 <= ram[popCC_readPort_cmd_payload];
    end
  end

  (* keep_hierarchy = "TRUE" *) BufferCC_6 popToPushGray_buffercc (
    .io_dataIn   (popToPushGray[4:0]                    ), //i
    .io_dataOut  (popToPushGray_buffercc_io_dataOut[4:0]), //o
    .wrclk       (wrclk                                 ), //i
    .wrclk_srstn (wrclk_srstn                           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_16 bufferCC_18 (
    .io_dataIn   (bufferCC_18_io_dataIn ), //i
    .io_dataOut  (bufferCC_18_io_dataOut), //o
    .rdclk       (rdclk                 ), //i
    .wrclk_srstn (wrclk_srstn           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_5 pushToPopGray_buffercc (
    .io_dataIn                                 (pushToPopGray[4:0]                       ), //i
    .io_dataOut                                (pushToPopGray_buffercc_io_dataOut[4:0]   ), //o
    .rdclk                                     (rdclk                                    ), //i
    .fifo_cc_dcfifo_4_wrclk_srstn_synchronized (fifo_cc_dcfifo_4_wrclk_srstn_synchronized)  //i
  );
  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(io_push_fire) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 5'h01); // @ BaseType.scala l299
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign pushCC_full = ((pushCC_pushPtrGray[4 : 3] == (~ pushCC_popPtrGray[4 : 3])) && (pushCC_pushPtrGray[2 : 0] == pushCC_popPtrGray[2 : 0])); // @ BaseType.scala l305
  assign io_push_ready = (! pushCC_full); // @ Stream.scala l1579
  assign tmp_io_pushOccupancy = (pushCC_popPtrGray[1] ^ tmp_io_pushOccupancy_1); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ tmp_io_pushOccupancy_2); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_2 = (pushCC_popPtrGray[3] ^ tmp_io_pushOccupancy_3); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_3 = pushCC_popPtrGray[4]; // @ Utils.scala l433
  assign io_pushOccupancy = (pushCC_pushPtr - {tmp_io_pushOccupancy_3,{tmp_io_pushOccupancy_2,{tmp_io_pushOccupancy_1,{tmp_io_pushOccupancy,(pushCC_popPtrGray[0] ^ tmp_io_pushOccupancy)}}}}); // @ Stream.scala l1586
  assign bufferCC_18_io_dataIn = (1'b1 ^ 1'b0); // @ CrossClock.scala l15
  assign fifo_cc_dcfifo_4_wrclk_srstn_synchronized = bufferCC_18_io_dataOut; // @ CrossClock.scala l18
  assign popCC_popPtrPlus = (popCC_popPtr + 5'h01); // @ BaseType.scala l299
  assign popCC_popPtrGray = (tmp_popCC_popPtrGray ^ popCC_popPtr); // @ BaseType.scala l318
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray); // @ BaseType.scala l305
  assign popCC_addressGen_valid = (! popCC_empty); // @ Stream.scala l1597
  assign popCC_addressGen_payload = popCC_popPtr[3:0]; // @ Stream.scala l1598
  assign popCC_addressGen_fire = (popCC_addressGen_valid && popCC_addressGen_ready); // @ BaseType.scala l305
  always @(*) begin
    popCC_addressGen_ready = popCC_readArbitation_ready; // @ Stream.scala l374
    if((! popCC_readArbitation_valid)) begin
      popCC_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign popCC_readArbitation_valid = popCC_addressGen_rValid; // @ Stream.scala l377
  assign popCC_readArbitation_payload = popCC_addressGen_rData; // @ Stream.scala l378
  assign popCC_readPort_rsp = ram_spinal_port1; // @ Mem.scala l123
  assign popCC_readPort_cmd_valid = popCC_addressGen_fire; // @ Stream.scala l1606
  assign popCC_readPort_cmd_payload = popCC_addressGen_payload; // @ Stream.scala l1606
  assign popCC_readArbitation_translated_valid = popCC_readArbitation_valid; // @ Stream.scala l307
  assign popCC_readArbitation_ready = popCC_readArbitation_translated_ready; // @ Stream.scala l308
  assign popCC_readArbitation_translated_payload = popCC_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = popCC_readArbitation_translated_valid; // @ Stream.scala l298
  assign popCC_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = popCC_readArbitation_translated_payload; // @ Stream.scala l300
  assign popCC_readArbitation_fire = (popCC_readArbitation_valid && popCC_readArbitation_ready); // @ BaseType.scala l305
  assign tmp_io_popOccupancy = (popCC_pushPtrGray[1] ^ tmp_io_popOccupancy_1); // @ Utils.scala l431
  assign tmp_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ tmp_io_popOccupancy_2); // @ Utils.scala l431
  assign tmp_io_popOccupancy_2 = (popCC_pushPtrGray[3] ^ tmp_io_popOccupancy_3); // @ Utils.scala l431
  assign tmp_io_popOccupancy_3 = popCC_pushPtrGray[4]; // @ Utils.scala l433
  assign io_popOccupancy = ({tmp_io_popOccupancy_3,{tmp_io_popOccupancy_2,{tmp_io_popOccupancy_1,{tmp_io_popOccupancy,(popCC_pushPtrGray[0] ^ tmp_io_popOccupancy)}}}} - popCC_ptrToOccupancy); // @ Stream.scala l1611
  assign pushToPopGray = pushCC_pushPtrGray; // @ Stream.scala l1614
  assign popToPushGray = popCC_ptrToPush; // @ Stream.scala l1615
  always @(posedge wrclk or negedge wrclk_srstn) begin
    if(!wrclk_srstn) begin
      pushCC_pushPtr <= 5'h0; // @ Data.scala l409
      pushCC_pushPtrGray <= 5'h0; // @ Data.scala l409
    end else begin
      if(io_push_fire) begin
        pushCC_pushPtrGray <= (tmp_pushCC_pushPtrGray ^ pushCC_pushPtrPlus); // @ Stream.scala l1575
      end
      if(io_push_fire) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus; // @ Stream.scala l1583
      end
    end
  end

  always @(posedge rdclk or negedge fifo_cc_dcfifo_4_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_4_wrclk_srstn_synchronized) begin
      popCC_popPtr <= 5'h0; // @ Data.scala l409
      popCC_addressGen_rValid <= 1'b0; // @ Data.scala l409
      popCC_ptrToPush <= 5'h0; // @ Data.scala l409
      popCC_ptrToOccupancy <= 5'h0; // @ Data.scala l409
    end else begin
      if(popCC_addressGen_fire) begin
        popCC_popPtr <= popCC_popPtrPlus; // @ Stream.scala l1601
      end
      if(popCC_addressGen_ready) begin
        popCC_addressGen_rValid <= popCC_addressGen_valid; // @ Stream.scala l365
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToPush <= popCC_popPtrGray; // @ Stream.scala l1609
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToOccupancy <= popCC_popPtr; // @ Stream.scala l1610
      end
    end
  end

  always @(posedge rdclk) begin
    if(popCC_addressGen_ready) begin
      popCC_addressGen_rData <= popCC_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifoCC_2 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [0:0]    io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [0:0]    io_pop_payload,
  output wire [4:0]    io_pushOccupancy,
  output wire [4:0]    io_popOccupancy,
  input  wire          wrclk,
  input  wire          wrclk_srstn,
  input  wire          rdclk
);

  wire                bufferCC_18_io_dataIn;
  reg        [0:0]    ram_spinal_port1;
  wire       [4:0]    popToPushGray_buffercc_io_dataOut;
  wire                bufferCC_18_io_dataOut;
  wire       [4:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [4:0]    tmp_pushCC_pushPtrGray;
  wire       [3:0]    tmp_ram_port;
  wire       [4:0]    tmp_popCC_popPtrGray;
  reg                 tmp_1;
  wire       [4:0]    popToPushGray;
  wire       [4:0]    pushToPopGray;
  reg        [4:0]    pushCC_pushPtr;
  wire       [4:0]    pushCC_pushPtrPlus;
  wire                io_push_fire;
  reg        [4:0]    pushCC_pushPtrGray;
  wire       [4:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                tmp_io_pushOccupancy;
  wire                tmp_io_pushOccupancy_1;
  wire                tmp_io_pushOccupancy_2;
  wire                tmp_io_pushOccupancy_3;
  wire                fifo_cc_dcfifo_3_wrclk_srstn_synchronized;
  reg        [4:0]    popCC_popPtr;
  (* keep , syn_keep *) wire       [4:0]    popCC_popPtrPlus /* synthesis syn_keep = 1 */ ;
  wire       [4:0]    popCC_popPtrGray;
  wire       [4:0]    popCC_pushPtrGray;
  wire                popCC_addressGen_valid;
  reg                 popCC_addressGen_ready;
  wire       [3:0]    popCC_addressGen_payload;
  wire                popCC_empty;
  wire                popCC_addressGen_fire;
  wire                popCC_readArbitation_valid;
  wire                popCC_readArbitation_ready;
  wire       [3:0]    popCC_readArbitation_payload;
  reg                 popCC_addressGen_rValid;
  reg        [3:0]    popCC_addressGen_rData;
  wire                popCC_readPort_cmd_valid;
  wire       [3:0]    popCC_readPort_cmd_payload;
  wire       [0:0]    popCC_readPort_rsp;
  wire                popCC_readArbitation_translated_valid;
  wire                popCC_readArbitation_translated_ready;
  wire       [0:0]    popCC_readArbitation_translated_payload;
  wire                popCC_readArbitation_fire;
  reg        [4:0]    popCC_ptrToPush;
  reg        [4:0]    popCC_ptrToOccupancy;
  wire                tmp_io_popOccupancy;
  wire                tmp_io_popOccupancy_1;
  wire                tmp_io_popOccupancy_2;
  wire                tmp_io_popOccupancy_3;
  reg [0:0] ram [0:15];

  assign tmp_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign tmp_ram_port = pushCC_pushPtr[3:0];
  assign tmp_popCC_popPtrGray = (popCC_popPtr >>> 1'b1);
  always @(posedge wrclk) begin
    if(tmp_1) begin
      ram[tmp_ram_port] <= io_push_payload;
    end
  end

  always @(posedge rdclk) begin
    if(popCC_readPort_cmd_valid) begin
      ram_spinal_port1 <= ram[popCC_readPort_cmd_payload];
    end
  end

  (* keep_hierarchy = "TRUE" *) BufferCC_6 popToPushGray_buffercc (
    .io_dataIn   (popToPushGray[4:0]                    ), //i
    .io_dataOut  (popToPushGray_buffercc_io_dataOut[4:0]), //o
    .wrclk       (wrclk                                 ), //i
    .wrclk_srstn (wrclk_srstn                           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_16 bufferCC_18 (
    .io_dataIn   (bufferCC_18_io_dataIn ), //i
    .io_dataOut  (bufferCC_18_io_dataOut), //o
    .rdclk       (rdclk                 ), //i
    .wrclk_srstn (wrclk_srstn           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_8 pushToPopGray_buffercc (
    .io_dataIn                                 (pushToPopGray[4:0]                       ), //i
    .io_dataOut                                (pushToPopGray_buffercc_io_dataOut[4:0]   ), //o
    .rdclk                                     (rdclk                                    ), //i
    .fifo_cc_dcfifo_3_wrclk_srstn_synchronized (fifo_cc_dcfifo_3_wrclk_srstn_synchronized)  //i
  );
  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(io_push_fire) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 5'h01); // @ BaseType.scala l299
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign pushCC_full = ((pushCC_pushPtrGray[4 : 3] == (~ pushCC_popPtrGray[4 : 3])) && (pushCC_pushPtrGray[2 : 0] == pushCC_popPtrGray[2 : 0])); // @ BaseType.scala l305
  assign io_push_ready = (! pushCC_full); // @ Stream.scala l1579
  assign tmp_io_pushOccupancy = (pushCC_popPtrGray[1] ^ tmp_io_pushOccupancy_1); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ tmp_io_pushOccupancy_2); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_2 = (pushCC_popPtrGray[3] ^ tmp_io_pushOccupancy_3); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_3 = pushCC_popPtrGray[4]; // @ Utils.scala l433
  assign io_pushOccupancy = (pushCC_pushPtr - {tmp_io_pushOccupancy_3,{tmp_io_pushOccupancy_2,{tmp_io_pushOccupancy_1,{tmp_io_pushOccupancy,(pushCC_popPtrGray[0] ^ tmp_io_pushOccupancy)}}}}); // @ Stream.scala l1586
  assign bufferCC_18_io_dataIn = (1'b1 ^ 1'b0); // @ CrossClock.scala l15
  assign fifo_cc_dcfifo_3_wrclk_srstn_synchronized = bufferCC_18_io_dataOut; // @ CrossClock.scala l18
  assign popCC_popPtrPlus = (popCC_popPtr + 5'h01); // @ BaseType.scala l299
  assign popCC_popPtrGray = (tmp_popCC_popPtrGray ^ popCC_popPtr); // @ BaseType.scala l318
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray); // @ BaseType.scala l305
  assign popCC_addressGen_valid = (! popCC_empty); // @ Stream.scala l1597
  assign popCC_addressGen_payload = popCC_popPtr[3:0]; // @ Stream.scala l1598
  assign popCC_addressGen_fire = (popCC_addressGen_valid && popCC_addressGen_ready); // @ BaseType.scala l305
  always @(*) begin
    popCC_addressGen_ready = popCC_readArbitation_ready; // @ Stream.scala l374
    if((! popCC_readArbitation_valid)) begin
      popCC_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign popCC_readArbitation_valid = popCC_addressGen_rValid; // @ Stream.scala l377
  assign popCC_readArbitation_payload = popCC_addressGen_rData; // @ Stream.scala l378
  assign popCC_readPort_rsp = ram_spinal_port1; // @ Mem.scala l123
  assign popCC_readPort_cmd_valid = popCC_addressGen_fire; // @ Stream.scala l1606
  assign popCC_readPort_cmd_payload = popCC_addressGen_payload; // @ Stream.scala l1606
  assign popCC_readArbitation_translated_valid = popCC_readArbitation_valid; // @ Stream.scala l307
  assign popCC_readArbitation_ready = popCC_readArbitation_translated_ready; // @ Stream.scala l308
  assign popCC_readArbitation_translated_payload = popCC_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = popCC_readArbitation_translated_valid; // @ Stream.scala l298
  assign popCC_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = popCC_readArbitation_translated_payload; // @ Stream.scala l300
  assign popCC_readArbitation_fire = (popCC_readArbitation_valid && popCC_readArbitation_ready); // @ BaseType.scala l305
  assign tmp_io_popOccupancy = (popCC_pushPtrGray[1] ^ tmp_io_popOccupancy_1); // @ Utils.scala l431
  assign tmp_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ tmp_io_popOccupancy_2); // @ Utils.scala l431
  assign tmp_io_popOccupancy_2 = (popCC_pushPtrGray[3] ^ tmp_io_popOccupancy_3); // @ Utils.scala l431
  assign tmp_io_popOccupancy_3 = popCC_pushPtrGray[4]; // @ Utils.scala l433
  assign io_popOccupancy = ({tmp_io_popOccupancy_3,{tmp_io_popOccupancy_2,{tmp_io_popOccupancy_1,{tmp_io_popOccupancy,(popCC_pushPtrGray[0] ^ tmp_io_popOccupancy)}}}} - popCC_ptrToOccupancy); // @ Stream.scala l1611
  assign pushToPopGray = pushCC_pushPtrGray; // @ Stream.scala l1614
  assign popToPushGray = popCC_ptrToPush; // @ Stream.scala l1615
  always @(posedge wrclk or negedge wrclk_srstn) begin
    if(!wrclk_srstn) begin
      pushCC_pushPtr <= 5'h0; // @ Data.scala l409
      pushCC_pushPtrGray <= 5'h0; // @ Data.scala l409
    end else begin
      if(io_push_fire) begin
        pushCC_pushPtrGray <= (tmp_pushCC_pushPtrGray ^ pushCC_pushPtrPlus); // @ Stream.scala l1575
      end
      if(io_push_fire) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus; // @ Stream.scala l1583
      end
    end
  end

  always @(posedge rdclk or negedge fifo_cc_dcfifo_3_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_3_wrclk_srstn_synchronized) begin
      popCC_popPtr <= 5'h0; // @ Data.scala l409
      popCC_addressGen_rValid <= 1'b0; // @ Data.scala l409
      popCC_ptrToPush <= 5'h0; // @ Data.scala l409
      popCC_ptrToOccupancy <= 5'h0; // @ Data.scala l409
    end else begin
      if(popCC_addressGen_fire) begin
        popCC_popPtr <= popCC_popPtrPlus; // @ Stream.scala l1601
      end
      if(popCC_addressGen_ready) begin
        popCC_addressGen_rValid <= popCC_addressGen_valid; // @ Stream.scala l365
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToPush <= popCC_popPtrGray; // @ Stream.scala l1609
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToOccupancy <= popCC_popPtr; // @ Stream.scala l1610
      end
    end
  end

  always @(posedge rdclk) begin
    if(popCC_addressGen_ready) begin
      popCC_addressGen_rData <= popCC_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifoCC_3 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [521:0]  io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [521:0]  io_pop_payload,
  output wire [7:0]    io_pushOccupancy,
  output wire [7:0]    io_popOccupancy,
  input  wire          wrclk,
  input  wire          wrclk_srstn,
  input  wire          rdclk
);

  wire                bufferCC_18_io_dataIn;
  reg        [521:0]  ram_spinal_port1;
  wire       [7:0]    popToPushGray_buffercc_io_dataOut;
  wire                bufferCC_18_io_dataOut;
  wire       [7:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [7:0]    tmp_pushCC_pushPtrGray;
  wire       [6:0]    tmp_ram_port;
  wire       [7:0]    tmp_popCC_popPtrGray;
  reg                 tmp_1;
  wire       [7:0]    popToPushGray;
  wire       [7:0]    pushToPopGray;
  reg        [7:0]    pushCC_pushPtr;
  wire       [7:0]    pushCC_pushPtrPlus;
  wire                io_push_fire;
  reg        [7:0]    pushCC_pushPtrGray;
  wire       [7:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                tmp_io_pushOccupancy;
  wire                tmp_io_pushOccupancy_1;
  wire                tmp_io_pushOccupancy_2;
  wire                tmp_io_pushOccupancy_3;
  wire                tmp_io_pushOccupancy_4;
  wire                tmp_io_pushOccupancy_5;
  wire                tmp_io_pushOccupancy_6;
  wire                fifo_cc_dcfifo_2_wrclk_srstn_synchronized;
  reg        [7:0]    popCC_popPtr;
  (* keep , syn_keep *) wire       [7:0]    popCC_popPtrPlus /* synthesis syn_keep = 1 */ ;
  wire       [7:0]    popCC_popPtrGray;
  wire       [7:0]    popCC_pushPtrGray;
  wire                popCC_addressGen_valid;
  reg                 popCC_addressGen_ready;
  wire       [6:0]    popCC_addressGen_payload;
  wire                popCC_empty;
  wire                popCC_addressGen_fire;
  wire                popCC_readArbitation_valid;
  wire                popCC_readArbitation_ready;
  wire       [6:0]    popCC_readArbitation_payload;
  reg                 popCC_addressGen_rValid;
  reg        [6:0]    popCC_addressGen_rData;
  wire                popCC_readPort_cmd_valid;
  wire       [6:0]    popCC_readPort_cmd_payload;
  wire       [521:0]  popCC_readPort_rsp;
  wire                popCC_readArbitation_translated_valid;
  wire                popCC_readArbitation_translated_ready;
  wire       [521:0]  popCC_readArbitation_translated_payload;
  wire                popCC_readArbitation_fire;
  reg        [7:0]    popCC_ptrToPush;
  reg        [7:0]    popCC_ptrToOccupancy;
  wire                tmp_io_popOccupancy;
  wire                tmp_io_popOccupancy_1;
  wire                tmp_io_popOccupancy_2;
  wire                tmp_io_popOccupancy_3;
  wire                tmp_io_popOccupancy_4;
  wire                tmp_io_popOccupancy_5;
  wire                tmp_io_popOccupancy_6;
  reg [521:0] ram [0:127];

  assign tmp_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign tmp_ram_port = pushCC_pushPtr[6:0];
  assign tmp_popCC_popPtrGray = (popCC_popPtr >>> 1'b1);
  always @(posedge wrclk) begin
    if(tmp_1) begin
      ram[tmp_ram_port] <= io_push_payload;
    end
  end

  always @(posedge rdclk) begin
    if(popCC_readPort_cmd_valid) begin
      ram_spinal_port1 <= ram[popCC_readPort_cmd_payload];
    end
  end

  (* keep_hierarchy = "TRUE" *) BufferCC_9 popToPushGray_buffercc (
    .io_dataIn   (popToPushGray[7:0]                    ), //i
    .io_dataOut  (popToPushGray_buffercc_io_dataOut[7:0]), //o
    .wrclk       (wrclk                                 ), //i
    .wrclk_srstn (wrclk_srstn                           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_16 bufferCC_18 (
    .io_dataIn   (bufferCC_18_io_dataIn ), //i
    .io_dataOut  (bufferCC_18_io_dataOut), //o
    .rdclk       (rdclk                 ), //i
    .wrclk_srstn (wrclk_srstn           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_11 pushToPopGray_buffercc (
    .io_dataIn                                 (pushToPopGray[7:0]                       ), //i
    .io_dataOut                                (pushToPopGray_buffercc_io_dataOut[7:0]   ), //o
    .rdclk                                     (rdclk                                    ), //i
    .fifo_cc_dcfifo_2_wrclk_srstn_synchronized (fifo_cc_dcfifo_2_wrclk_srstn_synchronized)  //i
  );
  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(io_push_fire) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 8'h01); // @ BaseType.scala l299
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign pushCC_full = ((pushCC_pushPtrGray[7 : 6] == (~ pushCC_popPtrGray[7 : 6])) && (pushCC_pushPtrGray[5 : 0] == pushCC_popPtrGray[5 : 0])); // @ BaseType.scala l305
  assign io_push_ready = (! pushCC_full); // @ Stream.scala l1579
  assign tmp_io_pushOccupancy = (pushCC_popPtrGray[1] ^ tmp_io_pushOccupancy_1); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ tmp_io_pushOccupancy_2); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_2 = (pushCC_popPtrGray[3] ^ tmp_io_pushOccupancy_3); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_3 = (pushCC_popPtrGray[4] ^ tmp_io_pushOccupancy_4); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_4 = (pushCC_popPtrGray[5] ^ tmp_io_pushOccupancy_5); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_5 = (pushCC_popPtrGray[6] ^ tmp_io_pushOccupancy_6); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_6 = pushCC_popPtrGray[7]; // @ Utils.scala l433
  assign io_pushOccupancy = (pushCC_pushPtr - {tmp_io_pushOccupancy_6,{tmp_io_pushOccupancy_5,{tmp_io_pushOccupancy_4,{tmp_io_pushOccupancy_3,{tmp_io_pushOccupancy_2,{tmp_io_pushOccupancy_1,{tmp_io_pushOccupancy,(pushCC_popPtrGray[0] ^ tmp_io_pushOccupancy)}}}}}}}); // @ Stream.scala l1586
  assign bufferCC_18_io_dataIn = (1'b1 ^ 1'b0); // @ CrossClock.scala l15
  assign fifo_cc_dcfifo_2_wrclk_srstn_synchronized = bufferCC_18_io_dataOut; // @ CrossClock.scala l18
  assign popCC_popPtrPlus = (popCC_popPtr + 8'h01); // @ BaseType.scala l299
  assign popCC_popPtrGray = (tmp_popCC_popPtrGray ^ popCC_popPtr); // @ BaseType.scala l318
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray); // @ BaseType.scala l305
  assign popCC_addressGen_valid = (! popCC_empty); // @ Stream.scala l1597
  assign popCC_addressGen_payload = popCC_popPtr[6:0]; // @ Stream.scala l1598
  assign popCC_addressGen_fire = (popCC_addressGen_valid && popCC_addressGen_ready); // @ BaseType.scala l305
  always @(*) begin
    popCC_addressGen_ready = popCC_readArbitation_ready; // @ Stream.scala l374
    if((! popCC_readArbitation_valid)) begin
      popCC_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign popCC_readArbitation_valid = popCC_addressGen_rValid; // @ Stream.scala l377
  assign popCC_readArbitation_payload = popCC_addressGen_rData; // @ Stream.scala l378
  assign popCC_readPort_rsp = ram_spinal_port1; // @ Mem.scala l123
  assign popCC_readPort_cmd_valid = popCC_addressGen_fire; // @ Stream.scala l1606
  assign popCC_readPort_cmd_payload = popCC_addressGen_payload; // @ Stream.scala l1606
  assign popCC_readArbitation_translated_valid = popCC_readArbitation_valid; // @ Stream.scala l307
  assign popCC_readArbitation_ready = popCC_readArbitation_translated_ready; // @ Stream.scala l308
  assign popCC_readArbitation_translated_payload = popCC_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = popCC_readArbitation_translated_valid; // @ Stream.scala l298
  assign popCC_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = popCC_readArbitation_translated_payload; // @ Stream.scala l300
  assign popCC_readArbitation_fire = (popCC_readArbitation_valid && popCC_readArbitation_ready); // @ BaseType.scala l305
  assign tmp_io_popOccupancy = (popCC_pushPtrGray[1] ^ tmp_io_popOccupancy_1); // @ Utils.scala l431
  assign tmp_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ tmp_io_popOccupancy_2); // @ Utils.scala l431
  assign tmp_io_popOccupancy_2 = (popCC_pushPtrGray[3] ^ tmp_io_popOccupancy_3); // @ Utils.scala l431
  assign tmp_io_popOccupancy_3 = (popCC_pushPtrGray[4] ^ tmp_io_popOccupancy_4); // @ Utils.scala l431
  assign tmp_io_popOccupancy_4 = (popCC_pushPtrGray[5] ^ tmp_io_popOccupancy_5); // @ Utils.scala l431
  assign tmp_io_popOccupancy_5 = (popCC_pushPtrGray[6] ^ tmp_io_popOccupancy_6); // @ Utils.scala l431
  assign tmp_io_popOccupancy_6 = popCC_pushPtrGray[7]; // @ Utils.scala l433
  assign io_popOccupancy = ({tmp_io_popOccupancy_6,{tmp_io_popOccupancy_5,{tmp_io_popOccupancy_4,{tmp_io_popOccupancy_3,{tmp_io_popOccupancy_2,{tmp_io_popOccupancy_1,{tmp_io_popOccupancy,(popCC_pushPtrGray[0] ^ tmp_io_popOccupancy)}}}}}}} - popCC_ptrToOccupancy); // @ Stream.scala l1611
  assign pushToPopGray = pushCC_pushPtrGray; // @ Stream.scala l1614
  assign popToPushGray = popCC_ptrToPush; // @ Stream.scala l1615
  always @(posedge wrclk or negedge wrclk_srstn) begin
    if(!wrclk_srstn) begin
      pushCC_pushPtr <= 8'h0; // @ Data.scala l409
      pushCC_pushPtrGray <= 8'h0; // @ Data.scala l409
    end else begin
      if(io_push_fire) begin
        pushCC_pushPtrGray <= (tmp_pushCC_pushPtrGray ^ pushCC_pushPtrPlus); // @ Stream.scala l1575
      end
      if(io_push_fire) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus; // @ Stream.scala l1583
      end
    end
  end

  always @(posedge rdclk or negedge fifo_cc_dcfifo_2_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_2_wrclk_srstn_synchronized) begin
      popCC_popPtr <= 8'h0; // @ Data.scala l409
      popCC_addressGen_rValid <= 1'b0; // @ Data.scala l409
      popCC_ptrToPush <= 8'h0; // @ Data.scala l409
      popCC_ptrToOccupancy <= 8'h0; // @ Data.scala l409
    end else begin
      if(popCC_addressGen_fire) begin
        popCC_popPtr <= popCC_popPtrPlus; // @ Stream.scala l1601
      end
      if(popCC_addressGen_ready) begin
        popCC_addressGen_rValid <= popCC_addressGen_valid; // @ Stream.scala l365
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToPush <= popCC_popPtrGray; // @ Stream.scala l1609
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToOccupancy <= popCC_popPtr; // @ Stream.scala l1610
      end
    end
  end

  always @(posedge rdclk) begin
    if(popCC_addressGen_ready) begin
      popCC_addressGen_rData <= popCC_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifoCC_4 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [39:0]   io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [39:0]   io_pop_payload,
  output wire [5:0]    io_pushOccupancy,
  output wire [5:0]    io_popOccupancy,
  input  wire          wrclk,
  input  wire          wrclk_srstn,
  input  wire          rdclk
);

  wire                bufferCC_18_io_dataIn;
  reg        [39:0]   ram_spinal_port1;
  wire       [5:0]    popToPushGray_buffercc_io_dataOut;
  wire                bufferCC_18_io_dataOut;
  wire       [5:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [5:0]    tmp_pushCC_pushPtrGray;
  wire       [4:0]    tmp_ram_port;
  wire       [5:0]    tmp_popCC_popPtrGray;
  reg                 tmp_1;
  wire       [5:0]    popToPushGray;
  wire       [5:0]    pushToPopGray;
  reg        [5:0]    pushCC_pushPtr;
  wire       [5:0]    pushCC_pushPtrPlus;
  wire                io_push_fire;
  reg        [5:0]    pushCC_pushPtrGray;
  wire       [5:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                tmp_io_pushOccupancy;
  wire                tmp_io_pushOccupancy_1;
  wire                tmp_io_pushOccupancy_2;
  wire                tmp_io_pushOccupancy_3;
  wire                tmp_io_pushOccupancy_4;
  wire                fifo_cc_dcfifo_1_wrclk_srstn_synchronized;
  reg        [5:0]    popCC_popPtr;
  (* keep , syn_keep *) wire       [5:0]    popCC_popPtrPlus /* synthesis syn_keep = 1 */ ;
  wire       [5:0]    popCC_popPtrGray;
  wire       [5:0]    popCC_pushPtrGray;
  wire                popCC_addressGen_valid;
  reg                 popCC_addressGen_ready;
  wire       [4:0]    popCC_addressGen_payload;
  wire                popCC_empty;
  wire                popCC_addressGen_fire;
  wire                popCC_readArbitation_valid;
  wire                popCC_readArbitation_ready;
  wire       [4:0]    popCC_readArbitation_payload;
  reg                 popCC_addressGen_rValid;
  reg        [4:0]    popCC_addressGen_rData;
  wire                popCC_readPort_cmd_valid;
  wire       [4:0]    popCC_readPort_cmd_payload;
  wire       [39:0]   popCC_readPort_rsp;
  wire                popCC_readArbitation_translated_valid;
  wire                popCC_readArbitation_translated_ready;
  wire       [39:0]   popCC_readArbitation_translated_payload;
  wire                popCC_readArbitation_fire;
  reg        [5:0]    popCC_ptrToPush;
  reg        [5:0]    popCC_ptrToOccupancy;
  wire                tmp_io_popOccupancy;
  wire                tmp_io_popOccupancy_1;
  wire                tmp_io_popOccupancy_2;
  wire                tmp_io_popOccupancy_3;
  wire                tmp_io_popOccupancy_4;
  reg [39:0] ram [0:31];

  assign tmp_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign tmp_ram_port = pushCC_pushPtr[4:0];
  assign tmp_popCC_popPtrGray = (popCC_popPtr >>> 1'b1);
  always @(posedge wrclk) begin
    if(tmp_1) begin
      ram[tmp_ram_port] <= io_push_payload;
    end
  end

  always @(posedge rdclk) begin
    if(popCC_readPort_cmd_valid) begin
      ram_spinal_port1 <= ram[popCC_readPort_cmd_payload];
    end
  end

  (* keep_hierarchy = "TRUE" *) BufferCC_12 popToPushGray_buffercc (
    .io_dataIn   (popToPushGray[5:0]                    ), //i
    .io_dataOut  (popToPushGray_buffercc_io_dataOut[5:0]), //o
    .wrclk       (wrclk                                 ), //i
    .wrclk_srstn (wrclk_srstn                           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_16 bufferCC_18 (
    .io_dataIn   (bufferCC_18_io_dataIn ), //i
    .io_dataOut  (bufferCC_18_io_dataOut), //o
    .rdclk       (rdclk                 ), //i
    .wrclk_srstn (wrclk_srstn           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_14 pushToPopGray_buffercc (
    .io_dataIn                                 (pushToPopGray[5:0]                       ), //i
    .io_dataOut                                (pushToPopGray_buffercc_io_dataOut[5:0]   ), //o
    .rdclk                                     (rdclk                                    ), //i
    .fifo_cc_dcfifo_1_wrclk_srstn_synchronized (fifo_cc_dcfifo_1_wrclk_srstn_synchronized)  //i
  );
  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(io_push_fire) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 6'h01); // @ BaseType.scala l299
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign pushCC_full = ((pushCC_pushPtrGray[5 : 4] == (~ pushCC_popPtrGray[5 : 4])) && (pushCC_pushPtrGray[3 : 0] == pushCC_popPtrGray[3 : 0])); // @ BaseType.scala l305
  assign io_push_ready = (! pushCC_full); // @ Stream.scala l1579
  assign tmp_io_pushOccupancy = (pushCC_popPtrGray[1] ^ tmp_io_pushOccupancy_1); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ tmp_io_pushOccupancy_2); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_2 = (pushCC_popPtrGray[3] ^ tmp_io_pushOccupancy_3); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_3 = (pushCC_popPtrGray[4] ^ tmp_io_pushOccupancy_4); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_4 = pushCC_popPtrGray[5]; // @ Utils.scala l433
  assign io_pushOccupancy = (pushCC_pushPtr - {tmp_io_pushOccupancy_4,{tmp_io_pushOccupancy_3,{tmp_io_pushOccupancy_2,{tmp_io_pushOccupancy_1,{tmp_io_pushOccupancy,(pushCC_popPtrGray[0] ^ tmp_io_pushOccupancy)}}}}}); // @ Stream.scala l1586
  assign bufferCC_18_io_dataIn = (1'b1 ^ 1'b0); // @ CrossClock.scala l15
  assign fifo_cc_dcfifo_1_wrclk_srstn_synchronized = bufferCC_18_io_dataOut; // @ CrossClock.scala l18
  assign popCC_popPtrPlus = (popCC_popPtr + 6'h01); // @ BaseType.scala l299
  assign popCC_popPtrGray = (tmp_popCC_popPtrGray ^ popCC_popPtr); // @ BaseType.scala l318
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray); // @ BaseType.scala l305
  assign popCC_addressGen_valid = (! popCC_empty); // @ Stream.scala l1597
  assign popCC_addressGen_payload = popCC_popPtr[4:0]; // @ Stream.scala l1598
  assign popCC_addressGen_fire = (popCC_addressGen_valid && popCC_addressGen_ready); // @ BaseType.scala l305
  always @(*) begin
    popCC_addressGen_ready = popCC_readArbitation_ready; // @ Stream.scala l374
    if((! popCC_readArbitation_valid)) begin
      popCC_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign popCC_readArbitation_valid = popCC_addressGen_rValid; // @ Stream.scala l377
  assign popCC_readArbitation_payload = popCC_addressGen_rData; // @ Stream.scala l378
  assign popCC_readPort_rsp = ram_spinal_port1; // @ Mem.scala l123
  assign popCC_readPort_cmd_valid = popCC_addressGen_fire; // @ Stream.scala l1606
  assign popCC_readPort_cmd_payload = popCC_addressGen_payload; // @ Stream.scala l1606
  assign popCC_readArbitation_translated_valid = popCC_readArbitation_valid; // @ Stream.scala l307
  assign popCC_readArbitation_ready = popCC_readArbitation_translated_ready; // @ Stream.scala l308
  assign popCC_readArbitation_translated_payload = popCC_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = popCC_readArbitation_translated_valid; // @ Stream.scala l298
  assign popCC_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = popCC_readArbitation_translated_payload; // @ Stream.scala l300
  assign popCC_readArbitation_fire = (popCC_readArbitation_valid && popCC_readArbitation_ready); // @ BaseType.scala l305
  assign tmp_io_popOccupancy = (popCC_pushPtrGray[1] ^ tmp_io_popOccupancy_1); // @ Utils.scala l431
  assign tmp_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ tmp_io_popOccupancy_2); // @ Utils.scala l431
  assign tmp_io_popOccupancy_2 = (popCC_pushPtrGray[3] ^ tmp_io_popOccupancy_3); // @ Utils.scala l431
  assign tmp_io_popOccupancy_3 = (popCC_pushPtrGray[4] ^ tmp_io_popOccupancy_4); // @ Utils.scala l431
  assign tmp_io_popOccupancy_4 = popCC_pushPtrGray[5]; // @ Utils.scala l433
  assign io_popOccupancy = ({tmp_io_popOccupancy_4,{tmp_io_popOccupancy_3,{tmp_io_popOccupancy_2,{tmp_io_popOccupancy_1,{tmp_io_popOccupancy,(popCC_pushPtrGray[0] ^ tmp_io_popOccupancy)}}}}} - popCC_ptrToOccupancy); // @ Stream.scala l1611
  assign pushToPopGray = pushCC_pushPtrGray; // @ Stream.scala l1614
  assign popToPushGray = popCC_ptrToPush; // @ Stream.scala l1615
  always @(posedge wrclk or negedge wrclk_srstn) begin
    if(!wrclk_srstn) begin
      pushCC_pushPtr <= 6'h0; // @ Data.scala l409
      pushCC_pushPtrGray <= 6'h0; // @ Data.scala l409
    end else begin
      if(io_push_fire) begin
        pushCC_pushPtrGray <= (tmp_pushCC_pushPtrGray ^ pushCC_pushPtrPlus); // @ Stream.scala l1575
      end
      if(io_push_fire) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus; // @ Stream.scala l1583
      end
    end
  end

  always @(posedge rdclk or negedge fifo_cc_dcfifo_1_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_1_wrclk_srstn_synchronized) begin
      popCC_popPtr <= 6'h0; // @ Data.scala l409
      popCC_addressGen_rValid <= 1'b0; // @ Data.scala l409
      popCC_ptrToPush <= 6'h0; // @ Data.scala l409
      popCC_ptrToOccupancy <= 6'h0; // @ Data.scala l409
    end else begin
      if(popCC_addressGen_fire) begin
        popCC_popPtr <= popCC_popPtrPlus; // @ Stream.scala l1601
      end
      if(popCC_addressGen_ready) begin
        popCC_addressGen_rValid <= popCC_addressGen_valid; // @ Stream.scala l365
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToPush <= popCC_popPtrGray; // @ Stream.scala l1609
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToOccupancy <= popCC_popPtr; // @ Stream.scala l1610
      end
    end
  end

  always @(posedge rdclk) begin
    if(popCC_addressGen_ready) begin
      popCC_addressGen_rData <= popCC_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifoCC_5 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [127:0]  io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [127:0]  io_pop_payload,
  output wire [3:0]    io_pushOccupancy,
  output wire [3:0]    io_popOccupancy,
  input  wire          wrclk,
  input  wire          wrclk_srstn,
  input  wire          rdclk
);

  wire                bufferCC_18_io_dataIn;
  reg        [127:0]  ram_spinal_port1;
  wire       [3:0]    popToPushGray_buffercc_io_dataOut;
  wire                bufferCC_18_io_dataOut;
  wire       [3:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [3:0]    tmp_pushCC_pushPtrGray;
  wire       [2:0]    tmp_ram_port;
  wire       [3:0]    tmp_popCC_popPtrGray;
  reg                 tmp_1;
  wire       [3:0]    popToPushGray;
  wire       [3:0]    pushToPopGray;
  reg        [3:0]    pushCC_pushPtr;
  wire       [3:0]    pushCC_pushPtrPlus;
  wire                io_push_fire;
  reg        [3:0]    pushCC_pushPtrGray;
  wire       [3:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                tmp_io_pushOccupancy;
  wire                tmp_io_pushOccupancy_1;
  wire                tmp_io_pushOccupancy_2;
  wire                fifo_cc_dcfifo_wrclk_srstn_synchronized;
  reg        [3:0]    popCC_popPtr;
  (* keep , syn_keep *) wire       [3:0]    popCC_popPtrPlus /* synthesis syn_keep = 1 */ ;
  wire       [3:0]    popCC_popPtrGray;
  wire       [3:0]    popCC_pushPtrGray;
  wire                popCC_addressGen_valid;
  reg                 popCC_addressGen_ready;
  wire       [2:0]    popCC_addressGen_payload;
  wire                popCC_empty;
  wire                popCC_addressGen_fire;
  wire                popCC_readArbitation_valid;
  wire                popCC_readArbitation_ready;
  wire       [2:0]    popCC_readArbitation_payload;
  reg                 popCC_addressGen_rValid;
  reg        [2:0]    popCC_addressGen_rData;
  wire                popCC_readPort_cmd_valid;
  wire       [2:0]    popCC_readPort_cmd_payload;
  wire       [127:0]  popCC_readPort_rsp;
  wire                popCC_readArbitation_translated_valid;
  wire                popCC_readArbitation_translated_ready;
  wire       [127:0]  popCC_readArbitation_translated_payload;
  wire                popCC_readArbitation_fire;
  reg        [3:0]    popCC_ptrToPush;
  reg        [3:0]    popCC_ptrToOccupancy;
  wire                tmp_io_popOccupancy;
  wire                tmp_io_popOccupancy_1;
  wire                tmp_io_popOccupancy_2;
  reg [127:0] ram [0:7];

  assign tmp_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign tmp_ram_port = pushCC_pushPtr[2:0];
  assign tmp_popCC_popPtrGray = (popCC_popPtr >>> 1'b1);
  always @(posedge wrclk) begin
    if(tmp_1) begin
      ram[tmp_ram_port] <= io_push_payload;
    end
  end

  always @(posedge rdclk) begin
    if(popCC_readPort_cmd_valid) begin
      ram_spinal_port1 <= ram[popCC_readPort_cmd_payload];
    end
  end

  (* keep_hierarchy = "TRUE" *) BufferCC_15 popToPushGray_buffercc (
    .io_dataIn   (popToPushGray[3:0]                    ), //i
    .io_dataOut  (popToPushGray_buffercc_io_dataOut[3:0]), //o
    .wrclk       (wrclk                                 ), //i
    .wrclk_srstn (wrclk_srstn                           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_16 bufferCC_18 (
    .io_dataIn   (bufferCC_18_io_dataIn ), //i
    .io_dataOut  (bufferCC_18_io_dataOut), //o
    .rdclk       (rdclk                 ), //i
    .wrclk_srstn (wrclk_srstn           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_17 pushToPopGray_buffercc (
    .io_dataIn                               (pushToPopGray[3:0]                     ), //i
    .io_dataOut                              (pushToPopGray_buffercc_io_dataOut[3:0] ), //o
    .rdclk                                   (rdclk                                  ), //i
    .fifo_cc_dcfifo_wrclk_srstn_synchronized (fifo_cc_dcfifo_wrclk_srstn_synchronized)  //i
  );
  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(io_push_fire) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 4'b0001); // @ BaseType.scala l299
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign pushCC_full = ((pushCC_pushPtrGray[3 : 2] == (~ pushCC_popPtrGray[3 : 2])) && (pushCC_pushPtrGray[1 : 0] == pushCC_popPtrGray[1 : 0])); // @ BaseType.scala l305
  assign io_push_ready = (! pushCC_full); // @ Stream.scala l1579
  assign tmp_io_pushOccupancy = (pushCC_popPtrGray[1] ^ tmp_io_pushOccupancy_1); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ tmp_io_pushOccupancy_2); // @ Utils.scala l431
  assign tmp_io_pushOccupancy_2 = pushCC_popPtrGray[3]; // @ Utils.scala l433
  assign io_pushOccupancy = (pushCC_pushPtr - {tmp_io_pushOccupancy_2,{tmp_io_pushOccupancy_1,{tmp_io_pushOccupancy,(pushCC_popPtrGray[0] ^ tmp_io_pushOccupancy)}}}); // @ Stream.scala l1586
  assign bufferCC_18_io_dataIn = (1'b1 ^ 1'b0); // @ CrossClock.scala l15
  assign fifo_cc_dcfifo_wrclk_srstn_synchronized = bufferCC_18_io_dataOut; // @ CrossClock.scala l18
  assign popCC_popPtrPlus = (popCC_popPtr + 4'b0001); // @ BaseType.scala l299
  assign popCC_popPtrGray = (tmp_popCC_popPtrGray ^ popCC_popPtr); // @ BaseType.scala l318
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut; // @ CrossClock.scala l18
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray); // @ BaseType.scala l305
  assign popCC_addressGen_valid = (! popCC_empty); // @ Stream.scala l1597
  assign popCC_addressGen_payload = popCC_popPtr[2:0]; // @ Stream.scala l1598
  assign popCC_addressGen_fire = (popCC_addressGen_valid && popCC_addressGen_ready); // @ BaseType.scala l305
  always @(*) begin
    popCC_addressGen_ready = popCC_readArbitation_ready; // @ Stream.scala l374
    if((! popCC_readArbitation_valid)) begin
      popCC_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign popCC_readArbitation_valid = popCC_addressGen_rValid; // @ Stream.scala l377
  assign popCC_readArbitation_payload = popCC_addressGen_rData; // @ Stream.scala l378
  assign popCC_readPort_rsp = ram_spinal_port1; // @ Mem.scala l123
  assign popCC_readPort_cmd_valid = popCC_addressGen_fire; // @ Stream.scala l1606
  assign popCC_readPort_cmd_payload = popCC_addressGen_payload; // @ Stream.scala l1606
  assign popCC_readArbitation_translated_valid = popCC_readArbitation_valid; // @ Stream.scala l307
  assign popCC_readArbitation_ready = popCC_readArbitation_translated_ready; // @ Stream.scala l308
  assign popCC_readArbitation_translated_payload = popCC_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = popCC_readArbitation_translated_valid; // @ Stream.scala l298
  assign popCC_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = popCC_readArbitation_translated_payload; // @ Stream.scala l300
  assign popCC_readArbitation_fire = (popCC_readArbitation_valid && popCC_readArbitation_ready); // @ BaseType.scala l305
  assign tmp_io_popOccupancy = (popCC_pushPtrGray[1] ^ tmp_io_popOccupancy_1); // @ Utils.scala l431
  assign tmp_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ tmp_io_popOccupancy_2); // @ Utils.scala l431
  assign tmp_io_popOccupancy_2 = popCC_pushPtrGray[3]; // @ Utils.scala l433
  assign io_popOccupancy = ({tmp_io_popOccupancy_2,{tmp_io_popOccupancy_1,{tmp_io_popOccupancy,(popCC_pushPtrGray[0] ^ tmp_io_popOccupancy)}}} - popCC_ptrToOccupancy); // @ Stream.scala l1611
  assign pushToPopGray = pushCC_pushPtrGray; // @ Stream.scala l1614
  assign popToPushGray = popCC_ptrToPush; // @ Stream.scala l1615
  always @(posedge wrclk or negedge wrclk_srstn) begin
    if(!wrclk_srstn) begin
      pushCC_pushPtr <= 4'b0000; // @ Data.scala l409
      pushCC_pushPtrGray <= 4'b0000; // @ Data.scala l409
    end else begin
      if(io_push_fire) begin
        pushCC_pushPtrGray <= (tmp_pushCC_pushPtrGray ^ pushCC_pushPtrPlus); // @ Stream.scala l1575
      end
      if(io_push_fire) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus; // @ Stream.scala l1583
      end
    end
  end

  always @(posedge rdclk or negedge fifo_cc_dcfifo_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_wrclk_srstn_synchronized) begin
      popCC_popPtr <= 4'b0000; // @ Data.scala l409
      popCC_addressGen_rValid <= 1'b0; // @ Data.scala l409
      popCC_ptrToPush <= 4'b0000; // @ Data.scala l409
      popCC_ptrToOccupancy <= 4'b0000; // @ Data.scala l409
    end else begin
      if(popCC_addressGen_fire) begin
        popCC_popPtr <= popCC_popPtrPlus; // @ Stream.scala l1601
      end
      if(popCC_addressGen_ready) begin
        popCC_addressGen_rValid <= popCC_addressGen_valid; // @ Stream.scala l365
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToPush <= popCC_popPtrGray; // @ Stream.scala l1609
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToOccupancy <= popCC_popPtr; // @ Stream.scala l1610
      end
    end
  end

  always @(posedge rdclk) begin
    if(popCC_addressGen_ready) begin
      popCC_addressGen_rData <= popCC_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [255:0]  io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [255:0]  io_pop_payload,
  input  wire          io_flush,
  output wire [6:0]    io_occupancy,
  output wire [6:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [255:0]  logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [6:0]    logic_ptr_push;
  reg        [6:0]    logic_ptr_pop;
  wire       [6:0]    logic_ptr_occupancy;
  wire       [6:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [5:0]    logic_push_onRam_write_payload_address;
  wire       [255:0]  logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [5:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [5:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [5:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [5:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [255:0]  logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [255:0]  logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [6:0]    logic_pop_sync_popReg;
  reg [255:0] logic_ram [0:63];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 7'h40) == 7'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[5:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[5:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (7'h40 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 7'h0; // @ Data.scala l409
      logic_ptr_pop <= 7'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 7'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 7'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 7'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 7'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 7'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 7'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_1 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [264:0]  io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [264:0]  io_pop_payload,
  input  wire          io_flush,
  output wire [6:0]    io_occupancy,
  output wire [6:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [264:0]  logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [6:0]    logic_ptr_push;
  reg        [6:0]    logic_ptr_pop;
  wire       [6:0]    logic_ptr_occupancy;
  wire       [6:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [5:0]    logic_push_onRam_write_payload_address;
  wire       [264:0]  logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [5:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [5:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [5:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [5:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [264:0]  logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [264:0]  logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [6:0]    logic_pop_sync_popReg;
  reg [264:0] logic_ram [0:63];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 7'h40) == 7'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[5:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[5:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (7'h40 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 7'h0; // @ Data.scala l409
      logic_ptr_pop <= 7'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 7'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 7'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 7'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 7'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 7'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 7'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_2 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [103:0]  io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [103:0]  io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [103:0]  logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [103:0]  logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [103:0]  logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [103:0]  logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [103:0] logic_ram [0:31];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (6'h20 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 6'h0; // @ Data.scala l409
      logic_ptr_pop <= 6'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 6'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 6'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_3 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [95:0]   io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [95:0]   io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [95:0]   logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [95:0]   logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [95:0]   logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [95:0]   logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [95:0] logic_ram [0:31];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (6'h20 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 6'h0; // @ Data.scala l409
      logic_ptr_pop <= 6'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 6'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 6'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_4 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [127:0]  io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [127:0]  io_pop_payload,
  input  wire          io_flush,
  output wire [6:0]    io_occupancy,
  output wire [6:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [127:0]  logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [6:0]    logic_ptr_push;
  reg        [6:0]    logic_ptr_pop;
  wire       [6:0]    logic_ptr_occupancy;
  wire       [6:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [5:0]    logic_push_onRam_write_payload_address;
  wire       [127:0]  logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [5:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [5:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [5:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [5:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [127:0]  logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [127:0]  logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [6:0]    logic_pop_sync_popReg;
  reg [127:0] logic_ram [0:63];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 7'h40) == 7'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[5:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[5:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (7'h40 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 7'h0; // @ Data.scala l409
      logic_ptr_pop <= 7'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 7'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 7'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 7'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 7'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 7'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 7'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_5 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [511:0]  io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [511:0]  io_pop_payload,
  input  wire          io_flush,
  output wire [3:0]    io_occupancy,
  output wire [3:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [511:0]  logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [3:0]    logic_ptr_push;
  reg        [3:0]    logic_ptr_pop;
  wire       [3:0]    logic_ptr_occupancy;
  wire       [3:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [2:0]    logic_push_onRam_write_payload_address;
  wire       [511:0]  logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [2:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [2:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [2:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [2:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [511:0]  logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [511:0]  logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [3:0]    logic_pop_sync_popReg;
  reg [511:0] logic_ram [0:7];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 4'b1000) == 4'b0000); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[2:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[2:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (4'b1000 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 4'b0000; // @ Data.scala l409
      logic_ptr_pop <= 4'b0000; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 4'b0000; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 4'b0001); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 4'b0001); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 4'b0000; // @ Stream.scala l1291
        logic_ptr_pop <= 4'b0000; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 4'b0000; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_6 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [10:0]   io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [10:0]   io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [10:0]   logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [10:0]   logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [10:0]   logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [10:0]   logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [10:0] logic_ram [0:31];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (6'h20 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 6'h0; // @ Data.scala l409
      logic_ptr_pop <= 6'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 6'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 6'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_7 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [39:0]   io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [39:0]   io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [39:0]   logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [39:0]   logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [39:0]   logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [39:0]   logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [39:0] logic_ram [0:31];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (6'h20 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 6'h0; // @ Data.scala l409
      logic_ptr_pop <= 6'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 6'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 6'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_8 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [264:0]  io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [264:0]  io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [264:0]  logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [264:0]  logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [264:0]  logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [264:0]  logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [264:0] logic_ram [0:31];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (6'h20 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 6'h0; // @ Data.scala l409
      logic_ptr_pop <= 6'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 6'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 6'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_9 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [255:0]  io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [255:0]  io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [255:0]  logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [255:0]  logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [255:0]  logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [255:0]  logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [255:0] logic_ram [0:31];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (6'h20 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 6'h0; // @ Data.scala l409
      logic_ptr_pop <= 6'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 6'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 6'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_10 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [31:0]   io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [31:0]   io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [31:0]   logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [31:0]   logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [31:0]   logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [31:0]   logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [31:0] logic_ram [0:31];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (6'h20 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 6'h0; // @ Data.scala l409
      logic_ptr_pop <= 6'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 6'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 6'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_11 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [23:0]   io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [23:0]   io_pop_payload,
  input  wire          io_flush,
  output wire [10:0]   io_occupancy,
  output wire [10:0]   io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [23:0]   logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [10:0]   logic_ptr_push;
  reg        [10:0]   logic_ptr_pop;
  wire       [10:0]   logic_ptr_occupancy;
  wire       [10:0]   logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [9:0]    logic_push_onRam_write_payload_address;
  wire       [23:0]   logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [9:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [9:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [9:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [9:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [23:0]   logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [23:0]   logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [10:0]   logic_pop_sync_popReg;
  reg [23:0] logic_ram [0:1023];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 11'h400) == 11'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[9:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[9:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (11'h400 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 11'h0; // @ Data.scala l409
      logic_ptr_pop <= 11'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 11'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 11'h001); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 11'h001); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 11'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 11'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 11'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_12 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [23:0]   io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [23:0]   io_pop_payload,
  input  wire          io_flush,
  output wire [3:0]    io_occupancy,
  output wire [3:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [23:0]   logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [3:0]    logic_ptr_push;
  reg        [3:0]    logic_ptr_pop;
  wire       [3:0]    logic_ptr_occupancy;
  wire       [3:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [2:0]    logic_push_onRam_write_payload_address;
  wire       [23:0]   logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [2:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [2:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [2:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [2:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [23:0]   logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [23:0]   logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [3:0]    logic_pop_sync_popReg;
  reg [23:0] logic_ram [0:7];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 4'b1000) == 4'b0000); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[2:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[2:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (4'b1000 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 4'b0000; // @ Data.scala l409
      logic_ptr_pop <= 4'b0000; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 4'b0000; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 4'b0001); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 4'b0001); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 4'b0000; // @ Stream.scala l1291
        logic_ptr_pop <= 4'b0000; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 4'b0000; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_13 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [127:0]  io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [127:0]  io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [127:0]  logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [127:0]  logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [127:0]  logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [127:0]  logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [127:0] logic_ram [0:31];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (6'h20 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 6'h0; // @ Data.scala l409
      logic_ptr_pop <= 6'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 6'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 6'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_14 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [307:0]  io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [307:0]  io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [307:0]  logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [307:0]  logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [307:0]  logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [307:0]  logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [307:0] logic_ram [0:31];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (6'h20 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 6'h0; // @ Data.scala l409
      logic_ptr_pop <= 6'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 6'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 6'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_15 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [1023:0] io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [1023:0] io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [1023:0] logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [1023:0] logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [1023:0] logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [1023:0] logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [1023:0] logic_ram [0:31];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (6'h20 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 6'h0; // @ Data.scala l409
      logic_ptr_pop <= 6'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 6'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 6'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_16 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [7:0]    io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [7:0]    io_pop_payload,
  input  wire          io_flush,
  output wire [4:0]    io_occupancy,
  output wire [4:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [7:0]    logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [4:0]    logic_ptr_push;
  reg        [4:0]    logic_ptr_pop;
  wire       [4:0]    logic_ptr_occupancy;
  wire       [4:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [3:0]    logic_push_onRam_write_payload_address;
  wire       [7:0]    logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [3:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [3:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [3:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [3:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [7:0]    logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [7:0]    logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [4:0]    logic_pop_sync_popReg;
  reg [7:0] logic_ram [0:15];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 5'h10) == 5'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[3:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[3:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (5'h10 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 5'h0; // @ Data.scala l409
      logic_ptr_pop <= 5'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 5'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 5'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 5'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 5'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 5'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 5'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_17 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [7:0]    io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [7:0]    io_pop_payload,
  input  wire          io_flush,
  output wire [7:0]    io_occupancy,
  output wire [7:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [7:0]    logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [7:0]    logic_ptr_push;
  reg        [7:0]    logic_ptr_pop;
  wire       [7:0]    logic_ptr_occupancy;
  wire       [7:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [6:0]    logic_push_onRam_write_payload_address;
  wire       [7:0]    logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [6:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [6:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [6:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [6:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [7:0]    logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [7:0]    logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [7:0]    logic_pop_sync_popReg;
  reg [7:0] logic_ram [0:127];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 8'h80) == 8'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[6:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[6:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (8'h80 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 8'h0; // @ Data.scala l409
      logic_ptr_pop <= 8'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 8'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 8'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 8'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 8'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 8'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 8'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_18 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [7:0]    io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [7:0]    io_pop_payload,
  input  wire          io_flush,
  output wire [3:0]    io_occupancy,
  output wire [3:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [7:0]    logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [3:0]    logic_ptr_push;
  reg        [3:0]    logic_ptr_pop;
  wire       [3:0]    logic_ptr_occupancy;
  wire       [3:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [2:0]    logic_push_onRam_write_payload_address;
  wire       [7:0]    logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [2:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [2:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [2:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [2:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [7:0]    logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [7:0]    logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [3:0]    logic_pop_sync_popReg;
  reg [7:0] logic_ram [0:7];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 4'b1000) == 4'b0000); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[2:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[2:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (4'b1000 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 4'b0000; // @ Data.scala l409
      logic_ptr_pop <= 4'b0000; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 4'b0000; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 4'b0001); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 4'b0001); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 4'b0000; // @ Stream.scala l1291
        logic_ptr_pop <= 4'b0000; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 4'b0000; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_19 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [63:0]   io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [63:0]   io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [63:0]   logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [63:0]   logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [63:0]   logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [63:0]   logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [63:0] logic_ram [0:31];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (6'h20 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 6'h0; // @ Data.scala l409
      logic_ptr_pop <= 6'h0; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 6'h0; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0; // @ Stream.scala l1291
        logic_ptr_pop <= 6'h0; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module StreamFifo_20 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [63:0]   io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [63:0]   io_pop_payload,
  input  wire          io_flush,
  output wire [3:0]    io_occupancy,
  output wire [3:0]    io_availability,
  input  wire          clock,
  input  wire          aclr
);

  reg        [63:0]   logic_ram_spinal_port1;
  reg                 tmp_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [3:0]    logic_ptr_push;
  reg        [3:0]    logic_ptr_pop;
  wire       [3:0]    logic_ptr_occupancy;
  wire       [3:0]    logic_ptr_popOnIo;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [2:0]    logic_push_onRam_write_payload_address;
  wire       [63:0]   logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [2:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [2:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [2:0]    logic_pop_addressGen_rData;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [2:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [63:0]   logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [63:0]   logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [3:0]    logic_pop_sync_popReg;
  reg [63:0] logic_ram [0:7];

  always @(posedge clock) begin
    if(tmp_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clock) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    tmp_1 = 1'b0; // @ when.scala l47
    if(logic_push_onRam_write_valid) begin
      tmp_1 = 1'b1; // @ when.scala l52
    end
  end

  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 4'b1000) == 4'b0000); // @ Stream.scala l1254
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop); // @ Stream.scala l1255
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo); // @ Stream.scala l1297
  assign io_push_ready = (! logic_ptr_full); // @ Stream.scala l1315
  assign io_push_fire = (io_push_valid && io_push_ready); // @ BaseType.scala l305
  assign logic_ptr_doPush = io_push_fire; // @ Stream.scala l1316
  assign logic_push_onRam_write_valid = io_push_fire; // @ Stream.scala l1319
  assign logic_push_onRam_write_payload_address = logic_ptr_push[2:0]; // @ Stream.scala l1320
  assign logic_push_onRam_write_payload_data = io_push_payload; // @ Stream.scala l1321
  assign logic_pop_addressGen_valid = (! logic_ptr_empty); // @ Stream.scala l1332
  assign logic_pop_addressGen_payload = logic_ptr_pop[2:0]; // @ Stream.scala l1333
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready); // @ BaseType.scala l305
  assign logic_ptr_doPop = logic_pop_addressGen_fire; // @ Stream.scala l1334
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready; // @ Stream.scala l374
    if((! logic_pop_sync_readArbitation_valid)) begin
      logic_pop_addressGen_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid; // @ Stream.scala l377
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData; // @ Stream.scala l378
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1; // @ Mem.scala l123
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire; // @ Stream.scala l1340
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload; // @ Stream.scala l1340
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid; // @ Stream.scala l307
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready; // @ Stream.scala l308
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp; // @ Stream.scala l328
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid; // @ Stream.scala l298
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready; // @ Stream.scala l299
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload; // @ Stream.scala l300
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready); // @ BaseType.scala l305
  assign logic_ptr_popOnIo = logic_pop_sync_popReg; // @ Stream.scala l1344
  assign io_occupancy = logic_ptr_occupancy; // @ Stream.scala l1366
  assign io_availability = (4'b1000 - logic_ptr_occupancy); // @ Stream.scala l1367
  always @(posedge clock) begin
    if(aclr) begin
      logic_ptr_push <= 4'b0000; // @ Data.scala l409
      logic_ptr_pop <= 4'b0000; // @ Data.scala l409
      logic_ptr_wentUp <= 1'b0; // @ Data.scala l409
      logic_pop_addressGen_rValid <= 1'b0; // @ Data.scala l409
      logic_pop_sync_popReg <= 4'b0000; // @ Data.scala l409
    end else begin
      if((logic_ptr_doPush != logic_ptr_doPop)) begin
        logic_ptr_wentUp <= logic_ptr_doPush; // @ Stream.scala l1248
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0; // @ Stream.scala l1248
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 4'b0001); // @ Stream.scala l1282
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 4'b0001); // @ Stream.scala l1286
      end
      if(io_flush) begin
        logic_ptr_push <= 4'b0000; // @ Stream.scala l1291
        logic_ptr_pop <= 4'b0000; // @ Stream.scala l1292
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid; // @ Stream.scala l365
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0; // @ Stream.scala l372
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop; // @ Stream.scala l1343
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 4'b0000; // @ Stream.scala l1345
      end
    end
  end

  always @(posedge clock) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload; // @ Stream.scala l366
    end
  end


endmodule

module BufferCC_2 (
  input  wire [5:0]    io_dataIn,
  output wire [5:0]    io_dataOut,
  input  wire          rdclk,
  input  wire          fifo_cc_dcfifo_5_wrclk_srstn_synchronized
);

  (* async_reg = "true" *) reg        [5:0]    buffers_0;
  (* async_reg = "true" *) reg        [5:0]    buffers_1;

  assign io_dataOut = buffers_1; // @ CrossClock.scala l77
  always @(posedge rdclk or negedge fifo_cc_dcfifo_5_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_5_wrclk_srstn_synchronized) begin
      buffers_0 <= 6'h0; // @ Data.scala l409
      buffers_1 <= 6'h0; // @ Data.scala l409
    end else begin
      buffers_0 <= io_dataIn; // @ CrossClock.scala l68
      buffers_1 <= buffers_0; // @ CrossClock.scala l72
    end
  end


endmodule

//BufferCC_1 replaced by BufferCC_16

//BufferCC replaced by BufferCC_12

module BufferCC_5 (
  input  wire [4:0]    io_dataIn,
  output wire [4:0]    io_dataOut,
  input  wire          rdclk,
  input  wire          fifo_cc_dcfifo_4_wrclk_srstn_synchronized
);

  (* async_reg = "true" *) reg        [4:0]    buffers_0;
  (* async_reg = "true" *) reg        [4:0]    buffers_1;

  assign io_dataOut = buffers_1; // @ CrossClock.scala l77
  always @(posedge rdclk or negedge fifo_cc_dcfifo_4_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_4_wrclk_srstn_synchronized) begin
      buffers_0 <= 5'h0; // @ Data.scala l409
      buffers_1 <= 5'h0; // @ Data.scala l409
    end else begin
      buffers_0 <= io_dataIn; // @ CrossClock.scala l68
      buffers_1 <= buffers_0; // @ CrossClock.scala l72
    end
  end


endmodule

//BufferCC_4 replaced by BufferCC_16

//BufferCC_3 replaced by BufferCC_6

module BufferCC_8 (
  input  wire [4:0]    io_dataIn,
  output wire [4:0]    io_dataOut,
  input  wire          rdclk,
  input  wire          fifo_cc_dcfifo_3_wrclk_srstn_synchronized
);

  (* async_reg = "true" *) reg        [4:0]    buffers_0;
  (* async_reg = "true" *) reg        [4:0]    buffers_1;

  assign io_dataOut = buffers_1; // @ CrossClock.scala l77
  always @(posedge rdclk or negedge fifo_cc_dcfifo_3_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_3_wrclk_srstn_synchronized) begin
      buffers_0 <= 5'h0; // @ Data.scala l409
      buffers_1 <= 5'h0; // @ Data.scala l409
    end else begin
      buffers_0 <= io_dataIn; // @ CrossClock.scala l68
      buffers_1 <= buffers_0; // @ CrossClock.scala l72
    end
  end


endmodule

//BufferCC_7 replaced by BufferCC_16

module BufferCC_6 (
  input  wire [4:0]    io_dataIn,
  output wire [4:0]    io_dataOut,
  input  wire          wrclk,
  input  wire          wrclk_srstn
);

  (* async_reg = "true" *) reg        [4:0]    buffers_0;
  (* async_reg = "true" *) reg        [4:0]    buffers_1;

  assign io_dataOut = buffers_1; // @ CrossClock.scala l77
  always @(posedge wrclk or negedge wrclk_srstn) begin
    if(!wrclk_srstn) begin
      buffers_0 <= 5'h0; // @ Data.scala l409
      buffers_1 <= 5'h0; // @ Data.scala l409
    end else begin
      buffers_0 <= io_dataIn; // @ CrossClock.scala l68
      buffers_1 <= buffers_0; // @ CrossClock.scala l72
    end
  end


endmodule

module BufferCC_11 (
  input  wire [7:0]    io_dataIn,
  output wire [7:0]    io_dataOut,
  input  wire          rdclk,
  input  wire          fifo_cc_dcfifo_2_wrclk_srstn_synchronized
);

  (* async_reg = "true" *) reg        [7:0]    buffers_0;
  (* async_reg = "true" *) reg        [7:0]    buffers_1;

  assign io_dataOut = buffers_1; // @ CrossClock.scala l77
  always @(posedge rdclk or negedge fifo_cc_dcfifo_2_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_2_wrclk_srstn_synchronized) begin
      buffers_0 <= 8'h0; // @ Data.scala l409
      buffers_1 <= 8'h0; // @ Data.scala l409
    end else begin
      buffers_0 <= io_dataIn; // @ CrossClock.scala l68
      buffers_1 <= buffers_0; // @ CrossClock.scala l72
    end
  end


endmodule

//BufferCC_10 replaced by BufferCC_16

module BufferCC_9 (
  input  wire [7:0]    io_dataIn,
  output wire [7:0]    io_dataOut,
  input  wire          wrclk,
  input  wire          wrclk_srstn
);

  (* async_reg = "true" *) reg        [7:0]    buffers_0;
  (* async_reg = "true" *) reg        [7:0]    buffers_1;

  assign io_dataOut = buffers_1; // @ CrossClock.scala l77
  always @(posedge wrclk or negedge wrclk_srstn) begin
    if(!wrclk_srstn) begin
      buffers_0 <= 8'h0; // @ Data.scala l409
      buffers_1 <= 8'h0; // @ Data.scala l409
    end else begin
      buffers_0 <= io_dataIn; // @ CrossClock.scala l68
      buffers_1 <= buffers_0; // @ CrossClock.scala l72
    end
  end


endmodule

module BufferCC_14 (
  input  wire [5:0]    io_dataIn,
  output wire [5:0]    io_dataOut,
  input  wire          rdclk,
  input  wire          fifo_cc_dcfifo_1_wrclk_srstn_synchronized
);

  (* async_reg = "true" *) reg        [5:0]    buffers_0;
  (* async_reg = "true" *) reg        [5:0]    buffers_1;

  assign io_dataOut = buffers_1; // @ CrossClock.scala l77
  always @(posedge rdclk or negedge fifo_cc_dcfifo_1_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_1_wrclk_srstn_synchronized) begin
      buffers_0 <= 6'h0; // @ Data.scala l409
      buffers_1 <= 6'h0; // @ Data.scala l409
    end else begin
      buffers_0 <= io_dataIn; // @ CrossClock.scala l68
      buffers_1 <= buffers_0; // @ CrossClock.scala l72
    end
  end


endmodule

//BufferCC_13 replaced by BufferCC_16

module BufferCC_12 (
  input  wire [5:0]    io_dataIn,
  output wire [5:0]    io_dataOut,
  input  wire          wrclk,
  input  wire          wrclk_srstn
);

  (* async_reg = "true" *) reg        [5:0]    buffers_0;
  (* async_reg = "true" *) reg        [5:0]    buffers_1;

  assign io_dataOut = buffers_1; // @ CrossClock.scala l77
  always @(posedge wrclk or negedge wrclk_srstn) begin
    if(!wrclk_srstn) begin
      buffers_0 <= 6'h0; // @ Data.scala l409
      buffers_1 <= 6'h0; // @ Data.scala l409
    end else begin
      buffers_0 <= io_dataIn; // @ CrossClock.scala l68
      buffers_1 <= buffers_0; // @ CrossClock.scala l72
    end
  end


endmodule

module BufferCC_17 (
  input  wire [3:0]    io_dataIn,
  output wire [3:0]    io_dataOut,
  input  wire          rdclk,
  input  wire          fifo_cc_dcfifo_wrclk_srstn_synchronized
);

  (* async_reg = "true" *) reg        [3:0]    buffers_0;
  (* async_reg = "true" *) reg        [3:0]    buffers_1;

  assign io_dataOut = buffers_1; // @ CrossClock.scala l77
  always @(posedge rdclk or negedge fifo_cc_dcfifo_wrclk_srstn_synchronized) begin
    if(!fifo_cc_dcfifo_wrclk_srstn_synchronized) begin
      buffers_0 <= 4'b0000; // @ Data.scala l409
      buffers_1 <= 4'b0000; // @ Data.scala l409
    end else begin
      buffers_0 <= io_dataIn; // @ CrossClock.scala l68
      buffers_1 <= buffers_0; // @ CrossClock.scala l72
    end
  end


endmodule

module BufferCC_16 (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          rdclk,
  input  wire          wrclk_srstn
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1; // @ CrossClock.scala l77
  always @(posedge rdclk or negedge wrclk_srstn) begin
    if(!wrclk_srstn) begin
      buffers_0 <= 1'b0; // @ Data.scala l409
      buffers_1 <= 1'b0; // @ Data.scala l409
    end else begin
      buffers_0 <= io_dataIn; // @ CrossClock.scala l68
      buffers_1 <= buffers_0; // @ CrossClock.scala l72
    end
  end


endmodule

module BufferCC_15 (
  input  wire [3:0]    io_dataIn,
  output wire [3:0]    io_dataOut,
  input  wire          wrclk,
  input  wire          wrclk_srstn
);

  (* async_reg = "true" *) reg        [3:0]    buffers_0;
  (* async_reg = "true" *) reg        [3:0]    buffers_1;

  assign io_dataOut = buffers_1; // @ CrossClock.scala l77
  always @(posedge wrclk or negedge wrclk_srstn) begin
    if(!wrclk_srstn) begin
      buffers_0 <= 4'b0000; // @ Data.scala l409
      buffers_1 <= 4'b0000; // @ Data.scala l409
    end else begin
      buffers_0 <= io_dataIn; // @ CrossClock.scala l68
      buffers_1 <= buffers_0; // @ CrossClock.scala l72
    end
  end


endmodule
