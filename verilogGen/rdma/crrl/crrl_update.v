// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : crrl_update
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766


module crrl_update (
  input  wire          crrl_req_valid,
  output reg           crrl_req_ready,
  input  wire [4:0]    crrl_req_payload_crr_state_id_state_crrl_cnt,
  input  wire [23:0]   crrl_req_payload_crr_state_id_state_ssn,
  input  wire          crrl_req_payload_crr_state_id_state_ce_bit,
  input  wire [23:0]   crrl_req_payload_crr_state_id_state_last_psn,
  input  wire [23:0]   crrl_req_payload_crr_state_id_state_first_psn,
  input  wire          crrl_req_payload_crr_state_it_state_finish_flag,
  input  wire          crrl_req_payload_crr_state_it_state_interrupt_bit,
  input  wire [31:0]   crrl_req_payload_crr_state_it_state_dma_length,
  input  wire [31:0]   crrl_req_payload_crr_state_it_state_sqe_rkey,
  input  wire [63:0]   crrl_req_payload_crr_state_it_state_sqe_va,
  input  wire [2:0]    crrl_req_payload_crr_state_it_state_sge_num,
  input  wire [7:0]    crrl_req_payload_crr_state_it_state_last_rd_rsp_opcode,
  input  wire [15:0]   crrl_req_payload_crr_state_it_state_sq_wqe_index,
  input  wire [3:0]    crrl_req_payload_crrl_sdb_module_id,
  input  wire [11:0]   crrl_req_payload_crrl_sdb_req_id,
  input  wire [23:0]   crrl_req_payload_crrl_sdb_qpn,
  input  wire [3:0]    crrl_req_payload_crrl_sdb_req_type,
  input  wire [3:0]    crrl_req_payload_crrl_sdb_status,
  output wire          crrl_rsp_valid,
  input  wire          crrl_rsp_ready,
  output wire [4:0]    crrl_rsp_payload_crr_state_id_state_crrl_cnt,
  output wire [23:0]   crrl_rsp_payload_crr_state_id_state_ssn,
  output wire          crrl_rsp_payload_crr_state_id_state_ce_bit,
  output wire [23:0]   crrl_rsp_payload_crr_state_id_state_last_psn,
  output wire [23:0]   crrl_rsp_payload_crr_state_id_state_first_psn,
  output wire          crrl_rsp_payload_crr_state_it_state_finish_flag,
  output wire          crrl_rsp_payload_crr_state_it_state_interrupt_bit,
  output wire [31:0]   crrl_rsp_payload_crr_state_it_state_dma_length,
  output wire [31:0]   crrl_rsp_payload_crr_state_it_state_sqe_rkey,
  output wire [63:0]   crrl_rsp_payload_crr_state_it_state_sqe_va,
  output wire [2:0]    crrl_rsp_payload_crr_state_it_state_sge_num,
  output wire [7:0]    crrl_rsp_payload_crr_state_it_state_last_rd_rsp_opcode,
  output wire [15:0]   crrl_rsp_payload_crr_state_it_state_sq_wqe_index,
  output wire [3:0]    crrl_rsp_payload_crrl_sdb_module_id,
  output wire [11:0]   crrl_rsp_payload_crrl_sdb_req_id,
  output wire [23:0]   crrl_rsp_payload_crrl_sdb_qpn,
  output wire [3:0]    crrl_rsp_payload_crrl_sdb_req_type,
  output wire [3:0]    crrl_rsp_payload_crrl_sdb_status,
  input  wire          clk,
  input  wire          reset
);

  wire                sqe_wqe_idx_ram_wren;
  wire       [15:0]   sqe_wqe_idx_ram_din;
  wire                it_state_ram_wren;
  wire                it_state_ram_rden;
  wire       [156:0]  it_state_ram_din;
  wire                id_state_ram_rden;
  wire       [77:0]   id_state_ram_din;
  wire       [9:0]    ptr_ram_din;
  wire       [15:0]   sqe_wqe_idx_ram_dout;
  wire       [156:0]  it_state_ram_dout;
  wire       [77:0]   id_state_ram_dout;
  wire       [7:0]    version_ram_dout;
  wire       [9:0]    ptr_ram_dout;
  wire       [8:0]    tmp_qp_id;
  wire       [8:0]    tmp_qp_id_pipe;
  wire       [11:0]   tmp_state_ram_raddr;
  wire       [11:0]   tmp_state_ram_raddr_1;
  wire       [11:0]   tmp_id_state_waddr;
  wire       [11:0]   tmp_id_state_waddr_1;
  wire       [11:0]   tmp_it_state_waddr;
  wire       [11:0]   tmp_it_state_waddr_1;
  wire       [3:0]    tmp_it_state_waddr_2;
  wire       [15:0]   tmp_din;
  wire                tmp_when;
  wire                sched_req_pop_valid;
  reg                 sched_req_pop_ready;
  wire       [4:0]    sched_req_pop_payload_crr_state_id_state_crrl_cnt;
  wire       [23:0]   sched_req_pop_payload_crr_state_id_state_ssn;
  wire                sched_req_pop_payload_crr_state_id_state_ce_bit;
  wire       [23:0]   sched_req_pop_payload_crr_state_id_state_last_psn;
  wire       [23:0]   sched_req_pop_payload_crr_state_id_state_first_psn;
  wire                sched_req_pop_payload_crr_state_it_state_finish_flag;
  wire                sched_req_pop_payload_crr_state_it_state_interrupt_bit;
  wire       [31:0]   sched_req_pop_payload_crr_state_it_state_dma_length;
  wire       [31:0]   sched_req_pop_payload_crr_state_it_state_sqe_rkey;
  wire       [63:0]   sched_req_pop_payload_crr_state_it_state_sqe_va;
  wire       [2:0]    sched_req_pop_payload_crr_state_it_state_sge_num;
  wire       [7:0]    sched_req_pop_payload_crr_state_it_state_last_rd_rsp_opcode;
  wire       [15:0]   sched_req_pop_payload_crr_state_it_state_sq_wqe_index;
  wire       [3:0]    sched_req_pop_payload_crrl_sdb_module_id;
  wire       [11:0]   sched_req_pop_payload_crrl_sdb_req_id;
  wire       [23:0]   sched_req_pop_payload_crrl_sdb_qpn;
  wire       [3:0]    sched_req_pop_payload_crrl_sdb_req_type;
  wire       [3:0]    sched_req_pop_payload_crrl_sdb_status;
  reg                 crrl_req_rValid;
  reg        [4:0]    crrl_req_rData_crr_state_id_state_crrl_cnt;
  reg        [23:0]   crrl_req_rData_crr_state_id_state_ssn;
  reg                 crrl_req_rData_crr_state_id_state_ce_bit;
  reg        [23:0]   crrl_req_rData_crr_state_id_state_last_psn;
  reg        [23:0]   crrl_req_rData_crr_state_id_state_first_psn;
  reg                 crrl_req_rData_crr_state_it_state_finish_flag;
  reg                 crrl_req_rData_crr_state_it_state_interrupt_bit;
  reg        [31:0]   crrl_req_rData_crr_state_it_state_dma_length;
  reg        [31:0]   crrl_req_rData_crr_state_it_state_sqe_rkey;
  reg        [63:0]   crrl_req_rData_crr_state_it_state_sqe_va;
  reg        [2:0]    crrl_req_rData_crr_state_it_state_sge_num;
  reg        [7:0]    crrl_req_rData_crr_state_it_state_last_rd_rsp_opcode;
  reg        [15:0]   crrl_req_rData_crr_state_it_state_sq_wqe_index;
  reg        [3:0]    crrl_req_rData_crrl_sdb_module_id;
  reg        [11:0]   crrl_req_rData_crrl_sdb_req_id;
  reg        [23:0]   crrl_req_rData_crrl_sdb_qpn;
  reg        [3:0]    crrl_req_rData_crrl_sdb_req_type;
  reg        [3:0]    crrl_req_rData_crrl_sdb_status;
  wire                pop_pipe_valid;
  wire                pop_pipe_ready;
  wire       [4:0]    pop_pipe_payload_crr_state_id_state_crrl_cnt;
  wire       [23:0]   pop_pipe_payload_crr_state_id_state_ssn;
  wire                pop_pipe_payload_crr_state_id_state_ce_bit;
  wire       [23:0]   pop_pipe_payload_crr_state_id_state_last_psn;
  wire       [23:0]   pop_pipe_payload_crr_state_id_state_first_psn;
  wire                pop_pipe_payload_crr_state_it_state_finish_flag;
  wire                pop_pipe_payload_crr_state_it_state_interrupt_bit;
  wire       [31:0]   pop_pipe_payload_crr_state_it_state_dma_length;
  wire       [31:0]   pop_pipe_payload_crr_state_it_state_sqe_rkey;
  wire       [63:0]   pop_pipe_payload_crr_state_it_state_sqe_va;
  wire       [2:0]    pop_pipe_payload_crr_state_it_state_sge_num;
  wire       [7:0]    pop_pipe_payload_crr_state_it_state_last_rd_rsp_opcode;
  wire       [15:0]   pop_pipe_payload_crr_state_it_state_sq_wqe_index;
  wire       [3:0]    pop_pipe_payload_crrl_sdb_module_id;
  wire       [11:0]   pop_pipe_payload_crrl_sdb_req_id;
  wire       [23:0]   pop_pipe_payload_crrl_sdb_qpn;
  wire       [3:0]    pop_pipe_payload_crrl_sdb_req_type;
  wire       [3:0]    pop_pipe_payload_crrl_sdb_status;
  reg                 sched_req_pop_rValid;
  reg        [4:0]    sched_req_pop_rData_crr_state_id_state_crrl_cnt;
  reg        [23:0]   sched_req_pop_rData_crr_state_id_state_ssn;
  reg                 sched_req_pop_rData_crr_state_id_state_ce_bit;
  reg        [23:0]   sched_req_pop_rData_crr_state_id_state_last_psn;
  reg        [23:0]   sched_req_pop_rData_crr_state_id_state_first_psn;
  reg                 sched_req_pop_rData_crr_state_it_state_finish_flag;
  reg                 sched_req_pop_rData_crr_state_it_state_interrupt_bit;
  reg        [31:0]   sched_req_pop_rData_crr_state_it_state_dma_length;
  reg        [31:0]   sched_req_pop_rData_crr_state_it_state_sqe_rkey;
  reg        [63:0]   sched_req_pop_rData_crr_state_it_state_sqe_va;
  reg        [2:0]    sched_req_pop_rData_crr_state_it_state_sge_num;
  reg        [7:0]    sched_req_pop_rData_crr_state_it_state_last_rd_rsp_opcode;
  reg        [15:0]   sched_req_pop_rData_crr_state_it_state_sq_wqe_index;
  reg        [3:0]    sched_req_pop_rData_crrl_sdb_module_id;
  reg        [11:0]   sched_req_pop_rData_crrl_sdb_req_id;
  reg        [23:0]   sched_req_pop_rData_crrl_sdb_qpn;
  reg        [3:0]    sched_req_pop_rData_crrl_sdb_req_type;
  reg        [3:0]    sched_req_pop_rData_crrl_sdb_status;
  wire       [7:0]    qp_id;
  wire       [7:0]    qp_id_pipe;
  wire       [7:0]    qp_version_pipe;
  wire                ptr_rd_en;
  wire       [3:0]    ptr_rd_out_push_ptr;
  wire       [3:0]    ptr_rd_out_pop_ptr;
  wire                ptr_rd_out_full;
  wire                ptr_rd_out_empty;
  wire                inital_empty;
  wire                ptr_wr_en;
  reg        [3:0]    ptr_wr_din_push_ptr;
  reg        [3:0]    ptr_wr_din_pop_ptr;
  reg                 ptr_wr_din_full;
  reg                 ptr_wr_din_empty;
  wire                wqe_idx_greater;
  wire                version_match;
  wire                req_clear;
  wire                req_push;
  wire                req_pop;
  wire                req_fill;
  wire                req_read;
  wire                supported_operation;
  wire                do_clear;
  wire                do_push;
  wire                do_pop;
  wire                do_fill;
  wire                do_read;
  wire       [11:0]   state_ram_raddr;
  wire       [11:0]   id_state_waddr;
  wire       [11:0]   it_state_waddr;
  wire       [4:0]    id_rd_out_crrl_cnt;
  wire       [23:0]   id_rd_out_ssn;
  wire                id_rd_out_ce_bit;
  wire       [23:0]   id_rd_out_last_psn;
  wire       [23:0]   id_rd_out_first_psn;
  wire                it_rd_out_finish_flag;
  wire                it_rd_out_interrupt_bit;
  wire       [31:0]   it_rd_out_dma_length;
  wire       [31:0]   it_rd_out_sqe_rkey;
  wire       [63:0]   it_rd_out_sqe_va;
  wire       [2:0]    it_rd_out_sge_num;
  wire       [7:0]    it_rd_out_last_rd_rsp_opcode;
  wire       [15:0]   it_rd_out_sq_wqe_index;
  wire       [4:0]    crrl_state_rd_out_id_state_crrl_cnt;
  wire       [23:0]   crrl_state_rd_out_id_state_ssn;
  wire                crrl_state_rd_out_id_state_ce_bit;
  wire       [23:0]   crrl_state_rd_out_id_state_last_psn;
  wire       [23:0]   crrl_state_rd_out_id_state_first_psn;
  wire                crrl_state_rd_out_it_state_finish_flag;
  wire                crrl_state_rd_out_it_state_interrupt_bit;
  wire       [31:0]   crrl_state_rd_out_it_state_dma_length;
  wire       [31:0]   crrl_state_rd_out_it_state_sqe_rkey;
  wire       [63:0]   crrl_state_rd_out_it_state_sqe_va;
  wire       [2:0]    crrl_state_rd_out_it_state_sge_num;
  wire       [7:0]    crrl_state_rd_out_it_state_last_rd_rsp_opcode;
  wire       [15:0]   crrl_state_rd_out_it_state_sq_wqe_index;
  wire                sdb_st_valid;
  reg                 sdb_st_ready;
  wire       [3:0]    sdb_st_payload_module_id;
  wire       [11:0]   sdb_st_payload_req_id;
  wire       [23:0]   sdb_st_payload_qpn;
  wire       [3:0]    sdb_st_payload_req_type;
  reg        [3:0]    sdb_st_payload_status;
  wire                sdb_st_m2sPipe_valid;
  reg                 sdb_st_m2sPipe_ready;
  wire       [3:0]    sdb_st_m2sPipe_payload_module_id;
  wire       [11:0]   sdb_st_m2sPipe_payload_req_id;
  wire       [23:0]   sdb_st_m2sPipe_payload_qpn;
  wire       [3:0]    sdb_st_m2sPipe_payload_req_type;
  wire       [3:0]    sdb_st_m2sPipe_payload_status;
  reg                 sdb_st_rValid;
  reg        [3:0]    sdb_st_rData_module_id;
  reg        [11:0]   sdb_st_rData_req_id;
  reg        [23:0]   sdb_st_rData_qpn;
  reg        [3:0]    sdb_st_rData_req_type;
  reg        [3:0]    sdb_st_rData_status;
  wire                sdb_pipe_st_valid;
  wire                sdb_pipe_st_ready;
  wire       [3:0]    sdb_pipe_st_payload_module_id;
  wire       [11:0]   sdb_pipe_st_payload_req_id;
  wire       [23:0]   sdb_pipe_st_payload_qpn;
  wire       [3:0]    sdb_pipe_st_payload_req_type;
  wire       [3:0]    sdb_pipe_st_payload_status;
  reg                 sdb_st_m2sPipe_rValid;
  reg        [3:0]    sdb_st_m2sPipe_rData_module_id;
  reg        [11:0]   sdb_st_m2sPipe_rData_req_id;
  reg        [23:0]   sdb_st_m2sPipe_rData_qpn;
  reg        [3:0]    sdb_st_m2sPipe_rData_req_type;
  reg        [3:0]    sdb_st_m2sPipe_rData_status;
  wire                rsp_rd;
  wire                crrl_rsp_push_valid;
  reg                 crrl_rsp_push_ready;
  reg        [4:0]    crrl_rsp_push_payload_crr_state_id_state_crrl_cnt;
  reg        [23:0]   crrl_rsp_push_payload_crr_state_id_state_ssn;
  reg                 crrl_rsp_push_payload_crr_state_id_state_ce_bit;
  reg        [23:0]   crrl_rsp_push_payload_crr_state_id_state_last_psn;
  reg        [23:0]   crrl_rsp_push_payload_crr_state_id_state_first_psn;
  reg                 crrl_rsp_push_payload_crr_state_it_state_finish_flag;
  reg                 crrl_rsp_push_payload_crr_state_it_state_interrupt_bit;
  reg        [31:0]   crrl_rsp_push_payload_crr_state_it_state_dma_length;
  reg        [31:0]   crrl_rsp_push_payload_crr_state_it_state_sqe_rkey;
  reg        [63:0]   crrl_rsp_push_payload_crr_state_it_state_sqe_va;
  reg        [2:0]    crrl_rsp_push_payload_crr_state_it_state_sge_num;
  reg        [7:0]    crrl_rsp_push_payload_crr_state_it_state_last_rd_rsp_opcode;
  reg        [15:0]   crrl_rsp_push_payload_crr_state_it_state_sq_wqe_index;
  wire       [3:0]    crrl_rsp_push_payload_crrl_sdb_module_id;
  wire       [11:0]   crrl_rsp_push_payload_crrl_sdb_req_id;
  wire       [23:0]   crrl_rsp_push_payload_crrl_sdb_qpn;
  wire       [3:0]    crrl_rsp_push_payload_crrl_sdb_req_type;
  reg        [3:0]    crrl_rsp_push_payload_crrl_sdb_status;
  reg                 back_pre;
  reg        [4:0]    crrl_state_rd_out_reg_id_state_crrl_cnt;
  reg        [23:0]   crrl_state_rd_out_reg_id_state_ssn;
  reg                 crrl_state_rd_out_reg_id_state_ce_bit;
  reg        [23:0]   crrl_state_rd_out_reg_id_state_last_psn;
  reg        [23:0]   crrl_state_rd_out_reg_id_state_first_psn;
  reg                 crrl_state_rd_out_reg_it_state_finish_flag;
  reg                 crrl_state_rd_out_reg_it_state_interrupt_bit;
  reg        [31:0]   crrl_state_rd_out_reg_it_state_dma_length;
  reg        [31:0]   crrl_state_rd_out_reg_it_state_sqe_rkey;
  reg        [63:0]   crrl_state_rd_out_reg_it_state_sqe_va;
  reg        [2:0]    crrl_state_rd_out_reg_it_state_sge_num;
  reg        [7:0]    crrl_state_rd_out_reg_it_state_last_rd_rsp_opcode;
  reg        [15:0]   crrl_state_rd_out_reg_it_state_sq_wqe_index;
  wire                rx_wqe_others_no_it;
  wire                sdb_st_fire;
  wire       [234:0]  tmp_crrl_rsp_push_payload_crr_state_id_state_crrl_cnt;
  wire       [77:0]   tmp_crrl_rsp_push_payload_crr_state_id_state_crrl_cnt_1;
  wire       [156:0]  tmp_crrl_rsp_push_payload_crr_state_it_state_finish_flag;
  wire                crrl_rsp_push_m2sPipe_valid;
  wire                crrl_rsp_push_m2sPipe_ready;
  wire       [4:0]    crrl_rsp_push_m2sPipe_payload_crr_state_id_state_crrl_cnt;
  wire       [23:0]   crrl_rsp_push_m2sPipe_payload_crr_state_id_state_ssn;
  wire                crrl_rsp_push_m2sPipe_payload_crr_state_id_state_ce_bit;
  wire       [23:0]   crrl_rsp_push_m2sPipe_payload_crr_state_id_state_last_psn;
  wire       [23:0]   crrl_rsp_push_m2sPipe_payload_crr_state_id_state_first_psn;
  wire                crrl_rsp_push_m2sPipe_payload_crr_state_it_state_finish_flag;
  wire                crrl_rsp_push_m2sPipe_payload_crr_state_it_state_interrupt_bit;
  wire       [31:0]   crrl_rsp_push_m2sPipe_payload_crr_state_it_state_dma_length;
  wire       [31:0]   crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sqe_rkey;
  wire       [63:0]   crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sqe_va;
  wire       [2:0]    crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sge_num;
  wire       [7:0]    crrl_rsp_push_m2sPipe_payload_crr_state_it_state_last_rd_rsp_opcode;
  wire       [15:0]   crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sq_wqe_index;
  wire       [3:0]    crrl_rsp_push_m2sPipe_payload_crrl_sdb_module_id;
  wire       [11:0]   crrl_rsp_push_m2sPipe_payload_crrl_sdb_req_id;
  wire       [23:0]   crrl_rsp_push_m2sPipe_payload_crrl_sdb_qpn;
  wire       [3:0]    crrl_rsp_push_m2sPipe_payload_crrl_sdb_req_type;
  wire       [3:0]    crrl_rsp_push_m2sPipe_payload_crrl_sdb_status;
  reg                 crrl_rsp_push_rValid;
  reg        [4:0]    crrl_rsp_push_rData_crr_state_id_state_crrl_cnt;
  reg        [23:0]   crrl_rsp_push_rData_crr_state_id_state_ssn;
  reg                 crrl_rsp_push_rData_crr_state_id_state_ce_bit;
  reg        [23:0]   crrl_rsp_push_rData_crr_state_id_state_last_psn;
  reg        [23:0]   crrl_rsp_push_rData_crr_state_id_state_first_psn;
  reg                 crrl_rsp_push_rData_crr_state_it_state_finish_flag;
  reg                 crrl_rsp_push_rData_crr_state_it_state_interrupt_bit;
  reg        [31:0]   crrl_rsp_push_rData_crr_state_it_state_dma_length;
  reg        [31:0]   crrl_rsp_push_rData_crr_state_it_state_sqe_rkey;
  reg        [63:0]   crrl_rsp_push_rData_crr_state_it_state_sqe_va;
  reg        [2:0]    crrl_rsp_push_rData_crr_state_it_state_sge_num;
  reg        [7:0]    crrl_rsp_push_rData_crr_state_it_state_last_rd_rsp_opcode;
  reg        [15:0]   crrl_rsp_push_rData_crr_state_it_state_sq_wqe_index;
  reg        [3:0]    crrl_rsp_push_rData_crrl_sdb_module_id;
  reg        [11:0]   crrl_rsp_push_rData_crrl_sdb_req_id;
  reg        [23:0]   crrl_rsp_push_rData_crrl_sdb_qpn;
  reg        [3:0]    crrl_rsp_push_rData_crrl_sdb_req_type;
  reg        [3:0]    crrl_rsp_push_rData_crrl_sdb_status;

  assign tmp_when = (((sdb_pipe_st_payload_status == 4'b0000) && rsp_rd) && (! rx_wqe_others_no_it));
  assign tmp_qp_id = (sched_req_pop_payload_crrl_sdb_qpn[8 : 0] - 9'h002);
  assign tmp_qp_id_pipe = (pop_pipe_payload_crrl_sdb_qpn[8 : 0] - 9'h002);
  assign tmp_state_ram_raddr = ({4'd0,qp_id_pipe} <<< 3'd4);
  assign tmp_state_ram_raddr_1 = {8'd0, ptr_rd_out_pop_ptr};
  assign tmp_id_state_waddr = ({4'd0,qp_id_pipe} <<< 3'd4);
  assign tmp_id_state_waddr_1 = {8'd0, ptr_rd_out_push_ptr};
  assign tmp_it_state_waddr = ({4'd0,qp_id_pipe} <<< 3'd4);
  assign tmp_it_state_waddr_2 = (req_push ? ptr_rd_out_push_ptr : ptr_rd_out_pop_ptr);
  assign tmp_it_state_waddr_1 = {8'd0, tmp_it_state_waddr_2};
  assign tmp_din = (pop_pipe_payload_crr_state_it_state_sq_wqe_index + 16'h0001);
  rdma_ctyun_sdpram #(
    .WR_ADDR_WIDTH     (8         ),
    .RD_ADDR_WIDTH     (8         ),
    .WR_DATA_WIDTH     (16        ),
    .RD_DATA_WIDTH     (16        ),
    .READ_LATENCY      (1         ),
    .RAM_TYPE          ("MLAB"    ),
    .READ_DURING_WRITE ("NEW_DATA"),
    .INIT_FILE         (""        )
  ) sqe_wqe_idx_ram (
    .clock     (clk                       ), //i
    .wren      (sqe_wqe_idx_ram_wren      ), //i
    .rden      (ptr_rd_en                 ), //i
    .byteena   (2'b11                     ), //i
    .din       (sqe_wqe_idx_ram_din[15:0] ), //i
    .rdaddress (qp_id[7:0]                ), //i
    .wraddress (qp_id_pipe[7:0]           ), //i
    .dout      (sqe_wqe_idx_ram_dout[15:0])  //o
  );
  rdma_ctyun_sdpram #(
    .WR_ADDR_WIDTH     (12        ),
    .RD_ADDR_WIDTH     (12        ),
    .WR_DATA_WIDTH     (157       ),
    .RD_DATA_WIDTH     (157       ),
    .READ_LATENCY      (2         ),
    .RAM_TYPE          ("AUTO"    ),
    .READ_DURING_WRITE ("OLD_DATA"),
    .INIT_FILE         (""        )
  ) it_state_ram (
    .clock     (clk                     ), //i
    .wren      (it_state_ram_wren       ), //i
    .rden      (it_state_ram_rden       ), //i
    .byteena   (20'hfffff               ), //i
    .din       (it_state_ram_din[156:0] ), //i
    .rdaddress (state_ram_raddr[11:0]   ), //i
    .wraddress (it_state_waddr[11:0]    ), //i
    .dout      (it_state_ram_dout[156:0])  //o
  );
  rdma_ctyun_sdpram #(
    .WR_ADDR_WIDTH     (12        ),
    .RD_ADDR_WIDTH     (12        ),
    .WR_DATA_WIDTH     (78        ),
    .RD_DATA_WIDTH     (78        ),
    .READ_LATENCY      (2         ),
    .RAM_TYPE          ("AUTO"    ),
    .READ_DURING_WRITE ("OLD_DATA"),
    .INIT_FILE         (""        )
  ) id_state_ram (
    .clock     (clk                    ), //i
    .wren      (do_push                ), //i
    .rden      (id_state_ram_rden      ), //i
    .byteena   (10'h3ff                ), //i
    .din       (id_state_ram_din[77:0] ), //i
    .rdaddress (state_ram_raddr[11:0]  ), //i
    .wraddress (id_state_waddr[11:0]   ), //i
    .dout      (id_state_ram_dout[77:0])  //o
  );
  rdma_ctyun_sdpram #(
    .WR_ADDR_WIDTH     (8         ),
    .RD_ADDR_WIDTH     (8         ),
    .WR_DATA_WIDTH     (8         ),
    .RD_DATA_WIDTH     (8         ),
    .READ_LATENCY      (1         ),
    .RAM_TYPE          ("AUTO"    ),
    .READ_DURING_WRITE ("OLD_DATA"),
    .INIT_FILE         (""        )
  ) version_ram (
    .clock     (clk                  ), //i
    .wren      (ptr_wr_en            ), //i
    .rden      (ptr_rd_en            ), //i
    .byteena   (1'b1                 ), //i
    .din       (qp_version_pipe[7:0] ), //i
    .rdaddress (qp_id[7:0]           ), //i
    .wraddress (qp_id_pipe[7:0]      ), //i
    .dout      (version_ram_dout[7:0])  //o
  );
  rdma_ctyun_sdpram #(
    .WR_ADDR_WIDTH     (8         ),
    .RD_ADDR_WIDTH     (8         ),
    .WR_DATA_WIDTH     (10        ),
    .RD_DATA_WIDTH     (10        ),
    .READ_LATENCY      (1         ),
    .RAM_TYPE          ("MLAB"    ),
    .READ_DURING_WRITE ("NEW_DATA"),
    .INIT_FILE         (""        )
  ) ptr_ram (
    .clock     (clk              ), //i
    .wren      (ptr_wr_en        ), //i
    .rden      (ptr_rd_en        ), //i
    .byteena   (2'b11            ), //i
    .din       (ptr_ram_din[9:0] ), //i
    .rdaddress (qp_id[7:0]       ), //i
    .wraddress (qp_id_pipe[7:0]  ), //i
    .dout      (ptr_ram_dout[9:0])  //o
  );
  always @(*) begin
    crrl_req_ready = sched_req_pop_ready; // @ Stream.scala l374
    if((! sched_req_pop_valid)) begin
      crrl_req_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign sched_req_pop_valid = crrl_req_rValid; // @ Stream.scala l377
  assign sched_req_pop_payload_crr_state_id_state_crrl_cnt = crrl_req_rData_crr_state_id_state_crrl_cnt; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_id_state_ssn = crrl_req_rData_crr_state_id_state_ssn; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_id_state_ce_bit = crrl_req_rData_crr_state_id_state_ce_bit; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_id_state_last_psn = crrl_req_rData_crr_state_id_state_last_psn; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_id_state_first_psn = crrl_req_rData_crr_state_id_state_first_psn; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_it_state_finish_flag = crrl_req_rData_crr_state_it_state_finish_flag; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_it_state_interrupt_bit = crrl_req_rData_crr_state_it_state_interrupt_bit; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_it_state_dma_length = crrl_req_rData_crr_state_it_state_dma_length; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_it_state_sqe_rkey = crrl_req_rData_crr_state_it_state_sqe_rkey; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_it_state_sqe_va = crrl_req_rData_crr_state_it_state_sqe_va; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_it_state_sge_num = crrl_req_rData_crr_state_it_state_sge_num; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_it_state_last_rd_rsp_opcode = crrl_req_rData_crr_state_it_state_last_rd_rsp_opcode; // @ Stream.scala l378
  assign sched_req_pop_payload_crr_state_it_state_sq_wqe_index = crrl_req_rData_crr_state_it_state_sq_wqe_index; // @ Stream.scala l378
  assign sched_req_pop_payload_crrl_sdb_module_id = crrl_req_rData_crrl_sdb_module_id; // @ Stream.scala l378
  assign sched_req_pop_payload_crrl_sdb_req_id = crrl_req_rData_crrl_sdb_req_id; // @ Stream.scala l378
  assign sched_req_pop_payload_crrl_sdb_qpn = crrl_req_rData_crrl_sdb_qpn; // @ Stream.scala l378
  assign sched_req_pop_payload_crrl_sdb_req_type = crrl_req_rData_crrl_sdb_req_type; // @ Stream.scala l378
  assign sched_req_pop_payload_crrl_sdb_status = crrl_req_rData_crrl_sdb_status; // @ Stream.scala l378
  always @(*) begin
    sched_req_pop_ready = pop_pipe_ready; // @ Stream.scala l374
    if((! pop_pipe_valid)) begin
      sched_req_pop_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign pop_pipe_valid = sched_req_pop_rValid; // @ Stream.scala l377
  assign pop_pipe_payload_crr_state_id_state_crrl_cnt = sched_req_pop_rData_crr_state_id_state_crrl_cnt; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_id_state_ssn = sched_req_pop_rData_crr_state_id_state_ssn; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_id_state_ce_bit = sched_req_pop_rData_crr_state_id_state_ce_bit; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_id_state_last_psn = sched_req_pop_rData_crr_state_id_state_last_psn; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_id_state_first_psn = sched_req_pop_rData_crr_state_id_state_first_psn; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_it_state_finish_flag = sched_req_pop_rData_crr_state_it_state_finish_flag; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_it_state_interrupt_bit = sched_req_pop_rData_crr_state_it_state_interrupt_bit; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_it_state_dma_length = sched_req_pop_rData_crr_state_it_state_dma_length; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_it_state_sqe_rkey = sched_req_pop_rData_crr_state_it_state_sqe_rkey; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_it_state_sqe_va = sched_req_pop_rData_crr_state_it_state_sqe_va; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_it_state_sge_num = sched_req_pop_rData_crr_state_it_state_sge_num; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_it_state_last_rd_rsp_opcode = sched_req_pop_rData_crr_state_it_state_last_rd_rsp_opcode; // @ Stream.scala l378
  assign pop_pipe_payload_crr_state_it_state_sq_wqe_index = sched_req_pop_rData_crr_state_it_state_sq_wqe_index; // @ Stream.scala l378
  assign pop_pipe_payload_crrl_sdb_module_id = sched_req_pop_rData_crrl_sdb_module_id; // @ Stream.scala l378
  assign pop_pipe_payload_crrl_sdb_req_id = sched_req_pop_rData_crrl_sdb_req_id; // @ Stream.scala l378
  assign pop_pipe_payload_crrl_sdb_qpn = sched_req_pop_rData_crrl_sdb_qpn; // @ Stream.scala l378
  assign pop_pipe_payload_crrl_sdb_req_type = sched_req_pop_rData_crrl_sdb_req_type; // @ Stream.scala l378
  assign pop_pipe_payload_crrl_sdb_status = sched_req_pop_rData_crrl_sdb_status; // @ Stream.scala l378
  assign qp_id = tmp_qp_id[7:0]; // @ BaseType.scala l299
  assign qp_id_pipe = tmp_qp_id_pipe[7:0]; // @ BaseType.scala l299
  assign qp_version_pipe = pop_pipe_payload_crrl_sdb_qpn[23 : 16]; // @ BaseType.scala l299
  assign ptr_rd_en = (sched_req_pop_valid && sched_req_pop_ready); // @ BaseType.scala l305
  assign inital_empty = ({ptr_rd_out_empty,{ptr_rd_out_full,{ptr_rd_out_pop_ptr,ptr_rd_out_push_ptr}}} == 10'h0); // @ BaseType.scala l305
  assign ptr_wr_en = (pop_pipe_valid && pop_pipe_ready); // @ BaseType.scala l305
  assign wqe_idx_greater = (sqe_wqe_idx_ram_dout <= pop_pipe_payload_crr_state_it_state_sq_wqe_index); // @ BaseType.scala l305
  assign version_match = (qp_version_pipe == version_ram_dout); // @ BaseType.scala l305
  assign req_clear = (pop_pipe_payload_crrl_sdb_module_id == 4'b0110); // @ BaseType.scala l305
  assign req_push = ((pop_pipe_payload_crrl_sdb_module_id == 4'b0011) && (pop_pipe_payload_crrl_sdb_req_type == 4'b0001)); // @ BaseType.scala l305
  assign req_pop = (((pop_pipe_payload_crrl_sdb_module_id == 4'b0100) && (pop_pipe_payload_crrl_sdb_req_type == 4'b0101)) && pop_pipe_payload_crr_state_it_state_finish_flag); // @ BaseType.scala l305
  assign req_fill = (((pop_pipe_payload_crrl_sdb_module_id == 4'b0100) && (pop_pipe_payload_crrl_sdb_req_type == 4'b0101)) && pop_pipe_payload_crr_state_it_state_interrupt_bit); // @ BaseType.scala l305
  assign req_read = (((pop_pipe_payload_crrl_sdb_module_id == 4'b0000) && (pop_pipe_payload_crrl_sdb_req_type == 4'b0001)) || ((pop_pipe_payload_crrl_sdb_module_id == 4'b0001) && ((pop_pipe_payload_crrl_sdb_req_type == 4'b0110) || (pop_pipe_payload_crrl_sdb_req_type == 4'b0101)))); // @ BaseType.scala l305
  assign supported_operation = (|{{{{req_clear,req_push},req_pop},req_fill},req_read}); // @ BaseType.scala l312
  assign do_clear = (req_clear && version_match); // @ BaseType.scala l305
  assign do_push = (((req_push && version_match) && wqe_idx_greater) && (! ptr_rd_out_full)); // @ BaseType.scala l305
  assign do_pop = ((req_pop && version_match) && (! (ptr_rd_out_empty || inital_empty))); // @ BaseType.scala l305
  assign do_fill = ((req_fill && version_match) && (! (ptr_rd_out_empty || inital_empty))); // @ BaseType.scala l305
  assign do_read = ((req_read && version_match) && (! (ptr_rd_out_empty || inital_empty))); // @ BaseType.scala l305
  assign state_ram_raddr = (tmp_state_ram_raddr + tmp_state_ram_raddr_1); // @ BaseType.scala l299
  assign id_state_waddr = (tmp_id_state_waddr + tmp_id_state_waddr_1); // @ BaseType.scala l299
  assign it_state_waddr = (tmp_it_state_waddr + tmp_it_state_waddr_1); // @ BaseType.scala l299
  always @(*) begin
    sdb_st_ready = sdb_st_m2sPipe_ready; // @ Stream.scala l374
    if((! sdb_st_m2sPipe_valid)) begin
      sdb_st_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign sdb_st_m2sPipe_valid = sdb_st_rValid; // @ Stream.scala l377
  assign sdb_st_m2sPipe_payload_module_id = sdb_st_rData_module_id; // @ Stream.scala l378
  assign sdb_st_m2sPipe_payload_req_id = sdb_st_rData_req_id; // @ Stream.scala l378
  assign sdb_st_m2sPipe_payload_qpn = sdb_st_rData_qpn; // @ Stream.scala l378
  assign sdb_st_m2sPipe_payload_req_type = sdb_st_rData_req_type; // @ Stream.scala l378
  assign sdb_st_m2sPipe_payload_status = sdb_st_rData_status; // @ Stream.scala l378
  always @(*) begin
    sdb_st_m2sPipe_ready = sdb_pipe_st_ready; // @ Stream.scala l374
    if((! sdb_pipe_st_valid)) begin
      sdb_st_m2sPipe_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign sdb_pipe_st_valid = sdb_st_m2sPipe_rValid; // @ Stream.scala l377
  assign sdb_pipe_st_payload_module_id = sdb_st_m2sPipe_rData_module_id; // @ Stream.scala l378
  assign sdb_pipe_st_payload_req_id = sdb_st_m2sPipe_rData_req_id; // @ Stream.scala l378
  assign sdb_pipe_st_payload_qpn = sdb_st_m2sPipe_rData_qpn; // @ Stream.scala l378
  assign sdb_pipe_st_payload_req_type = sdb_st_m2sPipe_rData_req_type; // @ Stream.scala l378
  assign sdb_pipe_st_payload_status = sdb_st_m2sPipe_rData_status; // @ Stream.scala l378
  assign rsp_rd = (((sdb_pipe_st_payload_module_id == 4'b0000) && (sdb_pipe_st_payload_req_type == 4'b0001)) || ((sdb_pipe_st_payload_module_id == 4'b0001) && ((sdb_pipe_st_payload_req_type == 4'b0101) || (sdb_pipe_st_payload_req_type == 4'b0110)))); // @ BaseType.scala l305
  assign rx_wqe_others_no_it = (((sdb_pipe_st_payload_module_id == 4'b0001) && (sdb_pipe_st_payload_req_type == 4'b0110)) && (! (back_pre ? crrl_state_rd_out_reg_it_state_interrupt_bit : it_rd_out_interrupt_bit))); // @ BaseType.scala l305
  assign ptr_rd_out_push_ptr = ptr_ram_dout[3 : 0]; // @ UInt.scala l381
  assign ptr_rd_out_pop_ptr = ptr_ram_dout[7 : 4]; // @ UInt.scala l381
  assign ptr_rd_out_full = ptr_ram_dout[8]; // @ Bool.scala l209
  assign ptr_rd_out_empty = ptr_ram_dout[9]; // @ Bool.scala l209
  always @(*) begin
    if(do_clear) begin
      ptr_wr_din_push_ptr = 4'b0000; // @ BitVector.scala l494
    end else begin
      if(do_push) begin
        ptr_wr_din_push_ptr = (ptr_rd_out_push_ptr + 4'b0001); // @ crrl_update.scala l133
      end else begin
        if(do_pop) begin
          ptr_wr_din_push_ptr = ptr_rd_out_push_ptr; // @ crrl_update.scala l138
        end else begin
          ptr_wr_din_push_ptr = ptr_rd_out_push_ptr; // @ crrl_update.scala l142
        end
      end
    end
  end

  always @(*) begin
    if(do_clear) begin
      ptr_wr_din_pop_ptr = 4'b0000; // @ BitVector.scala l494
    end else begin
      if(do_push) begin
        ptr_wr_din_pop_ptr = ptr_rd_out_pop_ptr; // @ crrl_update.scala l134
      end else begin
        if(do_pop) begin
          ptr_wr_din_pop_ptr = (ptr_rd_out_pop_ptr + 4'b0001); // @ crrl_update.scala l139
        end else begin
          ptr_wr_din_pop_ptr = ptr_rd_out_pop_ptr; // @ crrl_update.scala l142
        end
      end
    end
  end

  always @(*) begin
    if(do_clear) begin
      ptr_wr_din_full = 1'b0; // @ Bool.scala l92
    end else begin
      if(do_push) begin
        ptr_wr_din_full = (ptr_wr_din_push_ptr == ptr_wr_din_pop_ptr); // @ crrl_update.scala l135
      end else begin
        if(do_pop) begin
          ptr_wr_din_full = 1'b0; // @ Bool.scala l92
        end else begin
          ptr_wr_din_full = ptr_rd_out_full; // @ crrl_update.scala l142
        end
      end
    end
  end

  always @(*) begin
    if(do_clear) begin
      ptr_wr_din_empty = 1'b1; // @ Bool.scala l90
    end else begin
      if(do_push) begin
        ptr_wr_din_empty = 1'b0; // @ Bool.scala l92
      end else begin
        if(do_pop) begin
          ptr_wr_din_empty = (ptr_wr_din_push_ptr == ptr_wr_din_pop_ptr); // @ crrl_update.scala l141
        end else begin
          ptr_wr_din_empty = ptr_rd_out_empty; // @ crrl_update.scala l142
        end
      end
    end
  end

  assign ptr_ram_din = {ptr_wr_din_empty,{ptr_wr_din_full,{ptr_wr_din_pop_ptr,ptr_wr_din_push_ptr}}}; // @ rdma_ctyun_sdpram.scala l60
  assign sqe_wqe_idx_ram_wren = (ptr_wr_en && do_push); // @ rdma_ctyun_sdpram.scala l58
  assign sqe_wqe_idx_ram_din = tmp_din; // @ rdma_ctyun_sdpram.scala l60
  assign sdb_st_valid = pop_pipe_valid; // @ crrl_update.scala l149
  assign pop_pipe_ready = sdb_st_ready; // @ crrl_update.scala l150
  assign sdb_st_payload_module_id = pop_pipe_payload_crrl_sdb_module_id; // @ crrl_update.scala l151
  assign sdb_st_payload_req_id = pop_pipe_payload_crrl_sdb_req_id; // @ crrl_update.scala l151
  assign sdb_st_payload_qpn = pop_pipe_payload_crrl_sdb_qpn; // @ crrl_update.scala l151
  assign sdb_st_payload_req_type = pop_pipe_payload_crrl_sdb_req_type; // @ crrl_update.scala l151
  always @(*) begin
    sdb_st_payload_status = pop_pipe_payload_crrl_sdb_status; // @ crrl_update.scala l151
    if((! supported_operation)) begin
      sdb_st_payload_status = 4'b0100; // @ crrl_update.scala l153
    end else begin
      if((! version_match)) begin
        sdb_st_payload_status = 4'b0110; // @ crrl_update.scala l155
      end else begin
        if(req_push) begin
          if((! wqe_idx_greater)) begin
            sdb_st_payload_status = 4'b0111; // @ crrl_update.scala l158
          end else begin
            if(ptr_rd_out_full) begin
              sdb_st_payload_status = 4'b0011; // @ crrl_update.scala l160
            end else begin
              sdb_st_payload_status = 4'b0000; // @ BitVector.scala l494
            end
          end
        end else begin
          if(req_clear) begin
            sdb_st_payload_status = 4'b0000; // @ BitVector.scala l494
          end else begin
            if((ptr_rd_out_empty || inital_empty)) begin
              sdb_st_payload_status = 4'b0101; // @ crrl_update.scala l167
            end
          end
        end
      end
    end
  end

  assign id_state_ram_din = {pop_pipe_payload_crr_state_id_state_first_psn,{pop_pipe_payload_crr_state_id_state_last_psn,{pop_pipe_payload_crr_state_id_state_ce_bit,{pop_pipe_payload_crr_state_id_state_ssn,pop_pipe_payload_crr_state_id_state_crrl_cnt}}}}; // @ rdma_ctyun_sdpram.scala l60
  assign it_state_ram_wren = (do_push || do_fill); // @ rdma_ctyun_sdpram.scala l58
  assign it_state_ram_din = {pop_pipe_payload_crr_state_it_state_sq_wqe_index,{pop_pipe_payload_crr_state_it_state_last_rd_rsp_opcode,{pop_pipe_payload_crr_state_it_state_sge_num,{pop_pipe_payload_crr_state_it_state_sqe_va,{pop_pipe_payload_crr_state_it_state_sqe_rkey,{pop_pipe_payload_crr_state_it_state_dma_length,{pop_pipe_payload_crr_state_it_state_interrupt_bit,pop_pipe_payload_crr_state_it_state_finish_flag}}}}}}}; // @ rdma_ctyun_sdpram.scala l60
  assign sdb_st_fire = (sdb_st_valid && sdb_st_ready); // @ BaseType.scala l305
  assign id_state_ram_rden = (do_read && sdb_st_fire); // @ rdma_ctyun_sdpram.scala l65
  assign id_rd_out_crrl_cnt = id_state_ram_dout[4 : 0]; // @ UInt.scala l381
  assign id_rd_out_ssn = id_state_ram_dout[28 : 5]; // @ UInt.scala l381
  assign id_rd_out_ce_bit = id_state_ram_dout[29]; // @ Bool.scala l209
  assign id_rd_out_last_psn = id_state_ram_dout[53 : 30]; // @ UInt.scala l381
  assign id_rd_out_first_psn = id_state_ram_dout[77 : 54]; // @ UInt.scala l381
  assign it_state_ram_rden = (do_read && sdb_st_fire); // @ rdma_ctyun_sdpram.scala l65
  assign it_rd_out_finish_flag = it_state_ram_dout[0]; // @ Bool.scala l209
  assign it_rd_out_interrupt_bit = it_state_ram_dout[1]; // @ Bool.scala l209
  assign it_rd_out_dma_length = it_state_ram_dout[33 : 2]; // @ UInt.scala l381
  assign it_rd_out_sqe_rkey = it_state_ram_dout[65 : 34]; // @ Bits.scala l133
  assign it_rd_out_sqe_va = it_state_ram_dout[129 : 66]; // @ UInt.scala l381
  assign it_rd_out_sge_num = it_state_ram_dout[132 : 130]; // @ UInt.scala l381
  assign it_rd_out_last_rd_rsp_opcode = it_state_ram_dout[140 : 133]; // @ Bits.scala l133
  assign it_rd_out_sq_wqe_index = it_state_ram_dout[156 : 141]; // @ UInt.scala l381
  assign crrl_state_rd_out_id_state_crrl_cnt = id_rd_out_crrl_cnt; // @ crrl_update.scala l175
  assign crrl_state_rd_out_id_state_ssn = id_rd_out_ssn; // @ crrl_update.scala l175
  assign crrl_state_rd_out_id_state_ce_bit = id_rd_out_ce_bit; // @ crrl_update.scala l175
  assign crrl_state_rd_out_id_state_last_psn = id_rd_out_last_psn; // @ crrl_update.scala l175
  assign crrl_state_rd_out_id_state_first_psn = id_rd_out_first_psn; // @ crrl_update.scala l175
  assign crrl_state_rd_out_it_state_finish_flag = it_rd_out_finish_flag; // @ crrl_update.scala l176
  assign crrl_state_rd_out_it_state_interrupt_bit = it_rd_out_interrupt_bit; // @ crrl_update.scala l176
  assign crrl_state_rd_out_it_state_dma_length = it_rd_out_dma_length; // @ crrl_update.scala l176
  assign crrl_state_rd_out_it_state_sqe_rkey = it_rd_out_sqe_rkey; // @ crrl_update.scala l176
  assign crrl_state_rd_out_it_state_sqe_va = it_rd_out_sqe_va; // @ crrl_update.scala l176
  assign crrl_state_rd_out_it_state_sge_num = it_rd_out_sge_num; // @ crrl_update.scala l176
  assign crrl_state_rd_out_it_state_last_rd_rsp_opcode = it_rd_out_last_rd_rsp_opcode; // @ crrl_update.scala l176
  assign crrl_state_rd_out_it_state_sq_wqe_index = it_rd_out_sq_wqe_index; // @ crrl_update.scala l176
  assign crrl_rsp_push_payload_crrl_sdb_module_id = sdb_pipe_st_payload_module_id; // @ crrl_update.scala l179
  assign crrl_rsp_push_payload_crrl_sdb_req_id = sdb_pipe_st_payload_req_id; // @ crrl_update.scala l179
  assign crrl_rsp_push_payload_crrl_sdb_qpn = sdb_pipe_st_payload_qpn; // @ crrl_update.scala l179
  assign crrl_rsp_push_payload_crrl_sdb_req_type = sdb_pipe_st_payload_req_type; // @ crrl_update.scala l179
  always @(*) begin
    crrl_rsp_push_payload_crrl_sdb_status = sdb_pipe_st_payload_status; // @ crrl_update.scala l179
    if(((sdb_pipe_st_payload_status == 4'b0000) && rx_wqe_others_no_it)) begin
      crrl_rsp_push_payload_crrl_sdb_status = 4'b0010; // @ crrl_update.scala l181
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_id_state_crrl_cnt = (back_pre ? crrl_state_rd_out_reg_id_state_crrl_cnt : crrl_state_rd_out_id_state_crrl_cnt); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_id_state_crrl_cnt = tmp_crrl_rsp_push_payload_crr_state_id_state_crrl_cnt_1[4 : 0]; // @ UInt.scala l381
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_id_state_ssn = (back_pre ? crrl_state_rd_out_reg_id_state_ssn : crrl_state_rd_out_id_state_ssn); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_id_state_ssn = tmp_crrl_rsp_push_payload_crr_state_id_state_crrl_cnt_1[28 : 5]; // @ UInt.scala l381
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_id_state_ce_bit = (back_pre ? crrl_state_rd_out_reg_id_state_ce_bit : crrl_state_rd_out_id_state_ce_bit); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_id_state_ce_bit = tmp_crrl_rsp_push_payload_crr_state_id_state_crrl_cnt_1[29]; // @ Bool.scala l209
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_id_state_last_psn = (back_pre ? crrl_state_rd_out_reg_id_state_last_psn : crrl_state_rd_out_id_state_last_psn); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_id_state_last_psn = tmp_crrl_rsp_push_payload_crr_state_id_state_crrl_cnt_1[53 : 30]; // @ UInt.scala l381
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_id_state_first_psn = (back_pre ? crrl_state_rd_out_reg_id_state_first_psn : crrl_state_rd_out_id_state_first_psn); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_id_state_first_psn = tmp_crrl_rsp_push_payload_crr_state_id_state_crrl_cnt_1[77 : 54]; // @ UInt.scala l381
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_it_state_finish_flag = (back_pre ? crrl_state_rd_out_reg_it_state_finish_flag : crrl_state_rd_out_it_state_finish_flag); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_it_state_finish_flag = tmp_crrl_rsp_push_payload_crr_state_it_state_finish_flag[0]; // @ Bool.scala l209
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_it_state_interrupt_bit = (back_pre ? crrl_state_rd_out_reg_it_state_interrupt_bit : crrl_state_rd_out_it_state_interrupt_bit); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_it_state_interrupt_bit = tmp_crrl_rsp_push_payload_crr_state_it_state_finish_flag[1]; // @ Bool.scala l209
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_it_state_dma_length = (back_pre ? crrl_state_rd_out_reg_it_state_dma_length : crrl_state_rd_out_it_state_dma_length); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_it_state_dma_length = tmp_crrl_rsp_push_payload_crr_state_it_state_finish_flag[33 : 2]; // @ UInt.scala l381
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_it_state_sqe_rkey = (back_pre ? crrl_state_rd_out_reg_it_state_sqe_rkey : crrl_state_rd_out_it_state_sqe_rkey); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_it_state_sqe_rkey = tmp_crrl_rsp_push_payload_crr_state_it_state_finish_flag[65 : 34]; // @ Bits.scala l133
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_it_state_sqe_va = (back_pre ? crrl_state_rd_out_reg_it_state_sqe_va : crrl_state_rd_out_it_state_sqe_va); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_it_state_sqe_va = tmp_crrl_rsp_push_payload_crr_state_it_state_finish_flag[129 : 66]; // @ UInt.scala l381
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_it_state_sge_num = (back_pre ? crrl_state_rd_out_reg_it_state_sge_num : crrl_state_rd_out_it_state_sge_num); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_it_state_sge_num = tmp_crrl_rsp_push_payload_crr_state_it_state_finish_flag[132 : 130]; // @ UInt.scala l381
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_it_state_last_rd_rsp_opcode = (back_pre ? crrl_state_rd_out_reg_it_state_last_rd_rsp_opcode : crrl_state_rd_out_it_state_last_rd_rsp_opcode); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_it_state_last_rd_rsp_opcode = tmp_crrl_rsp_push_payload_crr_state_it_state_finish_flag[140 : 133]; // @ Bits.scala l133
    end
  end

  always @(*) begin
    if(tmp_when) begin
      crrl_rsp_push_payload_crr_state_it_state_sq_wqe_index = (back_pre ? crrl_state_rd_out_reg_it_state_sq_wqe_index : crrl_state_rd_out_it_state_sq_wqe_index); // @ crrl_update.scala l184
    end else begin
      crrl_rsp_push_payload_crr_state_it_state_sq_wqe_index = tmp_crrl_rsp_push_payload_crr_state_it_state_finish_flag[156 : 141]; // @ UInt.scala l381
    end
  end

  assign tmp_crrl_rsp_push_payload_crr_state_id_state_crrl_cnt = 235'h0; // @ BitVector.scala l494
  assign tmp_crrl_rsp_push_payload_crr_state_id_state_crrl_cnt_1 = tmp_crrl_rsp_push_payload_crr_state_id_state_crrl_cnt[77 : 0]; // @ BaseType.scala l299
  assign tmp_crrl_rsp_push_payload_crr_state_it_state_finish_flag = tmp_crrl_rsp_push_payload_crr_state_id_state_crrl_cnt[234 : 78]; // @ BaseType.scala l299
  always @(*) begin
    crrl_rsp_push_ready = crrl_rsp_push_m2sPipe_ready; // @ Stream.scala l374
    if((! crrl_rsp_push_m2sPipe_valid)) begin
      crrl_rsp_push_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign crrl_rsp_push_m2sPipe_valid = crrl_rsp_push_rValid; // @ Stream.scala l377
  assign crrl_rsp_push_m2sPipe_payload_crr_state_id_state_crrl_cnt = crrl_rsp_push_rData_crr_state_id_state_crrl_cnt; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_id_state_ssn = crrl_rsp_push_rData_crr_state_id_state_ssn; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_id_state_ce_bit = crrl_rsp_push_rData_crr_state_id_state_ce_bit; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_id_state_last_psn = crrl_rsp_push_rData_crr_state_id_state_last_psn; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_id_state_first_psn = crrl_rsp_push_rData_crr_state_id_state_first_psn; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_it_state_finish_flag = crrl_rsp_push_rData_crr_state_it_state_finish_flag; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_it_state_interrupt_bit = crrl_rsp_push_rData_crr_state_it_state_interrupt_bit; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_it_state_dma_length = crrl_rsp_push_rData_crr_state_it_state_dma_length; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sqe_rkey = crrl_rsp_push_rData_crr_state_it_state_sqe_rkey; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sqe_va = crrl_rsp_push_rData_crr_state_it_state_sqe_va; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sge_num = crrl_rsp_push_rData_crr_state_it_state_sge_num; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_it_state_last_rd_rsp_opcode = crrl_rsp_push_rData_crr_state_it_state_last_rd_rsp_opcode; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sq_wqe_index = crrl_rsp_push_rData_crr_state_it_state_sq_wqe_index; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crrl_sdb_module_id = crrl_rsp_push_rData_crrl_sdb_module_id; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crrl_sdb_req_id = crrl_rsp_push_rData_crrl_sdb_req_id; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crrl_sdb_qpn = crrl_rsp_push_rData_crrl_sdb_qpn; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crrl_sdb_req_type = crrl_rsp_push_rData_crrl_sdb_req_type; // @ Stream.scala l378
  assign crrl_rsp_push_m2sPipe_payload_crrl_sdb_status = crrl_rsp_push_rData_crrl_sdb_status; // @ Stream.scala l378
  assign crrl_rsp_valid = crrl_rsp_push_m2sPipe_valid; // @ crrl_update.scala l189
  assign crrl_rsp_push_m2sPipe_ready = crrl_rsp_ready; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_id_state_crrl_cnt = crrl_rsp_push_m2sPipe_payload_crr_state_id_state_crrl_cnt; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_id_state_ssn = crrl_rsp_push_m2sPipe_payload_crr_state_id_state_ssn; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_id_state_ce_bit = crrl_rsp_push_m2sPipe_payload_crr_state_id_state_ce_bit; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_id_state_last_psn = crrl_rsp_push_m2sPipe_payload_crr_state_id_state_last_psn; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_id_state_first_psn = crrl_rsp_push_m2sPipe_payload_crr_state_id_state_first_psn; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_it_state_finish_flag = crrl_rsp_push_m2sPipe_payload_crr_state_it_state_finish_flag; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_it_state_interrupt_bit = crrl_rsp_push_m2sPipe_payload_crr_state_it_state_interrupt_bit; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_it_state_dma_length = crrl_rsp_push_m2sPipe_payload_crr_state_it_state_dma_length; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_it_state_sqe_rkey = crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sqe_rkey; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_it_state_sqe_va = crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sqe_va; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_it_state_sge_num = crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sge_num; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_it_state_last_rd_rsp_opcode = crrl_rsp_push_m2sPipe_payload_crr_state_it_state_last_rd_rsp_opcode; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crr_state_it_state_sq_wqe_index = crrl_rsp_push_m2sPipe_payload_crr_state_it_state_sq_wqe_index; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crrl_sdb_module_id = crrl_rsp_push_m2sPipe_payload_crrl_sdb_module_id; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crrl_sdb_req_id = crrl_rsp_push_m2sPipe_payload_crrl_sdb_req_id; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crrl_sdb_qpn = crrl_rsp_push_m2sPipe_payload_crrl_sdb_qpn; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crrl_sdb_req_type = crrl_rsp_push_m2sPipe_payload_crrl_sdb_req_type; // @ crrl_update.scala l189
  assign crrl_rsp_payload_crrl_sdb_status = crrl_rsp_push_m2sPipe_payload_crrl_sdb_status; // @ crrl_update.scala l189
  assign sdb_pipe_st_ready = crrl_rsp_push_ready; // @ crrl_update.scala l192
  assign crrl_rsp_push_valid = sdb_pipe_st_valid; // @ crrl_update.scala l193
  always @(posedge clk) begin
    if(reset) begin
      crrl_req_rValid <= 1'b0; // @ Data.scala l409
      sched_req_pop_rValid <= 1'b0; // @ Data.scala l409
      sdb_st_rValid <= 1'b0; // @ Data.scala l409
      sdb_st_m2sPipe_rValid <= 1'b0; // @ Data.scala l409
      back_pre <= 1'b0; // @ Data.scala l409
      crrl_rsp_push_rValid <= 1'b0; // @ Data.scala l409
    end else begin
      if(crrl_req_ready) begin
        crrl_req_rValid <= crrl_req_valid; // @ Stream.scala l365
      end
      if(sched_req_pop_ready) begin
        sched_req_pop_rValid <= sched_req_pop_valid; // @ Stream.scala l365
      end
      if(sdb_st_ready) begin
        sdb_st_rValid <= sdb_st_valid; // @ Stream.scala l365
      end
      if(sdb_st_m2sPipe_ready) begin
        sdb_st_m2sPipe_rValid <= sdb_st_m2sPipe_valid; // @ Stream.scala l365
      end
      if((crrl_rsp_push_valid && (! crrl_rsp_push_ready))) begin
        back_pre <= 1'b1; // @ crrl_update.scala l178
      end
      if(crrl_rsp_push_ready) begin
        back_pre <= 1'b0; // @ crrl_update.scala l178
      end
      if(crrl_rsp_push_ready) begin
        crrl_rsp_push_rValid <= crrl_rsp_push_valid; // @ Stream.scala l365
      end
    end
  end

  always @(posedge clk) begin
    if(crrl_req_ready) begin
      crrl_req_rData_crr_state_id_state_crrl_cnt <= crrl_req_payload_crr_state_id_state_crrl_cnt; // @ Stream.scala l366
      crrl_req_rData_crr_state_id_state_ssn <= crrl_req_payload_crr_state_id_state_ssn; // @ Stream.scala l366
      crrl_req_rData_crr_state_id_state_ce_bit <= crrl_req_payload_crr_state_id_state_ce_bit; // @ Stream.scala l366
      crrl_req_rData_crr_state_id_state_last_psn <= crrl_req_payload_crr_state_id_state_last_psn; // @ Stream.scala l366
      crrl_req_rData_crr_state_id_state_first_psn <= crrl_req_payload_crr_state_id_state_first_psn; // @ Stream.scala l366
      crrl_req_rData_crr_state_it_state_finish_flag <= crrl_req_payload_crr_state_it_state_finish_flag; // @ Stream.scala l366
      crrl_req_rData_crr_state_it_state_interrupt_bit <= crrl_req_payload_crr_state_it_state_interrupt_bit; // @ Stream.scala l366
      crrl_req_rData_crr_state_it_state_dma_length <= crrl_req_payload_crr_state_it_state_dma_length; // @ Stream.scala l366
      crrl_req_rData_crr_state_it_state_sqe_rkey <= crrl_req_payload_crr_state_it_state_sqe_rkey; // @ Stream.scala l366
      crrl_req_rData_crr_state_it_state_sqe_va <= crrl_req_payload_crr_state_it_state_sqe_va; // @ Stream.scala l366
      crrl_req_rData_crr_state_it_state_sge_num <= crrl_req_payload_crr_state_it_state_sge_num; // @ Stream.scala l366
      crrl_req_rData_crr_state_it_state_last_rd_rsp_opcode <= crrl_req_payload_crr_state_it_state_last_rd_rsp_opcode; // @ Stream.scala l366
      crrl_req_rData_crr_state_it_state_sq_wqe_index <= crrl_req_payload_crr_state_it_state_sq_wqe_index; // @ Stream.scala l366
      crrl_req_rData_crrl_sdb_module_id <= crrl_req_payload_crrl_sdb_module_id; // @ Stream.scala l366
      crrl_req_rData_crrl_sdb_req_id <= crrl_req_payload_crrl_sdb_req_id; // @ Stream.scala l366
      crrl_req_rData_crrl_sdb_qpn <= crrl_req_payload_crrl_sdb_qpn; // @ Stream.scala l366
      crrl_req_rData_crrl_sdb_req_type <= crrl_req_payload_crrl_sdb_req_type; // @ Stream.scala l366
      crrl_req_rData_crrl_sdb_status <= crrl_req_payload_crrl_sdb_status; // @ Stream.scala l366
    end
    if(sched_req_pop_ready) begin
      sched_req_pop_rData_crr_state_id_state_crrl_cnt <= sched_req_pop_payload_crr_state_id_state_crrl_cnt; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_id_state_ssn <= sched_req_pop_payload_crr_state_id_state_ssn; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_id_state_ce_bit <= sched_req_pop_payload_crr_state_id_state_ce_bit; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_id_state_last_psn <= sched_req_pop_payload_crr_state_id_state_last_psn; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_id_state_first_psn <= sched_req_pop_payload_crr_state_id_state_first_psn; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_it_state_finish_flag <= sched_req_pop_payload_crr_state_it_state_finish_flag; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_it_state_interrupt_bit <= sched_req_pop_payload_crr_state_it_state_interrupt_bit; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_it_state_dma_length <= sched_req_pop_payload_crr_state_it_state_dma_length; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_it_state_sqe_rkey <= sched_req_pop_payload_crr_state_it_state_sqe_rkey; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_it_state_sqe_va <= sched_req_pop_payload_crr_state_it_state_sqe_va; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_it_state_sge_num <= sched_req_pop_payload_crr_state_it_state_sge_num; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_it_state_last_rd_rsp_opcode <= sched_req_pop_payload_crr_state_it_state_last_rd_rsp_opcode; // @ Stream.scala l366
      sched_req_pop_rData_crr_state_it_state_sq_wqe_index <= sched_req_pop_payload_crr_state_it_state_sq_wqe_index; // @ Stream.scala l366
      sched_req_pop_rData_crrl_sdb_module_id <= sched_req_pop_payload_crrl_sdb_module_id; // @ Stream.scala l366
      sched_req_pop_rData_crrl_sdb_req_id <= sched_req_pop_payload_crrl_sdb_req_id; // @ Stream.scala l366
      sched_req_pop_rData_crrl_sdb_qpn <= sched_req_pop_payload_crrl_sdb_qpn; // @ Stream.scala l366
      sched_req_pop_rData_crrl_sdb_req_type <= sched_req_pop_payload_crrl_sdb_req_type; // @ Stream.scala l366
      sched_req_pop_rData_crrl_sdb_status <= sched_req_pop_payload_crrl_sdb_status; // @ Stream.scala l366
    end
    if(sdb_st_ready) begin
      sdb_st_rData_module_id <= sdb_st_payload_module_id; // @ Stream.scala l366
      sdb_st_rData_req_id <= sdb_st_payload_req_id; // @ Stream.scala l366
      sdb_st_rData_qpn <= sdb_st_payload_qpn; // @ Stream.scala l366
      sdb_st_rData_req_type <= sdb_st_payload_req_type; // @ Stream.scala l366
      sdb_st_rData_status <= sdb_st_payload_status; // @ Stream.scala l366
    end
    if(sdb_st_m2sPipe_ready) begin
      sdb_st_m2sPipe_rData_module_id <= sdb_st_m2sPipe_payload_module_id; // @ Stream.scala l366
      sdb_st_m2sPipe_rData_req_id <= sdb_st_m2sPipe_payload_req_id; // @ Stream.scala l366
      sdb_st_m2sPipe_rData_qpn <= sdb_st_m2sPipe_payload_qpn; // @ Stream.scala l366
      sdb_st_m2sPipe_rData_req_type <= sdb_st_m2sPipe_payload_req_type; // @ Stream.scala l366
      sdb_st_m2sPipe_rData_status <= sdb_st_m2sPipe_payload_status; // @ Stream.scala l366
    end
    if(((! crrl_rsp_push_ready) && (! back_pre))) begin
      crrl_state_rd_out_reg_id_state_crrl_cnt <= crrl_state_rd_out_id_state_crrl_cnt; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_id_state_ssn <= crrl_state_rd_out_id_state_ssn; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_id_state_ce_bit <= crrl_state_rd_out_id_state_ce_bit; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_id_state_last_psn <= crrl_state_rd_out_id_state_last_psn; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_id_state_first_psn <= crrl_state_rd_out_id_state_first_psn; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_it_state_finish_flag <= crrl_state_rd_out_it_state_finish_flag; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_it_state_interrupt_bit <= crrl_state_rd_out_it_state_interrupt_bit; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_it_state_dma_length <= crrl_state_rd_out_it_state_dma_length; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_it_state_sqe_rkey <= crrl_state_rd_out_it_state_sqe_rkey; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_it_state_sqe_va <= crrl_state_rd_out_it_state_sqe_va; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_it_state_sge_num <= crrl_state_rd_out_it_state_sge_num; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_it_state_last_rd_rsp_opcode <= crrl_state_rd_out_it_state_last_rd_rsp_opcode; // @ crrl_update.scala l119
      crrl_state_rd_out_reg_it_state_sq_wqe_index <= crrl_state_rd_out_it_state_sq_wqe_index; // @ crrl_update.scala l119
    end
    if(crrl_rsp_push_ready) begin
      crrl_rsp_push_rData_crr_state_id_state_crrl_cnt <= crrl_rsp_push_payload_crr_state_id_state_crrl_cnt; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_id_state_ssn <= crrl_rsp_push_payload_crr_state_id_state_ssn; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_id_state_ce_bit <= crrl_rsp_push_payload_crr_state_id_state_ce_bit; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_id_state_last_psn <= crrl_rsp_push_payload_crr_state_id_state_last_psn; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_id_state_first_psn <= crrl_rsp_push_payload_crr_state_id_state_first_psn; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_it_state_finish_flag <= crrl_rsp_push_payload_crr_state_it_state_finish_flag; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_it_state_interrupt_bit <= crrl_rsp_push_payload_crr_state_it_state_interrupt_bit; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_it_state_dma_length <= crrl_rsp_push_payload_crr_state_it_state_dma_length; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_it_state_sqe_rkey <= crrl_rsp_push_payload_crr_state_it_state_sqe_rkey; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_it_state_sqe_va <= crrl_rsp_push_payload_crr_state_it_state_sqe_va; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_it_state_sge_num <= crrl_rsp_push_payload_crr_state_it_state_sge_num; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_it_state_last_rd_rsp_opcode <= crrl_rsp_push_payload_crr_state_it_state_last_rd_rsp_opcode; // @ Stream.scala l366
      crrl_rsp_push_rData_crr_state_it_state_sq_wqe_index <= crrl_rsp_push_payload_crr_state_it_state_sq_wqe_index; // @ Stream.scala l366
      crrl_rsp_push_rData_crrl_sdb_module_id <= crrl_rsp_push_payload_crrl_sdb_module_id; // @ Stream.scala l366
      crrl_rsp_push_rData_crrl_sdb_req_id <= crrl_rsp_push_payload_crrl_sdb_req_id; // @ Stream.scala l366
      crrl_rsp_push_rData_crrl_sdb_qpn <= crrl_rsp_push_payload_crrl_sdb_qpn; // @ Stream.scala l366
      crrl_rsp_push_rData_crrl_sdb_req_type <= crrl_rsp_push_payload_crrl_sdb_req_type; // @ Stream.scala l366
      crrl_rsp_push_rData_crrl_sdb_status <= crrl_rsp_push_payload_crrl_sdb_status; // @ Stream.scala l366
    end
  end


endmodule
