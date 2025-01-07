// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : pcie_us_if_cq
// Git hash  : 8262f175767927df78ab12ab66532ce14c29d6d3
// 



module pcie_us_if_cq (
  input  wire          s_axis_cq_tvalid,
  output wire          s_axis_cq_tready,
  input  wire [511:0]  s_axis_cq_tdata,
  input  wire [15:0]   s_axis_cq_tkeep,
  input  wire          s_axis_cq_tlast,
  input  wire [182:0]  s_axis_cq_tuser,
  output wire          rx_req_tlp_0_valid,
  input  wire          rx_req_tlp_0_ready,
  output wire [511:0]  rx_req_tlp_0_data,
  output wire [16:0]   rx_req_tlp_0_strb,
  output wire [127:0]  rx_req_tlp_0_hdr,
  output wire [2:0]    rx_req_tlp_0_bar_id,
  output wire [7:0]    rx_req_tlp_0_func_num,
  output wire          rx_req_tlp_0_sop,
  output wire          rx_req_tlp_0_eop,
  input  wire          clk,
  input  wire          rst
);
  localparam anon2_FM_3DW = 3'd0;
  localparam anon2_FMT_4DW = 3'd1;
  localparam anon2_FMT_3DW_DATA = 3'd2;
  localparam anon2_FMT_4DW_DATA = 3'd3;
  localparam anon2_FMT_PREFIX = 3'd4;
  localparam anon1_REQ_MEM_READ = 4'd0;
  localparam anon1_REQ_MEM_WRITE = 4'd1;
  localparam anon1_REQ_IO_READ = 4'd2;
  localparam anon1_REQ_IO_WRITE = 4'd3;
  localparam anon1_REQ_MEM_FETCH_ADD = 4'd4;
  localparam anon1_REQ_MEM_SWAP = 4'd5;
  localparam anon1_REQ_MEM_CAS = 4'd6;
  localparam anon1_REQ_MEM_READ_LOCKED = 4'd7;
  localparam anon1_REQ_CFG_READ_0 = 4'd8;
  localparam anon1_REQ_CFG_READ_1 = 4'd9;
  localparam anon1_REQ_CFG_WRITE_0 = 4'd10;
  localparam anon1_REQ_CFG_WRITE_1 = 4'd11;
  localparam anon1_REQ_MSG = 4'd12;
  localparam anon1_REQ_MSG_VENDOR = 4'd13;
  localparam anon1_REQ_MSG_ATS = 4'd14;

  wire       [895:0]  tmp_rx_req_tlp_data_0;
  wire                tmp_when;
  wire       [3:0]    tmp_tmp_1;
  wire                tmp_when_1;
  wire       [639:0]  tmp_rx_req_tlp_data_1;
  wire                tmp_when_2;
  wire       [3:0]    tmp_tmp_3;
  wire                tmp_when_3;
  wire       [0:0]    tmp_valid;
  wire       [4:0]    tmp_valid_1;
  wire       [1:0]    tlp_hdr_0_ph;
  wire       [61:0]   tlp_hdr_0_address;
  wire       [3:0]    tlp_hdr_0_first_dw_be;
  wire       [3:0]    tlp_hdr_0_last_dw_be;
  wire       [7:0]    tlp_hdr_0_tag;
  wire       [15:0]   tlp_hdr_0_requested_id;
  wire       [9:0]    tlp_hdr_0_length;
  wire       [1:0]    tlp_hdr_0_at;
  wire       [1:0]    tlp_hdr_0_attr_l;
  wire       [0:0]    tlp_hdr_0_ep;
  wire       [0:0]    tlp_hdr_0_td;
  wire       [0:0]    tlp_hdr_0_th;
  wire       [0:0]    tlp_hdr_0_rsv2;
  wire       [0:0]    tlp_hdr_0_attr_h;
  wire       [0:0]    tlp_hdr_0_rsv1;
  wire       [2:0]    tlp_hdr_0_tc;
  wire       [0:0]    tlp_hdr_0_rsv0;
  reg        [4:0]    tlp_hdr_0_type_;
  reg        [2:0]    tlp_hdr_0_fmt;
  wire       [1:0]    tlp_hdr_1_ph;
  wire       [61:0]   tlp_hdr_1_address;
  wire       [3:0]    tlp_hdr_1_first_dw_be;
  wire       [3:0]    tlp_hdr_1_last_dw_be;
  wire       [7:0]    tlp_hdr_1_tag;
  wire       [15:0]   tlp_hdr_1_requested_id;
  wire       [9:0]    tlp_hdr_1_length;
  wire       [1:0]    tlp_hdr_1_at;
  wire       [1:0]    tlp_hdr_1_attr_l;
  wire       [0:0]    tlp_hdr_1_ep;
  wire       [0:0]    tlp_hdr_1_td;
  wire       [0:0]    tlp_hdr_1_th;
  wire       [0:0]    tlp_hdr_1_rsv2;
  wire       [0:0]    tlp_hdr_1_attr_h;
  wire       [0:0]    tlp_hdr_1_rsv1;
  wire       [2:0]    tlp_hdr_1_tc;
  wire       [0:0]    tlp_hdr_1_rsv0;
  reg        [4:0]    tlp_hdr_1_type_;
  reg        [2:0]    tlp_hdr_1_fmt;
  wire       [2:0]    tlp_bar_id_0;
  wire       [2:0]    tlp_bar_id_1;
  wire       [7:0]    tlp_func_num_0;
  wire       [7:0]    tlp_func_num_1;
  wire       [7:0]    axis_cq_users_0_first_be;
  wire       [7:0]    axis_cq_users_0_last_be;
  wire       [63:0]   axis_cq_users_0_byte_en;
  wire       [1:0]    axis_cq_users_0_is_sop;
  wire       [1:0]    axis_cq_users_0_is_sop_ptr_0;
  wire       [1:0]    axis_cq_users_0_is_sop_ptr_1;
  wire       [1:0]    axis_cq_users_0_is_eop;
  wire       [3:0]    axis_cq_users_0_is_eop_ptr_0;
  wire       [3:0]    axis_cq_users_0_is_eop_ptr_1;
  wire                axis_cq_users_0_discontinue;
  wire       [1:0]    axis_cq_users_0_tph_present;
  wire       [3:0]    axis_cq_users_0_tph_type;
  wire       [15:0]   axis_cq_users_0_tph_st_tag;
  wire       [63:0]   axis_cq_users_0_parity;
  wire       [7:0]    axis_cq_users_1_first_be;
  wire       [7:0]    axis_cq_users_1_last_be;
  wire       [63:0]   axis_cq_users_1_byte_en;
  wire       [1:0]    axis_cq_users_1_is_sop;
  wire       [1:0]    axis_cq_users_1_is_sop_ptr_0;
  wire       [1:0]    axis_cq_users_1_is_sop_ptr_1;
  wire       [1:0]    axis_cq_users_1_is_eop;
  wire       [3:0]    axis_cq_users_1_is_eop_ptr_0;
  wire       [3:0]    axis_cq_users_1_is_eop_ptr_1;
  wire                axis_cq_users_1_discontinue;
  wire       [1:0]    axis_cq_users_1_tph_present;
  wire       [3:0]    axis_cq_users_1_tph_type;
  wire       [15:0]   axis_cq_users_1_tph_st_tag;
  wire       [63:0]   axis_cq_users_1_parity;
  wire                s_axis_cq_fire;
  reg        [511:0]  cq_data_int_reg;
  wire       [1023:0] cq_data_full;
  wire       [15:0]   cq_strb;
  reg        [15:0]   cq_strb_reg;
  wire       [31:0]   cq_strb_full;
  wire                valid;
  reg                 cq_strb_sop_0;
  reg                 cq_strb_sop_1;
  reg                 cq_strb_sop_2;
  reg                 cq_strb_sop_3;
  reg                 cq_strb_sop_4;
  reg                 cq_strb_sop_5;
  reg                 cq_strb_sop_6;
  reg                 cq_strb_sop_7;
  reg                 cq_strb_sop_8;
  reg                 cq_strb_sop_9;
  reg                 cq_strb_sop_10;
  reg                 cq_strb_sop_11;
  reg                 cq_strb_sop_12;
  reg                 cq_strb_sop_13;
  reg                 cq_strb_sop_14;
  reg                 cq_strb_sop_15;
  reg                 cq_strb_eop_0;
  reg                 cq_strb_eop_1;
  reg                 cq_strb_eop_2;
  reg                 cq_strb_eop_3;
  reg                 cq_strb_eop_4;
  reg                 cq_strb_eop_5;
  reg                 cq_strb_eop_6;
  reg                 cq_strb_eop_7;
  reg                 cq_strb_eop_8;
  reg                 cq_strb_eop_9;
  reg                 cq_strb_eop_10;
  reg                 cq_strb_eop_11;
  reg                 cq_strb_eop_12;
  reg                 cq_strb_eop_13;
  reg                 cq_strb_eop_14;
  reg                 cq_strb_eop_15;
  wire                cq_sop_0;
  wire                cq_sop_1;
  wire                cq_eop_0;
  wire                cq_eop_1;
  reg        [1:0]    cq_valid;
  wire       [255:0]  rx_req_tlp_data_0;
  wire       [255:0]  rx_req_tlp_data_1;
  wire       [7:0]    rx_req_tlp_strb_0;
  wire       [7:0]    rx_req_tlp_strb_1;
  wire       [1:0]    rx_req_tlp_valid_reg;
  wire       [3:0]    paser_header_0_cq_data_fmt;
  wire       [1:0]    paser_header_0_axis_cq_tlp_desctr_address_type;
  wire       [61:0]   paser_header_0_axis_cq_tlp_desctr_address;
  wire       [10:0]   paser_header_0_axis_cq_tlp_desctr_dword_count;
  wire       [3:0]    paser_header_0_axis_cq_tlp_desctr_request_type;
  wire       [0:0]    paser_header_0_axis_cq_tlp_desctr_rsv0;
  wire       [15:0]   paser_header_0_axis_cq_tlp_desctr_requester_id;
  wire       [7:0]    paser_header_0_axis_cq_tlp_desctr_tag;
  wire       [7:0]    paser_header_0_axis_cq_tlp_desctr_target_function;
  wire       [2:0]    paser_header_0_axis_cq_tlp_desctr_bar_id;
  wire       [5:0]    paser_header_0_axis_cq_tlp_desctr_bar_aperture;
  wire       [2:0]    paser_header_0_axis_cq_tlp_desctr_tc;
  wire       [2:0]    paser_header_0_axis_cq_tlp_desctr_attr;
  wire       [0:0]    paser_header_0_axis_cq_tlp_desctr_rsv1;
  wire       [3:0]    tmp_paser_header_0_cq_data_fmt;
  wire       [127:0]  tmp_paser_header_0_axis_cq_tlp_desctr_address_type;
  wire       [3:0]    paser_header_1_cq_data_fmt;
  wire       [1:0]    paser_header_1_axis_cq_tlp_desctr_address_type;
  wire       [61:0]   paser_header_1_axis_cq_tlp_desctr_address;
  wire       [10:0]   paser_header_1_axis_cq_tlp_desctr_dword_count;
  wire       [3:0]    paser_header_1_axis_cq_tlp_desctr_request_type;
  wire       [0:0]    paser_header_1_axis_cq_tlp_desctr_rsv0;
  wire       [15:0]   paser_header_1_axis_cq_tlp_desctr_requester_id;
  wire       [7:0]    paser_header_1_axis_cq_tlp_desctr_tag;
  wire       [7:0]    paser_header_1_axis_cq_tlp_desctr_target_function;
  wire       [2:0]    paser_header_1_axis_cq_tlp_desctr_bar_id;
  wire       [5:0]    paser_header_1_axis_cq_tlp_desctr_bar_aperture;
  wire       [2:0]    paser_header_1_axis_cq_tlp_desctr_tc;
  wire       [2:0]    paser_header_1_axis_cq_tlp_desctr_attr;
  wire       [0:0]    paser_header_1_axis_cq_tlp_desctr_rsv1;
  wire       [3:0]    tmp_paser_header_1_cq_data_fmt;
  wire       [127:0]  tmp_paser_header_1_axis_cq_tlp_desctr_address_type;
  wire       [3:0]    tmp_axis_cq_users_0_is_sop_ptr_0;
  wire       [7:0]    tmp_axis_cq_users_0_is_eop_ptr_0;
  reg        [182:0]  s_axis_cq_tuser_regNextWhen;
  wire       [3:0]    tmp_axis_cq_users_1_is_sop_ptr_0;
  wire       [7:0]    tmp_axis_cq_users_1_is_eop_ptr_0;
  wire       [15:0]   tmp_1;
  wire       [15:0]   tmp_2;
  wire       [15:0]   tmp_3;
  wire       [15:0]   tmp_4;
  wire       [669:0]  tmp_rx_req_tlp_0_data;
  `ifndef SYNTHESIS
  reg [95:0] tlp_hdr_0_fmt_string;
  reg [95:0] tlp_hdr_1_fmt_string;
  reg [151:0] paser_header_0_cq_data_fmt_string;
  reg [151:0] tmp_paser_header_0_cq_data_fmt_string;
  reg [151:0] paser_header_1_cq_data_fmt_string;
  reg [151:0] tmp_paser_header_1_cq_data_fmt_string;
  `endif


  assign tmp_when = axis_cq_users_0_is_sop[0];
  assign tmp_when_2 = axis_cq_users_0_is_sop[1];
  assign tmp_when_1 = axis_cq_users_0_is_eop[0];
  assign tmp_when_3 = axis_cq_users_0_is_eop[1];
  assign tmp_rx_req_tlp_data_0 = (cq_data_full >>> 8'd128);
  assign tmp_tmp_1 = ({2'd0,axis_cq_users_0_is_sop_ptr_0} <<< 2'd2);
  assign tmp_rx_req_tlp_data_1 = (cq_data_full >>> 9'd384);
  assign tmp_tmp_3 = ({2'd0,axis_cq_users_0_is_sop_ptr_1} <<< 2'd2);
  assign tmp_valid = cq_strb_sop_5;
  assign tmp_valid_1 = {cq_strb_sop_4,{cq_strb_sop_3,{cq_strb_sop_2,{cq_strb_sop_1,cq_strb_sop_0}}}};
  `ifndef SYNTHESIS
  always @(*) begin
    case(tlp_hdr_0_fmt)
      anon2_FM_3DW : tlp_hdr_0_fmt_string = "FM_3DW      ";
      anon2_FMT_4DW : tlp_hdr_0_fmt_string = "FMT_4DW     ";
      anon2_FMT_3DW_DATA : tlp_hdr_0_fmt_string = "FMT_3DW_DATA";
      anon2_FMT_4DW_DATA : tlp_hdr_0_fmt_string = "FMT_4DW_DATA";
      anon2_FMT_PREFIX : tlp_hdr_0_fmt_string = "FMT_PREFIX  ";
      default : tlp_hdr_0_fmt_string = "????????????";
    endcase
  end
  always @(*) begin
    case(tlp_hdr_1_fmt)
      anon2_FM_3DW : tlp_hdr_1_fmt_string = "FM_3DW      ";
      anon2_FMT_4DW : tlp_hdr_1_fmt_string = "FMT_4DW     ";
      anon2_FMT_3DW_DATA : tlp_hdr_1_fmt_string = "FMT_3DW_DATA";
      anon2_FMT_4DW_DATA : tlp_hdr_1_fmt_string = "FMT_4DW_DATA";
      anon2_FMT_PREFIX : tlp_hdr_1_fmt_string = "FMT_PREFIX  ";
      default : tlp_hdr_1_fmt_string = "????????????";
    endcase
  end
  always @(*) begin
    case(paser_header_0_cq_data_fmt)
      anon1_REQ_MEM_READ : paser_header_0_cq_data_fmt_string = "REQ_MEM_READ       ";
      anon1_REQ_MEM_WRITE : paser_header_0_cq_data_fmt_string = "REQ_MEM_WRITE      ";
      anon1_REQ_IO_READ : paser_header_0_cq_data_fmt_string = "REQ_IO_READ        ";
      anon1_REQ_IO_WRITE : paser_header_0_cq_data_fmt_string = "REQ_IO_WRITE       ";
      anon1_REQ_MEM_FETCH_ADD : paser_header_0_cq_data_fmt_string = "REQ_MEM_FETCH_ADD  ";
      anon1_REQ_MEM_SWAP : paser_header_0_cq_data_fmt_string = "REQ_MEM_SWAP       ";
      anon1_REQ_MEM_CAS : paser_header_0_cq_data_fmt_string = "REQ_MEM_CAS        ";
      anon1_REQ_MEM_READ_LOCKED : paser_header_0_cq_data_fmt_string = "REQ_MEM_READ_LOCKED";
      anon1_REQ_CFG_READ_0 : paser_header_0_cq_data_fmt_string = "REQ_CFG_READ_0     ";
      anon1_REQ_CFG_READ_1 : paser_header_0_cq_data_fmt_string = "REQ_CFG_READ_1     ";
      anon1_REQ_CFG_WRITE_0 : paser_header_0_cq_data_fmt_string = "REQ_CFG_WRITE_0    ";
      anon1_REQ_CFG_WRITE_1 : paser_header_0_cq_data_fmt_string = "REQ_CFG_WRITE_1    ";
      anon1_REQ_MSG : paser_header_0_cq_data_fmt_string = "REQ_MSG            ";
      anon1_REQ_MSG_VENDOR : paser_header_0_cq_data_fmt_string = "REQ_MSG_VENDOR     ";
      anon1_REQ_MSG_ATS : paser_header_0_cq_data_fmt_string = "REQ_MSG_ATS        ";
      default : paser_header_0_cq_data_fmt_string = "???????????????????";
    endcase
  end
  always @(*) begin
    case(tmp_paser_header_0_cq_data_fmt)
      anon1_REQ_MEM_READ : tmp_paser_header_0_cq_data_fmt_string = "REQ_MEM_READ       ";
      anon1_REQ_MEM_WRITE : tmp_paser_header_0_cq_data_fmt_string = "REQ_MEM_WRITE      ";
      anon1_REQ_IO_READ : tmp_paser_header_0_cq_data_fmt_string = "REQ_IO_READ        ";
      anon1_REQ_IO_WRITE : tmp_paser_header_0_cq_data_fmt_string = "REQ_IO_WRITE       ";
      anon1_REQ_MEM_FETCH_ADD : tmp_paser_header_0_cq_data_fmt_string = "REQ_MEM_FETCH_ADD  ";
      anon1_REQ_MEM_SWAP : tmp_paser_header_0_cq_data_fmt_string = "REQ_MEM_SWAP       ";
      anon1_REQ_MEM_CAS : tmp_paser_header_0_cq_data_fmt_string = "REQ_MEM_CAS        ";
      anon1_REQ_MEM_READ_LOCKED : tmp_paser_header_0_cq_data_fmt_string = "REQ_MEM_READ_LOCKED";
      anon1_REQ_CFG_READ_0 : tmp_paser_header_0_cq_data_fmt_string = "REQ_CFG_READ_0     ";
      anon1_REQ_CFG_READ_1 : tmp_paser_header_0_cq_data_fmt_string = "REQ_CFG_READ_1     ";
      anon1_REQ_CFG_WRITE_0 : tmp_paser_header_0_cq_data_fmt_string = "REQ_CFG_WRITE_0    ";
      anon1_REQ_CFG_WRITE_1 : tmp_paser_header_0_cq_data_fmt_string = "REQ_CFG_WRITE_1    ";
      anon1_REQ_MSG : tmp_paser_header_0_cq_data_fmt_string = "REQ_MSG            ";
      anon1_REQ_MSG_VENDOR : tmp_paser_header_0_cq_data_fmt_string = "REQ_MSG_VENDOR     ";
      anon1_REQ_MSG_ATS : tmp_paser_header_0_cq_data_fmt_string = "REQ_MSG_ATS        ";
      default : tmp_paser_header_0_cq_data_fmt_string = "???????????????????";
    endcase
  end
  always @(*) begin
    case(paser_header_1_cq_data_fmt)
      anon1_REQ_MEM_READ : paser_header_1_cq_data_fmt_string = "REQ_MEM_READ       ";
      anon1_REQ_MEM_WRITE : paser_header_1_cq_data_fmt_string = "REQ_MEM_WRITE      ";
      anon1_REQ_IO_READ : paser_header_1_cq_data_fmt_string = "REQ_IO_READ        ";
      anon1_REQ_IO_WRITE : paser_header_1_cq_data_fmt_string = "REQ_IO_WRITE       ";
      anon1_REQ_MEM_FETCH_ADD : paser_header_1_cq_data_fmt_string = "REQ_MEM_FETCH_ADD  ";
      anon1_REQ_MEM_SWAP : paser_header_1_cq_data_fmt_string = "REQ_MEM_SWAP       ";
      anon1_REQ_MEM_CAS : paser_header_1_cq_data_fmt_string = "REQ_MEM_CAS        ";
      anon1_REQ_MEM_READ_LOCKED : paser_header_1_cq_data_fmt_string = "REQ_MEM_READ_LOCKED";
      anon1_REQ_CFG_READ_0 : paser_header_1_cq_data_fmt_string = "REQ_CFG_READ_0     ";
      anon1_REQ_CFG_READ_1 : paser_header_1_cq_data_fmt_string = "REQ_CFG_READ_1     ";
      anon1_REQ_CFG_WRITE_0 : paser_header_1_cq_data_fmt_string = "REQ_CFG_WRITE_0    ";
      anon1_REQ_CFG_WRITE_1 : paser_header_1_cq_data_fmt_string = "REQ_CFG_WRITE_1    ";
      anon1_REQ_MSG : paser_header_1_cq_data_fmt_string = "REQ_MSG            ";
      anon1_REQ_MSG_VENDOR : paser_header_1_cq_data_fmt_string = "REQ_MSG_VENDOR     ";
      anon1_REQ_MSG_ATS : paser_header_1_cq_data_fmt_string = "REQ_MSG_ATS        ";
      default : paser_header_1_cq_data_fmt_string = "???????????????????";
    endcase
  end
  always @(*) begin
    case(tmp_paser_header_1_cq_data_fmt)
      anon1_REQ_MEM_READ : tmp_paser_header_1_cq_data_fmt_string = "REQ_MEM_READ       ";
      anon1_REQ_MEM_WRITE : tmp_paser_header_1_cq_data_fmt_string = "REQ_MEM_WRITE      ";
      anon1_REQ_IO_READ : tmp_paser_header_1_cq_data_fmt_string = "REQ_IO_READ        ";
      anon1_REQ_IO_WRITE : tmp_paser_header_1_cq_data_fmt_string = "REQ_IO_WRITE       ";
      anon1_REQ_MEM_FETCH_ADD : tmp_paser_header_1_cq_data_fmt_string = "REQ_MEM_FETCH_ADD  ";
      anon1_REQ_MEM_SWAP : tmp_paser_header_1_cq_data_fmt_string = "REQ_MEM_SWAP       ";
      anon1_REQ_MEM_CAS : tmp_paser_header_1_cq_data_fmt_string = "REQ_MEM_CAS        ";
      anon1_REQ_MEM_READ_LOCKED : tmp_paser_header_1_cq_data_fmt_string = "REQ_MEM_READ_LOCKED";
      anon1_REQ_CFG_READ_0 : tmp_paser_header_1_cq_data_fmt_string = "REQ_CFG_READ_0     ";
      anon1_REQ_CFG_READ_1 : tmp_paser_header_1_cq_data_fmt_string = "REQ_CFG_READ_1     ";
      anon1_REQ_CFG_WRITE_0 : tmp_paser_header_1_cq_data_fmt_string = "REQ_CFG_WRITE_0    ";
      anon1_REQ_CFG_WRITE_1 : tmp_paser_header_1_cq_data_fmt_string = "REQ_CFG_WRITE_1    ";
      anon1_REQ_MSG : tmp_paser_header_1_cq_data_fmt_string = "REQ_MSG            ";
      anon1_REQ_MSG_VENDOR : tmp_paser_header_1_cq_data_fmt_string = "REQ_MSG_VENDOR     ";
      anon1_REQ_MSG_ATS : tmp_paser_header_1_cq_data_fmt_string = "REQ_MSG_ATS        ";
      default : tmp_paser_header_1_cq_data_fmt_string = "???????????????????";
    endcase
  end
  `endif

  assign s_axis_cq_fire = (s_axis_cq_tvalid && s_axis_cq_tready); // @ BaseType.scala l305
  assign cq_data_full = {s_axis_cq_tdata,cq_data_int_reg}; // @ BaseType.scala l299
  assign cq_strb_full = {cq_strb,cq_strb_reg}; // @ BaseType.scala l299
  assign tmp_paser_header_0_cq_data_fmt = cq_data_full[78 : 75]; // @ Enum.scala l189
  assign paser_header_0_cq_data_fmt = tmp_paser_header_0_cq_data_fmt; // @ Enum.scala l191
  assign tmp_paser_header_0_axis_cq_tlp_desctr_address_type = cq_data_full[127 : 0]; // @ BaseType.scala l299
  assign paser_header_0_axis_cq_tlp_desctr_address_type = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[1 : 0]; // @ Bits.scala l133
  assign paser_header_0_axis_cq_tlp_desctr_address = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[63 : 2]; // @ Bits.scala l133
  assign paser_header_0_axis_cq_tlp_desctr_dword_count = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[74 : 64]; // @ UInt.scala l381
  assign paser_header_0_axis_cq_tlp_desctr_request_type = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[78 : 75]; // @ Bits.scala l133
  assign paser_header_0_axis_cq_tlp_desctr_rsv0 = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[79 : 79]; // @ Bits.scala l133
  assign paser_header_0_axis_cq_tlp_desctr_requester_id = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[95 : 80]; // @ UInt.scala l381
  assign paser_header_0_axis_cq_tlp_desctr_tag = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[103 : 96]; // @ Bits.scala l133
  assign paser_header_0_axis_cq_tlp_desctr_target_function = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[111 : 104]; // @ UInt.scala l381
  assign paser_header_0_axis_cq_tlp_desctr_bar_id = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[114 : 112]; // @ UInt.scala l381
  assign paser_header_0_axis_cq_tlp_desctr_bar_aperture = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[120 : 115]; // @ Bits.scala l133
  assign paser_header_0_axis_cq_tlp_desctr_tc = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[123 : 121]; // @ Bits.scala l133
  assign paser_header_0_axis_cq_tlp_desctr_attr = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[126 : 124]; // @ Bits.scala l133
  assign paser_header_0_axis_cq_tlp_desctr_rsv1 = tmp_paser_header_0_axis_cq_tlp_desctr_address_type[127 : 127]; // @ Bits.scala l133
  always @(*) begin
    case(paser_header_0_cq_data_fmt)
      anon1_REQ_MEM_READ : begin
        tlp_hdr_0_fmt = anon2_FMT_4DW; // @ Enum.scala l151
      end
      anon1_REQ_MEM_WRITE : begin
        tlp_hdr_0_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
      end
      anon1_REQ_IO_READ : begin
        tlp_hdr_0_fmt = anon2_FMT_4DW; // @ Enum.scala l151
      end
      anon1_REQ_IO_WRITE : begin
        tlp_hdr_0_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
      end
      anon1_REQ_MEM_FETCH_ADD : begin
        tlp_hdr_0_fmt = anon2_FMT_4DW; // @ Enum.scala l151
      end
      anon1_REQ_MEM_SWAP : begin
        tlp_hdr_0_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
      end
      anon1_REQ_MEM_CAS : begin
        tlp_hdr_0_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
      end
      anon1_REQ_MEM_READ_LOCKED : begin
        tlp_hdr_0_fmt = anon2_FMT_4DW; // @ Enum.scala l151
      end
      anon1_REQ_MSG : begin
        if((|paser_header_0_axis_cq_tlp_desctr_dword_count)) begin
          tlp_hdr_0_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
        end else begin
          tlp_hdr_0_fmt = anon2_FMT_4DW; // @ Enum.scala l151
        end
      end
      anon1_REQ_MSG_VENDOR : begin
        if((|paser_header_0_axis_cq_tlp_desctr_dword_count)) begin
          tlp_hdr_0_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
        end else begin
          tlp_hdr_0_fmt = anon2_FMT_4DW; // @ Enum.scala l151
        end
      end
      anon1_REQ_MSG_ATS : begin
        if((|paser_header_0_axis_cq_tlp_desctr_dword_count)) begin
          tlp_hdr_0_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
        end else begin
          tlp_hdr_0_fmt = anon2_FMT_4DW; // @ Enum.scala l151
        end
      end
      default : begin
        tlp_hdr_0_fmt = anon2_FMT_4DW; // @ Enum.scala l151
      end
    endcase
  end

  always @(*) begin
    case(paser_header_0_cq_data_fmt)
      anon1_REQ_MEM_READ : begin
        tlp_hdr_0_type_ = 5'h0; // @ pcie_us_if_cq.scala l55
      end
      anon1_REQ_MEM_WRITE : begin
        tlp_hdr_0_type_ = 5'h0; // @ pcie_us_if_cq.scala l59
      end
      anon1_REQ_IO_READ : begin
        tlp_hdr_0_type_ = 5'h02; // @ pcie_us_if_cq.scala l63
      end
      anon1_REQ_IO_WRITE : begin
        tlp_hdr_0_type_ = 5'h02; // @ pcie_us_if_cq.scala l67
      end
      anon1_REQ_MEM_FETCH_ADD : begin
        tlp_hdr_0_type_ = 5'h0c; // @ pcie_us_if_cq.scala l71
      end
      anon1_REQ_MEM_SWAP : begin
        tlp_hdr_0_type_ = 5'h0d; // @ pcie_us_if_cq.scala l75
      end
      anon1_REQ_MEM_CAS : begin
        tlp_hdr_0_type_ = 5'h0e; // @ pcie_us_if_cq.scala l79
      end
      anon1_REQ_MEM_READ_LOCKED : begin
        tlp_hdr_0_type_ = 5'h01; // @ pcie_us_if_cq.scala l83
      end
      anon1_REQ_MSG : begin
        tlp_hdr_0_type_ = {2'b10,paser_header_0_axis_cq_tlp_desctr_bar_id}; // @ pcie_us_if_cq.scala l91
      end
      anon1_REQ_MSG_VENDOR : begin
        tlp_hdr_0_type_ = {2'b10,paser_header_0_axis_cq_tlp_desctr_bar_id}; // @ pcie_us_if_cq.scala l99
      end
      anon1_REQ_MSG_ATS : begin
        tlp_hdr_0_type_ = {2'b10,paser_header_0_axis_cq_tlp_desctr_bar_id}; // @ pcie_us_if_cq.scala l107
      end
      default : begin
        tlp_hdr_0_type_ = 5'h0; // @ pcie_us_if_cq.scala l111
      end
    endcase
  end

  assign tlp_hdr_0_rsv0 = 1'b0; // @ pcie_us_if_cq.scala l114
  assign tlp_hdr_0_tc = paser_header_0_axis_cq_tlp_desctr_tc; // @ pcie_us_if_cq.scala l115
  assign tlp_hdr_0_rsv1 = 1'b0; // @ pcie_us_if_cq.scala l116
  assign tlp_hdr_0_attr_h = paser_header_0_axis_cq_tlp_desctr_attr[2]; // @ pcie_us_if_cq.scala l117
  assign tlp_hdr_0_rsv2 = 1'b0; // @ pcie_us_if_cq.scala l118
  assign tlp_hdr_0_th = 1'b0; // @ pcie_us_if_cq.scala l119
  assign tlp_hdr_0_td = 1'b0; // @ pcie_us_if_cq.scala l120
  assign tlp_hdr_0_ep = 1'b0; // @ pcie_us_if_cq.scala l121
  assign tlp_hdr_0_attr_l = paser_header_0_axis_cq_tlp_desctr_attr[1 : 0]; // @ pcie_us_if_cq.scala l122
  assign tlp_hdr_0_at = paser_header_0_axis_cq_tlp_desctr_address_type; // @ pcie_us_if_cq.scala l123
  assign tlp_hdr_0_length = paser_header_0_axis_cq_tlp_desctr_dword_count[9:0]; // @ pcie_us_if_cq.scala l124
  assign tlp_hdr_0_last_dw_be = axis_cq_users_0_first_be[7 : 4]; // @ pcie_us_if_cq.scala l125
  assign tlp_hdr_0_first_dw_be = axis_cq_users_0_first_be[3 : 0]; // @ pcie_us_if_cq.scala l126
  assign tlp_hdr_0_address = paser_header_0_axis_cq_tlp_desctr_address; // @ pcie_us_if_cq.scala l127
  assign tlp_hdr_0_ph = 2'b00; // @ pcie_us_if_cq.scala l128
  assign tlp_bar_id_0 = paser_header_0_axis_cq_tlp_desctr_bar_id; // @ pcie_us_if_cq.scala l130
  assign tlp_func_num_0 = paser_header_0_axis_cq_tlp_desctr_target_function; // @ pcie_us_if_cq.scala l131
  assign tmp_paser_header_1_cq_data_fmt = cq_data_full[334 : 331]; // @ Enum.scala l189
  assign paser_header_1_cq_data_fmt = tmp_paser_header_1_cq_data_fmt; // @ Enum.scala l191
  assign tmp_paser_header_1_axis_cq_tlp_desctr_address_type = cq_data_full[383 : 256]; // @ BaseType.scala l299
  assign paser_header_1_axis_cq_tlp_desctr_address_type = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[1 : 0]; // @ Bits.scala l133
  assign paser_header_1_axis_cq_tlp_desctr_address = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[63 : 2]; // @ Bits.scala l133
  assign paser_header_1_axis_cq_tlp_desctr_dword_count = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[74 : 64]; // @ UInt.scala l381
  assign paser_header_1_axis_cq_tlp_desctr_request_type = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[78 : 75]; // @ Bits.scala l133
  assign paser_header_1_axis_cq_tlp_desctr_rsv0 = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[79 : 79]; // @ Bits.scala l133
  assign paser_header_1_axis_cq_tlp_desctr_requester_id = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[95 : 80]; // @ UInt.scala l381
  assign paser_header_1_axis_cq_tlp_desctr_tag = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[103 : 96]; // @ Bits.scala l133
  assign paser_header_1_axis_cq_tlp_desctr_target_function = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[111 : 104]; // @ UInt.scala l381
  assign paser_header_1_axis_cq_tlp_desctr_bar_id = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[114 : 112]; // @ UInt.scala l381
  assign paser_header_1_axis_cq_tlp_desctr_bar_aperture = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[120 : 115]; // @ Bits.scala l133
  assign paser_header_1_axis_cq_tlp_desctr_tc = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[123 : 121]; // @ Bits.scala l133
  assign paser_header_1_axis_cq_tlp_desctr_attr = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[126 : 124]; // @ Bits.scala l133
  assign paser_header_1_axis_cq_tlp_desctr_rsv1 = tmp_paser_header_1_axis_cq_tlp_desctr_address_type[127 : 127]; // @ Bits.scala l133
  always @(*) begin
    case(paser_header_1_cq_data_fmt)
      anon1_REQ_MEM_READ : begin
        tlp_hdr_1_fmt = anon2_FMT_4DW; // @ Enum.scala l151
      end
      anon1_REQ_MEM_WRITE : begin
        tlp_hdr_1_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
      end
      anon1_REQ_IO_READ : begin
        tlp_hdr_1_fmt = anon2_FMT_4DW; // @ Enum.scala l151
      end
      anon1_REQ_IO_WRITE : begin
        tlp_hdr_1_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
      end
      anon1_REQ_MEM_FETCH_ADD : begin
        tlp_hdr_1_fmt = anon2_FMT_4DW; // @ Enum.scala l151
      end
      anon1_REQ_MEM_SWAP : begin
        tlp_hdr_1_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
      end
      anon1_REQ_MEM_CAS : begin
        tlp_hdr_1_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
      end
      anon1_REQ_MEM_READ_LOCKED : begin
        tlp_hdr_1_fmt = anon2_FMT_4DW; // @ Enum.scala l151
      end
      anon1_REQ_MSG : begin
        if((|paser_header_1_axis_cq_tlp_desctr_dword_count)) begin
          tlp_hdr_1_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
        end else begin
          tlp_hdr_1_fmt = anon2_FMT_4DW; // @ Enum.scala l151
        end
      end
      anon1_REQ_MSG_VENDOR : begin
        if((|paser_header_1_axis_cq_tlp_desctr_dword_count)) begin
          tlp_hdr_1_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
        end else begin
          tlp_hdr_1_fmt = anon2_FMT_4DW; // @ Enum.scala l151
        end
      end
      anon1_REQ_MSG_ATS : begin
        if((|paser_header_1_axis_cq_tlp_desctr_dword_count)) begin
          tlp_hdr_1_fmt = anon2_FMT_4DW_DATA; // @ Enum.scala l151
        end else begin
          tlp_hdr_1_fmt = anon2_FMT_4DW; // @ Enum.scala l151
        end
      end
      default : begin
        tlp_hdr_1_fmt = anon2_FMT_4DW; // @ Enum.scala l151
      end
    endcase
  end

  always @(*) begin
    case(paser_header_1_cq_data_fmt)
      anon1_REQ_MEM_READ : begin
        tlp_hdr_1_type_ = 5'h0; // @ pcie_us_if_cq.scala l55
      end
      anon1_REQ_MEM_WRITE : begin
        tlp_hdr_1_type_ = 5'h0; // @ pcie_us_if_cq.scala l59
      end
      anon1_REQ_IO_READ : begin
        tlp_hdr_1_type_ = 5'h02; // @ pcie_us_if_cq.scala l63
      end
      anon1_REQ_IO_WRITE : begin
        tlp_hdr_1_type_ = 5'h02; // @ pcie_us_if_cq.scala l67
      end
      anon1_REQ_MEM_FETCH_ADD : begin
        tlp_hdr_1_type_ = 5'h0c; // @ pcie_us_if_cq.scala l71
      end
      anon1_REQ_MEM_SWAP : begin
        tlp_hdr_1_type_ = 5'h0d; // @ pcie_us_if_cq.scala l75
      end
      anon1_REQ_MEM_CAS : begin
        tlp_hdr_1_type_ = 5'h0e; // @ pcie_us_if_cq.scala l79
      end
      anon1_REQ_MEM_READ_LOCKED : begin
        tlp_hdr_1_type_ = 5'h01; // @ pcie_us_if_cq.scala l83
      end
      anon1_REQ_MSG : begin
        tlp_hdr_1_type_ = {2'b10,paser_header_1_axis_cq_tlp_desctr_bar_id}; // @ pcie_us_if_cq.scala l91
      end
      anon1_REQ_MSG_VENDOR : begin
        tlp_hdr_1_type_ = {2'b10,paser_header_1_axis_cq_tlp_desctr_bar_id}; // @ pcie_us_if_cq.scala l99
      end
      anon1_REQ_MSG_ATS : begin
        tlp_hdr_1_type_ = {2'b10,paser_header_1_axis_cq_tlp_desctr_bar_id}; // @ pcie_us_if_cq.scala l107
      end
      default : begin
        tlp_hdr_1_type_ = 5'h0; // @ pcie_us_if_cq.scala l111
      end
    endcase
  end

  assign tlp_hdr_1_rsv0 = 1'b0; // @ pcie_us_if_cq.scala l114
  assign tlp_hdr_1_tc = paser_header_1_axis_cq_tlp_desctr_tc; // @ pcie_us_if_cq.scala l115
  assign tlp_hdr_1_rsv1 = 1'b0; // @ pcie_us_if_cq.scala l116
  assign tlp_hdr_1_attr_h = paser_header_1_axis_cq_tlp_desctr_attr[2]; // @ pcie_us_if_cq.scala l117
  assign tlp_hdr_1_rsv2 = 1'b0; // @ pcie_us_if_cq.scala l118
  assign tlp_hdr_1_th = 1'b0; // @ pcie_us_if_cq.scala l119
  assign tlp_hdr_1_td = 1'b0; // @ pcie_us_if_cq.scala l120
  assign tlp_hdr_1_ep = 1'b0; // @ pcie_us_if_cq.scala l121
  assign tlp_hdr_1_attr_l = paser_header_1_axis_cq_tlp_desctr_attr[1 : 0]; // @ pcie_us_if_cq.scala l122
  assign tlp_hdr_1_at = paser_header_1_axis_cq_tlp_desctr_address_type; // @ pcie_us_if_cq.scala l123
  assign tlp_hdr_1_length = paser_header_1_axis_cq_tlp_desctr_dword_count[9:0]; // @ pcie_us_if_cq.scala l124
  assign tlp_hdr_1_last_dw_be = axis_cq_users_1_first_be[7 : 4]; // @ pcie_us_if_cq.scala l125
  assign tlp_hdr_1_first_dw_be = axis_cq_users_1_first_be[3 : 0]; // @ pcie_us_if_cq.scala l126
  assign tlp_hdr_1_address = paser_header_1_axis_cq_tlp_desctr_address; // @ pcie_us_if_cq.scala l127
  assign tlp_hdr_1_ph = 2'b00; // @ pcie_us_if_cq.scala l128
  assign tlp_bar_id_1 = paser_header_1_axis_cq_tlp_desctr_bar_id; // @ pcie_us_if_cq.scala l130
  assign tlp_func_num_1 = paser_header_1_axis_cq_tlp_desctr_target_function; // @ pcie_us_if_cq.scala l131
  assign axis_cq_users_0_first_be = s_axis_cq_tuser[7 : 0]; // @ Bits.scala l133
  assign axis_cq_users_0_last_be = s_axis_cq_tuser[15 : 8]; // @ Bits.scala l133
  assign axis_cq_users_0_byte_en = s_axis_cq_tuser[79 : 16]; // @ Bits.scala l133
  assign axis_cq_users_0_is_sop = s_axis_cq_tuser[81 : 80]; // @ Bits.scala l133
  assign tmp_axis_cq_users_0_is_sop_ptr_0 = s_axis_cq_tuser[85 : 82]; // @ BaseType.scala l299
  assign axis_cq_users_0_is_sop_ptr_0 = tmp_axis_cq_users_0_is_sop_ptr_0[1 : 0]; // @ UInt.scala l381
  assign axis_cq_users_0_is_sop_ptr_1 = tmp_axis_cq_users_0_is_sop_ptr_0[3 : 2]; // @ UInt.scala l381
  assign axis_cq_users_0_is_eop = s_axis_cq_tuser[87 : 86]; // @ Bits.scala l133
  assign tmp_axis_cq_users_0_is_eop_ptr_0 = s_axis_cq_tuser[95 : 88]; // @ BaseType.scala l299
  assign axis_cq_users_0_is_eop_ptr_0 = tmp_axis_cq_users_0_is_eop_ptr_0[3 : 0]; // @ UInt.scala l381
  assign axis_cq_users_0_is_eop_ptr_1 = tmp_axis_cq_users_0_is_eop_ptr_0[7 : 4]; // @ UInt.scala l381
  assign axis_cq_users_0_discontinue = s_axis_cq_tuser[96]; // @ Bool.scala l209
  assign axis_cq_users_0_tph_present = s_axis_cq_tuser[98 : 97]; // @ Bits.scala l133
  assign axis_cq_users_0_tph_type = s_axis_cq_tuser[102 : 99]; // @ Bits.scala l133
  assign axis_cq_users_0_tph_st_tag = s_axis_cq_tuser[118 : 103]; // @ Bits.scala l133
  assign axis_cq_users_0_parity = s_axis_cq_tuser[182 : 119]; // @ Bits.scala l133
  assign axis_cq_users_1_first_be = s_axis_cq_tuser_regNextWhen[7 : 0]; // @ Bits.scala l133
  assign axis_cq_users_1_last_be = s_axis_cq_tuser_regNextWhen[15 : 8]; // @ Bits.scala l133
  assign axis_cq_users_1_byte_en = s_axis_cq_tuser_regNextWhen[79 : 16]; // @ Bits.scala l133
  assign axis_cq_users_1_is_sop = s_axis_cq_tuser_regNextWhen[81 : 80]; // @ Bits.scala l133
  assign tmp_axis_cq_users_1_is_sop_ptr_0 = s_axis_cq_tuser_regNextWhen[85 : 82]; // @ BaseType.scala l299
  assign axis_cq_users_1_is_sop_ptr_0 = tmp_axis_cq_users_1_is_sop_ptr_0[1 : 0]; // @ UInt.scala l381
  assign axis_cq_users_1_is_sop_ptr_1 = tmp_axis_cq_users_1_is_sop_ptr_0[3 : 2]; // @ UInt.scala l381
  assign axis_cq_users_1_is_eop = s_axis_cq_tuser_regNextWhen[87 : 86]; // @ Bits.scala l133
  assign tmp_axis_cq_users_1_is_eop_ptr_0 = s_axis_cq_tuser_regNextWhen[95 : 88]; // @ BaseType.scala l299
  assign axis_cq_users_1_is_eop_ptr_0 = tmp_axis_cq_users_1_is_eop_ptr_0[3 : 0]; // @ UInt.scala l381
  assign axis_cq_users_1_is_eop_ptr_1 = tmp_axis_cq_users_1_is_eop_ptr_0[7 : 4]; // @ UInt.scala l381
  assign axis_cq_users_1_discontinue = s_axis_cq_tuser_regNextWhen[96]; // @ Bool.scala l209
  assign axis_cq_users_1_tph_present = s_axis_cq_tuser_regNextWhen[98 : 97]; // @ Bits.scala l133
  assign axis_cq_users_1_tph_type = s_axis_cq_tuser_regNextWhen[102 : 99]; // @ Bits.scala l133
  assign axis_cq_users_1_tph_st_tag = s_axis_cq_tuser_regNextWhen[118 : 103]; // @ Bits.scala l133
  assign axis_cq_users_1_parity = s_axis_cq_tuser_regNextWhen[182 : 119]; // @ Bits.scala l133
  always @(*) begin
    cq_strb_sop_0 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[0]) begin
        cq_strb_sop_0 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[0]) begin
        cq_strb_sop_0 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_1 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[1]) begin
        cq_strb_sop_1 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[1]) begin
        cq_strb_sop_1 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_2 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[2]) begin
        cq_strb_sop_2 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[2]) begin
        cq_strb_sop_2 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_3 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[3]) begin
        cq_strb_sop_3 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[3]) begin
        cq_strb_sop_3 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_4 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[4]) begin
        cq_strb_sop_4 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[4]) begin
        cq_strb_sop_4 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_5 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[5]) begin
        cq_strb_sop_5 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[5]) begin
        cq_strb_sop_5 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_6 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[6]) begin
        cq_strb_sop_6 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[6]) begin
        cq_strb_sop_6 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_7 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[7]) begin
        cq_strb_sop_7 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[7]) begin
        cq_strb_sop_7 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_8 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[8]) begin
        cq_strb_sop_8 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[8]) begin
        cq_strb_sop_8 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_9 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[9]) begin
        cq_strb_sop_9 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[9]) begin
        cq_strb_sop_9 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_10 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[10]) begin
        cq_strb_sop_10 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[10]) begin
        cq_strb_sop_10 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_11 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[11]) begin
        cq_strb_sop_11 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[11]) begin
        cq_strb_sop_11 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_12 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[12]) begin
        cq_strb_sop_12 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[12]) begin
        cq_strb_sop_12 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_13 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[13]) begin
        cq_strb_sop_13 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[13]) begin
        cq_strb_sop_13 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_14 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[14]) begin
        cq_strb_sop_14 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[14]) begin
        cq_strb_sop_14 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_sop_15 = 1'b0; // @ pcie_us_if_cq.scala l138
    if(tmp_when) begin
      if(tmp_1[15]) begin
        cq_strb_sop_15 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
    if(tmp_when_2) begin
      if(tmp_3[15]) begin
        cq_strb_sop_15 = 1'b1; // @ pcie_us_if_cq.scala l144
      end
    end
  end

  always @(*) begin
    cq_strb_eop_0 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[0]) begin
        cq_strb_eop_0 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[0]) begin
        cq_strb_eop_0 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_1 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[1]) begin
        cq_strb_eop_1 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[1]) begin
        cq_strb_eop_1 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_2 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[2]) begin
        cq_strb_eop_2 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[2]) begin
        cq_strb_eop_2 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_3 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[3]) begin
        cq_strb_eop_3 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[3]) begin
        cq_strb_eop_3 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_4 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[4]) begin
        cq_strb_eop_4 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[4]) begin
        cq_strb_eop_4 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_5 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[5]) begin
        cq_strb_eop_5 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[5]) begin
        cq_strb_eop_5 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_6 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[6]) begin
        cq_strb_eop_6 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[6]) begin
        cq_strb_eop_6 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_7 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[7]) begin
        cq_strb_eop_7 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[7]) begin
        cq_strb_eop_7 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_8 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[8]) begin
        cq_strb_eop_8 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[8]) begin
        cq_strb_eop_8 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_9 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[9]) begin
        cq_strb_eop_9 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[9]) begin
        cq_strb_eop_9 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_10 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[10]) begin
        cq_strb_eop_10 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[10]) begin
        cq_strb_eop_10 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_11 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[11]) begin
        cq_strb_eop_11 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[11]) begin
        cq_strb_eop_11 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_12 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[12]) begin
        cq_strb_eop_12 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[12]) begin
        cq_strb_eop_12 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_13 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[13]) begin
        cq_strb_eop_13 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[13]) begin
        cq_strb_eop_13 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_14 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[14]) begin
        cq_strb_eop_14 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[14]) begin
        cq_strb_eop_14 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  always @(*) begin
    cq_strb_eop_15 = 1'b0; // @ pcie_us_if_cq.scala l139
    if(tmp_when_1) begin
      if(tmp_2[15]) begin
        cq_strb_eop_15 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
    if(tmp_when_3) begin
      if(tmp_4[15]) begin
        cq_strb_eop_15 = 1'b1; // @ pcie_us_if_cq.scala l147
      end
    end
  end

  assign rx_req_tlp_data_0 = tmp_rx_req_tlp_data_0[255:0]; // @ pcie_us_if_cq.scala l141
  assign tmp_1 = ({15'd0,1'b1} <<< tmp_tmp_1); // @ BaseType.scala l299
  assign tmp_2 = ({15'd0,1'b1} <<< axis_cq_users_0_is_eop_ptr_0); // @ BaseType.scala l299
  assign rx_req_tlp_data_1 = tmp_rx_req_tlp_data_1[255:0]; // @ pcie_us_if_cq.scala l141
  assign tmp_3 = ({15'd0,1'b1} <<< tmp_tmp_3); // @ BaseType.scala l299
  assign tmp_4 = ({15'd0,1'b1} <<< axis_cq_users_0_is_eop_ptr_1); // @ BaseType.scala l299
  assign cq_sop_0 = (|{cq_strb_sop_7,{cq_strb_sop_6,{cq_strb_sop_5,{cq_strb_sop_4,{cq_strb_sop_3,{cq_strb_sop_2,{cq_strb_sop_1,cq_strb_sop_0}}}}}}}); // @ pcie_us_if_cq.scala l150
  assign cq_sop_1 = (|{cq_strb_sop_15,{cq_strb_sop_14,{cq_strb_sop_13,{cq_strb_sop_12,{cq_strb_sop_11,{cq_strb_sop_10,{cq_strb_sop_9,cq_strb_sop_8}}}}}}}); // @ pcie_us_if_cq.scala l150
  assign valid = (|{cq_strb_sop_15,{cq_strb_sop_14,{cq_strb_sop_13,{cq_strb_sop_12,{cq_strb_sop_11,{cq_strb_sop_10,{cq_strb_sop_9,{cq_strb_sop_8,{cq_strb_sop_7,{cq_strb_sop_6,{tmp_valid,tmp_valid_1}}}}}}}}}}}); // @ pcie_us_if_cq.scala l151
  assign cq_eop_0 = (|{cq_strb_eop_7,{cq_strb_eop_6,{cq_strb_eop_5,{cq_strb_eop_4,{cq_strb_eop_3,{cq_strb_eop_2,{cq_strb_eop_1,cq_strb_eop_0}}}}}}}); // @ pcie_us_if_cq.scala l153
  assign cq_eop_1 = (|{cq_strb_eop_15,{cq_strb_eop_14,{cq_strb_eop_13,{cq_strb_eop_12,{cq_strb_eop_11,{cq_strb_eop_10,{cq_strb_eop_9,cq_strb_eop_8}}}}}}}); // @ pcie_us_if_cq.scala l153
  assign cq_strb = (valid ? 16'hffff : 16'h0); // @ pcie_us_if_cq.scala l154
  always @(*) begin
    cq_valid = 2'b00; // @ pcie_us_if_cq.scala l155
    if(valid) begin
      cq_valid = (valid ? 2'b11 : 2'b00); // @ pcie_us_if_cq.scala l157
    end
  end

  assign s_axis_cq_tready = 1'b1; // @ Bool.scala l90
  assign rx_req_tlp_0_valid = 1'b0; // @ Bool.scala l92
  assign tmp_rx_req_tlp_0_data = 670'h0; // @ BitVector.scala l494
  assign rx_req_tlp_0_data = tmp_rx_req_tlp_0_data[511 : 0]; // @ Bits.scala l133
  assign rx_req_tlp_0_strb = tmp_rx_req_tlp_0_data[528 : 512]; // @ Bits.scala l133
  assign rx_req_tlp_0_hdr = tmp_rx_req_tlp_0_data[656 : 529]; // @ Bits.scala l133
  assign rx_req_tlp_0_bar_id = tmp_rx_req_tlp_0_data[659 : 657]; // @ UInt.scala l381
  assign rx_req_tlp_0_func_num = tmp_rx_req_tlp_0_data[667 : 660]; // @ UInt.scala l381
  assign rx_req_tlp_0_sop = tmp_rx_req_tlp_0_data[668]; // @ Bool.scala l209
  assign rx_req_tlp_0_eop = tmp_rx_req_tlp_0_data[669]; // @ Bool.scala l209
  assign rx_req_tlp_valid_reg = 2'b00; // @ pcie_us_if_cq.scala l167
  always @(posedge clk) begin
    if(s_axis_cq_fire) begin
      cq_data_int_reg <= s_axis_cq_tdata; // @ pcie_us_if_cq.scala l24
    end
    if(s_axis_cq_fire) begin
      cq_strb_reg <= cq_strb; // @ pcie_us_if_cq.scala l27
    end
    if(s_axis_cq_fire) begin
      s_axis_cq_tuser_regNextWhen <= s_axis_cq_tuser; // @ pcie_us_if_cq.scala l135
    end
  end


endmodule
