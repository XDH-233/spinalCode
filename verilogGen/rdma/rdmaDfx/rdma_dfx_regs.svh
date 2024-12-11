typedef struct packed{
  logic [31:0] cmdq_fsm_state_db_proc; // fsm state of db process
  logic [31:0] cmdq_fsm_state_avst_width; // fsm state of avst width half
  logic [31:0] cmdq_fsm_state_dma_rreq_proc; // fsm state of dma rreq process
  logic [31:0] cmdq_cmd_id_bitmap; // bitmap of cmd_ids
  logic [31:0] cmdq_fsm_state_cmd_parser; // fsm state of cmd parser
  logic [31:0] cmdq_fsm_state_cmd_rsp_proc; // fsm state of cmd rsp proc
} t_cmdq_dfx;

typedef struct packed{
  t_cmdq_dfx cmdq;
} rdma_dfx_regs;
