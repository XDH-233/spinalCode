// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : axi_demo
// Git hash  : 99564492b4af4ebc9cf6d2191d7d7b4bde9ca06b
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
  input  wire          axi4s_s_tvalid,
  output wire          axi4s_s_tready,
  input  wire [31:0]   axi4s_s_tdata,
  input  wire [7:0]    axi4s_s_tid,
  input  wire [3:0]    axi4s_s_tkeep,
  input  wire          axi4s_s_tlast,
  input  wire          axil_s_awvalid,
  output reg           axil_s_awready,
  input  wire [31:0]   axil_s_awaddr,
  input  wire [2:0]    axil_s_awprot,
  input  wire          axil_s_wvalid,
  output reg           axil_s_wready,
  input  wire [31:0]   axil_s_wdata,
  input  wire [3:0]    axil_s_wstrb,
  output wire          axil_s_bvalid,
  input  wire          axil_s_bready,
  output wire [1:0]    axil_s_bresp,
  input  wire          axil_s_arvalid,
  output reg           axil_s_arready,
  input  wire [31:0]   axil_s_araddr,
  input  wire [2:0]    axil_s_arprot,
  output wire          axil_s_rvalid,
  input  wire          axil_s_rready,
  output wire [31:0]   axil_s_rdata,
  output wire [1:0]    axil_s_rresp,
  input  wire          clk,
  input  wire          reset
);

  wire       [31:0]   tmp_1;
  reg        [15:0]   reg_field0;
  reg        [15:0]   reg_field1;
  wire                bus_if_bus_rderr;
  wire       [31:0]   bus_if_bus_rdata;
  reg                 bus_if_reg_rderr;
  reg        [31:0]   bus_if_reg_rdata;
  wire       [3:0]    bus_if_wstrb;
  reg        [31:0]   bus_if_wmask;
  reg        [31:0]   bus_if_wmaskn;
  wire                bus_if_axiAr_valid;
  wire                bus_if_axiAr_ready;
  wire       [31:0]   bus_if_axiAr_payload_addr;
  wire       [2:0]    bus_if_axiAr_payload_prot;
  reg                 axil_s_ar_rValid;
  reg        [31:0]   axil_s_ar_rData_addr;
  reg        [2:0]    axil_s_ar_rData_prot;
  wire                bus_if_axiR_valid;
  wire                bus_if_axiR_ready;
  wire       [31:0]   bus_if_axiR_payload_data;
  reg        [1:0]    bus_if_axiR_payload_resp;
  reg                 bus_if_axiRValid;
  wire                bus_if_axiAw_valid;
  wire                bus_if_axiAw_ready;
  wire       [31:0]   bus_if_axiAw_payload_addr;
  wire       [2:0]    bus_if_axiAw_payload_prot;
  reg                 axil_s_aw_rValid;
  reg        [31:0]   axil_s_aw_rData_addr;
  reg        [2:0]    axil_s_aw_rData_prot;
  wire                bus_if_axiW_valid;
  wire                bus_if_axiW_ready;
  wire       [31:0]   bus_if_axiW_payload_data;
  wire       [3:0]    bus_if_axiW_payload_strb;
  reg                 axil_s_w_rValid;
  reg        [31:0]   axil_s_w_rData_data;
  reg        [3:0]    axil_s_w_rData_strb;
  wire                bus_if_axiB_valid;
  wire                bus_if_axiB_ready;
  wire       [1:0]    bus_if_axiB_payload_resp;
  reg                 bus_if_axiBValid;
  wire                bus_if_askWrite;
  wire                bus_if_askRead;
  wire                bus_if_doWrite;
  wire                bus_if_doRead;
  wire                read_hit_0x0000;
  wire                write_hit_0x0000;
  wire                axi4_s_w_fire;
  reg                 tmp_axi4_s_bvalid;
  wire       [4:0]    tmp_axi4_s_bid;
  reg        [2:0]    axi4_s_awid_regNext;
  wire       [37:0]   tmp_axi4_s_rdata;

  assign tmp_1 = {bus_if_axiAr_payload_addr[31 : 2],2'b00};
  always @(*) begin
    axil_s_arready = bus_if_axiAr_ready; // @ Stream.scala l374
    if((! bus_if_axiAr_valid)) begin
      axil_s_arready = 1'b1; // @ Stream.scala l375
    end
  end

  assign bus_if_axiAr_valid = axil_s_ar_rValid; // @ Stream.scala l377
  assign bus_if_axiAr_payload_addr = axil_s_ar_rData_addr; // @ Stream.scala l378
  assign bus_if_axiAr_payload_prot = axil_s_ar_rData_prot; // @ Stream.scala l378
  always @(*) begin
    axil_s_awready = bus_if_axiAw_ready; // @ Stream.scala l374
    if((! bus_if_axiAw_valid)) begin
      axil_s_awready = 1'b1; // @ Stream.scala l375
    end
  end

  assign bus_if_axiAw_valid = axil_s_aw_rValid; // @ Stream.scala l377
  assign bus_if_axiAw_payload_addr = axil_s_aw_rData_addr; // @ Stream.scala l378
  assign bus_if_axiAw_payload_prot = axil_s_aw_rData_prot; // @ Stream.scala l378
  always @(*) begin
    axil_s_wready = bus_if_axiW_ready; // @ Stream.scala l374
    if((! bus_if_axiW_valid)) begin
      axil_s_wready = 1'b1; // @ Stream.scala l375
    end
  end

  assign bus_if_axiW_valid = axil_s_w_rValid; // @ Stream.scala l377
  assign bus_if_axiW_payload_data = axil_s_w_rData_data; // @ Stream.scala l378
  assign bus_if_axiW_payload_strb = axil_s_w_rData_strb; // @ Stream.scala l378
  assign bus_if_wstrb = (bus_if_axiAr_valid ? 4'b1111 : bus_if_axiW_payload_strb); // @ AxiLite4BusInterface.scala l34
  always @(*) begin
    bus_if_wmask[7 : 0] = (bus_if_wstrb[0] ? 8'hff : 8'h0); // @ BusIfBase.scala l62
    bus_if_wmask[15 : 8] = (bus_if_wstrb[1] ? 8'hff : 8'h0); // @ BusIfBase.scala l62
    bus_if_wmask[23 : 16] = (bus_if_wstrb[2] ? 8'hff : 8'h0); // @ BusIfBase.scala l62
    bus_if_wmask[31 : 24] = (bus_if_wstrb[3] ? 8'hff : 8'h0); // @ BusIfBase.scala l62
  end

  always @(*) begin
    bus_if_wmaskn[7 : 0] = (bus_if_wstrb[0] ? 8'h0 : 8'hff); // @ BusIfBase.scala l63
    bus_if_wmaskn[15 : 8] = (bus_if_wstrb[1] ? 8'h0 : 8'hff); // @ BusIfBase.scala l63
    bus_if_wmaskn[23 : 16] = (bus_if_wstrb[2] ? 8'h0 : 8'hff); // @ BusIfBase.scala l63
    bus_if_wmaskn[31 : 24] = (bus_if_wstrb[3] ? 8'h0 : 8'hff); // @ BusIfBase.scala l63
  end

  always @(*) begin
    if(bus_if_bus_rderr) begin
      bus_if_axiR_payload_resp = 2'b10; // @ AxiLite4.scala l169
    end else begin
      bus_if_axiR_payload_resp = 2'b00; // @ AxiLite4.scala l167
    end
  end

  assign bus_if_axiR_valid = bus_if_axiRValid; // @ AxiLite4BusInterface.scala l43
  assign bus_if_axiR_payload_data = bus_if_bus_rdata; // @ AxiLite4BusInterface.scala l44
  assign bus_if_axiB_payload_resp = 2'b00; // @ AxiLite4.scala l138
  assign bus_if_axiB_valid = bus_if_axiBValid; // @ AxiLite4BusInterface.scala l48
  assign axil_s_rvalid = bus_if_axiR_valid; // @ Stream.scala l298
  assign bus_if_axiR_ready = axil_s_rready; // @ Stream.scala l299
  assign axil_s_rdata = bus_if_axiR_payload_data; // @ Stream.scala l300
  assign axil_s_rresp = bus_if_axiR_payload_resp; // @ Stream.scala l300
  assign axil_s_bvalid = bus_if_axiB_valid; // @ Stream.scala l298
  assign bus_if_axiB_ready = axil_s_bready; // @ Stream.scala l299
  assign axil_s_bresp = bus_if_axiB_payload_resp; // @ Stream.scala l300
  assign bus_if_askWrite = (bus_if_axiAw_valid && bus_if_axiW_valid); // @ BaseType.scala l305
  assign bus_if_askRead = (bus_if_axiAr_valid || (bus_if_axiR_valid && (! bus_if_axiR_ready))); // @ BaseType.scala l305
  assign bus_if_doWrite = (bus_if_askWrite && ((! bus_if_axiB_valid) || bus_if_axiB_ready)); // @ BaseType.scala l305
  assign bus_if_doRead = (bus_if_axiAr_valid && ((! bus_if_axiR_valid) || bus_if_axiR_ready)); // @ BaseType.scala l305
  assign bus_if_axiAr_ready = bus_if_doRead; // @ AxiLite4BusInterface.scala l62
  assign bus_if_axiAw_ready = bus_if_doWrite; // @ AxiLite4BusInterface.scala l65
  assign bus_if_axiW_ready = bus_if_doWrite; // @ AxiLite4BusInterface.scala l66
  assign read_hit_0x0000 = (({bus_if_axiAr_payload_addr[31 : 2],2'b00} == 32'h0) && bus_if_doRead); // @ BaseType.scala l305
  assign write_hit_0x0000 = ((bus_if_axiAw_payload_addr == 32'h0) && bus_if_doWrite); // @ BaseType.scala l305
  assign axi4_s_awready = 1'b1; // @ Bool.scala l90
  assign axi4_s_wready = 1'b1; // @ Bool.scala l90
  assign axi4_s_w_fire = (axi4_s_wvalid && axi4_s_wready); // @ BaseType.scala l305
  assign axi4_s_bvalid = tmp_axi4_s_bvalid; // @ AXIDemo.scala l39
  assign tmp_axi4_s_bid = 5'h0; // @ BitVector.scala l494
  always @(*) begin
    axi4_s_bid = tmp_axi4_s_bid[2 : 0]; // @ UInt.scala l381
    axi4_s_bid = axi4_s_awid_regNext; // @ AXIDemo.scala l42
  end

  assign axi4_s_bresp = tmp_axi4_s_bid[4 : 3]; // @ Bits.scala l133
  assign axi4_s_arready = 1'b1; // @ Bool.scala l90
  assign axi4_s_rvalid = 1'b0; // @ Bool.scala l92
  assign tmp_axi4_s_rdata = 38'h0; // @ BitVector.scala l494
  assign axi4_s_rdata = tmp_axi4_s_rdata[31 : 0]; // @ Bits.scala l133
  assign axi4_s_rid = tmp_axi4_s_rdata[34 : 32]; // @ UInt.scala l381
  assign axi4_s_rresp = tmp_axi4_s_rdata[36 : 35]; // @ Bits.scala l133
  assign axi4_s_rlast = tmp_axi4_s_rdata[37]; // @ Bool.scala l209
  assign axi4s_s_tready = 1'b1; // @ Bool.scala l90
  assign bus_if_bus_rderr = bus_if_reg_rderr; // @ BusIf.scala l298
  assign bus_if_bus_rdata = bus_if_reg_rdata; // @ BusIf.scala l299
  always @(posedge clk) begin
    if(reset) begin
      reg_field0 <= 16'h1234; // @ Data.scala l409
      reg_field1 <= 16'habcd; // @ Data.scala l409
      bus_if_reg_rderr <= 1'b0; // @ Data.scala l409
      bus_if_reg_rdata <= 32'h0; // @ Data.scala l409
      axil_s_ar_rValid <= 1'b0; // @ Data.scala l409
      bus_if_axiRValid <= 1'b0; // @ Data.scala l409
      axil_s_aw_rValid <= 1'b0; // @ Data.scala l409
      axil_s_w_rValid <= 1'b0; // @ Data.scala l409
      bus_if_axiBValid <= 1'b0; // @ Data.scala l409
      tmp_axi4_s_bvalid <= 1'b0; // @ Data.scala l409
    end else begin
      if(axil_s_arready) begin
        axil_s_ar_rValid <= axil_s_arvalid; // @ Stream.scala l365
      end
      if(axil_s_awready) begin
        axil_s_aw_rValid <= axil_s_awvalid; // @ Stream.scala l365
      end
      if(axil_s_wready) begin
        axil_s_w_rValid <= axil_s_wvalid; // @ Stream.scala l365
      end
      if(bus_if_axiR_ready) begin
        bus_if_axiRValid <= 1'b0; // @ AxiLite4BusInterface.scala l61
      end
      if(bus_if_doRead) begin
        bus_if_axiRValid <= 1'b1; // @ AxiLite4BusInterface.scala l61
      end
      if(bus_if_axiB_ready) begin
        bus_if_axiBValid <= 1'b0; // @ AxiLite4BusInterface.scala l64
      end
      if(bus_if_doWrite) begin
        bus_if_axiBValid <= 1'b1; // @ AxiLite4BusInterface.scala l64
      end
      if(write_hit_0x0000) begin
        reg_field0 <= ((reg_field0 & bus_if_wmaskn[15 : 0]) | (bus_if_axiW_payload_data[15 : 0] & bus_if_wmask[15 : 0])); // @ Bits.scala l133
      end
      if(write_hit_0x0000) begin
        reg_field1 <= ((reg_field1 & bus_if_wmaskn[31 : 16]) | (bus_if_axiW_payload_data[31 : 16] & bus_if_wmask[31 : 16])); // @ Bits.scala l133
      end
      tmp_axi4_s_bvalid <= (axi4_s_w_fire && axi4_s_wlast); // @ Reg.scala l39
      if(bus_if_askRead) begin
        case(tmp_1)
          32'h0 : begin
            bus_if_reg_rdata <= {reg_field1,reg_field0}; // @ RegInst.scala l393
            bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          default : begin
            bus_if_reg_rdata <= 32'h0; // @ BusIf.scala l266
            bus_if_reg_rderr <= 1'b0; // @ BusIf.scala l269
          end
        endcase
      end else begin
        bus_if_reg_rdata <= 32'h0; // @ BusIf.scala l283
        bus_if_reg_rderr <= 1'b0; // @ BusIf.scala l284
      end
    end
  end

  always @(posedge clk) begin
    if(axil_s_arready) begin
      axil_s_ar_rData_addr <= axil_s_araddr; // @ Stream.scala l366
      axil_s_ar_rData_prot <= axil_s_arprot; // @ Stream.scala l366
    end
    if(axil_s_awready) begin
      axil_s_aw_rData_addr <= axil_s_awaddr; // @ Stream.scala l366
      axil_s_aw_rData_prot <= axil_s_awprot; // @ Stream.scala l366
    end
    if(axil_s_wready) begin
      axil_s_w_rData_data <= axil_s_wdata; // @ Stream.scala l366
      axil_s_w_rData_strb <= axil_s_wstrb; // @ Stream.scala l366
    end
    axi4_s_awid_regNext <= axi4_s_awid; // @ Reg.scala l39
  end


endmodule
