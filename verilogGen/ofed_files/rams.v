// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : rams
// Git hash  : 49efc9243c37053f9cb9628511cfed8eea9c0c37



module rams ();

    wire [511:0] sdpram_rd_dout;
    wire         sdpram_perror;
    wire [ 63:0] sdpram_1_rd_dout;
    wire         sdpram_1_perror;
    wire [511:0] sdpram_2_rd_dout;
    wire         sdpram_2_perror;
    wire [ 63:0] sdpram_3_rd_dout;
    wire         sdpram_3_perror;
    wire [255:0] sdpram_4_rd_dout;
    wire         sdpram_4_perror;
    wire [ 23:0] sdpram_5_rd_dout;
    wire         sdpram_5_perror;
    wire [351:0] sdpram_6_rd_dout;
    wire         sdpram_6_perror;
    wire [ 95:0] sdpram_7_rd_dout;
    wire         sdpram_7_perror;

    sdpram1Kx512 sdpram (
        .rd_clk (1'b0),                   //i
        .rden   (1'b0),                   //i
        .rd_addr(10'h0),                  //i
        .rd_dout(sdpram_rd_dout[511:0]),  //o
        .wr_clk (1'b0),                   //i
        .wren   (1'b0),                   //i
        .wr_addr(10'h0),                  //i
        .wr_din (512'h0),                 //i
        .perror (sdpram_perror)           //o
    );
    sdpram512x64 sdpram_1 (
        .rd_clk (1'b0),                    //i
        .rden   (1'b0),                    //i
        .rd_addr(9'h0),                    //i
        .rd_dout(sdpram_1_rd_dout[63:0]),  //o
        .wr_clk (1'b0),                    //i
        .wren   (1'b0),                    //i
        .wr_addr(9'h0),                    //i
        .wr_din (64'h0),                   //i
        .perror (sdpram_1_perror)          //o
    );
    sdpram2Kx512 sdpram_2 (
        .rd_clk (1'b0),                     //i
        .rden   (1'b0),                     //i
        .rd_addr(11'h0),                    //i
        .rd_dout(sdpram_2_rd_dout[511:0]),  //o
        .wr_clk (1'b0),                     //i
        .wren   (1'b0),                     //i
        .wr_addr(11'h0),                    //i
        .wr_din (512'h0),                   //i
        .perror (sdpram_2_perror)           //o
    );
    sdpram1Kx64 sdpram_3 (
        .rd_clk (1'b0),                    //i
        .rden   (1'b0),                    //i
        .rd_addr(10'h0),                   //i
        .rd_dout(sdpram_3_rd_dout[63:0]),  //o
        .wr_clk (1'b0),                    //i
        .wren   (1'b0),                    //i
        .wr_addr(10'h0),                   //i
        .wr_din (64'h0),                   //i
        .perror (sdpram_3_perror)          //o
    );
    sdpram512x256 sdpram_4 (
        .rd_clk (1'b0),                     //i
        .rden   (1'b0),                     //i
        .rd_addr(9'h0),                     //i
        .rd_dout(sdpram_4_rd_dout[255:0]),  //o
        .wr_clk (1'b0),                     //i
        .wren   (1'b0),                     //i
        .wr_addr(9'h0),                     //i
        .wr_din (256'h0),                   //i
        .perror (sdpram_4_perror)           //o
    );
    sdpram1Kx24 sdpram_5 (
        .rd_clk (1'b0),                    //i
        .rden   (1'b0),                    //i
        .rd_addr(10'h0),                   //i
        .rd_dout(sdpram_5_rd_dout[23:0]),  //o
        .wr_clk (1'b0),                    //i
        .wren   (1'b0),                    //i
        .wr_addr(10'h0),                   //i
        .wr_din (24'h0),                   //i
        .perror (sdpram_5_perror)          //o
    );
    sdpram1Kx352 sdpram_6 (
        .rd_clk (1'b0),                     //i
        .rden   (1'b0),                     //i
        .rd_addr(10'h0),                    //i
        .rd_dout(sdpram_6_rd_dout[351:0]),  //o
        .wr_clk (1'b0),                     //i
        .wren   (1'b0),                     //i
        .wr_addr(10'h0),                    //i
        .wr_din (352'h0),                   //i
        .perror (sdpram_6_perror)           //o
    );
    sdpram256x96 sdpram_7 (
        .rd_clk (1'b0),                    //i
        .rden   (1'b0),                    //i
        .rd_addr(8'h0),                    //i
        .rd_dout(sdpram_7_rd_dout[95:0]),  //o
        .wr_clk (1'b0),                    //i
        .wren   (1'b0),                    //i
        .wr_addr(8'h0),                    //i
        .wr_din (96'h0),                   //i
        .perror (sdpram_7_perror)          //o
    );

endmodule

module sdpram256x96 (
    input  wire        rd_clk,
    input  wire        rden,
    input  wire [ 7:0] rd_addr,
    output wire [95:0] rd_dout,
    input  wire        wr_clk,
    input  wire        wren,
    input  wire [ 7:0] wr_addr,
    input  wire [95:0] wr_din,
    output wire        perror
);

    reg [95:0] mem_spinal_port1;
    reg [95:0] tmp_rd_dout;
    reg [95:0] mem              [0:255];

    always @(posedge wr_clk) begin
        if (wren) begin
            mem[wr_addr] <= wr_din;
        end
    end

    always @(posedge rd_clk) begin
        if (rden) begin
            mem_spinal_port1 <= mem[rd_addr];
        end
    end

    assign rd_dout = tmp_rd_dout;  // @ rams.scala l31
    assign perror  = 1'b0;  // @ Bool.scala l92
    always @(posedge rd_clk) begin
        tmp_rd_dout <= mem_spinal_port1;  // @ Reg.scala l39
    end


endmodule

module sdpram1Kx352 (
    input  wire         rd_clk,
    input  wire         rden,
    input  wire [  9:0] rd_addr,
    output wire [351:0] rd_dout,
    input  wire         wr_clk,
    input  wire         wren,
    input  wire [  9:0] wr_addr,
    input  wire [351:0] wr_din,
    output wire         perror
);

    reg [351:0] mem_spinal_port1;
    reg [351:0] tmp_rd_dout;
    reg [351:0] mem              [0:1023];

    always @(posedge wr_clk) begin
        if (wren) begin
            mem[wr_addr] <= wr_din;
        end
    end

    always @(posedge rd_clk) begin
        if (rden) begin
            mem_spinal_port1 <= mem[rd_addr];
        end
    end

    assign rd_dout = tmp_rd_dout;  // @ rams.scala l31
    assign perror  = 1'b0;  // @ Bool.scala l92
    always @(posedge rd_clk) begin
        tmp_rd_dout <= mem_spinal_port1;  // @ Reg.scala l39
    end


endmodule

module sdpram1Kx24 (
    input  wire        rd_clk,
    input  wire        rden,
    input  wire [ 9:0] rd_addr,
    output wire [23:0] rd_dout,
    input  wire        wr_clk,
    input  wire        wren,
    input  wire [ 9:0] wr_addr,
    input  wire [23:0] wr_din,
    output wire        perror
);

    reg [23:0] mem_spinal_port1;
    reg [23:0] tmp_rd_dout;
    reg [23:0] mem              [0:1023];

    always @(posedge wr_clk) begin
        if (wren) begin
            mem[wr_addr] <= wr_din;
        end
    end

    always @(posedge rd_clk) begin
        if (rden) begin
            mem_spinal_port1 <= mem[rd_addr];
        end
    end

    assign rd_dout = tmp_rd_dout;  // @ rams.scala l31
    assign perror  = 1'b0;  // @ Bool.scala l92
    always @(posedge rd_clk) begin
        tmp_rd_dout <= mem_spinal_port1;  // @ Reg.scala l39
    end


endmodule

module sdpram512x256 (
    input  wire         rd_clk,
    input  wire         rden,
    input  wire [  8:0] rd_addr,
    output wire [255:0] rd_dout,
    input  wire         wr_clk,
    input  wire         wren,
    input  wire [  8:0] wr_addr,
    input  wire [255:0] wr_din,
    output wire         perror
);

    reg [255:0] mem_spinal_port1;
    reg [255:0] tmp_rd_dout;
    reg [255:0] mem              [0:511];

    always @(posedge wr_clk) begin
        if (wren) begin
            mem[wr_addr] <= wr_din;
        end
    end

    always @(posedge rd_clk) begin
        if (rden) begin
            mem_spinal_port1 <= mem[rd_addr];
        end
    end

    assign rd_dout = tmp_rd_dout;  // @ rams.scala l31
    assign perror  = 1'b0;  // @ Bool.scala l92
    always @(posedge rd_clk) begin
        tmp_rd_dout <= mem_spinal_port1;  // @ Reg.scala l39
    end


endmodule

module sdpram1Kx64 (
    input  wire        rd_clk,
    input  wire        rden,
    input  wire [ 9:0] rd_addr,
    output wire [63:0] rd_dout,
    input  wire        wr_clk,
    input  wire        wren,
    input  wire [ 9:0] wr_addr,
    input  wire [63:0] wr_din,
    output wire        perror
);

    reg [63:0] mem_spinal_port1;
    reg [63:0] tmp_rd_dout;
    reg [63:0] mem              [0:1023];

    always @(posedge wr_clk) begin
        if (wren) begin
            mem[wr_addr] <= wr_din;
        end
    end

    always @(posedge rd_clk) begin
        if (rden) begin
            mem_spinal_port1 <= mem[rd_addr];
        end
    end

    assign rd_dout = tmp_rd_dout;  // @ rams.scala l31
    assign perror  = 1'b0;  // @ Bool.scala l92
    always @(posedge rd_clk) begin
        tmp_rd_dout <= mem_spinal_port1;  // @ Reg.scala l39
    end


endmodule

module sdpram2Kx512 (
    input  wire         rd_clk,
    input  wire         rden,
    input  wire [ 10:0] rd_addr,
    output wire [511:0] rd_dout,
    input  wire         wr_clk,
    input  wire         wren,
    input  wire [ 10:0] wr_addr,
    input  wire [511:0] wr_din,
    output wire         perror
);

    reg [511:0] mem_spinal_port1;
    reg [511:0] tmp_rd_dout;
    reg [511:0] mem              [0:2047];

    always @(posedge wr_clk) begin
        if (wren) begin
            mem[wr_addr] <= wr_din;
        end
    end

    always @(posedge rd_clk) begin
        if (rden) begin
            mem_spinal_port1 <= mem[rd_addr];
        end
    end

    assign rd_dout = tmp_rd_dout;  // @ rams.scala l31
    assign perror  = 1'b0;  // @ Bool.scala l92
    always @(posedge rd_clk) begin
        tmp_rd_dout <= mem_spinal_port1;  // @ Reg.scala l39
    end


endmodule

module sdpram512x64 (
    input  wire        rd_clk,
    input  wire        rden,
    input  wire [ 8:0] rd_addr,
    output wire [63:0] rd_dout,
    input  wire        wr_clk,
    input  wire        wren,
    input  wire [ 8:0] wr_addr,
    input  wire [63:0] wr_din,
    output wire        perror
);

    reg [63:0] mem_spinal_port1;
    reg [63:0] tmp_rd_dout;
    reg [63:0] mem              [0:511];

    always @(posedge wr_clk) begin
        if (wren) begin
            mem[wr_addr] <= wr_din;
        end
    end

    always @(posedge rd_clk) begin
        if (rden) begin
            mem_spinal_port1 <= mem[rd_addr];
        end
    end

    assign rd_dout = tmp_rd_dout;  // @ rams.scala l31
    assign perror  = 1'b0;  // @ Bool.scala l92
    always @(posedge rd_clk) begin
        tmp_rd_dout <= mem_spinal_port1;  // @ Reg.scala l39
    end


endmodule

module sdpram1Kx512 (
    input  wire         rd_clk,
    input  wire         rden,
    input  wire [  9:0] rd_addr,
    output wire [511:0] rd_dout,
    input  wire         wr_clk,
    input  wire         wren,
    input  wire [  9:0] wr_addr,
    input  wire [511:0] wr_din,
    output wire         perror
);

    reg [511:0] mem_spinal_port1;
    reg [511:0] tmp_rd_dout;
    reg [511:0] mem              [0:1023];

    always @(posedge wr_clk) begin
        if (wren) begin
            mem[wr_addr] <= wr_din;
        end
    end

    always @(posedge rd_clk) begin
        if (rden) begin
            mem_spinal_port1 <= mem[rd_addr];
        end
    end

    assign rd_dout = tmp_rd_dout;  // @ rams.scala l31
    assign perror  = 1'b0;  // @ Bool.scala l92
    always @(posedge rd_clk) begin
        tmp_rd_dout <= mem_spinal_port1;  // @ Reg.scala l39
    end


endmodule
