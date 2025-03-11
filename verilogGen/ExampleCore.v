// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : ExampleCore
// Git hash  : 49efc9243c37053f9cb9628511cfed8eea9c0c37
// 



module ExampleCore (
  input  wire          axil_ctrl_awvalid,
  output wire          axil_ctrl_awready,
  input  wire [23:0]   axil_ctrl_awaddr,
  input  wire [2:0]    axil_ctrl_awprot,
  input  wire          axil_ctrl_wvalid,
  output wire          axil_ctrl_wready,
  input  wire [31:0]   axil_ctrl_wdata,
  input  wire [3:0]    axil_ctrl_wstrb,
  output wire          axil_ctrl_bvalid,
  input  wire          axil_ctrl_bready,
  output wire [1:0]    axil_ctrl_bresp,
  input  wire          axil_ctrl_arvalid,
  output wire          axil_ctrl_arready,
  input  wire [23:0]   axil_ctrl_araddr,
  input  wire [2:0]    axil_ctrl_arprot,
  output wire          axil_ctrl_rvalid,
  input  wire          axil_ctrl_rready,
  output wire [31:0]   axil_ctrl_rdata,
  output wire [1:0]    axil_ctrl_rresp,
  input  wire          clk,
  input  wire          reset
);

  wire                busCtrl_readErrorFlag;
  wire                busCtrl_writeErrorFlag;
  wire                busCtrl_readHaltRequest;
  wire                busCtrl_writeHaltRequest;
  wire                busCtrl_writeJoinEvent_valid;
  wire                busCtrl_writeJoinEvent_ready;
  wire                busCtrl_writeOccur;
  reg        [1:0]    busCtrl_writeRsp_resp;
  wire                busCtrl_writeJoinEvent_translated_valid;
  wire                busCtrl_writeJoinEvent_translated_ready;
  wire       [1:0]    busCtrl_writeJoinEvent_translated_payload_resp;
  wire                tmp_busCtrl_writeJoinEvent_translated_ready;
  wire                tmp_busCtrl_writeJoinEvent_translated_ready_1;
  wire                tmp_axil_ctrl_bvalid;
  reg                 tmp_axil_ctrl_bvalid_1;
  reg        [1:0]    tmp_axil_ctrl_bresp;
  wire                busCtrl_readDataStage_valid;
  wire                busCtrl_readDataStage_ready;
  wire       [23:0]   busCtrl_readDataStage_payload_addr;
  wire       [2:0]    busCtrl_readDataStage_payload_prot;
  reg                 io_axil_ctrl_ar_rValid;
  wire                busCtrl_readDataStage_fire;
  reg        [23:0]   io_axil_ctrl_ar_rData_addr;
  reg        [2:0]    io_axil_ctrl_ar_rData_prot;
  reg        [31:0]   busCtrl_readRsp_data;
  reg        [1:0]    busCtrl_readRsp_resp;
  wire                tmp_axil_ctrl_rvalid;
  wire       [23:0]   busCtrl_readAddressMasked;
  wire       [23:0]   busCtrl_writeAddressMasked;
  wire                busCtrl_readOccur;
  reg                 dma_en;
  wire                dma_write_busy;
  wire                dma_read_busy;
  reg                 dma_rd_cpl_irq_en;
  reg                 dma_wr_cpl_irq_en;

  assign busCtrl_readErrorFlag = 1'b0; // @ BusSlaveFactory.scala l105
  assign busCtrl_writeErrorFlag = 1'b0; // @ BusSlaveFactory.scala l106
  assign busCtrl_readHaltRequest = 1'b0; // @ AxiLite4SlaveFactory.scala l13
  assign busCtrl_writeHaltRequest = 1'b0; // @ AxiLite4SlaveFactory.scala l14
  assign busCtrl_writeOccur = (busCtrl_writeJoinEvent_valid && busCtrl_writeJoinEvent_ready); // @ BaseType.scala l305
  assign busCtrl_writeJoinEvent_valid = (axil_ctrl_awvalid && axil_ctrl_wvalid); // @ Stream.scala l1135
  assign axil_ctrl_awready = busCtrl_writeOccur; // @ Stream.scala l1136
  assign axil_ctrl_wready = busCtrl_writeOccur; // @ Stream.scala l1136
  assign busCtrl_writeJoinEvent_translated_valid = busCtrl_writeJoinEvent_valid; // @ Stream.scala l307
  assign busCtrl_writeJoinEvent_ready = busCtrl_writeJoinEvent_translated_ready; // @ Stream.scala l308
  assign busCtrl_writeJoinEvent_translated_payload_resp = busCtrl_writeRsp_resp; // @ Stream.scala l328
  assign tmp_busCtrl_writeJoinEvent_translated_ready = (! busCtrl_writeHaltRequest); // @ BaseType.scala l299
  assign busCtrl_writeJoinEvent_translated_ready = (tmp_busCtrl_writeJoinEvent_translated_ready_1 && tmp_busCtrl_writeJoinEvent_translated_ready); // @ Stream.scala l434
  assign tmp_busCtrl_writeJoinEvent_translated_ready_1 = (! tmp_axil_ctrl_bvalid_1); // @ Stream.scala l421
  assign tmp_axil_ctrl_bvalid = tmp_axil_ctrl_bvalid_1; // @ Stream.scala l423
  assign axil_ctrl_bvalid = tmp_axil_ctrl_bvalid; // @ Stream.scala l298
  assign axil_ctrl_bresp = tmp_axil_ctrl_bresp; // @ Stream.scala l300
  assign busCtrl_readDataStage_fire = (busCtrl_readDataStage_valid && busCtrl_readDataStage_ready); // @ BaseType.scala l305
  assign axil_ctrl_arready = (! io_axil_ctrl_ar_rValid); // @ Stream.scala l421
  assign busCtrl_readDataStage_valid = io_axil_ctrl_ar_rValid; // @ Stream.scala l423
  assign busCtrl_readDataStage_payload_addr = io_axil_ctrl_ar_rData_addr; // @ Stream.scala l424
  assign busCtrl_readDataStage_payload_prot = io_axil_ctrl_ar_rData_prot; // @ Stream.scala l424
  assign tmp_axil_ctrl_rvalid = (! busCtrl_readHaltRequest); // @ BaseType.scala l299
  assign busCtrl_readDataStage_ready = (axil_ctrl_rready && tmp_axil_ctrl_rvalid); // @ Stream.scala l434
  assign axil_ctrl_rvalid = (busCtrl_readDataStage_valid && tmp_axil_ctrl_rvalid); // @ Stream.scala l298
  assign axil_ctrl_rdata = busCtrl_readRsp_data; // @ Stream.scala l300
  assign axil_ctrl_rresp = busCtrl_readRsp_resp; // @ Stream.scala l300
  always @(*) begin
    if(busCtrl_writeErrorFlag) begin
      busCtrl_writeRsp_resp = 2'b10; // @ AxiLite4.scala l140
    end else begin
      busCtrl_writeRsp_resp = 2'b00; // @ AxiLite4.scala l138
    end
  end

  always @(*) begin
    if(busCtrl_readErrorFlag) begin
      busCtrl_readRsp_resp = 2'b10; // @ AxiLite4.scala l169
    end else begin
      busCtrl_readRsp_resp = 2'b00; // @ AxiLite4.scala l167
    end
  end

  always @(*) begin
    busCtrl_readRsp_data = 32'h0; // @ AxiLite4SlaveFactory.scala l36
    case(busCtrl_readAddressMasked)
      24'h0 : begin
        busCtrl_readRsp_data[0 : 0] = dma_en; // @ BusSlaveFactory.scala l1015
        busCtrl_readRsp_data[8 : 8] = dma_write_busy; // @ BusSlaveFactory.scala l1015
        busCtrl_readRsp_data[1 : 1] = dma_read_busy; // @ BusSlaveFactory.scala l1015
      end
      24'h000008 : begin
        busCtrl_readRsp_data[0 : 0] = dma_rd_cpl_irq_en; // @ BusSlaveFactory.scala l1015
        busCtrl_readRsp_data[1 : 1] = dma_wr_cpl_irq_en; // @ BusSlaveFactory.scala l1015
      end
      default : begin
      end
    endcase
  end

  assign busCtrl_readAddressMasked = (busCtrl_readDataStage_payload_addr & (~ 24'h000003)); // @ BaseType.scala l299
  assign busCtrl_writeAddressMasked = (axil_ctrl_awaddr & (~ 24'h000003)); // @ BaseType.scala l299
  assign busCtrl_readOccur = (axil_ctrl_rvalid && axil_ctrl_rready); // @ BaseType.scala l305
  assign dma_write_busy = 1'b0;
  assign dma_read_busy = 1'b0;
  always @(posedge clk) begin
    if(reset) begin
      tmp_axil_ctrl_bvalid_1 <= 1'b0; // @ Data.scala l409
      io_axil_ctrl_ar_rValid <= 1'b0; // @ Data.scala l409
      dma_en <= 1'b0; // @ Data.scala l409
      dma_rd_cpl_irq_en <= 1'b0; // @ Data.scala l409
      dma_wr_cpl_irq_en <= 1'b0; // @ Data.scala l409
    end else begin
      if((busCtrl_writeJoinEvent_translated_valid && tmp_busCtrl_writeJoinEvent_translated_ready)) begin
        tmp_axil_ctrl_bvalid_1 <= 1'b1; // @ Stream.scala l418
      end
      if((tmp_axil_ctrl_bvalid && axil_ctrl_bready)) begin
        tmp_axil_ctrl_bvalid_1 <= 1'b0; // @ Stream.scala l418
      end
      if(axil_ctrl_arvalid) begin
        io_axil_ctrl_ar_rValid <= 1'b1; // @ Stream.scala l418
      end
      if(busCtrl_readDataStage_fire) begin
        io_axil_ctrl_ar_rValid <= 1'b0; // @ Stream.scala l418
      end
      case(busCtrl_writeAddressMasked)
        24'h0 : begin
          if(busCtrl_writeOccur) begin
            dma_en <= axil_ctrl_wdata[0]; // @ Bool.scala l209
          end
        end
        24'h000008 : begin
          if(busCtrl_writeOccur) begin
            dma_rd_cpl_irq_en <= axil_ctrl_wdata[0]; // @ Bool.scala l209
            dma_wr_cpl_irq_en <= axil_ctrl_wdata[1]; // @ Bool.scala l209
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if(tmp_busCtrl_writeJoinEvent_translated_ready_1) begin
      tmp_axil_ctrl_bresp <= busCtrl_writeJoinEvent_translated_payload_resp; // @ Stream.scala l419
    end
    if(axil_ctrl_arready) begin
      io_axil_ctrl_ar_rData_addr <= axil_ctrl_araddr; // @ Stream.scala l419
      io_axil_ctrl_ar_rData_prot <= axil_ctrl_arprot; // @ Stream.scala l419
    end
  end


endmodule
