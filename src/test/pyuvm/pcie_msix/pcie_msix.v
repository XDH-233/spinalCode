// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : pcie_msix
// Git hash  : 49efc9243c37053f9cb9628511cfed8eea9c0c37
// 



module pcie_msix (
  input  wire          axil_msix_awvalid,
  output wire          axil_msix_awready,
  input  wire [15:0]   axil_msix_awaddr,
  input  wire [2:0]    axil_msix_awprot,
  input  wire          axil_msix_wvalid,
  output wire          axil_msix_wready,
  input  wire [31:0]   axil_msix_wdata,
  input  wire [3:0]    axil_msix_wstrb,
  output wire          axil_msix_bvalid,
  input  wire          axil_msix_bready,
  output wire [1:0]    axil_msix_bresp,
  input  wire          axil_msix_arvalid,
  output wire          axil_msix_arready,
  input  wire [15:0]   axil_msix_araddr,
  input  wire [2:0]    axil_msix_arprot,
  output wire          axil_msix_rvalid,
  input  wire          axil_msix_rready,
  output wire [31:0]   axil_msix_rdata,
  output wire [1:0]    axil_msix_rresp,
  input  wire          irq_valid,
  output wire          irq_ready,
  input  wire [4:0]    irq_payload,
  output wire          tx_wr_req_tlp_valid,
  input  wire          tx_wr_req_tlp_ready,
  output wire [31:0]   tx_wr_req_tlp_data,
  output wire [1:0]    tx_wr_req_tlp_strb,
  output wire [1:0]    tx_wr_req_tlp_hdr_ph,
  output reg  [61:0]   tx_wr_req_tlp_hdr_address,
  output reg  [3:0]    tx_wr_req_tlp_hdr_first_dw_be,
  output wire [3:0]    tx_wr_req_tlp_hdr_last_dw_be,
  output wire [7:0]    tx_wr_req_tlp_hdr_tag,
  output reg  [15:0]   tx_wr_req_tlp_hdr_requested_id,
  output reg  [9:0]    tx_wr_req_tlp_hdr_length,
  output wire [1:0]    tx_wr_req_tlp_hdr_at,
  output wire [1:0]    tx_wr_req_tlp_hdr_attr_l,
  output wire [0:0]    tx_wr_req_tlp_hdr_ep,
  output wire [0:0]    tx_wr_req_tlp_hdr_td,
  output wire [0:0]    tx_wr_req_tlp_hdr_th,
  output wire [0:0]    tx_wr_req_tlp_hdr_rsv2,
  output wire [0:0]    tx_wr_req_tlp_hdr_attr_h,
  output wire [0:0]    tx_wr_req_tlp_hdr_rsv1,
  output wire [2:0]    tx_wr_req_tlp_hdr_tc,
  output wire [0:0]    tx_wr_req_tlp_hdr_rsv0,
  output wire [4:0]    tx_wr_req_tlp_hdr_type_,
  output reg  [2:0]    tx_wr_req_tlp_hdr_fmt,
  output wire          tx_wr_req_tlp_sop,
  output wire          tx_wr_req_tlp_eop,
  input  wire          clk,
  input  wire          reset
);
  localparam _FM_3DW = 3'd0;
  localparam _FMT_4DW = 3'd1;
  localparam _FMT_3DW_DATA = 3'd2;
  localparam _FMT_4DW_DATA = 3'd3;
  localparam _FMT_PREFIX = 3'd4;

  reg        [127:0]  tmp_tmp_irq_msix_entry_irq_addr;
  wire                tmp_when;
  wire                bus_slave_readErrorFlag;
  wire                bus_slave_writeErrorFlag;
  wire                bus_slave_readHaltRequest;
  wire                bus_slave_writeHaltRequest;
  wire                bus_slave_writeJoinEvent_valid;
  wire                bus_slave_writeJoinEvent_ready;
  wire                bus_slave_writeOccur;
  reg        [1:0]    bus_slave_writeRsp_resp;
  wire                bus_slave_writeJoinEvent_translated_valid;
  wire                bus_slave_writeJoinEvent_translated_ready;
  wire       [1:0]    bus_slave_writeJoinEvent_translated_payload_resp;
  wire                tmp_bus_slave_writeJoinEvent_translated_ready;
  wire                tmp_bus_slave_writeJoinEvent_translated_ready_1;
  wire                tmp_axil_msix_bvalid;
  reg                 tmp_axil_msix_bvalid_1;
  reg        [1:0]    tmp_axil_msix_bresp;
  wire                bus_slave_readDataStage_valid;
  wire                bus_slave_readDataStage_ready;
  wire       [15:0]   bus_slave_readDataStage_payload_addr;
  wire       [2:0]    bus_slave_readDataStage_payload_prot;
  reg                 axil_msix_ar_rValid;
  wire                bus_slave_readDataStage_fire;
  reg        [15:0]   axil_msix_ar_rData_addr;
  reg        [2:0]    axil_msix_ar_rData_prot;
  reg        [31:0]   bus_slave_readRsp_data;
  reg        [1:0]    bus_slave_readRsp_resp;
  wire                tmp_axil_msix_rvalid;
  wire       [15:0]   bus_slave_readAddressMasked;
  wire       [15:0]   bus_slave_writeAddressMasked;
  wire                bus_slave_readOccur;
  reg        [127:0]  msix_entries_0;
  reg        [127:0]  msix_entries_1;
  reg        [127:0]  msix_entries_2;
  reg        [127:0]  msix_entries_3;
  reg        [127:0]  msix_entries_4;
  reg        [127:0]  msix_entries_5;
  reg        [127:0]  msix_entries_6;
  reg        [127:0]  msix_entries_7;
  reg        [127:0]  msix_entries_8;
  reg        [127:0]  msix_entries_9;
  reg        [127:0]  msix_entries_10;
  reg        [127:0]  msix_entries_11;
  reg        [127:0]  msix_entries_12;
  reg        [127:0]  msix_entries_13;
  reg        [127:0]  msix_entries_14;
  reg        [127:0]  msix_entries_15;
  reg        [127:0]  msix_entries_16;
  reg        [127:0]  msix_entries_17;
  reg        [127:0]  msix_entries_18;
  reg        [127:0]  msix_entries_19;
  reg        [127:0]  msix_entries_20;
  reg        [127:0]  msix_entries_21;
  reg        [127:0]  msix_entries_22;
  reg        [127:0]  msix_entries_23;
  reg        [127:0]  msix_entries_24;
  reg        [127:0]  msix_entries_25;
  reg        [127:0]  msix_entries_26;
  reg        [127:0]  msix_entries_27;
  reg        [127:0]  msix_entries_28;
  reg        [127:0]  msix_entries_29;
  reg        [127:0]  msix_entries_30;
  reg        [127:0]  msix_entries_31;
  wire       [63:0]   pba_entries_0;
  wire       [63:0]   irq_msix_entry_irq_addr;
  wire       [7:0]    irq_msix_entry_msg_data_vec;
  wire       [23:0]   irq_msix_entry_msg_data_rsv;
  wire                irq_msix_entry_masked;
  wire       [30:0]   irq_msix_entry_rsv;
  wire       [127:0]  tmp_bus_slave_readRsp_data;
  wire       [127:0]  tmp_bus_slave_readRsp_data_1;
  wire       [127:0]  tmp_bus_slave_readRsp_data_2;
  wire       [127:0]  tmp_bus_slave_readRsp_data_3;
  wire       [127:0]  tmp_bus_slave_readRsp_data_4;
  wire       [127:0]  tmp_bus_slave_readRsp_data_5;
  wire       [127:0]  tmp_bus_slave_readRsp_data_6;
  wire       [127:0]  tmp_bus_slave_readRsp_data_7;
  wire       [127:0]  tmp_bus_slave_readRsp_data_8;
  wire       [127:0]  tmp_bus_slave_readRsp_data_9;
  wire       [127:0]  tmp_bus_slave_readRsp_data_10;
  wire       [127:0]  tmp_bus_slave_readRsp_data_11;
  wire       [127:0]  tmp_bus_slave_readRsp_data_12;
  wire       [127:0]  tmp_bus_slave_readRsp_data_13;
  wire       [127:0]  tmp_bus_slave_readRsp_data_14;
  wire       [127:0]  tmp_bus_slave_readRsp_data_15;
  wire       [127:0]  tmp_bus_slave_readRsp_data_16;
  wire       [127:0]  tmp_bus_slave_readRsp_data_17;
  wire       [127:0]  tmp_bus_slave_readRsp_data_18;
  wire       [127:0]  tmp_bus_slave_readRsp_data_19;
  wire       [127:0]  tmp_bus_slave_readRsp_data_20;
  wire       [127:0]  tmp_bus_slave_readRsp_data_21;
  wire       [127:0]  tmp_bus_slave_readRsp_data_22;
  wire       [127:0]  tmp_bus_slave_readRsp_data_23;
  wire       [127:0]  tmp_bus_slave_readRsp_data_24;
  wire       [127:0]  tmp_bus_slave_readRsp_data_25;
  wire       [127:0]  tmp_bus_slave_readRsp_data_26;
  wire       [127:0]  tmp_bus_slave_readRsp_data_27;
  wire       [127:0]  tmp_bus_slave_readRsp_data_28;
  wire       [127:0]  tmp_bus_slave_readRsp_data_29;
  wire       [127:0]  tmp_bus_slave_readRsp_data_30;
  wire       [127:0]  tmp_bus_slave_readRsp_data_31;
  wire       [63:0]   tmp_bus_slave_readRsp_data_32;
  wire       [127:0]  tmp_irq_msix_entry_irq_addr;
  wire       [31:0]   tmp_irq_msix_entry_msg_data_vec;
  wire       [127:0]  tmp_tx_wr_req_tlp_hdr_ph;
  wire       [2:0]    tmp_tx_wr_req_tlp_hdr_fmt;
  `ifndef SYNTHESIS
  reg [95:0] tx_wr_req_tlp_hdr_fmt_string;
  reg [95:0] tmp_tx_wr_req_tlp_hdr_fmt_string;
  `endif


  assign tmp_when = (|irq_msix_entry_irq_addr[63 : 32]);
  always @(*) begin
    case(irq_payload)
      5'b00000 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_0;
      5'b00001 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_1;
      5'b00010 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_2;
      5'b00011 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_3;
      5'b00100 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_4;
      5'b00101 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_5;
      5'b00110 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_6;
      5'b00111 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_7;
      5'b01000 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_8;
      5'b01001 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_9;
      5'b01010 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_10;
      5'b01011 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_11;
      5'b01100 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_12;
      5'b01101 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_13;
      5'b01110 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_14;
      5'b01111 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_15;
      5'b10000 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_16;
      5'b10001 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_17;
      5'b10010 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_18;
      5'b10011 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_19;
      5'b10100 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_20;
      5'b10101 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_21;
      5'b10110 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_22;
      5'b10111 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_23;
      5'b11000 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_24;
      5'b11001 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_25;
      5'b11010 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_26;
      5'b11011 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_27;
      5'b11100 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_28;
      5'b11101 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_29;
      5'b11110 : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_30;
      default : tmp_tmp_irq_msix_entry_irq_addr = msix_entries_31;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(tx_wr_req_tlp_hdr_fmt)
      _FM_3DW : tx_wr_req_tlp_hdr_fmt_string = "FM_3DW      ";
      _FMT_4DW : tx_wr_req_tlp_hdr_fmt_string = "FMT_4DW     ";
      _FMT_3DW_DATA : tx_wr_req_tlp_hdr_fmt_string = "FMT_3DW_DATA";
      _FMT_4DW_DATA : tx_wr_req_tlp_hdr_fmt_string = "FMT_4DW_DATA";
      _FMT_PREFIX : tx_wr_req_tlp_hdr_fmt_string = "FMT_PREFIX  ";
      default : tx_wr_req_tlp_hdr_fmt_string = "????????????";
    endcase
  end
  always @(*) begin
    case(tmp_tx_wr_req_tlp_hdr_fmt)
      _FM_3DW : tmp_tx_wr_req_tlp_hdr_fmt_string = "FM_3DW      ";
      _FMT_4DW : tmp_tx_wr_req_tlp_hdr_fmt_string = "FMT_4DW     ";
      _FMT_3DW_DATA : tmp_tx_wr_req_tlp_hdr_fmt_string = "FMT_3DW_DATA";
      _FMT_4DW_DATA : tmp_tx_wr_req_tlp_hdr_fmt_string = "FMT_4DW_DATA";
      _FMT_PREFIX : tmp_tx_wr_req_tlp_hdr_fmt_string = "FMT_PREFIX  ";
      default : tmp_tx_wr_req_tlp_hdr_fmt_string = "????????????";
    endcase
  end
  `endif

  assign bus_slave_readErrorFlag = 1'b0; // @ BusSlaveFactory.scala l105
  assign bus_slave_writeErrorFlag = 1'b0; // @ BusSlaveFactory.scala l106
  assign bus_slave_readHaltRequest = 1'b0; // @ AxiLite4SlaveFactory.scala l13
  assign bus_slave_writeHaltRequest = 1'b0; // @ AxiLite4SlaveFactory.scala l14
  assign bus_slave_writeOccur = (bus_slave_writeJoinEvent_valid && bus_slave_writeJoinEvent_ready); // @ BaseType.scala l305
  assign bus_slave_writeJoinEvent_valid = (axil_msix_awvalid && axil_msix_wvalid); // @ Stream.scala l1135
  assign axil_msix_awready = bus_slave_writeOccur; // @ Stream.scala l1136
  assign axil_msix_wready = bus_slave_writeOccur; // @ Stream.scala l1136
  assign bus_slave_writeJoinEvent_translated_valid = bus_slave_writeJoinEvent_valid; // @ Stream.scala l307
  assign bus_slave_writeJoinEvent_ready = bus_slave_writeJoinEvent_translated_ready; // @ Stream.scala l308
  assign bus_slave_writeJoinEvent_translated_payload_resp = bus_slave_writeRsp_resp; // @ Stream.scala l328
  assign tmp_bus_slave_writeJoinEvent_translated_ready = (! bus_slave_writeHaltRequest); // @ BaseType.scala l299
  assign bus_slave_writeJoinEvent_translated_ready = (tmp_bus_slave_writeJoinEvent_translated_ready_1 && tmp_bus_slave_writeJoinEvent_translated_ready); // @ Stream.scala l434
  assign tmp_bus_slave_writeJoinEvent_translated_ready_1 = (! tmp_axil_msix_bvalid_1); // @ Stream.scala l421
  assign tmp_axil_msix_bvalid = tmp_axil_msix_bvalid_1; // @ Stream.scala l423
  assign axil_msix_bvalid = tmp_axil_msix_bvalid; // @ Stream.scala l298
  assign axil_msix_bresp = tmp_axil_msix_bresp; // @ Stream.scala l300
  assign bus_slave_readDataStage_fire = (bus_slave_readDataStage_valid && bus_slave_readDataStage_ready); // @ BaseType.scala l305
  assign axil_msix_arready = (! axil_msix_ar_rValid); // @ Stream.scala l421
  assign bus_slave_readDataStage_valid = axil_msix_ar_rValid; // @ Stream.scala l423
  assign bus_slave_readDataStage_payload_addr = axil_msix_ar_rData_addr; // @ Stream.scala l424
  assign bus_slave_readDataStage_payload_prot = axil_msix_ar_rData_prot; // @ Stream.scala l424
  assign tmp_axil_msix_rvalid = (! bus_slave_readHaltRequest); // @ BaseType.scala l299
  assign bus_slave_readDataStage_ready = (axil_msix_rready && tmp_axil_msix_rvalid); // @ Stream.scala l434
  assign axil_msix_rvalid = (bus_slave_readDataStage_valid && tmp_axil_msix_rvalid); // @ Stream.scala l298
  assign axil_msix_rdata = bus_slave_readRsp_data; // @ Stream.scala l300
  assign axil_msix_rresp = bus_slave_readRsp_resp; // @ Stream.scala l300
  always @(*) begin
    if(bus_slave_writeErrorFlag) begin
      bus_slave_writeRsp_resp = 2'b10; // @ AxiLite4.scala l140
    end else begin
      bus_slave_writeRsp_resp = 2'b00; // @ AxiLite4.scala l138
    end
  end

  always @(*) begin
    if(bus_slave_readErrorFlag) begin
      bus_slave_readRsp_resp = 2'b10; // @ AxiLite4.scala l169
    end else begin
      bus_slave_readRsp_resp = 2'b00; // @ AxiLite4.scala l167
    end
  end

  always @(*) begin
    bus_slave_readRsp_data = 32'h0; // @ AxiLite4SlaveFactory.scala l36
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0004)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0008)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h000c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0010)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_1[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0014)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_1[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0018)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_1[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h001c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_1[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0020)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_2[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0024)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_2[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0028)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_2[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h002c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_2[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0030)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_3[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0034)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_3[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0038)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_3[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h003c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_3[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0040)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_4[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0044)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_4[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0048)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_4[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h004c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_4[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0050)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_5[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0054)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_5[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0058)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_5[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h005c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_5[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0060)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_6[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0064)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_6[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0068)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_6[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h006c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_6[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0070)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_7[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0074)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_7[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0078)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_7[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h007c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_7[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0080)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_8[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0084)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_8[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0088)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_8[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h008c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_8[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0090)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_9[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0094)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_9[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0098)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_9[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h009c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_9[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00a0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_10[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00a4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_10[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00a8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_10[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00ac)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_10[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00b0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_11[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00b4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_11[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00b8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_11[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00bc)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_11[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00c0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_12[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00c4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_12[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00c8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_12[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00cc)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_12[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00d0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_13[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00d4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_13[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00d8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_13[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00dc)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_13[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00e0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_14[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00e4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_14[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00e8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_14[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00ec)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_14[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00f0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_15[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00f4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_15[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00f8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_15[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h00fc)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_15[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0100)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_16[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0104)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_16[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0108)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_16[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h010c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_16[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0110)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_17[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0114)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_17[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0118)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_17[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h011c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_17[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0120)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_18[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0124)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_18[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0128)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_18[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h012c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_18[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0130)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_19[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0134)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_19[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0138)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_19[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h013c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_19[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0140)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_20[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0144)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_20[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0148)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_20[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h014c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_20[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0150)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_21[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0154)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_21[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0158)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_21[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h015c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_21[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0160)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_22[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0164)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_22[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0168)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_22[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h016c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_22[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0170)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_23[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0174)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_23[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0178)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_23[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h017c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_23[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0180)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_24[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0184)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_24[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0188)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_24[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h018c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_24[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0190)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_25[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0194)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_25[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0198)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_25[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h019c)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_25[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01a0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_26[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01a4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_26[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01a8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_26[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01ac)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_26[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01b0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_27[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01b4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_27[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01b8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_27[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01bc)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_27[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01c0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_28[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01c4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_28[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01c8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_28[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01cc)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_28[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01d0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_29[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01d4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_29[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01d8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_29[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01dc)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_29[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01e0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_30[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01e4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_30[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01e8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_30[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01ec)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_30[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01f0)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_31[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01f4)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_31[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01f8)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_31[95 : 64]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h01fc)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_31[127 : 96]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0800)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_32[31 : 0]; // @ BusSlaveFactory.scala l1015
    end
    if(((bus_slave_readAddressMasked & (~ 16'h0003)) == 16'h0804)) begin
      bus_slave_readRsp_data[31 : 0] = tmp_bus_slave_readRsp_data_32[63 : 32]; // @ BusSlaveFactory.scala l1015
    end
  end

  assign bus_slave_readAddressMasked = (bus_slave_readDataStage_payload_addr & (~ 16'h0003)); // @ BaseType.scala l299
  assign bus_slave_writeAddressMasked = (axil_msix_awaddr & (~ 16'h0003)); // @ BaseType.scala l299
  assign bus_slave_readOccur = (axil_msix_rvalid && axil_msix_rready); // @ BaseType.scala l305
  assign pba_entries_0 = 64'h0;
  assign tmp_bus_slave_readRsp_data = msix_entries_0; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_1 = msix_entries_1; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_2 = msix_entries_2; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_3 = msix_entries_3; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_4 = msix_entries_4; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_5 = msix_entries_5; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_6 = msix_entries_6; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_7 = msix_entries_7; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_8 = msix_entries_8; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_9 = msix_entries_9; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_10 = msix_entries_10; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_11 = msix_entries_11; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_12 = msix_entries_12; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_13 = msix_entries_13; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_14 = msix_entries_14; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_15 = msix_entries_15; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_16 = msix_entries_16; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_17 = msix_entries_17; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_18 = msix_entries_18; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_19 = msix_entries_19; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_20 = msix_entries_20; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_21 = msix_entries_21; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_22 = msix_entries_22; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_23 = msix_entries_23; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_24 = msix_entries_24; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_25 = msix_entries_25; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_26 = msix_entries_26; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_27 = msix_entries_27; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_28 = msix_entries_28; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_29 = msix_entries_29; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_30 = msix_entries_30; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_31 = msix_entries_31; // @ Bits.scala l152
  assign tmp_bus_slave_readRsp_data_32 = pba_entries_0; // @ Bits.scala l152
  assign tmp_irq_msix_entry_irq_addr = tmp_tmp_irq_msix_entry_irq_addr; // @ Vec.scala l202
  assign irq_msix_entry_irq_addr = tmp_irq_msix_entry_irq_addr[63 : 0]; // @ UInt.scala l381
  assign tmp_irq_msix_entry_msg_data_vec = tmp_irq_msix_entry_irq_addr[95 : 64]; // @ BaseType.scala l299
  assign irq_msix_entry_msg_data_vec = tmp_irq_msix_entry_msg_data_vec[7 : 0]; // @ UInt.scala l381
  assign irq_msix_entry_msg_data_rsv = tmp_irq_msix_entry_msg_data_vec[31 : 8]; // @ Bits.scala l133
  assign irq_msix_entry_masked = tmp_irq_msix_entry_irq_addr[96]; // @ Bool.scala l209
  assign irq_msix_entry_rsv = tmp_irq_msix_entry_irq_addr[127 : 97]; // @ Bits.scala l133
  assign tx_wr_req_tlp_data = {irq_msix_entry_msg_data_rsv,irq_msix_entry_msg_data_vec}; // @ PCIeMSIX.scala l51
  assign tx_wr_req_tlp_strb = 2'b01; // @ PCIeMSIX.scala l52
  assign tx_wr_req_tlp_sop = 1'b1; // @ Bool.scala l90
  assign tx_wr_req_tlp_eop = 1'b1; // @ Bool.scala l90
  assign tmp_tx_wr_req_tlp_hdr_ph = 128'h0; // @ BitVector.scala l494
  assign tx_wr_req_tlp_hdr_ph = tmp_tx_wr_req_tlp_hdr_ph[1 : 0]; // @ Bits.scala l133
  always @(*) begin
    tx_wr_req_tlp_hdr_address = tmp_tx_wr_req_tlp_hdr_ph[63 : 2]; // @ Bits.scala l133
    if(tmp_when) begin
      tx_wr_req_tlp_hdr_address = irq_msix_entry_irq_addr[63 : 2]; // @ PCIeMSIX.scala l62
    end else begin
      tx_wr_req_tlp_hdr_address = {irq_msix_entry_irq_addr[31 : 2],32'h0}; // @ PCIeMSIX.scala l65
    end
  end

  always @(*) begin
    tx_wr_req_tlp_hdr_first_dw_be = tmp_tx_wr_req_tlp_hdr_ph[67 : 64]; // @ Bits.scala l133
    tx_wr_req_tlp_hdr_first_dw_be = 4'b1111; // @ PCIeMSIX.scala l59
  end

  assign tx_wr_req_tlp_hdr_last_dw_be = tmp_tx_wr_req_tlp_hdr_ph[71 : 68]; // @ Bits.scala l133
  assign tx_wr_req_tlp_hdr_tag = tmp_tx_wr_req_tlp_hdr_ph[79 : 72]; // @ Bits.scala l133
  always @(*) begin
    tx_wr_req_tlp_hdr_requested_id = tmp_tx_wr_req_tlp_hdr_ph[95 : 80]; // @ UInt.scala l381
    tx_wr_req_tlp_hdr_requested_id = 16'h0; // @ PCIeMSIX.scala l58
  end

  always @(*) begin
    tx_wr_req_tlp_hdr_length = tmp_tx_wr_req_tlp_hdr_ph[105 : 96]; // @ UInt.scala l381
    tx_wr_req_tlp_hdr_length = 10'h001; // @ PCIeMSIX.scala l57
  end

  assign tx_wr_req_tlp_hdr_at = tmp_tx_wr_req_tlp_hdr_ph[107 : 106]; // @ Bits.scala l133
  assign tx_wr_req_tlp_hdr_attr_l = tmp_tx_wr_req_tlp_hdr_ph[109 : 108]; // @ Bits.scala l133
  assign tx_wr_req_tlp_hdr_ep = tmp_tx_wr_req_tlp_hdr_ph[110 : 110]; // @ Bits.scala l133
  assign tx_wr_req_tlp_hdr_td = tmp_tx_wr_req_tlp_hdr_ph[111 : 111]; // @ Bits.scala l133
  assign tx_wr_req_tlp_hdr_th = tmp_tx_wr_req_tlp_hdr_ph[112 : 112]; // @ Bits.scala l133
  assign tx_wr_req_tlp_hdr_rsv2 = tmp_tx_wr_req_tlp_hdr_ph[113 : 113]; // @ Bits.scala l133
  assign tx_wr_req_tlp_hdr_attr_h = tmp_tx_wr_req_tlp_hdr_ph[114 : 114]; // @ Bits.scala l133
  assign tx_wr_req_tlp_hdr_rsv1 = tmp_tx_wr_req_tlp_hdr_ph[115 : 115]; // @ Bits.scala l133
  assign tx_wr_req_tlp_hdr_tc = tmp_tx_wr_req_tlp_hdr_ph[118 : 116]; // @ Bits.scala l133
  assign tx_wr_req_tlp_hdr_rsv0 = tmp_tx_wr_req_tlp_hdr_ph[119 : 119]; // @ Bits.scala l133
  assign tx_wr_req_tlp_hdr_type_ = tmp_tx_wr_req_tlp_hdr_ph[124 : 120]; // @ Bits.scala l133
  assign tmp_tx_wr_req_tlp_hdr_fmt = tmp_tx_wr_req_tlp_hdr_ph[127 : 125]; // @ Enum.scala l189
  always @(*) begin
    tx_wr_req_tlp_hdr_fmt = tmp_tx_wr_req_tlp_hdr_fmt; // @ Enum.scala l191
    if(tmp_when) begin
      tx_wr_req_tlp_hdr_fmt = _FMT_4DW_DATA; // @ Enum.scala l151
    end else begin
      tx_wr_req_tlp_hdr_fmt = _FMT_3DW_DATA; // @ Enum.scala l151
    end
  end

  assign irq_ready = 1'b1; // @ Bool.scala l90
  assign tx_wr_req_tlp_valid = 1'b0; // @ Bool.scala l92
  always @(posedge clk) begin
    if(reset) begin
      tmp_axil_msix_bvalid_1 <= 1'b0; // @ Data.scala l409
      axil_msix_ar_rValid <= 1'b0; // @ Data.scala l409
      msix_entries_0 <= 128'h0; // @ Data.scala l409
      msix_entries_1 <= 128'h0; // @ Data.scala l409
      msix_entries_2 <= 128'h0; // @ Data.scala l409
      msix_entries_3 <= 128'h0; // @ Data.scala l409
      msix_entries_4 <= 128'h0; // @ Data.scala l409
      msix_entries_5 <= 128'h0; // @ Data.scala l409
      msix_entries_6 <= 128'h0; // @ Data.scala l409
      msix_entries_7 <= 128'h0; // @ Data.scala l409
      msix_entries_8 <= 128'h0; // @ Data.scala l409
      msix_entries_9 <= 128'h0; // @ Data.scala l409
      msix_entries_10 <= 128'h0; // @ Data.scala l409
      msix_entries_11 <= 128'h0; // @ Data.scala l409
      msix_entries_12 <= 128'h0; // @ Data.scala l409
      msix_entries_13 <= 128'h0; // @ Data.scala l409
      msix_entries_14 <= 128'h0; // @ Data.scala l409
      msix_entries_15 <= 128'h0; // @ Data.scala l409
      msix_entries_16 <= 128'h0; // @ Data.scala l409
      msix_entries_17 <= 128'h0; // @ Data.scala l409
      msix_entries_18 <= 128'h0; // @ Data.scala l409
      msix_entries_19 <= 128'h0; // @ Data.scala l409
      msix_entries_20 <= 128'h0; // @ Data.scala l409
      msix_entries_21 <= 128'h0; // @ Data.scala l409
      msix_entries_22 <= 128'h0; // @ Data.scala l409
      msix_entries_23 <= 128'h0; // @ Data.scala l409
      msix_entries_24 <= 128'h0; // @ Data.scala l409
      msix_entries_25 <= 128'h0; // @ Data.scala l409
      msix_entries_26 <= 128'h0; // @ Data.scala l409
      msix_entries_27 <= 128'h0; // @ Data.scala l409
      msix_entries_28 <= 128'h0; // @ Data.scala l409
      msix_entries_29 <= 128'h0; // @ Data.scala l409
      msix_entries_30 <= 128'h0; // @ Data.scala l409
      msix_entries_31 <= 128'h0; // @ Data.scala l409
    end else begin
      if((bus_slave_writeJoinEvent_translated_valid && tmp_bus_slave_writeJoinEvent_translated_ready)) begin
        tmp_axil_msix_bvalid_1 <= 1'b1; // @ Stream.scala l418
      end
      if((tmp_axil_msix_bvalid && axil_msix_bready)) begin
        tmp_axil_msix_bvalid_1 <= 1'b0; // @ Stream.scala l418
      end
      if(axil_msix_arvalid) begin
        axil_msix_ar_rValid <= 1'b1; // @ Stream.scala l418
      end
      if(bus_slave_readDataStage_fire) begin
        axil_msix_ar_rValid <= 1'b0; // @ Stream.scala l418
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_0[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0004)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_0[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0008)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_0[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h000c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_0[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0010)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_1[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0014)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_1[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0018)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_1[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h001c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_1[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0020)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_2[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0024)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_2[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0028)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_2[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h002c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_2[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0030)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_3[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0034)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_3[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0038)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_3[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h003c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_3[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0040)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_4[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0044)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_4[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0048)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_4[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h004c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_4[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0050)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_5[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0054)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_5[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0058)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_5[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h005c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_5[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0060)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_6[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0064)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_6[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0068)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_6[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h006c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_6[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0070)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_7[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0074)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_7[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0078)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_7[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h007c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_7[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0080)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_8[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0084)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_8[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0088)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_8[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h008c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_8[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0090)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_9[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0094)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_9[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0098)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_9[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h009c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_9[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00a0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_10[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00a4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_10[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00a8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_10[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00ac)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_10[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00b0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_11[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00b4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_11[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00b8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_11[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00bc)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_11[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00c0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_12[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00c4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_12[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00c8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_12[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00cc)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_12[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00d0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_13[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00d4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_13[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00d8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_13[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00dc)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_13[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00e0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_14[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00e4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_14[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00e8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_14[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00ec)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_14[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00f0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_15[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00f4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_15[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00f8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_15[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h00fc)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_15[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0100)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_16[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0104)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_16[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0108)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_16[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h010c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_16[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0110)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_17[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0114)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_17[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0118)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_17[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h011c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_17[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0120)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_18[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0124)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_18[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0128)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_18[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h012c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_18[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0130)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_19[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0134)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_19[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0138)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_19[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h013c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_19[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0140)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_20[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0144)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_20[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0148)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_20[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h014c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_20[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0150)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_21[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0154)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_21[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0158)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_21[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h015c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_21[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0160)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_22[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0164)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_22[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0168)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_22[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h016c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_22[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0170)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_23[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0174)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_23[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0178)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_23[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h017c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_23[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0180)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_24[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0184)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_24[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0188)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_24[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h018c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_24[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0190)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_25[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0194)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_25[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h0198)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_25[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h019c)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_25[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01a0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_26[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01a4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_26[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01a8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_26[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01ac)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_26[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01b0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_27[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01b4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_27[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01b8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_27[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01bc)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_27[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01c0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_28[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01c4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_28[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01c8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_28[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01cc)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_28[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01d0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_29[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01d4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_29[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01d8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_29[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01dc)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_29[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01e0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_30[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01e4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_30[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01e8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_30[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01ec)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_30[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01f0)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_31[31 : 0] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01f4)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_31[63 : 32] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01f8)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_31[95 : 64] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
      if(((bus_slave_writeAddressMasked & (~ 16'h0003)) == 16'h01fc)) begin
        if(bus_slave_writeOccur) begin
          msix_entries_31[127 : 96] <= axil_msix_wdata[31 : 0]; // @ Bits.scala l133
        end
      end
    end
  end

  always @(posedge clk) begin
    if(tmp_bus_slave_writeJoinEvent_translated_ready_1) begin
      tmp_axil_msix_bresp <= bus_slave_writeJoinEvent_translated_payload_resp; // @ Stream.scala l419
    end
    if(axil_msix_arready) begin
      axil_msix_ar_rData_addr <= axil_msix_araddr; // @ Stream.scala l419
      axil_msix_ar_rData_prot <= axil_msix_arprot; // @ Stream.scala l419
    end
  end


endmodule
