
module rdma_ctyun_sfifo #(
    parameter DATA_WIDTH      = 32,
    parameter DEPTH           = 256,
    parameter ADD_RAM_OUT_REG = "ON",       //! ON  or OFF
    parameter ALMOST_MTY_VAL  = 2,
    parameter ALMOST_FULL_VAL = DEPTH - 2,
    parameter SHOW_AHEAD      = "ON",       //! ON or OFF
    parameter RAM_BLK_STYLE   = "AUTO"      //! AUTO, M20K or MLAB
) (
    input                          clk         ,
    input                          srst        ,
    input                          wr_en       ,
    output                         full        ,
    input      [ DATA_WIDTH - 1:0] din         ,
    input                          rd_en       ,
    output                         empty       ,
    output     [   DATA_WIDTH-1:0] dout        ,
    output                         almost_empty,
    output                         almost_full ,
    output     [$clog2(DEPTH)-1:0] usedw       ,
    output                         overflow    ,
    output                         underflow
);

    localparam ADDR_WIDTH      = $clog2(DEPTH);
    localparam HINT            = RAM_BLK_STYLE == "M20K" ? "RAM_BLOCK_TYPE=M20K" : (RAM_BLK_STYLE == "MLAB" ? "RAM_BLOCK_TYPE=MLAB": "");

    reg wren_r;
    reg [DATA_WIDTH-1:0] data_r;

    always @(posedge clk ) begin
        if(srst)begin
            wren_r <= 1'b0;
        end else if(wr_en & full & ~wren_r) begin
            wren_r <= 1'b1;
            data_r <= din;
        end else if(~full)begin
            wren_r <= 1'b0;
        end
    end

    assign overflow = wr_en & full;
    assign underflow = rd_en & empty;

    scfifo scfifo_component (
        .clock       (clk         ),
        .data        (din         ),
        .rdreq       (rd_en       ),
        .sclr        (srst        ),
        .wrreq       (wr_en       ),
        .almost_empty(almost_empty),
        .almost_full (almost_full ),
        .empty       (empty       ),
        .full        (full        ),
        .q           (dout        ),
        .usedw       (usedw       ),
        .aclr        (1'b0        ),
        .eccstatus   (            )
    );
    defparam
        scfifo_component.add_ram_output_register = ADD_RAM_OUT_REG,
        scfifo_component.almost_empty_value      = ALMOST_MTY_VAL,
        scfifo_component.almost_full_value       = ALMOST_FULL_VAL,
        scfifo_component.enable_ecc              = "FALSE",
        scfifo_component.intended_device_family  = "Agilex",
        scfifo_component.lpm_hint                = HINT,
        scfifo_component.lpm_numwords            = DEPTH,
        scfifo_component.lpm_showahead           = SHOW_AHEAD,
        scfifo_component.lpm_type                = "scfifo",
        scfifo_component.lpm_width               = DATA_WIDTH,
        scfifo_component.lpm_widthu              = ADDR_WIDTH,
        scfifo_component.overflow_checking       = "ON",
        scfifo_component.underflow_checking      = "ON",
        scfifo_component.use_eab                 = "ON";


endmodule