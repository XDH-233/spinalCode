// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : rdma_dfx_regs
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766


module rdma_dfx_regs (
  input  wire          dfx_avmm_read,
  input  wire          dfx_avmm_write,
  output wire          dfx_avmm_waitRequestn,
  input  wire [31:0]   dfx_avmm_address,
  input  wire [31:0]   dfx_avmm_writeData,
  output wire          dfx_avmm_readDataValid,
  output wire [31:0]   dfx_avmm_readData,
  input  wire [31:0]   cmdq_fsm_state_db_proc_i,
  input  wire [31:0]   cmdq_fsm_state_avst_width_i,
  input  wire [31:0]   cmdq_fsm_state_dma_rreq_proc_i,
  input  wire [31:0]   cmdq_cmd_id_bitmap_i,
  input  wire [31:0]   cmdq_fsm_state_cmd_parser_i,
  input  wire [31:0]   cmdq_fsm_state_cmd_rsp_proc_i,
  input  wire          clk,
  input  wire          reset
);

  wire                avmm_bus_if_bus_rderr;
  wire       [31:0]   avmm_bus_if_bus_rdata;
  reg                 avmm_bus_if_reg_rderr;
  reg        [31:0]   avmm_bus_if_reg_rdata;
  wire       [0:0]    avmm_bus_if_wmask;
  wire       [0:0]    avmm_bus_if_wmaskn;
  reg                 dfx_avmm_read_regNext;
  wire                read_hit_0x80000;
  wire                write_hit_0x80000;
  wire                read_hit_0x80004;
  wire                write_hit_0x80004;
  wire                read_hit_0x80008;
  wire                write_hit_0x80008;
  wire                read_hit_0x8000c;
  wire                write_hit_0x8000c;
  wire                read_hit_0x80010;
  wire                write_hit_0x80010;
  wire                read_hit_0x80014;
  wire                write_hit_0x80014;
  wire                read_hit_0x800c4;
  wire                write_hit_0x800c4;
  wire                read_hit_0x81ffc;
  wire                write_hit_0x81ffc;
  wire                read_hit_0x82ffc;
  wire                write_hit_0x82ffc;
  wire                read_hit_0x83ffc;
  wire                write_hit_0x83ffc;
  wire                read_hit_0x84ffc;
  wire                write_hit_0x84ffc;
  wire                read_hit_0x85ffc;
  wire                write_hit_0x85ffc;
  wire                read_hit_0x86ffc;
  wire                write_hit_0x86ffc;
  wire                read_hit_0x87ffc;
  wire                write_hit_0x87ffc;
  wire                read_hit_0x88ffc;
  wire                write_hit_0x88ffc;
  wire                read_hit_0x89ffc;
  wire                write_hit_0x89ffc;
  wire                read_hit_0x8affc;
  wire                write_hit_0x8affc;
  wire                read_hit_0x8bffc;
  wire                write_hit_0x8bffc;
  wire                read_hit_0x8cffc;
  wire                write_hit_0x8cffc;
  reg        [31:0]   cmdq_fsm_state_db_proc;
  reg        [31:0]   rx_wqe_rw_test_reg;
  reg        [31:0]   cmdq_fsm_state_avst_width;
  reg        [31:0]   tx_pkt_gen_rw_test_reg;
  reg        [31:0]   db_scheduler_rw_test_reg;
  reg        [31:0]   tx_dma_ctrl_rw_test_reg;
  reg        [31:0]   cmdq_fsm_state_dma_rreq_proc;
  reg        [31:0]   eq_rw_test_reg;
  reg        [31:0]   timer_rw_test_reg;
  reg        [31:0]   cmdq_cmd_id_bitmap;
  reg        [31:0]   cmdq_fsm_state_cmd_parser;
  reg        [31:0]   mr_rw_test_reg;
  reg        [31:0]   tx_wqe_rw_test_reg;
  reg        [31:0]   cmdq_rw_reg;
  reg        [31:0]   rx_pkt_parser_rw_test_reg;
  reg        [31:0]   cq_rw_test_reg;
  reg        [31:0]   qp_manager_rw_test_reg;
  reg        [31:0]   rx_pkt_processor_rw_test_reg;
  reg        [31:0]   cmdq_fsm_state_cmd_rsp_proc;

  assign avmm_bus_if_wmask = 1'b1; // @ Expression.scala l2327
  assign avmm_bus_if_wmaskn = 1'b1; // @ Expression.scala l2327
  assign dfx_avmm_readDataValid = dfx_avmm_read_regNext; // @ AvalonMMBusInterface.scala l32
  assign dfx_avmm_readData = avmm_bus_if_reg_rdata; // @ AvalonMMBusInterface.scala l33
  assign dfx_avmm_waitRequestn = (! (dfx_avmm_read || dfx_avmm_write)); // @ AvalonMMBusInterface.scala l34
  assign read_hit_0x80000 = ((dfx_avmm_address == 32'h00080000) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x80000 = ((dfx_avmm_address == 32'h00080000) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x80004 = ((dfx_avmm_address == 32'h00080004) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x80004 = ((dfx_avmm_address == 32'h00080004) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x80008 = ((dfx_avmm_address == 32'h00080008) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x80008 = ((dfx_avmm_address == 32'h00080008) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x8000c = ((dfx_avmm_address == 32'h0008000c) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x8000c = ((dfx_avmm_address == 32'h0008000c) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x80010 = ((dfx_avmm_address == 32'h00080010) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x80010 = ((dfx_avmm_address == 32'h00080010) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x80014 = ((dfx_avmm_address == 32'h00080014) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x80014 = ((dfx_avmm_address == 32'h00080014) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x800c4 = ((dfx_avmm_address == 32'h000800c4) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x800c4 = ((dfx_avmm_address == 32'h000800c4) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x81ffc = ((dfx_avmm_address == 32'h00081ffc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x81ffc = ((dfx_avmm_address == 32'h00081ffc) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x82ffc = ((dfx_avmm_address == 32'h00082ffc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x82ffc = ((dfx_avmm_address == 32'h00082ffc) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x83ffc = ((dfx_avmm_address == 32'h00083ffc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x83ffc = ((dfx_avmm_address == 32'h00083ffc) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x84ffc = ((dfx_avmm_address == 32'h00084ffc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x84ffc = ((dfx_avmm_address == 32'h00084ffc) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x85ffc = ((dfx_avmm_address == 32'h00085ffc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x85ffc = ((dfx_avmm_address == 32'h00085ffc) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x86ffc = ((dfx_avmm_address == 32'h00086ffc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x86ffc = ((dfx_avmm_address == 32'h00086ffc) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x87ffc = ((dfx_avmm_address == 32'h00087ffc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x87ffc = ((dfx_avmm_address == 32'h00087ffc) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x88ffc = ((dfx_avmm_address == 32'h00088ffc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x88ffc = ((dfx_avmm_address == 32'h00088ffc) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x89ffc = ((dfx_avmm_address == 32'h00089ffc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x89ffc = ((dfx_avmm_address == 32'h00089ffc) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x8affc = ((dfx_avmm_address == 32'h0008affc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x8affc = ((dfx_avmm_address == 32'h0008affc) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x8bffc = ((dfx_avmm_address == 32'h0008bffc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x8bffc = ((dfx_avmm_address == 32'h0008bffc) && dfx_avmm_write); // @ BaseType.scala l305
  assign read_hit_0x8cffc = ((dfx_avmm_address == 32'h0008cffc) && dfx_avmm_read); // @ BaseType.scala l305
  assign write_hit_0x8cffc = ((dfx_avmm_address == 32'h0008cffc) && dfx_avmm_write); // @ BaseType.scala l305
  assign avmm_bus_if_bus_rderr = avmm_bus_if_reg_rderr; // @ BusIf.scala l298
  assign avmm_bus_if_bus_rdata = avmm_bus_if_reg_rdata; // @ BusIf.scala l299
  always @(posedge clk) begin
    if(reset) begin
      avmm_bus_if_reg_rderr <= 1'b0; // @ Data.scala l409
      avmm_bus_if_reg_rdata <= 32'h0; // @ Data.scala l409
      dfx_avmm_read_regNext <= 1'b0; // @ Data.scala l409
      cmdq_fsm_state_db_proc <= 32'h0; // @ Data.scala l409
      rx_wqe_rw_test_reg <= 32'h0; // @ Data.scala l409
      cmdq_fsm_state_avst_width <= 32'h0; // @ Data.scala l409
      tx_pkt_gen_rw_test_reg <= 32'h0; // @ Data.scala l409
      db_scheduler_rw_test_reg <= 32'h0; // @ Data.scala l409
      tx_dma_ctrl_rw_test_reg <= 32'h0; // @ Data.scala l409
      cmdq_fsm_state_dma_rreq_proc <= 32'h0; // @ Data.scala l409
      eq_rw_test_reg <= 32'h0; // @ Data.scala l409
      timer_rw_test_reg <= 32'h0; // @ Data.scala l409
      cmdq_cmd_id_bitmap <= 32'h0; // @ Data.scala l409
      cmdq_fsm_state_cmd_parser <= 32'h0; // @ Data.scala l409
      mr_rw_test_reg <= 32'h0; // @ Data.scala l409
      tx_wqe_rw_test_reg <= 32'h0; // @ Data.scala l409
      cmdq_rw_reg <= 32'hffffffff; // @ Data.scala l409
      rx_pkt_parser_rw_test_reg <= 32'h0; // @ Data.scala l409
      cq_rw_test_reg <= 32'h0; // @ Data.scala l409
      qp_manager_rw_test_reg <= 32'h0; // @ Data.scala l409
      rx_pkt_processor_rw_test_reg <= 32'h0; // @ Data.scala l409
      cmdq_fsm_state_cmd_rsp_proc <= 32'h0; // @ Data.scala l409
    end else begin
      avmm_bus_if_reg_rderr <= avmm_bus_if_bus_rderr; // @ Reg.scala l39
      avmm_bus_if_reg_rdata <= avmm_bus_if_bus_rdata; // @ Reg.scala l39
      dfx_avmm_read_regNext <= dfx_avmm_read; // @ Reg.scala l39
      cmdq_fsm_state_db_proc <= cmdq_fsm_state_db_proc_i; // @ BusIfExt.scala l154
      if(write_hit_0x8cffc) begin
        rx_wqe_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      cmdq_fsm_state_avst_width <= cmdq_fsm_state_avst_width_i; // @ BusIfExt.scala l154
      if(write_hit_0x8affc) begin
        tx_pkt_gen_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      if(write_hit_0x82ffc) begin
        db_scheduler_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      if(write_hit_0x89ffc) begin
        tx_dma_ctrl_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      cmdq_fsm_state_dma_rreq_proc <= cmdq_fsm_state_dma_rreq_proc_i; // @ BusIfExt.scala l154
      if(write_hit_0x83ffc) begin
        eq_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      if(write_hit_0x88ffc) begin
        timer_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      cmdq_cmd_id_bitmap <= cmdq_cmd_id_bitmap_i; // @ BusIfExt.scala l154
      cmdq_fsm_state_cmd_parser <= cmdq_fsm_state_cmd_parser_i; // @ BusIfExt.scala l154
      if(write_hit_0x84ffc) begin
        mr_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      if(write_hit_0x8bffc) begin
        tx_wqe_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      if(write_hit_0x800c4) begin
        cmdq_rw_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      if(write_hit_0x86ffc) begin
        rx_pkt_parser_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      if(write_hit_0x81ffc) begin
        cq_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      if(write_hit_0x85ffc) begin
        qp_manager_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      if(write_hit_0x87ffc) begin
        rx_pkt_processor_rw_test_reg <= dfx_avmm_writeData[31 : 0]; // @ Bits.scala l133
      end
      cmdq_fsm_state_cmd_rsp_proc <= cmdq_fsm_state_cmd_rsp_proc_i; // @ BusIfExt.scala l154
      if(dfx_avmm_read) begin
        case(dfx_avmm_address)
          32'h00080000 : begin
            avmm_bus_if_reg_rdata <= cmdq_cmd_id_bitmap; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00080004 : begin
            avmm_bus_if_reg_rdata <= cmdq_fsm_state_db_proc; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00080008 : begin
            avmm_bus_if_reg_rdata <= cmdq_fsm_state_dma_rreq_proc; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h0008000c : begin
            avmm_bus_if_reg_rdata <= cmdq_fsm_state_cmd_parser; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00080010 : begin
            avmm_bus_if_reg_rdata <= cmdq_fsm_state_avst_width; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00080014 : begin
            avmm_bus_if_reg_rdata <= cmdq_fsm_state_cmd_rsp_proc; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h000800c4 : begin
            avmm_bus_if_reg_rdata <= cmdq_rw_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00081ffc : begin
            avmm_bus_if_reg_rdata <= cq_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00082ffc : begin
            avmm_bus_if_reg_rdata <= db_scheduler_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00083ffc : begin
            avmm_bus_if_reg_rdata <= eq_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00084ffc : begin
            avmm_bus_if_reg_rdata <= mr_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00085ffc : begin
            avmm_bus_if_reg_rdata <= qp_manager_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00086ffc : begin
            avmm_bus_if_reg_rdata <= rx_pkt_parser_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00087ffc : begin
            avmm_bus_if_reg_rdata <= rx_pkt_processor_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00088ffc : begin
            avmm_bus_if_reg_rdata <= timer_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h00089ffc : begin
            avmm_bus_if_reg_rdata <= tx_dma_ctrl_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h0008affc : begin
            avmm_bus_if_reg_rdata <= tx_pkt_gen_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h0008bffc : begin
            avmm_bus_if_reg_rdata <= tx_wqe_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          32'h0008cffc : begin
            avmm_bus_if_reg_rdata <= rx_wqe_rw_test_reg; // @ RegInst.scala l393
            avmm_bus_if_reg_rderr <= 1'b0; // @ RegInst.scala l394
          end
          default : begin
            avmm_bus_if_reg_rdata <= 32'hdeaddead; // @ BusIf.scala l266
            avmm_bus_if_reg_rderr <= ((|dfx_avmm_address[1 : 0]) ? 1'b1 : 1'b0); // @ BusIf.scala l272
          end
        endcase
      end else begin
        avmm_bus_if_reg_rdata <= 32'hdeaddead; // @ BusIf.scala l283
        avmm_bus_if_reg_rderr <= 1'b0; // @ BusIf.scala l284
      end
    end
  end


endmodule
