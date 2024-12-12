module tb_avst_width_cov (
    input          clk                   ,
    input          rst                   ,
    output         avst_d_in_ready         ,
    input          avst_d_in_valid         ,
    input          avst_d_in_startofpacket ,
    input  [511:0] avst_d_in_data          ,
    input  [  5:0] avst_d_in_empty         ,
    input          avst_d_in_endofpacket   ,
    input  [127:0] avst_d_in_channel       ,
    
    output         avst_e_in_ready         ,
    input          avst_e_in_valid         ,
    input          avst_e_in_startofpacket ,
    input  [127:0] avst_e_in_data          ,
    input  [  3:0] avst_e_in_empty         ,
    input          avst_e_in_endofpacket   ,
    input  [127:0] avst_e_in_channel       ,

    input          avst_d_out_ready        ,
    output         avst_d_out_valid        ,
    output         avst_d_out_startofpacket,
    output [127:0] avst_d_out_data         ,
    output [  3:0] avst_d_out_empty        ,
    output         avst_d_out_endofpacket  ,
    output [127:0] avst_d_out_channel,

    input          avst_e_out_ready        ,
    output         avst_e_out_valid        ,
    output         avst_e_out_startofpacket,
    output [511:0] avst_e_out_data         ,
    output [  5:0] avst_e_out_empty        ,
    output         avst_e_out_endofpacket  ,
    output [127:0] avst_e_out_channel

);


//    reg  clk;
//
//    initial clk = 0;
//    always #5 clk = ~clk;

AvstCovtDemo u_AvstCovtDemo(
.avst_in_ready                        ( avst_d_in_ready         ),
.avst_in_valid                        ( avst_d_in_valid         ),
.avst_in_payload_data                 ( avst_d_in_data          ),
.avst_in_payload_channel              ( avst_d_in_channel       ),
.avst_in_payload_empty                ( avst_d_in_empty         ),
.avst_in_payload_eop                  ( avst_d_in_endofpacket   ),
.avst_in_payload_sop                  ( avst_d_in_startofpacket ),
.avst_e_in_ready                      ( avst_e_in_ready         ),
.avst_e_in_valid                      ( avst_e_in_valid         ),
.avst_e_in_payload_data               ( avst_e_in_data          ),
.avst_e_in_payload_channel            ( avst_e_in_channel       ),
.avst_e_in_payload_empty              ( avst_e_in_empty         ),
.avst_e_in_payload_eop                ( avst_e_in_endofpacket   ),
.avst_e_in_payload_sop                ( avst_e_in_startofpacket ),
.avst_in_divide_ret_ready             ( avst_d_out_ready        ),
.avst_in_divide_ret_valid             ( avst_d_out_valid        ),
.avst_in_divide_ret_payload_data      ( avst_d_out_data         ),
.avst_in_divide_ret_payload_channel   ( avst_d_out_channel      ),
.avst_in_divide_ret_payload_empty     ( avst_d_out_empty        ),
.avst_in_divide_ret_payload_eop       ( avst_d_out_endofpacket  ),
.avst_in_divide_ret_payload_sop       ( avst_d_out_startofpacket),
.avst_e_in_expand_ret_ready           ( avst_e_out_ready        ),
.avst_e_in_expand_ret_valid           ( avst_e_out_valid        ),
.avst_e_in_expand_ret_payload_data    ( avst_e_out_data         ),
.avst_e_in_expand_ret_payload_channel ( avst_e_out_channel      ),
.avst_e_in_expand_ret_payload_empty   ( avst_e_out_empty        ),
.avst_e_in_expand_ret_payload_eop     ( avst_e_out_endofpacket  ),
.avst_e_in_expand_ret_payload_sop     ( avst_e_out_startofpacket),
.clk                                  ( clk                     ),
.reset                                ( rst                     ));



endmodule
