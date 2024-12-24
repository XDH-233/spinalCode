// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : axi_demo
// Git hash  : 009989a4a162ae6ed46680114c230e5bc7ecc6d0
// 



module axi_demo (
  input  wire          axi4_s_awvalid,
  output wire          axi4_s_awready,
  input  wire [15:0]   axi4_s_awaddr,
  input  wire [2:0]    axi4_s_awid,
  input  wire [7:0]    axi4_s_awlen,
  input  wire [2:0]    axi4_s_awsize,
  input  wire [1:0]    axi4_s_awburst,
  input  wire          axi4_s_wvalid,
  output wire          axi4_s_wready,
  input  wire [31:0]   axi4_s_wdata,
  input  wire [3:0]    axi4_s_wstrb,
  input  wire          axi4_s_wlast,
  output wire          axi4_s_bvalid,
  input  wire          axi4_s_bready,
  output reg  [2:0]    axi4_s_bid,
  output wire [1:0]    axi4_s_bresp,
  input  wire          axi4_s_arvalid,
  output wire          axi4_s_arready,
  input  wire [15:0]   axi4_s_araddr,
  input  wire [2:0]    axi4_s_arid,
  input  wire [7:0]    axi4_s_arlen,
  input  wire [2:0]    axi4_s_arsize,
  input  wire [1:0]    axi4_s_arburst,
  output wire          axi4_s_rvalid,
  input  wire          axi4_s_rready,
  output wire [31:0]   axi4_s_rdata,
  output wire [2:0]    axi4_s_rid,
  output wire [1:0]    axi4_s_rresp,
  output wire          axi4_s_rlast,
  input  wire          axi4s_s_valid,
  output wire          axi4s_s_ready,
  input  wire [255:0]  axi4s_s_payload_data,
  input  wire          clk,
  input  wire          reset
);

  wire                axi4_s_w_fire;
  reg                 tmp_axi4_s_bvalid;
  wire       [4:0]    tmp_axi4_s_bid;
  reg        [2:0]    axi4_s_awid_regNext;
  wire       [37:0]   tmp_axi4_s_rdata;
  wire                reg_1;

  assign axi4_s_awready = 1'b1; // @ Bool.scala l90
  assign axi4_s_wready = 1'b1; // @ Bool.scala l90
  assign axi4_s_w_fire = (axi4_s_wvalid && axi4_s_wready); // @ BaseType.scala l305
  assign axi4_s_bvalid = tmp_axi4_s_bvalid; // @ AXIDemo.scala l24
  assign tmp_axi4_s_bid = 5'h0; // @ BitVector.scala l494
  always @(*) begin
    axi4_s_bid = tmp_axi4_s_bid[2 : 0]; // @ UInt.scala l381
    axi4_s_bid = axi4_s_awid_regNext; // @ AXIDemo.scala l27
  end

  assign axi4_s_bresp = tmp_axi4_s_bid[4 : 3]; // @ Bits.scala l133
  assign axi4_s_arready = 1'b1; // @ Bool.scala l90
  assign axi4_s_rvalid = 1'b0; // @ Bool.scala l92
  assign tmp_axi4_s_rdata = 38'h0; // @ BitVector.scala l494
  assign axi4_s_rdata = tmp_axi4_s_rdata[31 : 0]; // @ Bits.scala l133
  assign axi4_s_rid = tmp_axi4_s_rdata[34 : 32]; // @ UInt.scala l381
  assign axi4_s_rresp = tmp_axi4_s_rdata[36 : 35]; // @ Bits.scala l133
  assign axi4_s_rlast = tmp_axi4_s_rdata[37]; // @ Bool.scala l209
  assign axi4s_s_ready = 1'b1; // @ Bool.scala l90
  assign reg_1 = 1'b0;
  always @(posedge clk) begin
    if(reset) begin
      tmp_axi4_s_bvalid <= 1'b0; // @ Data.scala l409
    end else begin
      tmp_axi4_s_bvalid <= (axi4_s_w_fire && axi4_s_wlast); // @ Reg.scala l39
    end
  end

  always @(posedge clk) begin
    axi4_s_awid_regNext <= axi4_s_awid; // @ Reg.scala l39
  end


endmodule
