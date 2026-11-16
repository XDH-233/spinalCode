module reg_cam #(
    parameter DATA_WIDTH = 32,
    parameter DATA_NUM = 8
)(
  input  logic                  query_valid,
  input  logic [DATA_WIDTH-1:0] query_payload,
  output logic                  query_exist,
  input  logic                  insert_valid,
  input  logic [DATA_WIDTH-1:0] insert_payload,
  output logic                  insert_success,
  input  logic                  clear_valid,
  input  logic [DATA_WIDTH-1:0] clear_payload,
  output logic                  clear_success,
  input  logic                  clk,
  input  logic                  rst_n
);

  logic [DATA_NUM-1:0]                 tmp_plus_one;
  logic [DATA_NUM-1:0][  DATA_WIDTH:0] regs;
  logic [DATA_NUM-1:0][DATA_WIDTH-1:0] entrs;
  logic [DATA_NUM-1:0]                 entrs_vld;
  logic [DATA_NUM-1:0]                 vlds_bits;
  logic [DATA_NUM-1:0]                 plus_one;
  logic [DATA_NUM-1:0]                 low_zero_one_hot;
  logic                                full;
  logic [DATA_NUM-1:0]                 qry_exist_exists;
  logic                                qry_exist_exist;
  logic [DATA_NUM-1:0]                 clr_exist_exists;
  logic                                clr_exist_exist;
  logic [DATA_NUM-1:0]                 insert_exist_exists;
  logic                                insert_exist_exist;
  logic                                tmp_query_exist;
  logic                                tmp_insert_success;
  logic                                tmp_clear_success;
  logic                                clear_query;
  logic                                insert_query;

  always_comb begin
    for(integer i = 0; i < DATA_NUM; i=i+1) begin
        vlds_bits [i]          = regs[i][0];
        qry_exist_exists[i]    = (regs[i][0] && !(|{regs[i][DATA_WIDTH : 1] ^ query_payload}));
        clr_exist_exists[i]    = (regs[i][0] && !(|{regs[i][DATA_WIDTH : 1] ^ clear_payload}));
        insert_exist_exists[i] = (regs[i][0] && !(|{regs[i][DATA_WIDTH : 1] ^ insert_payload}));
        entrs[i]               = regs[i][DATA_WIDTH : 1];
        entrs_vld[i]           = regs[i][0];
    end
  end

  assign tmp_plus_one       = (vlds_bits + 1'b1);
  assign plus_one           = tmp_plus_one;
  assign low_zero_one_hot   = ((plus_one ^ vlds_bits) & plus_one);
  assign full               = &vlds_bits;
  assign qry_exist_exist    = |qry_exist_exists;
  assign clr_exist_exist    = |insert_exist_exists;
  assign insert_exist_exist = |insert_exist_exists;
  assign query_exist        = tmp_query_exist;
  assign insert_success     = tmp_insert_success;
  assign clear_success      = tmp_clear_success;
  assign clear_query        = (clear_valid && query_valid && (clear_payload == query_payload));
  assign insert_query        = (insert_valid && query_valid && (insert_payload == query_payload));

always_ff @(posedge clk) begin
    if(!rst_n)begin
        tmp_query_exist <= 1'b0;
        tmp_insert_success <= 1'b0;
        tmp_clear_success <= 1'b0;
    end else begin
        tmp_query_exist <= (qry_exist_exist & ~clear_query) | (~qry_exist_exist & ~full & insert_query) && query_valid;
        tmp_insert_success <= ((insert_valid && (! full)) && (! insert_exist_exist));
        tmp_clear_success <= (clear_valid && clr_exist_exist);
    end

end

  always_ff @(posedge clk) begin
    for(integer i = 0; i < DATA_NUM; i=i+1)begin
        if(!rst_n)begin
            regs[i] <= {(DATA_WIDTH+1){1'b0}};
        end else begin
            if(((clear_valid && !(|{clear_payload ^ regs[i][DATA_WIDTH : 1]})) && regs[i][0])) begin
                regs[i] <= {regs[i][DATA_WIDTH : 1],1'b0};
            end else begin
                if((((insert_valid && (! full)) && low_zero_one_hot[i]) && (! insert_exist_exist))) begin
                    regs[i] <= {insert_payload,1'b1};
                end
            end
        end
    end
  end


endmodule
