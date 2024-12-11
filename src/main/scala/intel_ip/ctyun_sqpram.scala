package intel_ip

import spinal.core._
import spinal.lib._

import scala.language.postfixOps

case class SqpPort(dataWidth: Int, addrWidth: Int) extends Bundle with IMasterSlave {
  val rden_a:          Bool = Bool()
  val rden_b:          Bool = Bool()
  val wren_a:          Bool = Bool()
  val wren_b:          Bool = Bool()
  val byteena_a:       Bits = Bits((dataWidth + 7) / 8 bits)
  val byteena_b:       Bits = Bits((dataWidth + 7) / 8 bits)
  val din_a:           Bits = Bits(dataWidth bits)
  val din_b:           Bits = Bits(dataWidth bits)
  val read_address_a:  UInt = UInt(addrWidth bits)
  val read_address_b:  UInt = UInt(addrWidth bits)
  val write_address_a: UInt = UInt(addrWidth bits)
  val write_address_b: UInt = UInt(addrWidth bits)
  val dout_a:          Bits = Bits(dataWidth bits)
  val dout_b:          Bits = Bits(dataWidth bits)

  override def asMaster(): Unit = {
    in(dout_a, dout_b)
    out(rden_a, rden_b, wren_a, wren_b, byteena_a, byteena_b, din_a, din_b, read_address_a, read_address_b, write_address_a, write_address_b)
  }

  def <<(that: SqpPort): Unit = {
    rden_a          := that.rden_a
    rden_b          := that.rden_b
    wren_a          := that.wren_a
    wren_b          := that.wren_b
    byteena_a       := that.byteena_a
    byteena_b       := that.byteena_b
    din_a           := that.din_a
    din_b           := that.din_b
    read_address_a  := that.read_address_a
    read_address_b  := that.read_address_b
    write_address_a := that.write_address_a
    write_address_b := that.write_address_b
    that.dout_a     := dout_a
    that.dout_b     := dout_b
  }

//  def clearAll(): Unit ={
//     rden_a.clear()
//     rden_b.clear()
//     wren_a.clear()
//     wren_b.clear()
//     byteena_a.clearAll()
//     byteena_b.clearAll()
//     din_a.clearAll()
//     din_b.clearAll()
//     read_address_a.clearAll()
//     read_address_b.clearAll()
//     write_address_a.clearAll()
//     write_address_b.clearAll()
//    Unit
//  }
}

object ctyun_sqpram {
  def apply(port: SqpPort, readLatency: Int): ctyun_sqpram = {
    val ram = new ctyun_sqpram(port.dataWidth, port.addrWidth, readLatency)
    ram.io.ram_port << port
    ram
  }
}

case class ctyun_sqpram(dataWidth: Int, addrWidth: Int, readLatency: Int = 2) extends BlackBox {
  val io = new Bundle {
    val clock:    Bool    = in Bool ()
    val ram_port: SqpPort = slave(SqpPort(dataWidth, addrWidth).setName(""))
  }

  noIoPrefix()
  mapClockDomain(clock = io.clock)

  addGenerics(
    ("DATA_WIDTH", dataWidth),
    ("ADDR_WIDTH", addrWidth),
    ("READ_LATENCY_A", readLatency),
    ("READ_LATENCY_B", readLatency)
  )
  setInlineVerilog("""module ctyun_sqpram #(
                     |    parameter ADDR_WIDTH     = 8 ,
                     |    parameter DATA_WIDTH     = 32,
                     |    parameter READ_LATENCY_A = 2 ,
                     |    parameter READ_LATENCY_B = 2
                     |) (
                     |    input                                  clock          ,
                     |    input                                  rden_a         ,
                     |    input                                  rden_b         ,
                     |    input                                  wren_a         ,
                     |    input                                  wren_b         ,
                     |    input  [     (DATA_WIDTH + 7)/8 - 1:0] byteena_a      ,
                     |    input  [     (DATA_WIDTH+7) / 8 - 1:0] byteena_b      ,
                     |    input  [             DATA_WIDTH - 1:0] din_a          ,
                     |    input  [             DATA_WIDTH - 1:0] din_b          ,
                     |    input  [              ADDR_WIDTH- 1:0] read_address_a ,
                     |    input  [             ADDR_WIDTH - 1:0] read_address_b ,
                     |    input  [             ADDR_WIDTH - 1:0] write_address_a,
                     |    input  [              ADDR_WIDTH- 1:0] write_address_b,
                     |    output [             DATA_WIDTH - 1:0] dout_a         ,
                     |    output [             DATA_WIDTH - 1:0] dout_b
                     |);
                     |
                     |    localparam BYTEENA_WIDTH  = (DATA_WIDTH + 7) / 8;
                     |    localparam DATA_WIDTH_PAD = BYTEENA_WIDTH * 8;
                     |    localparam DEPTH          = 1 << ADDR_WIDTH;
                     |    localparam OUTDATA_REG_B  = (READ_LATENCY_B > 1 ? "CLOCK0" : "UNREGISTERED");
                     |    localparam OUTDATA_REG_A  = (READ_LATENCY_A > 1 ? "CLOCK0" : "UNREGISTERED");
                     |    wire [DATA_WIDTH_PAD-1:0]din_a_pad, din_b_pad, dout_a_pad, dout_b_pad;
                     |    assign din_a_pad = {{(DATA_WIDTH_PAD-DATA_WIDTH){1'b0}}, din_a};
                     |    assign din_b_pad = {{(DATA_WIDTH_PAD-DATA_WIDTH){1'b0}}, din_b};
                     |    assign dout_a    = dout_a_pad[DATA_WIDTH-1:0];
                     |    assign dout_b    = dout_b_pad[DATA_WIDTH-1:0];
                     |
                     |    altera_syncram altera_syncram_component (
                     |        .address2_a    (read_address_a     ),
                     |        .address2_b    (read_address_b     ),
                     |        .address_a     (write_address_a    ),
                     |        .address_b     (write_address_b    ),
                     |        .byteena_a     (byteena_a          ),
                     |        .byteena_b     (byteena_b          ),
                     |        .clock0        (clock              ),
                     |        .clocken0      (1'b1               ),
                     |        .data_a        (din_a_pad          ),
                     |        .data_b        (din_b_pad          ),
                     |        .rden_a        (rden_a             ),
                     |        .rden_b        (rden_b             ),
                     |        .wren_a        (wren_a             ),
                     |        .wren_b        (wren_b             ),
                     |        .q_a           (dout_a_pad         ),
                     |        .q_b           (dout_b_pad         ),
                     |        .aclr0         (1'b0               ),
                     |        .aclr1         (1'b0               ),
                     |        .addressstall_a(1'b0               ),
                     |        .addressstall_b(1'b0               ),
                     |        .clock1        (1'b1               ),
                     |        .clocken1      (1'b1               ),
                     |        .clocken2      (1'b1               ),
                     |        .clocken3      (1'b1               ),
                     |        .eccencbypass  (1'b0               ),
                     |        .eccencparity  (8'b0               ),
                     |        .eccstatus     (                   ),
                     |        .sclr          (1'b0               )
                     |    );
                     |    defparam
                     |        // Read input Aclrs
                     |        altera_syncram_component.address_aclr_a = "NONE",  //  CLEAR0 or NONE
                     |        altera_syncram_component.address_aclr_b = "NONE",  //  CLEAR0 or NONE
                     |
                     |        // Input Registers, must be CLOCK0 in RAM: 4-PORT IP
                     |        altera_syncram_component.address_reg_b = "CLOCK0",  // must be CLOCK0
                     |        altera_syncram_component.byteena_reg_b = "CLOCK0",  // must be CLOCK0
                     |        altera_syncram_component.indata_reg_b  = "CLOCK0",  // must be CLOCK0
                     |
                     |        // Clock Enables: Use clock enable for input and output registers, these four below all are BYPASS or NORMAL.
                     |        altera_syncram_component.clock_enable_input_a  = "BYPASS",  // BYPASS or NORMAL
                     |        altera_syncram_component.clock_enable_input_b  = "BYPASS",  // BYPASS or NORMAL
                     |        altera_syncram_component.clock_enable_output_a = "BYPASS",  // BYPASS or NORMAL
                     |        altera_syncram_component.clock_enable_output_b = "BYPASS",  // BYPASS or NORMAL
                     |
                     |        altera_syncram_component.intended_device_family = "Agilex",
                     |        altera_syncram_component.lpm_type               = "altera_syncram",
                     |        altera_syncram_component.operation_mode         = "QUAD_PORT",
                     |
                     |        // output Aclrs or Sclrs
                     |        altera_syncram_component.outdata_aclr_a = "NONE",  // CLEAR0 or NONE
                     |        altera_syncram_component.outdata_sclr_a = "NONE",  // SCLEAR or NONE
                     |        altera_syncram_component.outdata_aclr_b = "NONE",  // CLEAR0 or NONE
                     |        altera_syncram_component.outdata_sclr_b = "NONE",  // SCLEAR or NONE
                     |
                     |        // Output Registers
                     |        altera_syncram_component.outdata_reg_a = OUTDATA_REG_A,  // UNREGISTERED or CLOKC0
                     |        altera_syncram_component.outdata_reg_b = OUTDATA_REG_B,  // UNREGISTERED or CLOKC0
                     |
                     |        altera_syncram_component.power_up_uninitialized              = "FALSE",
                     |        altera_syncram_component.ram_block_type                      = "M20K",
                     |        altera_syncram_component.enable_force_to_zero                = "TRUE",        // TRUE or FALSE
                     |        altera_syncram_component.optimization_option                 = "HIGH_SPEED",
                     |        altera_syncram_component.read_during_write_mode_port_a       = "DONT_CARE",
                     |        altera_syncram_component.read_during_write_mode_port_b       = "DONT_CARE",
                     |        altera_syncram_component.read_during_write_mode_mixed_ports  = "NEW_A_OLD_B",
                     |        altera_syncram_component.numwords_a                          = DEPTH,
                     |        altera_syncram_component.numwords_b                          = DEPTH,
                     |        altera_syncram_component.widthad_a                           = ADDR_WIDTH,
                     |        altera_syncram_component.widthad_b                           = ADDR_WIDTH,
                     |        altera_syncram_component.widthad2_a                          = ADDR_WIDTH,
                     |        altera_syncram_component.widthad2_b                          = ADDR_WIDTH,
                     |        altera_syncram_component.width_a                             = DATA_WIDTH_PAD,
                     |        altera_syncram_component.width_b                             = DATA_WIDTH_PAD,
                     |        altera_syncram_component.width_byteena_a                     = BYTEENA_WIDTH,
                     |        altera_syncram_component.width_byteena_b                     = BYTEENA_WIDTH,
                     |        altera_syncram_component.byte_size                           = 8;
                     |
                     |endmodule""".stripMargin)
}
