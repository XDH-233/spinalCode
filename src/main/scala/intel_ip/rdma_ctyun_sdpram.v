module rdma_ctyun_sdpram #(
    parameter WR_ADDR_WIDTH     = 8          ,
    parameter RD_ADDR_WIDTH     = 8          ,
    parameter WR_DATA_WIDTH     = 32         ,
    parameter RD_DATA_WIDTH     = 32         ,
    parameter READ_LATENCY      = 2          ,  //! 1 or 2 cycles
    parameter RAM_TYPE          = "AUTO"     ,  //! AUTO, M20K, MLAB; MLAB is unavailable if WR_DATA_WIDTH != RD_DATA_WIDTH
    parameter READ_DURING_WRITE = "OLD_DATA" ,  //! OLD_DATA, DONT_CARE or NEW_DATA; NEW_DATA is available only when use MLAB or AUTO
    parameter INIT_FILE         = "UNUSED"

) (
    input                                  clock    ,
    input                                  wren     ,
    input                                  rden     ,
    input  [     (WR_DATA_WIDTH+7)/8 -1:0] byteena  ,
    input  [            WR_DATA_WIDTH-1:0] din      ,
    input  [            RD_ADDR_WIDTH-1:0] rdaddress,
    input  [            WR_ADDR_WIDTH-1:0] wraddress,
    output [            RD_DATA_WIDTH-1:0] dout
);

    localparam NUM_WORDS_A       = 1 << WR_ADDR_WIDTH   ;
    localparam NUM_WORDS_B       = 1 << RD_ADDR_WIDTH   ;
    localparam BYTEENA_WIDTH_A   = (WR_DATA_WIDTH+7) / 8;
    localparam BYTEENA_WIDTH_B   = (RD_DATA_WIDTH+7) / 8;
    localparam WR_DATA_WIDTH_PAD = 8 * BYTEENA_WIDTH_A  ;
    localparam RD_DATA_WIDTH_PAD = 8 * BYTEENA_WIDTH_B  ;

    localparam OUTDATA_REG_B   = (READ_LATENCY > 1 ? "CLOCK0" : "UNREGISTERED");
    wire [WR_DATA_WIDTH_PAD-1:0] din_a;
    wire [RD_DATA_WIDTH_PAD-1:0] dout_b;
    assign din_a               = {{(WR_DATA_WIDTH_PAD-WR_DATA_WIDTH){1'b0}}, din};
    assign dout                = dout_b[RD_DATA_WIDTH-1:0];
    altera_syncram altera_syncram_component (
        .address_a     (wraddress            ),
        .address_b     (rdaddress            ),
        .clock0        (clock                ),
        .data_a        (din_a                ),
        .wren_a        (wren                 ),
        .q_b           (dout_b               ),
        .aclr0         (1'b0                 ),
        .aclr1         (1'b0                 ),
        .address2_a    (1'b1                 ),
        .address2_b    (1'b1                 ),
        .addressstall_a(1'b0                 ),
        .addressstall_b(1'b0                 ),
        .byteena_a     (byteena              ),
        .byteena_b     (1'b1                 ),
        .clock1        (1'b1                 ),
        .clocken0      (1'b1                 ),
        .clocken1      (1'b1                 ),
        .clocken2      (1'b1                 ),
        .clocken3      (1'b1                 ),
        // .data_b        ({RD_DATA_WIDTH{1'b1}}),
        .eccencbypass  (1'b0                 ),
        .eccencparity  (8'b0                 ),
        .eccstatus     (                     ),
        .q_a           (                     ),
        .rden_a        (1'b1                 ),
        .rden_b        (rden                 ),
        .sclr          (1'b0                 ),
        .wren_b        (1'b0                 )
    );
    defparam
        altera_syncram_component.address_aclr_b                      = "NONE"            ,
        altera_syncram_component.address_reg_b                       = "CLOCK0"          ,
        altera_syncram_component.clock_enable_input_a                = "BYPASS"          ,
        altera_syncram_component.clock_enable_input_b                = "BYPASS"          ,
        altera_syncram_component.clock_enable_output_b               = "BYPASS"          ,
        altera_syncram_component.enable_force_to_zero                = "FALSE"           ,
        altera_syncram_component.intended_device_family              = "Agilex"          ,
        altera_syncram_component.lpm_type                            = "altera_syncram"  ,
        altera_syncram_component.numwords_a                          = NUM_WORDS_A       ,
        altera_syncram_component.numwords_b                          = NUM_WORDS_B       ,
        altera_syncram_component.operation_mode                      = "DUAL_PORT"       ,
        altera_syncram_component.outdata_aclr_b                      = "NONE"            ,
        altera_syncram_component.outdata_sclr_b                      = "NONE"            ,
        altera_syncram_component.outdata_reg_b                       = OUTDATA_REG_B     ,
        altera_syncram_component.power_up_uninitialized              = "FALSE"           ,
        altera_syncram_component.byte_size                           = 8                 ,
        altera_syncram_component.read_during_write_mode_mixed_ports  = READ_DURING_WRITE ,
        altera_syncram_component.ram_block_type                      = RAM_TYPE          ,
        altera_syncram_component.widthad_a                           = WR_ADDR_WIDTH     ,
        altera_syncram_component.widthad_b                           = RD_ADDR_WIDTH     ,
        altera_syncram_component.width_a                             = WR_DATA_WIDTH_PAD ,
        altera_syncram_component.width_b                             = RD_DATA_WIDTH_PAD ,
        altera_syncram_component.width_byteena_a                     = BYTEENA_WIDTH_A   ,
        altera_syncram_component.init_file                           = INIT_FILE         ;

endmodule