// module one_hot2bin #(
//     parameter WIDTH = 128,
//     localparam BIN_WIDTH = $clog2(WIDTH)
// )(
//     input  logic                 clk,
//     input  logic                 rst,
//     input  logic [    WIDTH-1:0] one_hot_in,
//     output logic [BIN_WIDTH-1:0] bin_out
// );

//     localparam OR_NUM = 2**(BIN_WIDTH-1);
//     logic [BIN_WIDTH-1:0][OR_NUM-1:0] tmp;

//     always_comb begin
//         for (integer i=0; i < BIN_WIDTH; i=i+1)begin
//             bin_out[i] = |tmp[i];
//         end
//     end

//     always_comb begin
//         for (integer i=0; i < BIN_WIDTH; i=i+1)begin
//             integer j = 0;
//             for (integer k=0; k < WIDTH; k=k+1)begin
//                 if((k >> i) & 1 != 0)begin
//                     tmp[i][j] = one_hot_in[k];
//                     j = j + 1;
//                     $display(j);
//                 end
//             end
//         end
//     end

// endmodule


module one_hot2bin #(
    parameter WIDTH = 128,
    localparam BIN_WIDTH = $clog2(WIDTH),
    localparam OR_NUM = 2**(BIN_WIDTH-1)
)(
    input  logic                 clk,        // 保留接口兼容性
    input  logic                 rst,        // 保留接口兼容性
    input  logic [    WIDTH-1:0] one_hot_in,
    output logic [BIN_WIDTH-1:0] bin_out
);

    // 1. 预计算掩码数组：mask[i][k] = ((k >> i) & 1) != 0
    logic [BIN_WIDTH-1:0][WIDTH-1:0] mask;

    generate
        for (genvar i = 0; i < BIN_WIDTH; i++) begin : gen_mask_i
            for (genvar k = 0; k < WIDTH; k++) begin : gen_mask_k
                // 编译时常量赋值：掩码位为0或1
                assign mask[i][k] = ((k >> i) & 1) != 0;
            end
        end
    endgenerate

    // 2. 为每个二进制位计算或运算
    generate
        for (genvar i = 0; i < BIN_WIDTH; i++) begin : gen_bin_out
            logic [WIDTH-1:0] masked_bits;

            // 掩码与输入按位与
            assign masked_bits = one_hot_in & mask[i];

            // 按位或运算得到输出位
            assign bin_out[i] = |masked_bits;
        end
    endgenerate

endmodule
