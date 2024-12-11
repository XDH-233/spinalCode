// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : cmdq_id_mngr
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766
// Gen time  : 2024-11-25 11:51:40


module cmdq_id_mngr (
  input  wire          io_clear_valid,
  output reg           io_clear_ready,
  input  wire [4:0]    io_clear_payload,
  output wire          io_fetch_valid,
  input  wire          io_fetch_ready,
  output wire [4:0]    io_fetch_payload,
  input  wire          reset,
  input  wire          clk
);

  wire       [4:0]    id_fifo_din;
  wire                id_fifo_full;
  wire       [4:0]    id_fifo_dout;
  wire                id_fifo_empty;
  wire                id_fifo_almost_empty;
  wire                id_fifo_almost_full;
  wire       [4:0]    id_fifo_usedw;
  wire                id_fifo_overflow;
  wire                id_fifo_underflow;
  wire       [4:0]    tmp_cnt_valueNext;
  wire       [0:0]    tmp_cnt_valueNext_1;
  reg                 init_push;
  reg                 cnt_willIncrement;
  wire                cnt_willClear;
  reg        [4:0]    cnt_valueNext;
  reg        [4:0]    cnt_value;
  wire                cnt_willOverflowIfInc;
  wire                cnt_willOverflow;
  reg                 push_valid;
  wire                push_ready;
  reg        [4:0]    push_payload;

  assign tmp_cnt_valueNext_1 = cnt_willIncrement;
  assign tmp_cnt_valueNext = {4'd0, tmp_cnt_valueNext_1};
  rdma_ctyun_sfifo #(
    .DEPTH      (32),
    .DATA_WIDTH (5 )
  ) id_fifo (
    .clk          (clk                 ), //i
    .srst         (reset               ), //i
    .wr_en        (push_valid          ), //i
    .din          (id_fifo_din[4:0]    ), //i
    .full         (id_fifo_full        ), //o
    .rd_en        (io_fetch_ready      ), //i
    .dout         (id_fifo_dout[4:0]   ), //o
    .empty        (id_fifo_empty       ), //o
    .almost_empty (id_fifo_almost_empty), //o
    .almost_full  (id_fifo_almost_full ), //o
    .usedw        (id_fifo_usedw[4:0]  ), //o
    .overflow     (id_fifo_overflow    ), //o
    .underflow    (id_fifo_underflow   )  //o
  );
  always @(*) begin
    cnt_willIncrement = 1'b0; // @ Utils.scala l594
    if(init_push) begin
      cnt_willIncrement = 1'b1; // @ Utils.scala l598
    end
  end

  assign cnt_willClear = 1'b0; // @ Utils.scala l595
  assign cnt_willOverflowIfInc = (cnt_value == 5'h1f); // @ BaseType.scala l305
  assign cnt_willOverflow = (cnt_willOverflowIfInc && cnt_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    cnt_valueNext = (cnt_value + tmp_cnt_valueNext); // @ Utils.scala l606
    if(cnt_willClear) begin
      cnt_valueNext = 5'h0; // @ Utils.scala l616
    end
  end

  assign id_fifo_din = push_payload; // @ rdma_ctyun_sfifo.scala l34
  assign push_ready = (! id_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign io_fetch_valid = (! id_fifo_empty); // @ id_mngr.scala l21
  assign io_fetch_payload = id_fifo_dout; // @ id_mngr.scala l21
  always @(*) begin
    if(init_push) begin
      io_clear_ready = 1'b0; // @ Bool.scala l92
    end else begin
      io_clear_ready = push_ready; // @ id_mngr.scala l30
    end
  end

  always @(*) begin
    if(init_push) begin
      push_valid = 1'b1; // @ Bool.scala l90
    end else begin
      push_valid = io_clear_valid; // @ id_mngr.scala l30
    end
  end

  always @(*) begin
    if(init_push) begin
      push_payload = cnt_value; // @ id_mngr.scala l28
    end else begin
      push_payload = io_clear_payload; // @ id_mngr.scala l30
    end
  end

  always @(posedge clk) begin
    if(reset) begin
      init_push <= 1'b1; // @ Data.scala l409
      cnt_value <= 5'h0; // @ Data.scala l409
    end else begin
      cnt_value <= cnt_valueNext; // @ Reg.scala l39
      if((cnt_value == 5'h1f)) begin
        init_push <= 1'b0; // @ Bool.scala l92
      end
    end
  end


endmodule
