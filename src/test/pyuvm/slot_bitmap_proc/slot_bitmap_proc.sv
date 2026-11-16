
`include "tcu_macros.svh"
`include "tcu_constants.svh"
`include "mqe_proc_types.svh"

module slot_bitmap_proc #(
    parameter BTM_WDITH = 192*8,
    parameter SEGMENT_WIDTH = 128
)(
  input  logic                          bitmap_in_valid,
  input  logic [BITMAP_INFO_BITS-1:0]   bitmap_in_data,
  output logic                          bitmap_in_ready,
  output logic                          slot_id_info_valid,
  output logic [SLOT_ID_BUF_BITS-1:0]   slot_id_info_data,
  input  logic                          slot_id_info_ready,
  input  logic                          clk,
  input  logic                          rst_n
);

slot_id_buf_t    slot_id_fifo_io_push_payload;
slot_id_buf_t    slot_id_fifo_io_pop_payload;
bitmap_info_t    bitmap_fifo_pop_payload;

logic [     BITMAP_INFO_BITS-1:0]    bitmap_fifo_io_push_payload;
logic                                bitmap_fifo_io_push_ready;
logic                                bitmap_fifo_io_pop_valid;
logic                                slot_id_fifo_io_push_ready;
logic                                slot_id_fifo_io_pop_valid;
logic [           `SID_WIDTH-1:0]    tmp_slot_id_out;
logic [           `SID_WIDTH-1:0]    tmp_bitmap_end;
logic [            BTM_WDITH-1:0]    tmp_bitmap_reg;
logic [            BTM_WDITH-1:0]    tmp_bitmap_reg_1;
logic                                bitmap_fifo_pop_valid;
logic                                bitmap_fifo_pop_ready;
logic                                bitmap_reg_vld;
logic [            BTM_WDITH-1:0]    bitmap_reg;
logic [        SEGMENT_WIDTH-1:0]    bitmap_seg;
logic [        SEGMENT_WIDTH-1:0]    bitmap_seg_reg;
logic                                bitmap_seg_reg_vld;
logic [        SEGMENT_WIDTH-1:0]    bitmap_seg_proc;
logic [        SEGMENT_WIDTH-1:0]    bitmap_seg_proc_minus_1;
logic [        SEGMENT_WIDTH-1:0]    low_1_one_hot;
logic [        SEGMENT_WIDTH-1:0]    bitmap_seg_next;
logic                                shift_en;
logic [           `SID_WIDTH-1:0]    seg_start_id_reg;
logic [           `SID_WIDTH-1:0]    seg_start_id;
logic [           `SID_WIDTH-1:0]    slot_id_out;
logic                                bitmap_end;
logic [           `SID_WIDTH-1:0]    slot_id_buf_slot_id;
logic                                slot_id_buf_last;
logic [$clog2(SEGMENT_WIDTH)-1:0]    low_1_index;
logic                                bitmap_info_fifo_pop_empty;
logic                                slot_id_fifo_pop_empty;

assign bitmap_seg_proc_minus_1   = bitmap_seg_proc - 1'b1;
assign tmp_slot_id_out           = {{(`SID_WIDTH-$clog2(SEGMENT_WIDTH)){1'b0}}, low_1_index};
assign tmp_bitmap_end            = (seg_start_id + SEGMENT_WIDTH);
assign tmp_bitmap_reg            = (bitmap_reg >>> SEGMENT_WIDTH);
assign tmp_bitmap_reg_1          = (bitmap_fifo_pop_payload.bitmap >>> SEGMENT_WIDTH);
assign bitmap_fifo_io_pop_valid  = ~bitmap_info_fifo_pop_empty;
assign slot_id_fifo_io_pop_valid = ~slot_id_fifo_pop_empty;


assign bitmap_fifo_io_push_payload = bitmap_in_data;
assign bitmap_in_ready             = bitmap_fifo_io_push_ready;
assign bitmap_fifo_pop_valid       = bitmap_fifo_io_pop_valid;
assign bitmap_seg                  = (bitmap_reg_vld ? bitmap_reg[SEGMENT_WIDTH-1 : 0] : bitmap_fifo_pop_payload.bitmap[SEGMENT_WIDTH-1 : 0]);
assign bitmap_seg_proc             = (bitmap_seg_reg_vld ? bitmap_seg_reg : bitmap_seg);
assign low_1_one_hot               = ((bitmap_seg_proc ^ bitmap_seg_proc_minus_1) & bitmap_seg_proc);



assign bitmap_seg_next                      = (bitmap_seg_proc ^ low_1_one_hot);
assign shift_en                             = ((! (|bitmap_seg_next)) && slot_id_fifo_io_push_ready);
assign slot_id_out                          = (seg_start_id + tmp_slot_id_out);
assign bitmap_end                           = (bitmap_fifo_pop_payload.cur_sto_id_end <= tmp_bitmap_end);
assign seg_start_id                         = (bitmap_reg_vld ? seg_start_id_reg : bitmap_fifo_pop_payload.cur_sto_id_start);
assign bitmap_fifo_pop_ready                = ((slot_id_fifo_io_push_ready && bitmap_end) && shift_en);
assign slot_id_buf_slot_id                  = slot_id_out;
assign slot_id_buf_last                     = ((bitmap_fifo_pop_payload.last && shift_en) && bitmap_end);
assign slot_id_fifo_io_push_payload.slot_id = slot_id_buf_slot_id;
assign slot_id_fifo_io_push_payload.last    = slot_id_buf_last;
assign slot_id_info_valid                   = slot_id_fifo_io_pop_valid;
assign slot_id_info_data                    = slot_id_fifo_io_pop_payload


`ALWAYS_FF(clk, rst_n)begin
    if(!rst_n) begin
        bitmap_reg_vld <= 1'b0;
        bitmap_seg_reg_vld <= 1'b0;
    end else begin
        if(shift_en) begin
            if(bitmap_end) begin
                bitmap_reg_vld <= 1'b0;
            end else begin
                bitmap_reg_vld <= bitmap_fifo_pop_valid;
            end
        end
        if(bitmap_seg_reg_vld) begin
            if(shift_en) begin
                bitmap_seg_reg_vld <= 1'b0;
            end
        end else begin
            bitmap_seg_reg_vld <= (bitmap_fifo_pop_valid && slot_id_fifo_io_push_ready);
        end
        if(shift_en) begin
            bitmap_seg_reg_vld <= 1'b0;
        end else begin
            bitmap_seg_reg_vld <= bitmap_fifo_pop_valid;
        end
    end
end

always @(posedge clk) begin
    if(slot_id_fifo_io_push_ready) begin
        bitmap_seg_reg <= bitmap_seg_next;
    end
    if(shift_en) begin
        bitmap_reg <= (bitmap_reg_vld ? tmp_bitmap_reg : tmp_bitmap_reg_1);
    end
    if(shift_en) begin
        if(bitmap_reg_vld) begin
            seg_start_id_reg <= (seg_start_id_reg + SEGMENT_WIDTH);
        end else begin
            seg_start_id_reg <= (bitmap_fifo_pop_payload.cur_sto_id_start + SEGMENT_WIDTH);
        end
    end
end

one_hot2bin #(
    .WIDTH(SEGMENT_WIDTH)
)u_one_hot2bin(
    .clk       (clk),
    .rst       (rst),
    .one_hot_in(low_1_one_hot),
    .bin_out   (low_1_index)
);



logic_sync_fifo  #(
    /*parameter */.DEPTH           (8),// = 2,     //FIFO深度,支持非2的n次方
    /*parameter */.WIDTH           (BITMAP_INFO_BITS),// = 32,    //FIFO数据宽度
    /*parameter */.MEM_TYPE        (),// = 0, //0：reg 1:1r1w ram
    /*parameter */.MEM_PROTECT_TYPE(),//= 0,//0:no_protect 1:parity 2:ecc
    /*parameter */.FWFT_EN         (),// = 1,  //0：nfwft_fifo 1:fwft_fifo
    /*parameter */.DELAY_CYCLES    (),// = 2, //nfwft模式的读延迟，外接mem的情况下，需要等于外接ram的读延迟。
    /*parameter */.BANK_DIV_WIDTH  (),//   = 502,//fifo位宽过大且需要做ecc时，按照多少位宽为粒度拆分为底层的ram
    /*parameter */.ALMOST_EMPTY_POS(),// = 1,     //将空拉高水线
    /*parameter */.ALMOST_EMPTY_NEG()// = 1,     //将空拉低水线
    // localparam FIFO_ADDR_W = clog2(DEPTH),
    // localparam FIFO_CNT_W  = clog2(DEPTH+1)
)u_bitmap_info_fifo_fifo(
    /*input  logic                  */.clk             (clk),
    /*input  logic                  */.rst_n           (rst_n),
    /*input  logic                  */.wr_en           (bitmap_in_valid),
    /*input  logic [WIDTH      -1:0]*/.wr_data         (bitmap_fifo_io_push_payload),
    /*output logic                  */.almost_full     (),
    /*output logic                  */.full            (bitmap_fifo_io_push_ready),
    /*output logic                  */.overflow        (),
    /*input  logic [FIFO_CNT_W -1:0]*/.cfg_aful_pos    (),//将满拉高水线
    /*input  logic [FIFO_CNT_W -1:0]*/.cfg_aful_neg    (),//将满拉低水线
    /*input  logic                  */.rd_en           (bitmap_fifo_pop_ready),
    /*output logic                  */.rd_data_vld     (),
    /*output logic [2          -1:0]*/.rd_data_err     (),//0:无错误 1:可纠正错误 2:不可纠正错误
    /*output logic [FIFO_ADDR_W-1:0]*/.rd_data_mem_addr(),
    /*output logic [WIDTH      -1:0]*/.rd_data         (bitmap_fifo_pop_payload),
    /*output logic                  */.almost_empty    (),
    /*output logic                  */.empty           (bitmap_info_fifo_pop_empty),
    /*output logic                  */.underflow       (),
    /*output logic [FIFO_CNT_W -1:0]*/.fifo_cnt        (),
    /*input  logic [2          -1:0]*/.inject_err      ()//bit1:csr_inject_double_err;bit0:csr_inject_signle_err
);


logic_sync_fifo  #(
    /*parameter */.DEPTH           (SEGMENT_WIDTH),// = 2,     //FIFO深度,支持非2的n次方
    /*parameter */.WIDTH           (SLOT_ID_BUF_BITS),// = 32,    //FIFO数据宽度
    /*parameter */.MEM_TYPE        (),// = 0, //0：reg 1:1r1w ram
    /*parameter */.MEM_PROTECT_TYPE(),//= 0,//0:no_protect 1:parity 2:ecc
    /*parameter */.FWFT_EN         (),// = 1,  //0：nfwft_fifo 1:fwft_fifo
    /*parameter */.DELAY_CYCLES    (),// = 2, //nfwft模式的读延迟，外接mem的情况下，需要等于外接ram的读延迟。
    /*parameter */.BANK_DIV_WIDTH  (),//   = 502,//fifo位宽过大且需要做ecc时，按照多少位宽为粒度拆分为底层的ram
    /*parameter */.ALMOST_EMPTY_POS(),// = 1,     //将空拉高水线
    /*parameter */.ALMOST_EMPTY_NEG()// = 1,     //将空拉低水线
    // localparam FIFO_ADDR_W = clog2(DEPTH),
    // localparam FIFO_CNT_W  = clog2(DEPTH+1)
)u_slot_id_fifo(
    /*input  logic                  */.clk             (clk),
    /*input  logic                  */.rst_n           (rst_n),
    /*input  logic                  */.wr_en           (bitmap_fifo_pop_valid),
    /*input  logic [WIDTH      -1:0]*/.wr_data         (slot_id_fifo_io_push_payload),
    /*output logic                  */.almost_full     (),
    /*output logic                  */.full            (slot_id_fifo_io_push_ready),
    /*output logic                  */.overflow        (),
    /*input  logic [FIFO_CNT_W -1:0]*/.cfg_aful_pos    (),//将满拉高水线
    /*input  logic [FIFO_CNT_W -1:0]*/.cfg_aful_neg    (),//将满拉低水线
    /*input  logic                  */.rd_en           (slot_id_info_ready),
    /*output logic                  */.rd_data_vld     (),
    /*output logic [2          -1:0]*/.rd_data_err     (),//0:无错误 1:可纠正错误 2:不可纠正错误
    /*output logic [FIFO_ADDR_W-1:0]*/.rd_data_mem_addr(),
    /*output logic [WIDTH      -1:0]*/.rd_data         (slot_id_fifo_io_pop_payload),
    /*output logic                  */.almost_empty    (slot_id_fifo_pop_empty),
    /*output logic                  */.empty           (),
    /*output logic                  */.underflow       (),
    /*output logic [FIFO_CNT_W -1:0]*/.fifo_cnt        (),
    /*input  logic [2          -1:0]*/.inject_err      ()//bit1:csr_inject_double_err;bit0:csr_inject_signle_err
);

endmodule
