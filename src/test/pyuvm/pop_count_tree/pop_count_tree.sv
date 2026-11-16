// pop_count_tree: 参数化分治加法树 popcount
// 参考 verilogGen/PopCountTree.v (SpinalHDL elaborated, 固定 WIDTH=32)
// 本文件为手写参数化版本, WIDTH 任意, 结构与之保持一致
//
// 树状示意 (以 N=8 为例, N=32 结构相同只是每级节点数翻倍):
//
//   bits_in:  b0 b1   b2 b3   b4 b5   b6 b7
//              \ /      \ /      \ /      \ /
//   级0:      2bit     2bit     2bit     2bit     {a&b, a^b}, 无需加法器
//               \       /          \       /
//   级1:         3bit               3bit            +
//                 \                /
//   级2:            4bit = count_out                +, 深度 = $clog2(WIDTH)
//
//   深度 = $clog2(WIDTH) 级合并 (对比串行链的 WIDTH-1 级)
//   奇数 WIDTH: 每级最后一个落单节点直接透传

module pop_count_tree #(
    parameter int WIDTH = 32
) (
    input  logic [WIDTH-1:0]           bits_in,
    output logic [$clog2(WIDTH+1)-1:0] count
);

    localparam int W         = $clog2(WIDTH + 1);            // 计数位宽
    localparam int LVLS      = $clog2(WIDTH);                // 合并级数, WIDTH=1 时为 0
    localparam int MAX_NODES = (WIDTH + 1) / 2;              // 级0 节点数(最多的一级)

    // 各级节点数: lvl0 = ceil(WIDTH/2), 之后逐级 ceil(n/2)
    function automatic int n_nodes(int lvl);
        int n = WIDTH;
        repeat (lvl + 1) n = (n + 1) / 2;
        return n;
    endfunction

    // nodes[级][序号], 全 packed 三维, 统一 W bit (低位级超宽部分综合时自动剪除)
    // 注: 用 packed 而非 unpacked 数组, 避免 verilator UNOPTFLAT 误报
    logic [LVLS:0][MAX_NODES-1:0][W-1:0] nodes;

    genvar i, k;

    // 级0: 两两配对, {a&b, a^b} 得到 2bit 计数
    generate
        for (i = 0; i < MAX_NODES; i++) begin : g_pair
            if (2*i + 1 < WIDTH) begin : g_full
                assign nodes[0][i] = W'({bits_in[2*i] & bits_in[2*i+1],
                                         bits_in[2*i] ^ bits_in[2*i+1]});
            end else begin : g_tail   // 奇数 WIDTH 的落单 bit
                assign nodes[0][i] = W'(bits_in[2*i]);
            end
        end
    endgenerate

    // 级1..LVLS: 两两相加, 奇数落单节点透传
    generate
        for (k = 1; k <= LVLS; k++) begin : g_lvl
            for (i = 0; i < n_nodes(k); i++) begin : g_merge
                if (2*i + 1 < n_nodes(k-1)) begin : g_full
                    assign nodes[k][i] = nodes[k-1][2*i] + nodes[k-1][2*i+1];
                end else begin : g_tail
                    assign nodes[k][i] = nodes[k-1][2*i];
                end
            end
        end
    endgenerate

    assign count = nodes[LVLS][0];

endmodule
