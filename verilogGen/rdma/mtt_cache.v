// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : mtt_cache
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766
// Gen time  : 2024-12-09 15:52:04



module mtt_cache (
  input  wire          mtt_qry_valid,
  output wire          mtt_qry_ready,
  input  wire          mtt_qry_mr_tran_din_sop,
  input  wire          mtt_qry_mr_tran_din_eop,
  input  wire          mtt_qry_mr_tran_din_err,
  input  wire          mtt_qry_mr_tran_din_need_trans,
  input  wire [4:0]    mtt_qry_mr_tran_din_log_entity_sz,
  input  wire [63:0]   mtt_qry_mr_tran_din_mtt_pba,
  input  wire [31:0]   mtt_qry_mr_tran_din_trans_len,
  input  wire [31:0]   mtt_qry_mr_tran_din_trans_sofst,
  input  wire [14:0]   mtt_qry_mr_tran_din_mr_idx,
  input  wire [25:0]   mtt_qry_spge_idx,
  input  wire [25:0]   mtt_qry_epge_idx,
  output wire          mtt_trans_valid,
  input  wire          mtt_trans_ready,
  output wire          mtt_trans_sop,
  output wire          mtt_trans_eop,
  output wire [4:0]    mtt_trans_log_entity_sz,
  output wire [63:0]   mtt_trans_trans_pba,
  output wire [31:0]   mtt_trans_trans_len,
  output wire          dma_rdreq_valid,
  input  wire          dma_rdreq_ready,
  output wire [8:0]    dma_rdreq_dma_len,
  output wire [63:0]   dma_rdreq_dma_pa,
  output wire [4:0]    dma_rdreq_cl_num,
  output wire          dma_rrsp_ready,
  input  wire          dma_rrsp_valid,
  input  wire [511:0]  dma_rrsp_data,
  input  wire [4:0]    dma_rrsp_cl_num,
  input  wire          dma_rrsp_eop,
  input  wire          dma_rrsp_sop,
  output wire          mtt_qry_ff_afull,
  input  wire          reset,
  input  wire          clk
);

  wire       [203:0]  mtt_qry_fifo_din;
  wire       [77:0]   dma_rreq_fifo_din;
  wire       [162:0]  qry_tmp_reorder_fifo_din;
  wire       [518:0]  dma_rrsp_fifo_din;
  wire                mtt_qry_fifo_full;
  wire       [203:0]  mtt_qry_fifo_dout;
  wire                mtt_qry_fifo_empty;
  wire                mtt_qry_fifo_almost_empty;
  wire                mtt_qry_fifo_almost_full;
  wire       [5:0]    mtt_qry_fifo_usedw;
  wire                mtt_qry_fifo_overflow;
  wire                mtt_qry_fifo_underflow;
  wire                dma_rreq_fifo_full;
  wire       [77:0]   dma_rreq_fifo_dout;
  wire                dma_rreq_fifo_empty;
  wire                dma_rreq_fifo_almost_empty;
  wire                dma_rreq_fifo_almost_full;
  wire       [4:0]    dma_rreq_fifo_usedw;
  wire                dma_rreq_fifo_overflow;
  wire                dma_rreq_fifo_underflow;
  wire                qry_tmp_reorder_fifo_full;
  wire       [162:0]  qry_tmp_reorder_fifo_dout;
  wire                qry_tmp_reorder_fifo_empty;
  wire                qry_tmp_reorder_fifo_almost_empty;
  wire                qry_tmp_reorder_fifo_almost_full;
  wire       [6:0]    qry_tmp_reorder_fifo_usedw;
  wire                qry_tmp_reorder_fifo_overflow;
  wire                qry_tmp_reorder_fifo_underflow;
  wire                dma_rrsp_fifo_full;
  wire       [518:0]  dma_rrsp_fifo_dout;
  wire                dma_rrsp_fifo_empty;
  wire                dma_rrsp_fifo_almost_empty;
  wire                dma_rrsp_fifo_almost_full;
  wire       [4:0]    dma_rrsp_fifo_usedw;
  wire                dma_rrsp_fifo_overflow;
  wire                dma_rrsp_fifo_underflow;
  wire       [511:0]  data_ram_dout;
  reg                 tmp_plru_ctrl_plru_evict_logic_1_validCheck_notOks_0;
  reg                 tmp_plru_ctrl_plru_evict_logic_1_validCheck_notOks_1;
  reg                 tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_0;
  reg                 tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_1;
  reg                 tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_0;
  reg                 tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_1;
  reg                 tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0;
  reg                 tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_0_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_0_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_1_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_1_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_2_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_2_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_3_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_3_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_4_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_4_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_5_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_5_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_6_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_6_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_7_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_7_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_8_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_8_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_9_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_9_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_10_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_10_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_11_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_11_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_12_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_12_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_13_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_13_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_14_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_14_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_15_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_15_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_16_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_16_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_17_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_17_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_18_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_18_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_19_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_19_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_20_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_20_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_21_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_21_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_22_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_22_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_23_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_23_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_24_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_24_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_25_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_25_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_26_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_26_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_27_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_27_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_28_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_28_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_29_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_29_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_30_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_30_valueNext_1;
  wire       [11:0]   tmp_plru_ctrl_aging_logic_cnts_31_valueNext;
  wire       [0:0]    tmp_plru_ctrl_aging_logic_cnts_31_valueNext_1;
  wire                tmp_when;
  wire                tmp_when_1;
  wire                tmp_when_2;
  wire                tmp_when_3;
  wire                tmp_when_4;
  wire                tmp_when_5;
  wire                tmp_when_6;
  wire                tmp_when_7;
  wire                tmp_when_8;
  wire                tmp_when_9;
  wire                tmp_when_10;
  wire                tmp_when_11;
  wire                tmp_when_12;
  wire                tmp_when_13;
  wire                tmp_when_14;
  wire                tmp_when_15;
  wire                tmp_when_16;
  wire                tmp_when_17;
  wire                tmp_when_18;
  wire                tmp_when_19;
  wire                tmp_when_20;
  wire                tmp_when_21;
  wire                tmp_when_22;
  wire                tmp_when_23;
  wire                tmp_when_24;
  wire                tmp_when_25;
  wire                tmp_when_26;
  wire                tmp_when_27;
  wire                tmp_when_28;
  wire                tmp_when_29;
  wire                tmp_when_30;
  wire                tmp_when_31;
  wire       [0:0]    tmp_plru_ctrl_plru_io_context_valids;
  wire       [20:0]   tmp_plru_ctrl_plru_io_context_valids_1;
  wire       [0:0]    tmp_plru_ctrl_plru_io_context_valids_2;
  wire       [9:0]    tmp_plru_ctrl_plru_io_context_valids_3;
  wire       [0:0]    tmp_hit_miss_logic_hit;
  wire       [20:0]   tmp_hit_miss_logic_hit_1;
  wire       [0:0]    tmp_hit_miss_logic_hit_2;
  wire       [9:0]    tmp_hit_miss_logic_hit_3;
  wire       [25:0]   tmp_miss_dma_logic_spge_ofst;
  wire       [20:0]   tmp_miss_dma_logic_spge_ofst_1;
  wire       [63:0]   tmp_miss_dma_logic_dma_rreq_push_payload_dma_pa;
  wire       [0:0]    tmp_din;
  wire       [0:0]    tmp_din_1;
  wire       [6:0]    tmp_cache_ram_rw_logic_waddr;
  wire       [6:0]    tmp_cache_ram_rw_logic_waddr_1;
  reg        [63:0]   tmp_mtt_trans_gen_logic_rpl_mtt_pa;
  wire       [63:0]   tmp_mtt_trans_gen_logic_rpl_mtt_pa_1;
  wire       [63:0]   tmp_mtt_trans_gen_logic_cached_mtt_pa;
  wire       [31:0]   tmp_mtt_trans_gen_logic_cached_mtt_pa_1;
  reg        [63:0]   tmp_mtt_trans_gen_logic_cached_mtt_pa_2;
  wire       [20:0]   tmp_tmp_qry_tags_0_spge_tag;
  wire       [15:0]   tmp_qry_cnt_valueNext;
  wire       [0:0]    tmp_qry_cnt_valueNext_1;
  wire       [15:0]   tmp_hit_cnt_valueNext;
  wire       [0:0]    tmp_hit_cnt_valueNext_1;
  wire                mtt_qry_pop_valid;
  wire                mtt_qry_pop_ready;
  wire                mtt_qry_pop_payload_mr_tran_din_sop;
  wire                mtt_qry_pop_payload_mr_tran_din_eop;
  wire                mtt_qry_pop_payload_mr_tran_din_err;
  wire                mtt_qry_pop_payload_mr_tran_din_need_trans;
  wire       [4:0]    mtt_qry_pop_payload_mr_tran_din_log_entity_sz;
  wire       [63:0]   mtt_qry_pop_payload_mr_tran_din_mtt_pba;
  wire       [31:0]   mtt_qry_pop_payload_mr_tran_din_trans_len;
  wire       [31:0]   mtt_qry_pop_payload_mr_tran_din_trans_sofst;
  wire       [14:0]   mtt_qry_pop_payload_mr_tran_din_mr_idx;
  wire       [25:0]   mtt_qry_pop_payload_spge_idx;
  wire       [25:0]   mtt_qry_pop_payload_epge_idx;
  wire                mtt_qry_push_valid;
  wire                mtt_qry_push_ready;
  wire                mtt_qry_push_payload_mr_tran_din_sop;
  wire                mtt_qry_push_payload_mr_tran_din_eop;
  wire                mtt_qry_push_payload_mr_tran_din_err;
  wire                mtt_qry_push_payload_mr_tran_din_need_trans;
  wire       [4:0]    mtt_qry_push_payload_mr_tran_din_log_entity_sz;
  wire       [63:0]   mtt_qry_push_payload_mr_tran_din_mtt_pba;
  wire       [31:0]   mtt_qry_push_payload_mr_tran_din_trans_len;
  wire       [31:0]   mtt_qry_push_payload_mr_tran_din_trans_sofst;
  wire       [14:0]   mtt_qry_push_payload_mr_tran_din_mr_idx;
  wire       [25:0]   mtt_qry_push_payload_spge_idx;
  wire       [25:0]   mtt_qry_push_payload_epge_idx;
  wire       [151:0]  tmp_mtt_qry_pop_payload_mr_tran_din_sop;
  reg        [25:0]   qry_tags_0_spge_tag;
  reg        [14:0]   qry_tags_0_mr_idx;
  reg        [25:0]   qry_tags_1_spge_tag;
  reg        [14:0]   qry_tags_1_mr_idx;
  reg        [25:0]   qry_tags_2_spge_tag;
  reg        [14:0]   qry_tags_2_mr_idx;
  reg        [25:0]   qry_tags_3_spge_tag;
  reg        [14:0]   qry_tags_3_mr_idx;
  reg        [25:0]   qry_tags_4_spge_tag;
  reg        [14:0]   qry_tags_4_mr_idx;
  reg        [25:0]   qry_tags_5_spge_tag;
  reg        [14:0]   qry_tags_5_mr_idx;
  reg        [25:0]   qry_tags_6_spge_tag;
  reg        [14:0]   qry_tags_6_mr_idx;
  reg        [25:0]   qry_tags_7_spge_tag;
  reg        [14:0]   qry_tags_7_mr_idx;
  reg        [25:0]   qry_tags_8_spge_tag;
  reg        [14:0]   qry_tags_8_mr_idx;
  reg        [25:0]   qry_tags_9_spge_tag;
  reg        [14:0]   qry_tags_9_mr_idx;
  reg        [25:0]   qry_tags_10_spge_tag;
  reg        [14:0]   qry_tags_10_mr_idx;
  reg        [25:0]   qry_tags_11_spge_tag;
  reg        [14:0]   qry_tags_11_mr_idx;
  reg        [25:0]   qry_tags_12_spge_tag;
  reg        [14:0]   qry_tags_12_mr_idx;
  reg        [25:0]   qry_tags_13_spge_tag;
  reg        [14:0]   qry_tags_13_mr_idx;
  reg        [25:0]   qry_tags_14_spge_tag;
  reg        [14:0]   qry_tags_14_mr_idx;
  reg        [25:0]   qry_tags_15_spge_tag;
  reg        [14:0]   qry_tags_15_mr_idx;
  reg        [25:0]   qry_tags_16_spge_tag;
  reg        [14:0]   qry_tags_16_mr_idx;
  reg        [25:0]   qry_tags_17_spge_tag;
  reg        [14:0]   qry_tags_17_mr_idx;
  reg        [25:0]   qry_tags_18_spge_tag;
  reg        [14:0]   qry_tags_18_mr_idx;
  reg        [25:0]   qry_tags_19_spge_tag;
  reg        [14:0]   qry_tags_19_mr_idx;
  reg        [25:0]   qry_tags_20_spge_tag;
  reg        [14:0]   qry_tags_20_mr_idx;
  reg        [25:0]   qry_tags_21_spge_tag;
  reg        [14:0]   qry_tags_21_mr_idx;
  reg        [25:0]   qry_tags_22_spge_tag;
  reg        [14:0]   qry_tags_22_mr_idx;
  reg        [25:0]   qry_tags_23_spge_tag;
  reg        [14:0]   qry_tags_23_mr_idx;
  reg        [25:0]   qry_tags_24_spge_tag;
  reg        [14:0]   qry_tags_24_mr_idx;
  reg        [25:0]   qry_tags_25_spge_tag;
  reg        [14:0]   qry_tags_25_mr_idx;
  reg        [25:0]   qry_tags_26_spge_tag;
  reg        [14:0]   qry_tags_26_mr_idx;
  reg        [25:0]   qry_tags_27_spge_tag;
  reg        [14:0]   qry_tags_27_mr_idx;
  reg        [25:0]   qry_tags_28_spge_tag;
  reg        [14:0]   qry_tags_28_mr_idx;
  reg        [25:0]   qry_tags_29_spge_tag;
  reg        [14:0]   qry_tags_29_mr_idx;
  reg        [25:0]   qry_tags_30_spge_tag;
  reg        [14:0]   qry_tags_30_mr_idx;
  reg        [25:0]   qry_tags_31_spge_tag;
  reg        [14:0]   qry_tags_31_mr_idx;
  wire                plru_qry_update_valid;
  wire                plru_qry_update_ready;
  wire       [4:0]    plru_qry_update_payload_id;
  wire                plru_qry_update_payload_hit_or_miss;
  wire                dma_rpl_end_valid;
  wire       [4:0]    dma_rpl_end_payload;
  wire                plru_ctrl_update_valid;
  wire                plru_ctrl_update_ready;
  wire       [4:0]    plru_ctrl_update_payload_id;
  wire                plru_ctrl_update_payload_hit_or_miss;
  wire       [4:0]    plru_ctrl_plru_entry;
  wire                plru_ctrl_rpl_end_valid;
  wire       [4:0]    plru_ctrl_rpl_end_payload;
  wire       [0:0]    plru_ctrl_plru_io_context_state_0;
  wire       [1:0]    plru_ctrl_plru_io_context_state_1;
  wire       [3:0]    plru_ctrl_plru_io_context_state_2;
  wire       [7:0]    plru_ctrl_plru_io_context_state_3;
  wire       [15:0]   plru_ctrl_plru_io_context_state_4;
  wire       [31:0]   plru_ctrl_plru_io_context_valids;
  wire       [4:0]    plru_ctrl_plru_io_evict_id;
  wire       [4:0]    plru_ctrl_plru_io_update_id;
  wire       [0:0]    plru_ctrl_plru_io_update_state_0;
  reg        [1:0]    plru_ctrl_plru_io_update_state_1;
  reg        [3:0]    plru_ctrl_plru_io_update_state_2;
  reg        [7:0]    plru_ctrl_plru_io_update_state_3;
  reg        [15:0]   plru_ctrl_plru_io_update_state_4;
  reg                 plru_ctrl_plru_evict_sel_0;
  reg                 plru_ctrl_plru_evict_sel_1;
  reg                 plru_ctrl_plru_evict_sel_2;
  reg                 plru_ctrl_plru_evict_sel_3;
  reg                 plru_ctrl_plru_evict_sel_4;
  wire                plru_ctrl_plru_evict_logic_0_state;
  wire       [31:0]   tmp_plru_ctrl_plru_evict_logic_0_validCheck_groups_0_0;
  wire                plru_ctrl_plru_evict_logic_0_validCheck_groups_0_0;
  wire                plru_ctrl_plru_evict_logic_0_validCheck_groups_0_1;
  wire                plru_ctrl_plru_evict_logic_0_validCheck_notOks_0;
  wire                plru_ctrl_plru_evict_logic_0_validCheck_notOks_1;
  wire       [0:0]    plru_ctrl_plru_evict_logic_1_stateSel;
  wire                plru_ctrl_plru_evict_logic_1_state;
  wire       [15:0]   tmp_plru_ctrl_plru_evict_logic_1_validCheck_groups_0_0;
  wire       [15:0]   tmp_plru_ctrl_plru_evict_logic_1_validCheck_groups_1_0;
  wire                plru_ctrl_plru_evict_logic_1_validCheck_groups_0_0;
  wire                plru_ctrl_plru_evict_logic_1_validCheck_groups_0_1;
  wire                plru_ctrl_plru_evict_logic_1_validCheck_groups_1_0;
  wire                plru_ctrl_plru_evict_logic_1_validCheck_groups_1_1;
  wire                plru_ctrl_plru_evict_logic_1_validCheck_notOks_0;
  wire                plru_ctrl_plru_evict_logic_1_validCheck_notOks_1;
  wire       [1:0]    plru_ctrl_plru_evict_logic_2_stateSel;
  wire                plru_ctrl_plru_evict_logic_2_state;
  wire       [7:0]    tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_0_0;
  wire       [7:0]    tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_1_0;
  wire       [7:0]    tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_2_0;
  wire       [7:0]    tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_3_0;
  wire                plru_ctrl_plru_evict_logic_2_validCheck_groups_0_0;
  wire                plru_ctrl_plru_evict_logic_2_validCheck_groups_0_1;
  wire                plru_ctrl_plru_evict_logic_2_validCheck_groups_1_0;
  wire                plru_ctrl_plru_evict_logic_2_validCheck_groups_1_1;
  wire                plru_ctrl_plru_evict_logic_2_validCheck_groups_2_0;
  wire                plru_ctrl_plru_evict_logic_2_validCheck_groups_2_1;
  wire                plru_ctrl_plru_evict_logic_2_validCheck_groups_3_0;
  wire                plru_ctrl_plru_evict_logic_2_validCheck_groups_3_1;
  wire                plru_ctrl_plru_evict_logic_2_validCheck_notOks_0;
  wire                plru_ctrl_plru_evict_logic_2_validCheck_notOks_1;
  wire       [2:0]    plru_ctrl_plru_evict_logic_3_stateSel;
  wire                plru_ctrl_plru_evict_logic_3_state;
  wire       [3:0]    tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_0_0;
  wire       [3:0]    tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_1_0;
  wire       [3:0]    tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_2_0;
  wire       [3:0]    tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_3_0;
  wire       [3:0]    tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_4_0;
  wire       [3:0]    tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_5_0;
  wire       [3:0]    tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_6_0;
  wire       [3:0]    tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_7_0;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_0_0;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_0_1;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_1_0;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_1_1;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_2_0;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_2_1;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_3_0;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_3_1;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_4_0;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_4_1;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_5_0;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_5_1;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_6_0;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_6_1;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_7_0;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_groups_7_1;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_notOks_0;
  wire                plru_ctrl_plru_evict_logic_3_validCheck_notOks_1;
  wire       [3:0]    plru_ctrl_plru_evict_logic_4_stateSel;
  wire                plru_ctrl_plru_evict_logic_4_state;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_0_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_1_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_2_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_3_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_4_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_5_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_6_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_7_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_8_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_9_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_10_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_11_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_12_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_13_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_14_0;
  wire       [1:0]    tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_15_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_0_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_0_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_1_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_1_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_2_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_2_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_3_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_3_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_4_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_4_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_5_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_5_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_6_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_6_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_7_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_7_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_8_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_8_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_9_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_9_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_10_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_10_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_11_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_11_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_12_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_12_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_13_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_13_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_14_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_14_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_15_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_groups_15_1;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_notOks_0;
  wire                plru_ctrl_plru_evict_logic_4_validCheck_notOks_1;
  wire       [0:0]    plru_ctrl_plru_update_logic_1_sel;
  wire       [1:0]    plru_ctrl_plru_update_logic_2_sel;
  wire       [2:0]    plru_ctrl_plru_update_logic_3_sel;
  wire       [3:0]    plru_ctrl_plru_update_logic_4_sel;
  reg        [0:0]    plru_ctrl_state_0;
  reg        [1:0]    plru_ctrl_state_1;
  reg        [3:0]    plru_ctrl_state_2;
  reg        [7:0]    plru_ctrl_state_3;
  reg        [15:0]   plru_ctrl_state_4;
  reg                 plru_ctrl_aging_logic_cnts_0_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_0_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_0_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_0_value;
  wire                plru_ctrl_aging_logic_cnts_0_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_0_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_1_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_1_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_1_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_1_value;
  wire                plru_ctrl_aging_logic_cnts_1_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_1_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_2_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_2_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_2_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_2_value;
  wire                plru_ctrl_aging_logic_cnts_2_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_2_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_3_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_3_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_3_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_3_value;
  wire                plru_ctrl_aging_logic_cnts_3_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_3_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_4_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_4_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_4_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_4_value;
  wire                plru_ctrl_aging_logic_cnts_4_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_4_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_5_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_5_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_5_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_5_value;
  wire                plru_ctrl_aging_logic_cnts_5_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_5_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_6_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_6_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_6_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_6_value;
  wire                plru_ctrl_aging_logic_cnts_6_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_6_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_7_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_7_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_7_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_7_value;
  wire                plru_ctrl_aging_logic_cnts_7_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_7_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_8_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_8_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_8_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_8_value;
  wire                plru_ctrl_aging_logic_cnts_8_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_8_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_9_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_9_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_9_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_9_value;
  wire                plru_ctrl_aging_logic_cnts_9_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_9_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_10_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_10_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_10_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_10_value;
  wire                plru_ctrl_aging_logic_cnts_10_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_10_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_11_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_11_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_11_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_11_value;
  wire                plru_ctrl_aging_logic_cnts_11_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_11_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_12_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_12_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_12_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_12_value;
  wire                plru_ctrl_aging_logic_cnts_12_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_12_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_13_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_13_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_13_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_13_value;
  wire                plru_ctrl_aging_logic_cnts_13_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_13_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_14_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_14_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_14_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_14_value;
  wire                plru_ctrl_aging_logic_cnts_14_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_14_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_15_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_15_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_15_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_15_value;
  wire                plru_ctrl_aging_logic_cnts_15_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_15_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_16_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_16_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_16_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_16_value;
  wire                plru_ctrl_aging_logic_cnts_16_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_16_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_17_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_17_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_17_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_17_value;
  wire                plru_ctrl_aging_logic_cnts_17_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_17_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_18_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_18_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_18_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_18_value;
  wire                plru_ctrl_aging_logic_cnts_18_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_18_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_19_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_19_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_19_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_19_value;
  wire                plru_ctrl_aging_logic_cnts_19_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_19_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_20_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_20_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_20_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_20_value;
  wire                plru_ctrl_aging_logic_cnts_20_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_20_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_21_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_21_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_21_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_21_value;
  wire                plru_ctrl_aging_logic_cnts_21_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_21_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_22_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_22_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_22_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_22_value;
  wire                plru_ctrl_aging_logic_cnts_22_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_22_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_23_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_23_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_23_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_23_value;
  wire                plru_ctrl_aging_logic_cnts_23_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_23_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_24_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_24_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_24_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_24_value;
  wire                plru_ctrl_aging_logic_cnts_24_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_24_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_25_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_25_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_25_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_25_value;
  wire                plru_ctrl_aging_logic_cnts_25_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_25_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_26_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_26_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_26_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_26_value;
  wire                plru_ctrl_aging_logic_cnts_26_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_26_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_27_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_27_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_27_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_27_value;
  wire                plru_ctrl_aging_logic_cnts_27_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_27_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_28_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_28_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_28_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_28_value;
  wire                plru_ctrl_aging_logic_cnts_28_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_28_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_29_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_29_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_29_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_29_value;
  wire                plru_ctrl_aging_logic_cnts_29_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_29_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_30_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_30_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_30_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_30_value;
  wire                plru_ctrl_aging_logic_cnts_30_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_30_willOverflow;
  reg                 plru_ctrl_aging_logic_cnts_31_willIncrement;
  wire                plru_ctrl_aging_logic_cnts_31_willClear;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_31_valueNext;
  reg        [11:0]   plru_ctrl_aging_logic_cnts_31_value;
  wire                plru_ctrl_aging_logic_cnts_31_willOverflowIfInc;
  wire                plru_ctrl_aging_logic_cnts_31_willOverflow;
  reg                 plru_ctrl_aging_logic_valids_0;
  reg                 plru_ctrl_aging_logic_valids_1;
  reg                 plru_ctrl_aging_logic_valids_2;
  reg                 plru_ctrl_aging_logic_valids_3;
  reg                 plru_ctrl_aging_logic_valids_4;
  reg                 plru_ctrl_aging_logic_valids_5;
  reg                 plru_ctrl_aging_logic_valids_6;
  reg                 plru_ctrl_aging_logic_valids_7;
  reg                 plru_ctrl_aging_logic_valids_8;
  reg                 plru_ctrl_aging_logic_valids_9;
  reg                 plru_ctrl_aging_logic_valids_10;
  reg                 plru_ctrl_aging_logic_valids_11;
  reg                 plru_ctrl_aging_logic_valids_12;
  reg                 plru_ctrl_aging_logic_valids_13;
  reg                 plru_ctrl_aging_logic_valids_14;
  reg                 plru_ctrl_aging_logic_valids_15;
  reg                 plru_ctrl_aging_logic_valids_16;
  reg                 plru_ctrl_aging_logic_valids_17;
  reg                 plru_ctrl_aging_logic_valids_18;
  reg                 plru_ctrl_aging_logic_valids_19;
  reg                 plru_ctrl_aging_logic_valids_20;
  reg                 plru_ctrl_aging_logic_valids_21;
  reg                 plru_ctrl_aging_logic_valids_22;
  reg                 plru_ctrl_aging_logic_valids_23;
  reg                 plru_ctrl_aging_logic_valids_24;
  reg                 plru_ctrl_aging_logic_valids_25;
  reg                 plru_ctrl_aging_logic_valids_26;
  reg                 plru_ctrl_aging_logic_valids_27;
  reg                 plru_ctrl_aging_logic_valids_28;
  reg                 plru_ctrl_aging_logic_valids_29;
  reg                 plru_ctrl_aging_logic_valids_30;
  reg                 plru_ctrl_aging_logic_valids_31;
  reg        [31:0]   plru_ctrl_aging_logic_filled;
  reg        [31:0]   plru_ctrl_aging_logic_entries_died;
  wire                plru_ctrl_update_fire;
  wire                plru_ctrl_rpl_blk_logic_rpl_start_valid;
  wire       [4:0]    plru_ctrl_rpl_blk_logic_rpl_start_payload;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_0;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_1;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_2;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_3;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_4;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_5;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_6;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_7;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_8;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_9;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_10;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_11;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_12;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_13;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_14;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_15;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_16;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_17;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_18;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_19;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_20;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_21;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_22;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_23;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_24;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_25;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_26;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_27;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_28;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_29;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_30;
  reg                 plru_ctrl_rpl_blk_logic_blks_vec_31;
  wire                plru_ctrl_rpl_blk_logic_no_more;
  wire                plru_ctrl_rpl_blk_logic_rpl_same_err;
  wire                hit_miss_logic_hits_0;
  wire                hit_miss_logic_hits_1;
  wire                hit_miss_logic_hits_2;
  wire                hit_miss_logic_hits_3;
  wire                hit_miss_logic_hits_4;
  wire                hit_miss_logic_hits_5;
  wire                hit_miss_logic_hits_6;
  wire                hit_miss_logic_hits_7;
  wire                hit_miss_logic_hits_8;
  wire                hit_miss_logic_hits_9;
  wire                hit_miss_logic_hits_10;
  wire                hit_miss_logic_hits_11;
  wire                hit_miss_logic_hits_12;
  wire                hit_miss_logic_hits_13;
  wire                hit_miss_logic_hits_14;
  wire                hit_miss_logic_hits_15;
  wire                hit_miss_logic_hits_16;
  wire                hit_miss_logic_hits_17;
  wire                hit_miss_logic_hits_18;
  wire                hit_miss_logic_hits_19;
  wire                hit_miss_logic_hits_20;
  wire                hit_miss_logic_hits_21;
  wire                hit_miss_logic_hits_22;
  wire                hit_miss_logic_hits_23;
  wire                hit_miss_logic_hits_24;
  wire                hit_miss_logic_hits_25;
  wire                hit_miss_logic_hits_26;
  wire                hit_miss_logic_hits_27;
  wire                hit_miss_logic_hits_28;
  wire                hit_miss_logic_hits_29;
  wire                hit_miss_logic_hits_30;
  wire                hit_miss_logic_hits_31;
  wire                hit_miss_logic_hit;
  wire                tmp_hit_miss_logic_hit_idx;
  wire                tmp_hit_miss_logic_hit_idx_1;
  wire                tmp_hit_miss_logic_hit_idx_2;
  wire                tmp_hit_miss_logic_hit_idx_3;
  wire                tmp_hit_miss_logic_hit_idx_4;
  wire       [4:0]    hit_miss_logic_hit_idx;
  wire                mtt_qry_pop_fire;
  wire                hit_miss_logic_miss_info;
  wire                qry_tmp_reorder_push_valid;
  wire                qry_tmp_reorder_push_ready;
  wire                qry_tmp_reorder_push_payload_mr_trans_tmp_sop;
  wire                qry_tmp_reorder_push_payload_mr_trans_tmp_eop;
  wire                qry_tmp_reorder_push_payload_mr_trans_tmp_err;
  wire                qry_tmp_reorder_push_payload_mr_trans_tmp_need_trans;
  wire       [4:0]    qry_tmp_reorder_push_payload_mr_trans_tmp_log_entity_sz;
  wire       [63:0]   qry_tmp_reorder_push_payload_mr_trans_tmp_mtt_pba;
  wire       [31:0]   qry_tmp_reorder_push_payload_mr_trans_tmp_trans_len;
  wire       [31:0]   qry_tmp_reorder_push_payload_mr_trans_tmp_trans_sofst;
  wire       [14:0]   qry_tmp_reorder_push_payload_mr_trans_tmp_mr_idx;
  wire                qry_tmp_reorder_push_payload_hit;
  wire       [4:0]    qry_tmp_reorder_push_payload_cl_idx;
  wire       [4:0]    qry_tmp_reorder_push_payload_cl_ofst;
  wire                miss_dma_logic_on_epge_range;
  wire       [5:0]    miss_dma_logic_dma_page_num;
  wire       [28:0]   miss_dma_logic_spge_ofst;
  wire                miss_dma_logic_dma_rreq_push_valid;
  wire                miss_dma_logic_dma_rreq_push_ready;
  wire       [8:0]    miss_dma_logic_dma_rreq_push_payload_dma_len;
  wire       [63:0]   miss_dma_logic_dma_rreq_push_payload_dma_pa;
  wire       [4:0]    miss_dma_logic_dma_rreq_push_payload_cl_num;
  wire                qry_tmp_reorder_pop_valid;
  reg                 qry_tmp_reorder_pop_ready;
  wire                qry_tmp_reorder_pop_payload_mr_trans_tmp_sop;
  wire                qry_tmp_reorder_pop_payload_mr_trans_tmp_eop;
  wire                qry_tmp_reorder_pop_payload_mr_trans_tmp_err;
  wire                qry_tmp_reorder_pop_payload_mr_trans_tmp_need_trans;
  wire       [4:0]    qry_tmp_reorder_pop_payload_mr_trans_tmp_log_entity_sz;
  wire       [63:0]   qry_tmp_reorder_pop_payload_mr_trans_tmp_mtt_pba;
  wire       [31:0]   qry_tmp_reorder_pop_payload_mr_trans_tmp_trans_len;
  wire       [31:0]   qry_tmp_reorder_pop_payload_mr_trans_tmp_trans_sofst;
  wire       [14:0]   qry_tmp_reorder_pop_payload_mr_trans_tmp_mr_idx;
  wire                qry_tmp_reorder_pop_payload_hit;
  wire       [4:0]    qry_tmp_reorder_pop_payload_cl_idx;
  wire       [4:0]    qry_tmp_reorder_pop_payload_cl_ofst;
  wire       [151:0]  tmp_qry_tmp_reorder_pop_payload_mr_trans_tmp_sop;
  wire                dma_rrsp_pop_ready;
  wire                dma_rrsp_pop_valid;
  wire       [511:0]  dma_rrsp_pop_payload_data;
  wire       [4:0]    dma_rrsp_pop_payload_channel;
  wire                dma_rrsp_pop_payload_eop;
  wire                dma_rrsp_pop_payload_sop;
  reg        [1:0]    dma_rsp_cnt;
  wire                tmp_pop_pipe_valid;
  wire                tmp_pop_pipe_ready;
  wire                tmp_pop_pipe_payload_mr_trans_tmp_sop;
  wire                tmp_pop_pipe_payload_mr_trans_tmp_eop;
  wire                tmp_pop_pipe_payload_mr_trans_tmp_err;
  wire                tmp_pop_pipe_payload_mr_trans_tmp_need_trans;
  wire       [4:0]    tmp_pop_pipe_payload_mr_trans_tmp_log_entity_sz;
  wire       [63:0]   tmp_pop_pipe_payload_mr_trans_tmp_mtt_pba;
  wire       [31:0]   tmp_pop_pipe_payload_mr_trans_tmp_trans_len;
  wire       [31:0]   tmp_pop_pipe_payload_mr_trans_tmp_trans_sofst;
  wire       [14:0]   tmp_pop_pipe_payload_mr_trans_tmp_mr_idx;
  wire                tmp_pop_pipe_payload_hit;
  wire       [4:0]    tmp_pop_pipe_payload_cl_idx;
  wire       [4:0]    tmp_pop_pipe_payload_cl_ofst;
  reg                 qry_tmp_reorder_pop_rValid;
  reg                 qry_tmp_reorder_pop_rData_mr_trans_tmp_sop;
  reg                 qry_tmp_reorder_pop_rData_mr_trans_tmp_eop;
  reg                 qry_tmp_reorder_pop_rData_mr_trans_tmp_err;
  reg                 qry_tmp_reorder_pop_rData_mr_trans_tmp_need_trans;
  reg        [4:0]    qry_tmp_reorder_pop_rData_mr_trans_tmp_log_entity_sz;
  reg        [63:0]   qry_tmp_reorder_pop_rData_mr_trans_tmp_mtt_pba;
  reg        [31:0]   qry_tmp_reorder_pop_rData_mr_trans_tmp_trans_len;
  reg        [31:0]   qry_tmp_reorder_pop_rData_mr_trans_tmp_trans_sofst;
  reg        [14:0]   qry_tmp_reorder_pop_rData_mr_trans_tmp_mr_idx;
  reg                 qry_tmp_reorder_pop_rData_hit;
  reg        [4:0]    qry_tmp_reorder_pop_rData_cl_idx;
  reg        [4:0]    qry_tmp_reorder_pop_rData_cl_ofst;
  wire                cache_ram_rw_logic_rden_int;
  wire                cache_ram_rw_logic_rden;
  wire       [6:0]    cache_ram_rw_logic_raddr_int;
  wire       [6:0]    cache_ram_rw_logic_raddr;
  wire                cache_ram_rw_logic_wren;
  wire       [6:0]    cache_ram_rw_logic_waddr;
  wire       [63:0]   cache_ram_rw_logic_cache_rd_out_0;
  wire       [63:0]   cache_ram_rw_logic_cache_rd_out_1;
  wire       [63:0]   cache_ram_rw_logic_cache_rd_out_2;
  wire       [63:0]   cache_ram_rw_logic_cache_rd_out_3;
  wire       [63:0]   cache_ram_rw_logic_cache_rd_out_4;
  wire       [63:0]   cache_ram_rw_logic_cache_rd_out_5;
  wire       [63:0]   cache_ram_rw_logic_cache_rd_out_6;
  wire       [63:0]   cache_ram_rw_logic_cache_rd_out_7;
  wire                cache_ram_rw_logic_ruw;
  reg                 cache_ram_rw_logic_ruw_d;
  reg                 cache_ram_rw_logic_rden_int_regNext;
  reg        [6:0]    cache_ram_rw_logic_raddr_int_regNext;
  wire       [2:0]    mtt_trans_gen_logic_mtt_pa_sel;
  wire       [63:0]   mtt_trans_gen_logic_rpl_mtt_pa;
  wire       [1:0]    mtt_trans_gen_logic_row_sel;
  wire       [63:0]   mtt_trans_gen_logic_cached_mtt_pa;
  wire                mtt_trans_gen_logic_dma_cl_err;
  wire       [31:0]   tmp_1;
  wire                tmp_2;
  wire                tmp_3;
  wire                tmp_4;
  wire                tmp_5;
  wire                tmp_6;
  wire                tmp_7;
  wire                tmp_8;
  wire                tmp_9;
  wire                tmp_10;
  wire                tmp_11;
  wire                tmp_12;
  wire                tmp_13;
  wire                tmp_14;
  wire                tmp_15;
  wire                tmp_16;
  wire                tmp_17;
  wire                tmp_18;
  wire                tmp_19;
  wire                tmp_20;
  wire                tmp_21;
  wire                tmp_22;
  wire                tmp_23;
  wire                tmp_24;
  wire                tmp_25;
  wire                tmp_26;
  wire                tmp_27;
  wire                tmp_28;
  wire                tmp_29;
  wire                tmp_30;
  wire                tmp_31;
  wire                tmp_32;
  wire                tmp_33;
  wire       [25:0]   tmp_qry_tags_0_spge_tag;
  reg                 qry_cnt_willIncrement;
  wire                qry_cnt_willClear;
  reg        [15:0]   qry_cnt_valueNext;
  reg        [15:0]   qry_cnt_value;
  wire                qry_cnt_willOverflowIfInc;
  wire                qry_cnt_willOverflow;
  reg                 hit_cnt_willIncrement;
  wire                hit_cnt_willClear;
  reg        [15:0]   hit_cnt_valueNext;
  reg        [15:0]   hit_cnt_value;
  wire                hit_cnt_willOverflowIfInc;
  wire                hit_cnt_willOverflow;

  assign tmp_when = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h0) : (plru_ctrl_plru_entry == 5'h0)));
  assign tmp_when_1 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h01) : (plru_ctrl_plru_entry == 5'h01)));
  assign tmp_when_2 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h02) : (plru_ctrl_plru_entry == 5'h02)));
  assign tmp_when_3 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h03) : (plru_ctrl_plru_entry == 5'h03)));
  assign tmp_when_4 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h04) : (plru_ctrl_plru_entry == 5'h04)));
  assign tmp_when_5 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h05) : (plru_ctrl_plru_entry == 5'h05)));
  assign tmp_when_6 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h06) : (plru_ctrl_plru_entry == 5'h06)));
  assign tmp_when_7 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h07) : (plru_ctrl_plru_entry == 5'h07)));
  assign tmp_when_8 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h08) : (plru_ctrl_plru_entry == 5'h08)));
  assign tmp_when_9 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h09) : (plru_ctrl_plru_entry == 5'h09)));
  assign tmp_when_10 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h0a) : (plru_ctrl_plru_entry == 5'h0a)));
  assign tmp_when_11 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h0b) : (plru_ctrl_plru_entry == 5'h0b)));
  assign tmp_when_12 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h0c) : (plru_ctrl_plru_entry == 5'h0c)));
  assign tmp_when_13 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h0d) : (plru_ctrl_plru_entry == 5'h0d)));
  assign tmp_when_14 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h0e) : (plru_ctrl_plru_entry == 5'h0e)));
  assign tmp_when_15 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h0f) : (plru_ctrl_plru_entry == 5'h0f)));
  assign tmp_when_16 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h10) : (plru_ctrl_plru_entry == 5'h10)));
  assign tmp_when_17 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h11) : (plru_ctrl_plru_entry == 5'h11)));
  assign tmp_when_18 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h12) : (plru_ctrl_plru_entry == 5'h12)));
  assign tmp_when_19 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h13) : (plru_ctrl_plru_entry == 5'h13)));
  assign tmp_when_20 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h14) : (plru_ctrl_plru_entry == 5'h14)));
  assign tmp_when_21 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h15) : (plru_ctrl_plru_entry == 5'h15)));
  assign tmp_when_22 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h16) : (plru_ctrl_plru_entry == 5'h16)));
  assign tmp_when_23 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h17) : (plru_ctrl_plru_entry == 5'h17)));
  assign tmp_when_24 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h18) : (plru_ctrl_plru_entry == 5'h18)));
  assign tmp_when_25 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h19) : (plru_ctrl_plru_entry == 5'h19)));
  assign tmp_when_26 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h1a) : (plru_ctrl_plru_entry == 5'h1a)));
  assign tmp_when_27 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h1b) : (plru_ctrl_plru_entry == 5'h1b)));
  assign tmp_when_28 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h1c) : (plru_ctrl_plru_entry == 5'h1c)));
  assign tmp_when_29 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h1d) : (plru_ctrl_plru_entry == 5'h1d)));
  assign tmp_when_30 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h1e) : (plru_ctrl_plru_entry == 5'h1e)));
  assign tmp_when_31 = (plru_ctrl_update_fire && (plru_ctrl_update_payload_hit_or_miss ? (plru_ctrl_update_payload_id == 5'h1f) : (plru_ctrl_plru_entry == 5'h1f)));
  assign tmp_plru_ctrl_aging_logic_cnts_0_valueNext_1 = plru_ctrl_aging_logic_cnts_0_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_0_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_0_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_1_valueNext_1 = plru_ctrl_aging_logic_cnts_1_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_1_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_1_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_2_valueNext_1 = plru_ctrl_aging_logic_cnts_2_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_2_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_2_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_3_valueNext_1 = plru_ctrl_aging_logic_cnts_3_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_3_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_3_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_4_valueNext_1 = plru_ctrl_aging_logic_cnts_4_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_4_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_4_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_5_valueNext_1 = plru_ctrl_aging_logic_cnts_5_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_5_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_5_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_6_valueNext_1 = plru_ctrl_aging_logic_cnts_6_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_6_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_6_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_7_valueNext_1 = plru_ctrl_aging_logic_cnts_7_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_7_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_7_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_8_valueNext_1 = plru_ctrl_aging_logic_cnts_8_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_8_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_8_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_9_valueNext_1 = plru_ctrl_aging_logic_cnts_9_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_9_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_9_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_10_valueNext_1 = plru_ctrl_aging_logic_cnts_10_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_10_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_10_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_11_valueNext_1 = plru_ctrl_aging_logic_cnts_11_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_11_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_11_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_12_valueNext_1 = plru_ctrl_aging_logic_cnts_12_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_12_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_12_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_13_valueNext_1 = plru_ctrl_aging_logic_cnts_13_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_13_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_13_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_14_valueNext_1 = plru_ctrl_aging_logic_cnts_14_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_14_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_14_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_15_valueNext_1 = plru_ctrl_aging_logic_cnts_15_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_15_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_15_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_16_valueNext_1 = plru_ctrl_aging_logic_cnts_16_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_16_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_16_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_17_valueNext_1 = plru_ctrl_aging_logic_cnts_17_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_17_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_17_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_18_valueNext_1 = plru_ctrl_aging_logic_cnts_18_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_18_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_18_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_19_valueNext_1 = plru_ctrl_aging_logic_cnts_19_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_19_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_19_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_20_valueNext_1 = plru_ctrl_aging_logic_cnts_20_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_20_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_20_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_21_valueNext_1 = plru_ctrl_aging_logic_cnts_21_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_21_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_21_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_22_valueNext_1 = plru_ctrl_aging_logic_cnts_22_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_22_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_22_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_23_valueNext_1 = plru_ctrl_aging_logic_cnts_23_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_23_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_23_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_24_valueNext_1 = plru_ctrl_aging_logic_cnts_24_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_24_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_24_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_25_valueNext_1 = plru_ctrl_aging_logic_cnts_25_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_25_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_25_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_26_valueNext_1 = plru_ctrl_aging_logic_cnts_26_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_26_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_26_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_27_valueNext_1 = plru_ctrl_aging_logic_cnts_27_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_27_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_27_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_28_valueNext_1 = plru_ctrl_aging_logic_cnts_28_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_28_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_28_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_29_valueNext_1 = plru_ctrl_aging_logic_cnts_29_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_29_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_29_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_30_valueNext_1 = plru_ctrl_aging_logic_cnts_30_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_30_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_30_valueNext_1};
  assign tmp_plru_ctrl_aging_logic_cnts_31_valueNext_1 = plru_ctrl_aging_logic_cnts_31_willIncrement;
  assign tmp_plru_ctrl_aging_logic_cnts_31_valueNext = {11'd0, tmp_plru_ctrl_aging_logic_cnts_31_valueNext_1};
  assign tmp_miss_dma_logic_spge_ofst = ({5'd0,tmp_miss_dma_logic_spge_ofst_1} <<< 3'd5);
  assign tmp_miss_dma_logic_spge_ofst_1 = (mtt_qry_pop_payload_spge_idx >>> 3'd5);
  assign tmp_miss_dma_logic_dma_rreq_push_payload_dma_pa = {35'd0, miss_dma_logic_spge_ofst};
  assign tmp_cache_ram_rw_logic_waddr = ({2'd0,tmp_pop_pipe_payload_cl_idx} <<< 2'd2);
  assign tmp_cache_ram_rw_logic_waddr_1 = {5'd0, dma_rsp_cnt};
  assign tmp_mtt_trans_gen_logic_rpl_mtt_pa_1 = {32'd0, tmp_pop_pipe_payload_mr_trans_tmp_trans_sofst};
  assign tmp_mtt_trans_gen_logic_cached_mtt_pa_1 = (tmp_pop_pipe_payload_mr_trans_tmp_need_trans ? tmp_pop_pipe_payload_mr_trans_tmp_trans_sofst : 32'h0);
  assign tmp_mtt_trans_gen_logic_cached_mtt_pa = {32'd0, tmp_mtt_trans_gen_logic_cached_mtt_pa_1};
  assign tmp_tmp_qry_tags_0_spge_tag = (mtt_qry_pop_payload_spge_idx >>> 3'd5);
  assign tmp_qry_cnt_valueNext_1 = qry_cnt_willIncrement;
  assign tmp_qry_cnt_valueNext = {15'd0, tmp_qry_cnt_valueNext_1};
  assign tmp_hit_cnt_valueNext_1 = hit_cnt_willIncrement;
  assign tmp_hit_cnt_valueNext = {15'd0, tmp_hit_cnt_valueNext_1};
  assign tmp_plru_ctrl_plru_io_context_valids = plru_ctrl_rpl_blk_logic_blks_vec_21;
  assign tmp_plru_ctrl_plru_io_context_valids_1 = {plru_ctrl_rpl_blk_logic_blks_vec_20,{plru_ctrl_rpl_blk_logic_blks_vec_19,{plru_ctrl_rpl_blk_logic_blks_vec_18,{plru_ctrl_rpl_blk_logic_blks_vec_17,{plru_ctrl_rpl_blk_logic_blks_vec_16,{plru_ctrl_rpl_blk_logic_blks_vec_15,{plru_ctrl_rpl_blk_logic_blks_vec_14,{plru_ctrl_rpl_blk_logic_blks_vec_13,{plru_ctrl_rpl_blk_logic_blks_vec_12,{plru_ctrl_rpl_blk_logic_blks_vec_11,{tmp_plru_ctrl_plru_io_context_valids_2,tmp_plru_ctrl_plru_io_context_valids_3}}}}}}}}}}};
  assign tmp_plru_ctrl_plru_io_context_valids_2 = plru_ctrl_rpl_blk_logic_blks_vec_10;
  assign tmp_plru_ctrl_plru_io_context_valids_3 = {plru_ctrl_rpl_blk_logic_blks_vec_9,{plru_ctrl_rpl_blk_logic_blks_vec_8,{plru_ctrl_rpl_blk_logic_blks_vec_7,{plru_ctrl_rpl_blk_logic_blks_vec_6,{plru_ctrl_rpl_blk_logic_blks_vec_5,{plru_ctrl_rpl_blk_logic_blks_vec_4,{plru_ctrl_rpl_blk_logic_blks_vec_3,{plru_ctrl_rpl_blk_logic_blks_vec_2,{plru_ctrl_rpl_blk_logic_blks_vec_1,plru_ctrl_rpl_blk_logic_blks_vec_0}}}}}}}}};
  assign tmp_hit_miss_logic_hit = hit_miss_logic_hits_21;
  assign tmp_hit_miss_logic_hit_1 = {hit_miss_logic_hits_20,{hit_miss_logic_hits_19,{hit_miss_logic_hits_18,{hit_miss_logic_hits_17,{hit_miss_logic_hits_16,{hit_miss_logic_hits_15,{hit_miss_logic_hits_14,{hit_miss_logic_hits_13,{hit_miss_logic_hits_12,{hit_miss_logic_hits_11,{tmp_hit_miss_logic_hit_2,tmp_hit_miss_logic_hit_3}}}}}}}}}}};
  assign tmp_hit_miss_logic_hit_2 = hit_miss_logic_hits_10;
  assign tmp_hit_miss_logic_hit_3 = {hit_miss_logic_hits_9,{hit_miss_logic_hits_8,{hit_miss_logic_hits_7,{hit_miss_logic_hits_6,{hit_miss_logic_hits_5,{hit_miss_logic_hits_4,{hit_miss_logic_hits_3,{hit_miss_logic_hits_2,{hit_miss_logic_hits_1,hit_miss_logic_hits_0}}}}}}}}};
  assign tmp_din = qry_tmp_reorder_push_payload_mr_trans_tmp_eop;
  assign tmp_din_1 = qry_tmp_reorder_push_payload_mr_trans_tmp_sop;
  rdma_ctyun_sfifo #(
    .DEPTH      (64 ),
    .DATA_WIDTH (204)
  ) mtt_qry_fifo (
    .clk          (clk                      ), //i
    .srst         (reset                    ), //i
    .wr_en        (mtt_qry_valid            ), //i
    .din          (mtt_qry_fifo_din[203:0]  ), //i
    .full         (mtt_qry_fifo_full        ), //o
    .rd_en        (mtt_qry_pop_ready        ), //i
    .dout         (mtt_qry_fifo_dout[203:0] ), //o
    .empty        (mtt_qry_fifo_empty       ), //o
    .almost_empty (mtt_qry_fifo_almost_empty), //o
    .almost_full  (mtt_qry_fifo_almost_full ), //o
    .usedw        (mtt_qry_fifo_usedw[5:0]  ), //o
    .overflow     (mtt_qry_fifo_overflow    ), //o
    .underflow    (mtt_qry_fifo_underflow   )  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (32),
    .DATA_WIDTH (78)
  ) dma_rreq_fifo (
    .clk          (clk                               ), //i
    .srst         (reset                             ), //i
    .wr_en        (miss_dma_logic_dma_rreq_push_valid), //i
    .din          (dma_rreq_fifo_din[77:0]           ), //i
    .full         (dma_rreq_fifo_full                ), //o
    .rd_en        (dma_rdreq_ready                   ), //i
    .dout         (dma_rreq_fifo_dout[77:0]          ), //o
    .empty        (dma_rreq_fifo_empty               ), //o
    .almost_empty (dma_rreq_fifo_almost_empty        ), //o
    .almost_full  (dma_rreq_fifo_almost_full         ), //o
    .usedw        (dma_rreq_fifo_usedw[4:0]          ), //o
    .overflow     (dma_rreq_fifo_overflow            ), //o
    .underflow    (dma_rreq_fifo_underflow           )  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (128),
    .DATA_WIDTH (163)
  ) qry_tmp_reorder_fifo (
    .clk          (clk                              ), //i
    .srst         (reset                            ), //i
    .wr_en        (qry_tmp_reorder_push_valid       ), //i
    .din          (qry_tmp_reorder_fifo_din[162:0]  ), //i
    .full         (qry_tmp_reorder_fifo_full        ), //o
    .rd_en        (qry_tmp_reorder_pop_ready        ), //i
    .dout         (qry_tmp_reorder_fifo_dout[162:0] ), //o
    .empty        (qry_tmp_reorder_fifo_empty       ), //o
    .almost_empty (qry_tmp_reorder_fifo_almost_empty), //o
    .almost_full  (qry_tmp_reorder_fifo_almost_full ), //o
    .usedw        (qry_tmp_reorder_fifo_usedw[6:0]  ), //o
    .overflow     (qry_tmp_reorder_fifo_overflow    ), //o
    .underflow    (qry_tmp_reorder_fifo_underflow   )  //o
  );
  rdma_ctyun_sfifo #(
    .DEPTH      (32 ),
    .DATA_WIDTH (519)
  ) dma_rrsp_fifo (
    .clk          (clk                       ), //i
    .srst         (reset                     ), //i
    .wr_en        (dma_rrsp_valid            ), //i
    .din          (dma_rrsp_fifo_din[518:0]  ), //i
    .full         (dma_rrsp_fifo_full        ), //o
    .rd_en        (dma_rrsp_pop_ready        ), //i
    .dout         (dma_rrsp_fifo_dout[518:0] ), //o
    .empty        (dma_rrsp_fifo_empty       ), //o
    .almost_empty (dma_rrsp_fifo_almost_empty), //o
    .almost_full  (dma_rrsp_fifo_almost_full ), //o
    .usedw        (dma_rrsp_fifo_usedw[4:0]  ), //o
    .overflow     (dma_rrsp_fifo_overflow    ), //o
    .underflow    (dma_rrsp_fifo_underflow   )  //o
  );
  rdma_ctyun_sdpram #(
    .WR_ADDR_WIDTH     (7         ),
    .RD_ADDR_WIDTH     (7         ),
    .WR_DATA_WIDTH     (512       ),
    .RD_DATA_WIDTH     (512       ),
    .READ_LATENCY      (1         ),
    .RAM_TYPE          ("M20K"    ),
    .READ_DURING_WRITE ("OLD_DATA"),
    .INIT_FILE         (""        )
  ) data_ram (
    .clock     (clk                             ), //i
    .wren      (cache_ram_rw_logic_wren         ), //i
    .rden      (cache_ram_rw_logic_rden         ), //i
    .byteena   (64'hffffffffffffffff            ), //i
    .din       (dma_rrsp_pop_payload_data[511:0]), //i
    .rdaddress (cache_ram_rw_logic_raddr[6:0]   ), //i
    .wraddress (cache_ram_rw_logic_waddr[6:0]   ), //i
    .dout      (data_ram_dout[511:0]            )  //o
  );
  always @(*) begin
    case(plru_ctrl_plru_evict_logic_1_stateSel)
      1'b0 : begin
        tmp_plru_ctrl_plru_evict_logic_1_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_1_validCheck_groups_0_0;
        tmp_plru_ctrl_plru_evict_logic_1_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_1_validCheck_groups_0_1;
      end
      default : begin
        tmp_plru_ctrl_plru_evict_logic_1_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_1_validCheck_groups_1_0;
        tmp_plru_ctrl_plru_evict_logic_1_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_1_validCheck_groups_1_1;
      end
    endcase
  end

  always @(*) begin
    case(plru_ctrl_plru_evict_logic_2_stateSel)
      2'b00 : begin
        tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_2_validCheck_groups_0_0;
        tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_2_validCheck_groups_0_1;
      end
      2'b01 : begin
        tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_2_validCheck_groups_1_0;
        tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_2_validCheck_groups_1_1;
      end
      2'b10 : begin
        tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_2_validCheck_groups_2_0;
        tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_2_validCheck_groups_2_1;
      end
      default : begin
        tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_2_validCheck_groups_3_0;
        tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_2_validCheck_groups_3_1;
      end
    endcase
  end

  always @(*) begin
    case(plru_ctrl_plru_evict_logic_3_stateSel)
      3'b000 : begin
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_3_validCheck_groups_0_0;
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_3_validCheck_groups_0_1;
      end
      3'b001 : begin
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_3_validCheck_groups_1_0;
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_3_validCheck_groups_1_1;
      end
      3'b010 : begin
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_3_validCheck_groups_2_0;
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_3_validCheck_groups_2_1;
      end
      3'b011 : begin
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_3_validCheck_groups_3_0;
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_3_validCheck_groups_3_1;
      end
      3'b100 : begin
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_3_validCheck_groups_4_0;
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_3_validCheck_groups_4_1;
      end
      3'b101 : begin
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_3_validCheck_groups_5_0;
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_3_validCheck_groups_5_1;
      end
      3'b110 : begin
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_3_validCheck_groups_6_0;
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_3_validCheck_groups_6_1;
      end
      default : begin
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_3_validCheck_groups_7_0;
        tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_3_validCheck_groups_7_1;
      end
    endcase
  end

  always @(*) begin
    case(plru_ctrl_plru_evict_logic_4_stateSel)
      4'b0000 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_0_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_0_1;
      end
      4'b0001 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_1_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_1_1;
      end
      4'b0010 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_2_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_2_1;
      end
      4'b0011 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_3_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_3_1;
      end
      4'b0100 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_4_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_4_1;
      end
      4'b0101 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_5_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_5_1;
      end
      4'b0110 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_6_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_6_1;
      end
      4'b0111 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_7_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_7_1;
      end
      4'b1000 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_8_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_8_1;
      end
      4'b1001 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_9_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_9_1;
      end
      4'b1010 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_10_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_10_1;
      end
      4'b1011 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_11_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_11_1;
      end
      4'b1100 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_12_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_12_1;
      end
      4'b1101 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_13_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_13_1;
      end
      4'b1110 : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_14_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_14_1;
      end
      default : begin
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_4_validCheck_groups_15_0;
        tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_4_validCheck_groups_15_1;
      end
    endcase
  end

  always @(*) begin
    case(mtt_trans_gen_logic_mtt_pa_sel)
      3'b000 : begin
        tmp_mtt_trans_gen_logic_rpl_mtt_pa = dma_rrsp_pop_payload_data[63 : 0];
        tmp_mtt_trans_gen_logic_cached_mtt_pa_2 = cache_ram_rw_logic_cache_rd_out_0;
      end
      3'b001 : begin
        tmp_mtt_trans_gen_logic_rpl_mtt_pa = dma_rrsp_pop_payload_data[127 : 64];
        tmp_mtt_trans_gen_logic_cached_mtt_pa_2 = cache_ram_rw_logic_cache_rd_out_1;
      end
      3'b010 : begin
        tmp_mtt_trans_gen_logic_rpl_mtt_pa = dma_rrsp_pop_payload_data[191 : 128];
        tmp_mtt_trans_gen_logic_cached_mtt_pa_2 = cache_ram_rw_logic_cache_rd_out_2;
      end
      3'b011 : begin
        tmp_mtt_trans_gen_logic_rpl_mtt_pa = dma_rrsp_pop_payload_data[255 : 192];
        tmp_mtt_trans_gen_logic_cached_mtt_pa_2 = cache_ram_rw_logic_cache_rd_out_3;
      end
      3'b100 : begin
        tmp_mtt_trans_gen_logic_rpl_mtt_pa = dma_rrsp_pop_payload_data[319 : 256];
        tmp_mtt_trans_gen_logic_cached_mtt_pa_2 = cache_ram_rw_logic_cache_rd_out_4;
      end
      3'b101 : begin
        tmp_mtt_trans_gen_logic_rpl_mtt_pa = dma_rrsp_pop_payload_data[383 : 320];
        tmp_mtt_trans_gen_logic_cached_mtt_pa_2 = cache_ram_rw_logic_cache_rd_out_5;
      end
      3'b110 : begin
        tmp_mtt_trans_gen_logic_rpl_mtt_pa = dma_rrsp_pop_payload_data[447 : 384];
        tmp_mtt_trans_gen_logic_cached_mtt_pa_2 = cache_ram_rw_logic_cache_rd_out_6;
      end
      default : begin
        tmp_mtt_trans_gen_logic_rpl_mtt_pa = dma_rrsp_pop_payload_data[511 : 448];
        tmp_mtt_trans_gen_logic_cached_mtt_pa_2 = cache_ram_rw_logic_cache_rd_out_7;
      end
    endcase
  end

  assign mtt_qry_fifo_din = {mtt_qry_epge_idx,{mtt_qry_spge_idx,{mtt_qry_mr_tran_din_mr_idx,{mtt_qry_mr_tran_din_trans_sofst,{mtt_qry_mr_tran_din_trans_len,{mtt_qry_mr_tran_din_mtt_pba,{mtt_qry_mr_tran_din_log_entity_sz,{mtt_qry_mr_tran_din_need_trans,{mtt_qry_mr_tran_din_err,{mtt_qry_mr_tran_din_eop,mtt_qry_mr_tran_din_sop}}}}}}}}}}; // @ rdma_ctyun_sfifo.scala l34
  assign mtt_qry_ready = (! mtt_qry_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign mtt_qry_pop_valid = (! mtt_qry_fifo_empty); // @ rdma_ctyun_sfifo.scala l39
  assign tmp_mtt_qry_pop_payload_mr_tran_din_sop = mtt_qry_fifo_dout[151 : 0]; // @ BaseType.scala l299
  assign mtt_qry_pop_payload_mr_tran_din_sop = tmp_mtt_qry_pop_payload_mr_tran_din_sop[0]; // @ Bool.scala l209
  assign mtt_qry_pop_payload_mr_tran_din_eop = tmp_mtt_qry_pop_payload_mr_tran_din_sop[1]; // @ Bool.scala l209
  assign mtt_qry_pop_payload_mr_tran_din_err = tmp_mtt_qry_pop_payload_mr_tran_din_sop[2]; // @ Bool.scala l209
  assign mtt_qry_pop_payload_mr_tran_din_need_trans = tmp_mtt_qry_pop_payload_mr_tran_din_sop[3]; // @ Bool.scala l209
  assign mtt_qry_pop_payload_mr_tran_din_log_entity_sz = tmp_mtt_qry_pop_payload_mr_tran_din_sop[8 : 4]; // @ UInt.scala l381
  assign mtt_qry_pop_payload_mr_tran_din_mtt_pba = tmp_mtt_qry_pop_payload_mr_tran_din_sop[72 : 9]; // @ UInt.scala l381
  assign mtt_qry_pop_payload_mr_tran_din_trans_len = tmp_mtt_qry_pop_payload_mr_tran_din_sop[104 : 73]; // @ UInt.scala l381
  assign mtt_qry_pop_payload_mr_tran_din_trans_sofst = tmp_mtt_qry_pop_payload_mr_tran_din_sop[136 : 105]; // @ UInt.scala l381
  assign mtt_qry_pop_payload_mr_tran_din_mr_idx = tmp_mtt_qry_pop_payload_mr_tran_din_sop[151 : 137]; // @ Bits.scala l133
  assign mtt_qry_pop_payload_spge_idx = mtt_qry_fifo_dout[177 : 152]; // @ UInt.scala l381
  assign mtt_qry_pop_payload_epge_idx = mtt_qry_fifo_dout[203 : 178]; // @ UInt.scala l381
  assign plru_ctrl_plru_evict_logic_0_state = plru_ctrl_plru_io_context_state_0[0]; // @ BaseType.scala l305
  always @(*) begin
    plru_ctrl_plru_evict_sel_0 = (! plru_ctrl_plru_evict_logic_0_state); // @ Plru.scala l36
    if(plru_ctrl_plru_evict_logic_0_validCheck_notOks_1) begin
      plru_ctrl_plru_evict_sel_0 = 1'b0; // @ Plru.scala l41
    end
    if(plru_ctrl_plru_evict_logic_0_validCheck_notOks_0) begin
      plru_ctrl_plru_evict_sel_0 = 1'b1; // @ Plru.scala l41
    end
  end

  assign tmp_plru_ctrl_plru_evict_logic_0_validCheck_groups_0_0 = plru_ctrl_plru_io_context_valids[31 : 0]; // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_0_validCheck_groups_0_0 = (! (|tmp_plru_ctrl_plru_evict_logic_0_validCheck_groups_0_0[15 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_0_validCheck_groups_0_1 = (! (|tmp_plru_ctrl_plru_evict_logic_0_validCheck_groups_0_0[31 : 16])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_0_validCheck_notOks_0 = plru_ctrl_plru_evict_logic_0_validCheck_groups_0_0; // @ Vec.scala l169
  assign plru_ctrl_plru_evict_logic_0_validCheck_notOks_1 = plru_ctrl_plru_evict_logic_0_validCheck_groups_0_1; // @ Vec.scala l169
  assign plru_ctrl_plru_evict_logic_1_stateSel = plru_ctrl_plru_evict_sel_0; // @ BaseType.scala l318
  assign plru_ctrl_plru_evict_logic_1_state = plru_ctrl_plru_io_context_state_1[plru_ctrl_plru_evict_logic_1_stateSel]; // @ BaseType.scala l305
  always @(*) begin
    plru_ctrl_plru_evict_sel_1 = (! plru_ctrl_plru_evict_logic_1_state); // @ Plru.scala l36
    if(plru_ctrl_plru_evict_logic_1_validCheck_notOks_1) begin
      plru_ctrl_plru_evict_sel_1 = 1'b0; // @ Plru.scala l41
    end
    if(plru_ctrl_plru_evict_logic_1_validCheck_notOks_0) begin
      plru_ctrl_plru_evict_sel_1 = 1'b1; // @ Plru.scala l41
    end
  end

  assign tmp_plru_ctrl_plru_evict_logic_1_validCheck_groups_0_0 = plru_ctrl_plru_io_context_valids[15 : 0]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_1_validCheck_groups_1_0 = plru_ctrl_plru_io_context_valids[31 : 16]; // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_1_validCheck_groups_0_0 = (! (|tmp_plru_ctrl_plru_evict_logic_1_validCheck_groups_0_0[7 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_1_validCheck_groups_0_1 = (! (|tmp_plru_ctrl_plru_evict_logic_1_validCheck_groups_0_0[15 : 8])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_1_validCheck_groups_1_0 = (! (|tmp_plru_ctrl_plru_evict_logic_1_validCheck_groups_1_0[7 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_1_validCheck_groups_1_1 = (! (|tmp_plru_ctrl_plru_evict_logic_1_validCheck_groups_1_0[15 : 8])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_1_validCheck_notOks_0 = tmp_plru_ctrl_plru_evict_logic_1_validCheck_notOks_0; // @ Vec.scala l202
  assign plru_ctrl_plru_evict_logic_1_validCheck_notOks_1 = tmp_plru_ctrl_plru_evict_logic_1_validCheck_notOks_1; // @ Vec.scala l202
  assign plru_ctrl_plru_evict_logic_2_stateSel = {plru_ctrl_plru_evict_sel_0,plru_ctrl_plru_evict_sel_1}; // @ BaseType.scala l318
  assign plru_ctrl_plru_evict_logic_2_state = plru_ctrl_plru_io_context_state_2[plru_ctrl_plru_evict_logic_2_stateSel]; // @ BaseType.scala l305
  always @(*) begin
    plru_ctrl_plru_evict_sel_2 = (! plru_ctrl_plru_evict_logic_2_state); // @ Plru.scala l36
    if(plru_ctrl_plru_evict_logic_2_validCheck_notOks_1) begin
      plru_ctrl_plru_evict_sel_2 = 1'b0; // @ Plru.scala l41
    end
    if(plru_ctrl_plru_evict_logic_2_validCheck_notOks_0) begin
      plru_ctrl_plru_evict_sel_2 = 1'b1; // @ Plru.scala l41
    end
  end

  assign tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_0_0 = plru_ctrl_plru_io_context_valids[7 : 0]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_1_0 = plru_ctrl_plru_io_context_valids[15 : 8]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_2_0 = plru_ctrl_plru_io_context_valids[23 : 16]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_3_0 = plru_ctrl_plru_io_context_valids[31 : 24]; // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_2_validCheck_groups_0_0 = (! (|tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_0_0[3 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_2_validCheck_groups_0_1 = (! (|tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_0_0[7 : 4])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_2_validCheck_groups_1_0 = (! (|tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_1_0[3 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_2_validCheck_groups_1_1 = (! (|tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_1_0[7 : 4])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_2_validCheck_groups_2_0 = (! (|tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_2_0[3 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_2_validCheck_groups_2_1 = (! (|tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_2_0[7 : 4])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_2_validCheck_groups_3_0 = (! (|tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_3_0[3 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_2_validCheck_groups_3_1 = (! (|tmp_plru_ctrl_plru_evict_logic_2_validCheck_groups_3_0[7 : 4])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_2_validCheck_notOks_0 = tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_0; // @ Vec.scala l202
  assign plru_ctrl_plru_evict_logic_2_validCheck_notOks_1 = tmp_plru_ctrl_plru_evict_logic_2_validCheck_notOks_1; // @ Vec.scala l202
  assign plru_ctrl_plru_evict_logic_3_stateSel = {plru_ctrl_plru_evict_sel_0,{plru_ctrl_plru_evict_sel_1,plru_ctrl_plru_evict_sel_2}}; // @ BaseType.scala l318
  assign plru_ctrl_plru_evict_logic_3_state = plru_ctrl_plru_io_context_state_3[plru_ctrl_plru_evict_logic_3_stateSel]; // @ BaseType.scala l305
  always @(*) begin
    plru_ctrl_plru_evict_sel_3 = (! plru_ctrl_plru_evict_logic_3_state); // @ Plru.scala l36
    if(plru_ctrl_plru_evict_logic_3_validCheck_notOks_1) begin
      plru_ctrl_plru_evict_sel_3 = 1'b0; // @ Plru.scala l41
    end
    if(plru_ctrl_plru_evict_logic_3_validCheck_notOks_0) begin
      plru_ctrl_plru_evict_sel_3 = 1'b1; // @ Plru.scala l41
    end
  end

  assign tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_0_0 = plru_ctrl_plru_io_context_valids[3 : 0]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_1_0 = plru_ctrl_plru_io_context_valids[7 : 4]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_2_0 = plru_ctrl_plru_io_context_valids[11 : 8]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_3_0 = plru_ctrl_plru_io_context_valids[15 : 12]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_4_0 = plru_ctrl_plru_io_context_valids[19 : 16]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_5_0 = plru_ctrl_plru_io_context_valids[23 : 20]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_6_0 = plru_ctrl_plru_io_context_valids[27 : 24]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_7_0 = plru_ctrl_plru_io_context_valids[31 : 28]; // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_0_0 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_0_0[1 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_0_1 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_0_0[3 : 2])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_1_0 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_1_0[1 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_1_1 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_1_0[3 : 2])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_2_0 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_2_0[1 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_2_1 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_2_0[3 : 2])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_3_0 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_3_0[1 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_3_1 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_3_0[3 : 2])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_4_0 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_4_0[1 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_4_1 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_4_0[3 : 2])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_5_0 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_5_0[1 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_5_1 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_5_0[3 : 2])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_6_0 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_6_0[1 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_6_1 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_6_0[3 : 2])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_7_0 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_7_0[1 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_groups_7_1 = (! (|tmp_plru_ctrl_plru_evict_logic_3_validCheck_groups_7_0[3 : 2])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_3_validCheck_notOks_0 = tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_0; // @ Vec.scala l202
  assign plru_ctrl_plru_evict_logic_3_validCheck_notOks_1 = tmp_plru_ctrl_plru_evict_logic_3_validCheck_notOks_1; // @ Vec.scala l202
  assign plru_ctrl_plru_evict_logic_4_stateSel = {plru_ctrl_plru_evict_sel_0,{plru_ctrl_plru_evict_sel_1,{plru_ctrl_plru_evict_sel_2,plru_ctrl_plru_evict_sel_3}}}; // @ BaseType.scala l318
  assign plru_ctrl_plru_evict_logic_4_state = plru_ctrl_plru_io_context_state_4[plru_ctrl_plru_evict_logic_4_stateSel]; // @ BaseType.scala l305
  always @(*) begin
    plru_ctrl_plru_evict_sel_4 = (! plru_ctrl_plru_evict_logic_4_state); // @ Plru.scala l36
    if(plru_ctrl_plru_evict_logic_4_validCheck_notOks_1) begin
      plru_ctrl_plru_evict_sel_4 = 1'b0; // @ Plru.scala l41
    end
    if(plru_ctrl_plru_evict_logic_4_validCheck_notOks_0) begin
      plru_ctrl_plru_evict_sel_4 = 1'b1; // @ Plru.scala l41
    end
  end

  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_0_0 = plru_ctrl_plru_io_context_valids[1 : 0]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_1_0 = plru_ctrl_plru_io_context_valids[3 : 2]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_2_0 = plru_ctrl_plru_io_context_valids[5 : 4]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_3_0 = plru_ctrl_plru_io_context_valids[7 : 6]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_4_0 = plru_ctrl_plru_io_context_valids[9 : 8]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_5_0 = plru_ctrl_plru_io_context_valids[11 : 10]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_6_0 = plru_ctrl_plru_io_context_valids[13 : 12]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_7_0 = plru_ctrl_plru_io_context_valids[15 : 14]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_8_0 = plru_ctrl_plru_io_context_valids[17 : 16]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_9_0 = plru_ctrl_plru_io_context_valids[19 : 18]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_10_0 = plru_ctrl_plru_io_context_valids[21 : 20]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_11_0 = plru_ctrl_plru_io_context_valids[23 : 22]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_12_0 = plru_ctrl_plru_io_context_valids[25 : 24]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_13_0 = plru_ctrl_plru_io_context_valids[27 : 26]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_14_0 = plru_ctrl_plru_io_context_valids[29 : 28]; // @ BaseType.scala l299
  assign tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_15_0 = plru_ctrl_plru_io_context_valids[31 : 30]; // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_0_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_0_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_0_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_0_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_1_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_1_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_1_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_1_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_2_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_2_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_2_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_2_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_3_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_3_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_3_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_3_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_4_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_4_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_4_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_4_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_5_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_5_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_5_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_5_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_6_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_6_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_6_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_6_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_7_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_7_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_7_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_7_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_8_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_8_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_8_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_8_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_9_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_9_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_9_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_9_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_10_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_10_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_10_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_10_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_11_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_11_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_11_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_11_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_12_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_12_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_12_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_12_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_13_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_13_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_13_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_13_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_14_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_14_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_14_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_14_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_15_0 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_15_0[0 : 0])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_groups_15_1 = (! (|tmp_plru_ctrl_plru_evict_logic_4_validCheck_groups_15_0[1 : 1])); // @ BaseType.scala l299
  assign plru_ctrl_plru_evict_logic_4_validCheck_notOks_0 = tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_0; // @ Vec.scala l202
  assign plru_ctrl_plru_evict_logic_4_validCheck_notOks_1 = tmp_plru_ctrl_plru_evict_logic_4_validCheck_notOks_1; // @ Vec.scala l202
  assign plru_ctrl_plru_io_evict_id = {plru_ctrl_plru_evict_sel_0,{plru_ctrl_plru_evict_sel_1,{plru_ctrl_plru_evict_sel_2,{plru_ctrl_plru_evict_sel_3,plru_ctrl_plru_evict_sel_4}}}}; // @ Plru.scala l44
  assign plru_ctrl_plru_io_update_state_0[0] = plru_ctrl_plru_io_update_id[4]; // @ Plru.scala l52
  assign plru_ctrl_plru_update_logic_1_sel = plru_ctrl_plru_io_update_id[4 : 4]; // @ BaseType.scala l318
  always @(*) begin
    plru_ctrl_plru_io_update_state_1 = plru_ctrl_plru_io_context_state_1; // @ Plru.scala l51
    plru_ctrl_plru_io_update_state_1[plru_ctrl_plru_update_logic_1_sel] = plru_ctrl_plru_io_update_id[3]; // @ Plru.scala l52
  end

  assign plru_ctrl_plru_update_logic_2_sel = plru_ctrl_plru_io_update_id[4 : 3]; // @ BaseType.scala l318
  always @(*) begin
    plru_ctrl_plru_io_update_state_2 = plru_ctrl_plru_io_context_state_2; // @ Plru.scala l51
    plru_ctrl_plru_io_update_state_2[plru_ctrl_plru_update_logic_2_sel] = plru_ctrl_plru_io_update_id[2]; // @ Plru.scala l52
  end

  assign plru_ctrl_plru_update_logic_3_sel = plru_ctrl_plru_io_update_id[4 : 2]; // @ BaseType.scala l318
  always @(*) begin
    plru_ctrl_plru_io_update_state_3 = plru_ctrl_plru_io_context_state_3; // @ Plru.scala l51
    plru_ctrl_plru_io_update_state_3[plru_ctrl_plru_update_logic_3_sel] = plru_ctrl_plru_io_update_id[1]; // @ Plru.scala l52
  end

  assign plru_ctrl_plru_update_logic_4_sel = plru_ctrl_plru_io_update_id[4 : 1]; // @ BaseType.scala l318
  always @(*) begin
    plru_ctrl_plru_io_update_state_4 = plru_ctrl_plru_io_context_state_4; // @ Plru.scala l51
    plru_ctrl_plru_io_update_state_4[plru_ctrl_plru_update_logic_4_sel] = plru_ctrl_plru_io_update_id[0]; // @ Plru.scala l52
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_0_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when) begin
      if(((! plru_ctrl_aging_logic_cnts_0_willOverflowIfInc) && plru_ctrl_aging_logic_filled[0])) begin
        plru_ctrl_aging_logic_cnts_0_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_0_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_0_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_0_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_0_willOverflow = (plru_ctrl_aging_logic_cnts_0_willOverflowIfInc && plru_ctrl_aging_logic_cnts_0_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_0_willOverflow) begin
      plru_ctrl_aging_logic_cnts_0_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_0_valueNext = (plru_ctrl_aging_logic_cnts_0_value + tmp_plru_ctrl_aging_logic_cnts_0_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_0_willClear) begin
      plru_ctrl_aging_logic_cnts_0_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_1_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_1) begin
      if(((! plru_ctrl_aging_logic_cnts_1_willOverflowIfInc) && plru_ctrl_aging_logic_filled[1])) begin
        plru_ctrl_aging_logic_cnts_1_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_1_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_1_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_1_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_1_willOverflow = (plru_ctrl_aging_logic_cnts_1_willOverflowIfInc && plru_ctrl_aging_logic_cnts_1_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_1_willOverflow) begin
      plru_ctrl_aging_logic_cnts_1_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_1_valueNext = (plru_ctrl_aging_logic_cnts_1_value + tmp_plru_ctrl_aging_logic_cnts_1_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_1_willClear) begin
      plru_ctrl_aging_logic_cnts_1_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_2_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_2) begin
      if(((! plru_ctrl_aging_logic_cnts_2_willOverflowIfInc) && plru_ctrl_aging_logic_filled[2])) begin
        plru_ctrl_aging_logic_cnts_2_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_2_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_2_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_2_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_2_willOverflow = (plru_ctrl_aging_logic_cnts_2_willOverflowIfInc && plru_ctrl_aging_logic_cnts_2_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_2_willOverflow) begin
      plru_ctrl_aging_logic_cnts_2_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_2_valueNext = (plru_ctrl_aging_logic_cnts_2_value + tmp_plru_ctrl_aging_logic_cnts_2_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_2_willClear) begin
      plru_ctrl_aging_logic_cnts_2_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_3_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_3) begin
      if(((! plru_ctrl_aging_logic_cnts_3_willOverflowIfInc) && plru_ctrl_aging_logic_filled[3])) begin
        plru_ctrl_aging_logic_cnts_3_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_3_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_3_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_3_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_3_willOverflow = (plru_ctrl_aging_logic_cnts_3_willOverflowIfInc && plru_ctrl_aging_logic_cnts_3_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_3_willOverflow) begin
      plru_ctrl_aging_logic_cnts_3_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_3_valueNext = (plru_ctrl_aging_logic_cnts_3_value + tmp_plru_ctrl_aging_logic_cnts_3_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_3_willClear) begin
      plru_ctrl_aging_logic_cnts_3_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_4_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_4) begin
      if(((! plru_ctrl_aging_logic_cnts_4_willOverflowIfInc) && plru_ctrl_aging_logic_filled[4])) begin
        plru_ctrl_aging_logic_cnts_4_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_4_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_4_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_4_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_4_willOverflow = (plru_ctrl_aging_logic_cnts_4_willOverflowIfInc && plru_ctrl_aging_logic_cnts_4_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_4_willOverflow) begin
      plru_ctrl_aging_logic_cnts_4_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_4_valueNext = (plru_ctrl_aging_logic_cnts_4_value + tmp_plru_ctrl_aging_logic_cnts_4_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_4_willClear) begin
      plru_ctrl_aging_logic_cnts_4_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_5_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_5) begin
      if(((! plru_ctrl_aging_logic_cnts_5_willOverflowIfInc) && plru_ctrl_aging_logic_filled[5])) begin
        plru_ctrl_aging_logic_cnts_5_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_5_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_5_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_5_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_5_willOverflow = (plru_ctrl_aging_logic_cnts_5_willOverflowIfInc && plru_ctrl_aging_logic_cnts_5_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_5_willOverflow) begin
      plru_ctrl_aging_logic_cnts_5_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_5_valueNext = (plru_ctrl_aging_logic_cnts_5_value + tmp_plru_ctrl_aging_logic_cnts_5_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_5_willClear) begin
      plru_ctrl_aging_logic_cnts_5_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_6_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_6) begin
      if(((! plru_ctrl_aging_logic_cnts_6_willOverflowIfInc) && plru_ctrl_aging_logic_filled[6])) begin
        plru_ctrl_aging_logic_cnts_6_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_6_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_6_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_6_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_6_willOverflow = (plru_ctrl_aging_logic_cnts_6_willOverflowIfInc && plru_ctrl_aging_logic_cnts_6_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_6_willOverflow) begin
      plru_ctrl_aging_logic_cnts_6_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_6_valueNext = (plru_ctrl_aging_logic_cnts_6_value + tmp_plru_ctrl_aging_logic_cnts_6_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_6_willClear) begin
      plru_ctrl_aging_logic_cnts_6_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_7_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_7) begin
      if(((! plru_ctrl_aging_logic_cnts_7_willOverflowIfInc) && plru_ctrl_aging_logic_filled[7])) begin
        plru_ctrl_aging_logic_cnts_7_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_7_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_7_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_7_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_7_willOverflow = (plru_ctrl_aging_logic_cnts_7_willOverflowIfInc && plru_ctrl_aging_logic_cnts_7_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_7_willOverflow) begin
      plru_ctrl_aging_logic_cnts_7_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_7_valueNext = (plru_ctrl_aging_logic_cnts_7_value + tmp_plru_ctrl_aging_logic_cnts_7_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_7_willClear) begin
      plru_ctrl_aging_logic_cnts_7_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_8_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_8) begin
      if(((! plru_ctrl_aging_logic_cnts_8_willOverflowIfInc) && plru_ctrl_aging_logic_filled[8])) begin
        plru_ctrl_aging_logic_cnts_8_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_8_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_8_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_8_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_8_willOverflow = (plru_ctrl_aging_logic_cnts_8_willOverflowIfInc && plru_ctrl_aging_logic_cnts_8_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_8_willOverflow) begin
      plru_ctrl_aging_logic_cnts_8_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_8_valueNext = (plru_ctrl_aging_logic_cnts_8_value + tmp_plru_ctrl_aging_logic_cnts_8_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_8_willClear) begin
      plru_ctrl_aging_logic_cnts_8_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_9_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_9) begin
      if(((! plru_ctrl_aging_logic_cnts_9_willOverflowIfInc) && plru_ctrl_aging_logic_filled[9])) begin
        plru_ctrl_aging_logic_cnts_9_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_9_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_9_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_9_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_9_willOverflow = (plru_ctrl_aging_logic_cnts_9_willOverflowIfInc && plru_ctrl_aging_logic_cnts_9_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_9_willOverflow) begin
      plru_ctrl_aging_logic_cnts_9_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_9_valueNext = (plru_ctrl_aging_logic_cnts_9_value + tmp_plru_ctrl_aging_logic_cnts_9_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_9_willClear) begin
      plru_ctrl_aging_logic_cnts_9_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_10_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_10) begin
      if(((! plru_ctrl_aging_logic_cnts_10_willOverflowIfInc) && plru_ctrl_aging_logic_filled[10])) begin
        plru_ctrl_aging_logic_cnts_10_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_10_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_10_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_10_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_10_willOverflow = (plru_ctrl_aging_logic_cnts_10_willOverflowIfInc && plru_ctrl_aging_logic_cnts_10_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_10_willOverflow) begin
      plru_ctrl_aging_logic_cnts_10_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_10_valueNext = (plru_ctrl_aging_logic_cnts_10_value + tmp_plru_ctrl_aging_logic_cnts_10_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_10_willClear) begin
      plru_ctrl_aging_logic_cnts_10_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_11_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_11) begin
      if(((! plru_ctrl_aging_logic_cnts_11_willOverflowIfInc) && plru_ctrl_aging_logic_filled[11])) begin
        plru_ctrl_aging_logic_cnts_11_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_11_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_11_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_11_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_11_willOverflow = (plru_ctrl_aging_logic_cnts_11_willOverflowIfInc && plru_ctrl_aging_logic_cnts_11_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_11_willOverflow) begin
      plru_ctrl_aging_logic_cnts_11_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_11_valueNext = (plru_ctrl_aging_logic_cnts_11_value + tmp_plru_ctrl_aging_logic_cnts_11_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_11_willClear) begin
      plru_ctrl_aging_logic_cnts_11_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_12_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_12) begin
      if(((! plru_ctrl_aging_logic_cnts_12_willOverflowIfInc) && plru_ctrl_aging_logic_filled[12])) begin
        plru_ctrl_aging_logic_cnts_12_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_12_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_12_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_12_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_12_willOverflow = (plru_ctrl_aging_logic_cnts_12_willOverflowIfInc && plru_ctrl_aging_logic_cnts_12_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_12_willOverflow) begin
      plru_ctrl_aging_logic_cnts_12_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_12_valueNext = (plru_ctrl_aging_logic_cnts_12_value + tmp_plru_ctrl_aging_logic_cnts_12_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_12_willClear) begin
      plru_ctrl_aging_logic_cnts_12_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_13_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_13) begin
      if(((! plru_ctrl_aging_logic_cnts_13_willOverflowIfInc) && plru_ctrl_aging_logic_filled[13])) begin
        plru_ctrl_aging_logic_cnts_13_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_13_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_13_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_13_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_13_willOverflow = (plru_ctrl_aging_logic_cnts_13_willOverflowIfInc && plru_ctrl_aging_logic_cnts_13_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_13_willOverflow) begin
      plru_ctrl_aging_logic_cnts_13_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_13_valueNext = (plru_ctrl_aging_logic_cnts_13_value + tmp_plru_ctrl_aging_logic_cnts_13_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_13_willClear) begin
      plru_ctrl_aging_logic_cnts_13_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_14_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_14) begin
      if(((! plru_ctrl_aging_logic_cnts_14_willOverflowIfInc) && plru_ctrl_aging_logic_filled[14])) begin
        plru_ctrl_aging_logic_cnts_14_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_14_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_14_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_14_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_14_willOverflow = (plru_ctrl_aging_logic_cnts_14_willOverflowIfInc && plru_ctrl_aging_logic_cnts_14_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_14_willOverflow) begin
      plru_ctrl_aging_logic_cnts_14_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_14_valueNext = (plru_ctrl_aging_logic_cnts_14_value + tmp_plru_ctrl_aging_logic_cnts_14_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_14_willClear) begin
      plru_ctrl_aging_logic_cnts_14_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_15_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_15) begin
      if(((! plru_ctrl_aging_logic_cnts_15_willOverflowIfInc) && plru_ctrl_aging_logic_filled[15])) begin
        plru_ctrl_aging_logic_cnts_15_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_15_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_15_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_15_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_15_willOverflow = (plru_ctrl_aging_logic_cnts_15_willOverflowIfInc && plru_ctrl_aging_logic_cnts_15_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_15_willOverflow) begin
      plru_ctrl_aging_logic_cnts_15_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_15_valueNext = (plru_ctrl_aging_logic_cnts_15_value + tmp_plru_ctrl_aging_logic_cnts_15_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_15_willClear) begin
      plru_ctrl_aging_logic_cnts_15_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_16_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_16) begin
      if(((! plru_ctrl_aging_logic_cnts_16_willOverflowIfInc) && plru_ctrl_aging_logic_filled[16])) begin
        plru_ctrl_aging_logic_cnts_16_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_16_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_16_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_16_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_16_willOverflow = (plru_ctrl_aging_logic_cnts_16_willOverflowIfInc && plru_ctrl_aging_logic_cnts_16_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_16_willOverflow) begin
      plru_ctrl_aging_logic_cnts_16_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_16_valueNext = (plru_ctrl_aging_logic_cnts_16_value + tmp_plru_ctrl_aging_logic_cnts_16_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_16_willClear) begin
      plru_ctrl_aging_logic_cnts_16_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_17_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_17) begin
      if(((! plru_ctrl_aging_logic_cnts_17_willOverflowIfInc) && plru_ctrl_aging_logic_filled[17])) begin
        plru_ctrl_aging_logic_cnts_17_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_17_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_17_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_17_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_17_willOverflow = (plru_ctrl_aging_logic_cnts_17_willOverflowIfInc && plru_ctrl_aging_logic_cnts_17_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_17_willOverflow) begin
      plru_ctrl_aging_logic_cnts_17_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_17_valueNext = (plru_ctrl_aging_logic_cnts_17_value + tmp_plru_ctrl_aging_logic_cnts_17_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_17_willClear) begin
      plru_ctrl_aging_logic_cnts_17_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_18_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_18) begin
      if(((! plru_ctrl_aging_logic_cnts_18_willOverflowIfInc) && plru_ctrl_aging_logic_filled[18])) begin
        plru_ctrl_aging_logic_cnts_18_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_18_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_18_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_18_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_18_willOverflow = (plru_ctrl_aging_logic_cnts_18_willOverflowIfInc && plru_ctrl_aging_logic_cnts_18_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_18_willOverflow) begin
      plru_ctrl_aging_logic_cnts_18_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_18_valueNext = (plru_ctrl_aging_logic_cnts_18_value + tmp_plru_ctrl_aging_logic_cnts_18_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_18_willClear) begin
      plru_ctrl_aging_logic_cnts_18_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_19_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_19) begin
      if(((! plru_ctrl_aging_logic_cnts_19_willOverflowIfInc) && plru_ctrl_aging_logic_filled[19])) begin
        plru_ctrl_aging_logic_cnts_19_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_19_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_19_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_19_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_19_willOverflow = (plru_ctrl_aging_logic_cnts_19_willOverflowIfInc && plru_ctrl_aging_logic_cnts_19_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_19_willOverflow) begin
      plru_ctrl_aging_logic_cnts_19_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_19_valueNext = (plru_ctrl_aging_logic_cnts_19_value + tmp_plru_ctrl_aging_logic_cnts_19_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_19_willClear) begin
      plru_ctrl_aging_logic_cnts_19_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_20_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_20) begin
      if(((! plru_ctrl_aging_logic_cnts_20_willOverflowIfInc) && plru_ctrl_aging_logic_filled[20])) begin
        plru_ctrl_aging_logic_cnts_20_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_20_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_20_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_20_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_20_willOverflow = (plru_ctrl_aging_logic_cnts_20_willOverflowIfInc && plru_ctrl_aging_logic_cnts_20_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_20_willOverflow) begin
      plru_ctrl_aging_logic_cnts_20_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_20_valueNext = (plru_ctrl_aging_logic_cnts_20_value + tmp_plru_ctrl_aging_logic_cnts_20_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_20_willClear) begin
      plru_ctrl_aging_logic_cnts_20_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_21_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_21) begin
      if(((! plru_ctrl_aging_logic_cnts_21_willOverflowIfInc) && plru_ctrl_aging_logic_filled[21])) begin
        plru_ctrl_aging_logic_cnts_21_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_21_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_21_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_21_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_21_willOverflow = (plru_ctrl_aging_logic_cnts_21_willOverflowIfInc && plru_ctrl_aging_logic_cnts_21_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_21_willOverflow) begin
      plru_ctrl_aging_logic_cnts_21_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_21_valueNext = (plru_ctrl_aging_logic_cnts_21_value + tmp_plru_ctrl_aging_logic_cnts_21_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_21_willClear) begin
      plru_ctrl_aging_logic_cnts_21_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_22_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_22) begin
      if(((! plru_ctrl_aging_logic_cnts_22_willOverflowIfInc) && plru_ctrl_aging_logic_filled[22])) begin
        plru_ctrl_aging_logic_cnts_22_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_22_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_22_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_22_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_22_willOverflow = (plru_ctrl_aging_logic_cnts_22_willOverflowIfInc && plru_ctrl_aging_logic_cnts_22_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_22_willOverflow) begin
      plru_ctrl_aging_logic_cnts_22_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_22_valueNext = (plru_ctrl_aging_logic_cnts_22_value + tmp_plru_ctrl_aging_logic_cnts_22_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_22_willClear) begin
      plru_ctrl_aging_logic_cnts_22_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_23_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_23) begin
      if(((! plru_ctrl_aging_logic_cnts_23_willOverflowIfInc) && plru_ctrl_aging_logic_filled[23])) begin
        plru_ctrl_aging_logic_cnts_23_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_23_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_23_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_23_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_23_willOverflow = (plru_ctrl_aging_logic_cnts_23_willOverflowIfInc && plru_ctrl_aging_logic_cnts_23_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_23_willOverflow) begin
      plru_ctrl_aging_logic_cnts_23_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_23_valueNext = (plru_ctrl_aging_logic_cnts_23_value + tmp_plru_ctrl_aging_logic_cnts_23_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_23_willClear) begin
      plru_ctrl_aging_logic_cnts_23_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_24_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_24) begin
      if(((! plru_ctrl_aging_logic_cnts_24_willOverflowIfInc) && plru_ctrl_aging_logic_filled[24])) begin
        plru_ctrl_aging_logic_cnts_24_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_24_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_24_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_24_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_24_willOverflow = (plru_ctrl_aging_logic_cnts_24_willOverflowIfInc && plru_ctrl_aging_logic_cnts_24_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_24_willOverflow) begin
      plru_ctrl_aging_logic_cnts_24_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_24_valueNext = (plru_ctrl_aging_logic_cnts_24_value + tmp_plru_ctrl_aging_logic_cnts_24_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_24_willClear) begin
      plru_ctrl_aging_logic_cnts_24_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_25_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_25) begin
      if(((! plru_ctrl_aging_logic_cnts_25_willOverflowIfInc) && plru_ctrl_aging_logic_filled[25])) begin
        plru_ctrl_aging_logic_cnts_25_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_25_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_25_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_25_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_25_willOverflow = (plru_ctrl_aging_logic_cnts_25_willOverflowIfInc && plru_ctrl_aging_logic_cnts_25_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_25_willOverflow) begin
      plru_ctrl_aging_logic_cnts_25_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_25_valueNext = (plru_ctrl_aging_logic_cnts_25_value + tmp_plru_ctrl_aging_logic_cnts_25_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_25_willClear) begin
      plru_ctrl_aging_logic_cnts_25_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_26_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_26) begin
      if(((! plru_ctrl_aging_logic_cnts_26_willOverflowIfInc) && plru_ctrl_aging_logic_filled[26])) begin
        plru_ctrl_aging_logic_cnts_26_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_26_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_26_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_26_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_26_willOverflow = (plru_ctrl_aging_logic_cnts_26_willOverflowIfInc && plru_ctrl_aging_logic_cnts_26_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_26_willOverflow) begin
      plru_ctrl_aging_logic_cnts_26_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_26_valueNext = (plru_ctrl_aging_logic_cnts_26_value + tmp_plru_ctrl_aging_logic_cnts_26_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_26_willClear) begin
      plru_ctrl_aging_logic_cnts_26_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_27_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_27) begin
      if(((! plru_ctrl_aging_logic_cnts_27_willOverflowIfInc) && plru_ctrl_aging_logic_filled[27])) begin
        plru_ctrl_aging_logic_cnts_27_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_27_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_27_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_27_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_27_willOverflow = (plru_ctrl_aging_logic_cnts_27_willOverflowIfInc && plru_ctrl_aging_logic_cnts_27_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_27_willOverflow) begin
      plru_ctrl_aging_logic_cnts_27_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_27_valueNext = (plru_ctrl_aging_logic_cnts_27_value + tmp_plru_ctrl_aging_logic_cnts_27_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_27_willClear) begin
      plru_ctrl_aging_logic_cnts_27_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_28_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_28) begin
      if(((! plru_ctrl_aging_logic_cnts_28_willOverflowIfInc) && plru_ctrl_aging_logic_filled[28])) begin
        plru_ctrl_aging_logic_cnts_28_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_28_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_28_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_28_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_28_willOverflow = (plru_ctrl_aging_logic_cnts_28_willOverflowIfInc && plru_ctrl_aging_logic_cnts_28_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_28_willOverflow) begin
      plru_ctrl_aging_logic_cnts_28_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_28_valueNext = (plru_ctrl_aging_logic_cnts_28_value + tmp_plru_ctrl_aging_logic_cnts_28_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_28_willClear) begin
      plru_ctrl_aging_logic_cnts_28_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_29_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_29) begin
      if(((! plru_ctrl_aging_logic_cnts_29_willOverflowIfInc) && plru_ctrl_aging_logic_filled[29])) begin
        plru_ctrl_aging_logic_cnts_29_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_29_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_29_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_29_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_29_willOverflow = (plru_ctrl_aging_logic_cnts_29_willOverflowIfInc && plru_ctrl_aging_logic_cnts_29_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_29_willOverflow) begin
      plru_ctrl_aging_logic_cnts_29_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_29_valueNext = (plru_ctrl_aging_logic_cnts_29_value + tmp_plru_ctrl_aging_logic_cnts_29_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_29_willClear) begin
      plru_ctrl_aging_logic_cnts_29_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_30_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_30) begin
      if(((! plru_ctrl_aging_logic_cnts_30_willOverflowIfInc) && plru_ctrl_aging_logic_filled[30])) begin
        plru_ctrl_aging_logic_cnts_30_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_30_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_30_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_30_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_30_willOverflow = (plru_ctrl_aging_logic_cnts_30_willOverflowIfInc && plru_ctrl_aging_logic_cnts_30_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_30_willOverflow) begin
      plru_ctrl_aging_logic_cnts_30_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_30_valueNext = (plru_ctrl_aging_logic_cnts_30_value + tmp_plru_ctrl_aging_logic_cnts_30_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_30_willClear) begin
      plru_ctrl_aging_logic_cnts_30_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    plru_ctrl_aging_logic_cnts_31_willIncrement = 1'b0; // @ Utils.scala l594
    if(!tmp_when_31) begin
      if(((! plru_ctrl_aging_logic_cnts_31_willOverflowIfInc) && plru_ctrl_aging_logic_filled[31])) begin
        plru_ctrl_aging_logic_cnts_31_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  assign plru_ctrl_aging_logic_cnts_31_willClear = 1'b0; // @ Utils.scala l595
  assign plru_ctrl_aging_logic_cnts_31_willOverflowIfInc = (plru_ctrl_aging_logic_cnts_31_value == 12'h9c4); // @ BaseType.scala l305
  assign plru_ctrl_aging_logic_cnts_31_willOverflow = (plru_ctrl_aging_logic_cnts_31_willOverflowIfInc && plru_ctrl_aging_logic_cnts_31_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    if(plru_ctrl_aging_logic_cnts_31_willOverflow) begin
      plru_ctrl_aging_logic_cnts_31_valueNext = 12'h0; // @ Utils.scala l610
    end else begin
      plru_ctrl_aging_logic_cnts_31_valueNext = (plru_ctrl_aging_logic_cnts_31_value + tmp_plru_ctrl_aging_logic_cnts_31_valueNext); // @ Utils.scala l612
    end
    if(plru_ctrl_aging_logic_cnts_31_willClear) begin
      plru_ctrl_aging_logic_cnts_31_valueNext = 12'h0; // @ Utils.scala l616
    end
  end

  assign plru_ctrl_update_fire = (plru_ctrl_update_valid && plru_ctrl_update_ready); // @ BaseType.scala l305
  always @(*) begin
    plru_ctrl_aging_logic_entries_died[0] = (plru_ctrl_aging_logic_cnts_0_willOverflowIfInc && plru_ctrl_aging_logic_valids_0); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[1] = (plru_ctrl_aging_logic_cnts_1_willOverflowIfInc && plru_ctrl_aging_logic_valids_1); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[2] = (plru_ctrl_aging_logic_cnts_2_willOverflowIfInc && plru_ctrl_aging_logic_valids_2); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[3] = (plru_ctrl_aging_logic_cnts_3_willOverflowIfInc && plru_ctrl_aging_logic_valids_3); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[4] = (plru_ctrl_aging_logic_cnts_4_willOverflowIfInc && plru_ctrl_aging_logic_valids_4); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[5] = (plru_ctrl_aging_logic_cnts_5_willOverflowIfInc && plru_ctrl_aging_logic_valids_5); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[6] = (plru_ctrl_aging_logic_cnts_6_willOverflowIfInc && plru_ctrl_aging_logic_valids_6); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[7] = (plru_ctrl_aging_logic_cnts_7_willOverflowIfInc && plru_ctrl_aging_logic_valids_7); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[8] = (plru_ctrl_aging_logic_cnts_8_willOverflowIfInc && plru_ctrl_aging_logic_valids_8); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[9] = (plru_ctrl_aging_logic_cnts_9_willOverflowIfInc && plru_ctrl_aging_logic_valids_9); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[10] = (plru_ctrl_aging_logic_cnts_10_willOverflowIfInc && plru_ctrl_aging_logic_valids_10); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[11] = (plru_ctrl_aging_logic_cnts_11_willOverflowIfInc && plru_ctrl_aging_logic_valids_11); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[12] = (plru_ctrl_aging_logic_cnts_12_willOverflowIfInc && plru_ctrl_aging_logic_valids_12); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[13] = (plru_ctrl_aging_logic_cnts_13_willOverflowIfInc && plru_ctrl_aging_logic_valids_13); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[14] = (plru_ctrl_aging_logic_cnts_14_willOverflowIfInc && plru_ctrl_aging_logic_valids_14); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[15] = (plru_ctrl_aging_logic_cnts_15_willOverflowIfInc && plru_ctrl_aging_logic_valids_15); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[16] = (plru_ctrl_aging_logic_cnts_16_willOverflowIfInc && plru_ctrl_aging_logic_valids_16); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[17] = (plru_ctrl_aging_logic_cnts_17_willOverflowIfInc && plru_ctrl_aging_logic_valids_17); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[18] = (plru_ctrl_aging_logic_cnts_18_willOverflowIfInc && plru_ctrl_aging_logic_valids_18); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[19] = (plru_ctrl_aging_logic_cnts_19_willOverflowIfInc && plru_ctrl_aging_logic_valids_19); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[20] = (plru_ctrl_aging_logic_cnts_20_willOverflowIfInc && plru_ctrl_aging_logic_valids_20); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[21] = (plru_ctrl_aging_logic_cnts_21_willOverflowIfInc && plru_ctrl_aging_logic_valids_21); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[22] = (plru_ctrl_aging_logic_cnts_22_willOverflowIfInc && plru_ctrl_aging_logic_valids_22); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[23] = (plru_ctrl_aging_logic_cnts_23_willOverflowIfInc && plru_ctrl_aging_logic_valids_23); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[24] = (plru_ctrl_aging_logic_cnts_24_willOverflowIfInc && plru_ctrl_aging_logic_valids_24); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[25] = (plru_ctrl_aging_logic_cnts_25_willOverflowIfInc && plru_ctrl_aging_logic_valids_25); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[26] = (plru_ctrl_aging_logic_cnts_26_willOverflowIfInc && plru_ctrl_aging_logic_valids_26); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[27] = (plru_ctrl_aging_logic_cnts_27_willOverflowIfInc && plru_ctrl_aging_logic_valids_27); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[28] = (plru_ctrl_aging_logic_cnts_28_willOverflowIfInc && plru_ctrl_aging_logic_valids_28); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[29] = (plru_ctrl_aging_logic_cnts_29_willOverflowIfInc && plru_ctrl_aging_logic_valids_29); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[30] = (plru_ctrl_aging_logic_cnts_30_willOverflowIfInc && plru_ctrl_aging_logic_valids_30); // @ PlruControl.scala l45
    plru_ctrl_aging_logic_entries_died[31] = (plru_ctrl_aging_logic_cnts_31_willOverflowIfInc && plru_ctrl_aging_logic_valids_31); // @ PlruControl.scala l45
  end

  assign plru_ctrl_rpl_blk_logic_no_more = (! (|plru_ctrl_plru_io_context_valids)); // @ BaseType.scala l299
  assign plru_ctrl_plru_io_context_valids = {plru_ctrl_rpl_blk_logic_blks_vec_31,{plru_ctrl_rpl_blk_logic_blks_vec_30,{plru_ctrl_rpl_blk_logic_blks_vec_29,{plru_ctrl_rpl_blk_logic_blks_vec_28,{plru_ctrl_rpl_blk_logic_blks_vec_27,{plru_ctrl_rpl_blk_logic_blks_vec_26,{plru_ctrl_rpl_blk_logic_blks_vec_25,{plru_ctrl_rpl_blk_logic_blks_vec_24,{plru_ctrl_rpl_blk_logic_blks_vec_23,{plru_ctrl_rpl_blk_logic_blks_vec_22,{tmp_plru_ctrl_plru_io_context_valids,tmp_plru_ctrl_plru_io_context_valids_1}}}}}}}}}}}; // @ PlruControl.scala l54
  assign plru_ctrl_rpl_blk_logic_rpl_start_valid = (plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)); // @ PlruControl.scala l55
  assign plru_ctrl_rpl_blk_logic_rpl_start_payload = plru_ctrl_plru_entry; // @ PlruControl.scala l56
  assign plru_ctrl_rpl_blk_logic_rpl_same_err = ((plru_ctrl_rpl_blk_logic_rpl_start_valid && plru_ctrl_rpl_end_valid) && (plru_ctrl_rpl_blk_logic_rpl_start_payload == plru_ctrl_rpl_end_payload)); // @ BaseType.scala l305
  assign plru_ctrl_plru_io_context_state_0 = plru_ctrl_state_0; // @ PlruControl.scala l68
  assign plru_ctrl_plru_io_context_state_1 = plru_ctrl_state_1; // @ PlruControl.scala l68
  assign plru_ctrl_plru_io_context_state_2 = plru_ctrl_state_2; // @ PlruControl.scala l68
  assign plru_ctrl_plru_io_context_state_3 = plru_ctrl_state_3; // @ PlruControl.scala l68
  assign plru_ctrl_plru_io_context_state_4 = plru_ctrl_state_4; // @ PlruControl.scala l68
  assign plru_ctrl_plru_entry = plru_ctrl_plru_io_evict_id; // @ PlruControl.scala l72
  assign plru_ctrl_plru_io_update_id = (plru_ctrl_update_payload_hit_or_miss ? plru_ctrl_update_payload_id : plru_ctrl_plru_io_evict_id); // @ PlruControl.scala l73
  assign plru_ctrl_update_ready = (plru_ctrl_update_payload_hit_or_miss ? 1'b1 : (! plru_ctrl_rpl_blk_logic_no_more)); // @ PlruControl.scala l75
  assign plru_ctrl_update_valid = plru_qry_update_valid; // @ PlruControl.scala l128
  assign plru_ctrl_update_payload_id = plru_qry_update_payload_id; // @ PlruControl.scala l129
  assign plru_ctrl_update_payload_hit_or_miss = plru_qry_update_payload_hit_or_miss; // @ PlruControl.scala l129
  assign plru_qry_update_ready = plru_ctrl_update_ready; // @ PlruControl.scala l130
  assign plru_ctrl_rpl_end_valid = dma_rpl_end_valid; // @ PlruControl.scala l132
  assign plru_ctrl_rpl_end_payload = dma_rpl_end_payload; // @ PlruControl.scala l132
  assign hit_miss_logic_hits_0 = (((! (|(qry_tags_0_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_0) && (! (|(qry_tags_0_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_1 = (((! (|(qry_tags_1_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_1) && (! (|(qry_tags_1_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_2 = (((! (|(qry_tags_2_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_2) && (! (|(qry_tags_2_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_3 = (((! (|(qry_tags_3_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_3) && (! (|(qry_tags_3_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_4 = (((! (|(qry_tags_4_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_4) && (! (|(qry_tags_4_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_5 = (((! (|(qry_tags_5_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_5) && (! (|(qry_tags_5_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_6 = (((! (|(qry_tags_6_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_6) && (! (|(qry_tags_6_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_7 = (((! (|(qry_tags_7_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_7) && (! (|(qry_tags_7_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_8 = (((! (|(qry_tags_8_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_8) && (! (|(qry_tags_8_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_9 = (((! (|(qry_tags_9_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_9) && (! (|(qry_tags_9_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_10 = (((! (|(qry_tags_10_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_10) && (! (|(qry_tags_10_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_11 = (((! (|(qry_tags_11_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_11) && (! (|(qry_tags_11_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_12 = (((! (|(qry_tags_12_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_12) && (! (|(qry_tags_12_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_13 = (((! (|(qry_tags_13_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_13) && (! (|(qry_tags_13_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_14 = (((! (|(qry_tags_14_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_14) && (! (|(qry_tags_14_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_15 = (((! (|(qry_tags_15_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_15) && (! (|(qry_tags_15_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_16 = (((! (|(qry_tags_16_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_16) && (! (|(qry_tags_16_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_17 = (((! (|(qry_tags_17_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_17) && (! (|(qry_tags_17_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_18 = (((! (|(qry_tags_18_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_18) && (! (|(qry_tags_18_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_19 = (((! (|(qry_tags_19_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_19) && (! (|(qry_tags_19_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_20 = (((! (|(qry_tags_20_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_20) && (! (|(qry_tags_20_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_21 = (((! (|(qry_tags_21_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_21) && (! (|(qry_tags_21_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_22 = (((! (|(qry_tags_22_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_22) && (! (|(qry_tags_22_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_23 = (((! (|(qry_tags_23_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_23) && (! (|(qry_tags_23_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_24 = (((! (|(qry_tags_24_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_24) && (! (|(qry_tags_24_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_25 = (((! (|(qry_tags_25_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_25) && (! (|(qry_tags_25_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_26 = (((! (|(qry_tags_26_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_26) && (! (|(qry_tags_26_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_27 = (((! (|(qry_tags_27_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_27) && (! (|(qry_tags_27_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_28 = (((! (|(qry_tags_28_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_28) && (! (|(qry_tags_28_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_29 = (((! (|(qry_tags_29_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_29) && (! (|(qry_tags_29_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_30 = (((! (|(qry_tags_30_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_30) && (! (|(qry_tags_30_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hits_31 = (((! (|(qry_tags_31_spge_tag[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))) && plru_ctrl_aging_logic_valids_31) && (! (|(qry_tags_31_mr_idx ^ mtt_qry_pop_payload_mr_tran_din_mr_idx)))); // @ mtt_cache.scala l90
  assign hit_miss_logic_hit = (|{hit_miss_logic_hits_31,{hit_miss_logic_hits_30,{hit_miss_logic_hits_29,{hit_miss_logic_hits_28,{hit_miss_logic_hits_27,{hit_miss_logic_hits_26,{hit_miss_logic_hits_25,{hit_miss_logic_hits_24,{hit_miss_logic_hits_23,{hit_miss_logic_hits_22,{tmp_hit_miss_logic_hit,tmp_hit_miss_logic_hit_1}}}}}}}}}}}); // @ BaseType.scala l312
  assign tmp_hit_miss_logic_hit_idx = (((((((((((((((hit_miss_logic_hits_1 || hit_miss_logic_hits_3) || hit_miss_logic_hits_5) || hit_miss_logic_hits_7) || hit_miss_logic_hits_9) || hit_miss_logic_hits_11) || hit_miss_logic_hits_13) || hit_miss_logic_hits_15) || hit_miss_logic_hits_17) || hit_miss_logic_hits_19) || hit_miss_logic_hits_21) || hit_miss_logic_hits_23) || hit_miss_logic_hits_25) || hit_miss_logic_hits_27) || hit_miss_logic_hits_29) || hit_miss_logic_hits_31); // @ BaseType.scala l305
  assign tmp_hit_miss_logic_hit_idx_1 = (((((((((((((((hit_miss_logic_hits_2 || hit_miss_logic_hits_3) || hit_miss_logic_hits_6) || hit_miss_logic_hits_7) || hit_miss_logic_hits_10) || hit_miss_logic_hits_11) || hit_miss_logic_hits_14) || hit_miss_logic_hits_15) || hit_miss_logic_hits_18) || hit_miss_logic_hits_19) || hit_miss_logic_hits_22) || hit_miss_logic_hits_23) || hit_miss_logic_hits_26) || hit_miss_logic_hits_27) || hit_miss_logic_hits_30) || hit_miss_logic_hits_31); // @ BaseType.scala l305
  assign tmp_hit_miss_logic_hit_idx_2 = (((((((((((((((hit_miss_logic_hits_4 || hit_miss_logic_hits_5) || hit_miss_logic_hits_6) || hit_miss_logic_hits_7) || hit_miss_logic_hits_12) || hit_miss_logic_hits_13) || hit_miss_logic_hits_14) || hit_miss_logic_hits_15) || hit_miss_logic_hits_20) || hit_miss_logic_hits_21) || hit_miss_logic_hits_22) || hit_miss_logic_hits_23) || hit_miss_logic_hits_28) || hit_miss_logic_hits_29) || hit_miss_logic_hits_30) || hit_miss_logic_hits_31); // @ BaseType.scala l305
  assign tmp_hit_miss_logic_hit_idx_3 = (((((((((((((((hit_miss_logic_hits_8 || hit_miss_logic_hits_9) || hit_miss_logic_hits_10) || hit_miss_logic_hits_11) || hit_miss_logic_hits_12) || hit_miss_logic_hits_13) || hit_miss_logic_hits_14) || hit_miss_logic_hits_15) || hit_miss_logic_hits_24) || hit_miss_logic_hits_25) || hit_miss_logic_hits_26) || hit_miss_logic_hits_27) || hit_miss_logic_hits_28) || hit_miss_logic_hits_29) || hit_miss_logic_hits_30) || hit_miss_logic_hits_31); // @ BaseType.scala l305
  assign tmp_hit_miss_logic_hit_idx_4 = (((((((((((((((hit_miss_logic_hits_16 || hit_miss_logic_hits_17) || hit_miss_logic_hits_18) || hit_miss_logic_hits_19) || hit_miss_logic_hits_20) || hit_miss_logic_hits_21) || hit_miss_logic_hits_22) || hit_miss_logic_hits_23) || hit_miss_logic_hits_24) || hit_miss_logic_hits_25) || hit_miss_logic_hits_26) || hit_miss_logic_hits_27) || hit_miss_logic_hits_28) || hit_miss_logic_hits_29) || hit_miss_logic_hits_30) || hit_miss_logic_hits_31); // @ BaseType.scala l305
  assign hit_miss_logic_hit_idx = {tmp_hit_miss_logic_hit_idx_4,{tmp_hit_miss_logic_hit_idx_3,{tmp_hit_miss_logic_hit_idx_2,{tmp_hit_miss_logic_hit_idx_1,tmp_hit_miss_logic_hit_idx}}}}; // @ BaseType.scala l318
  assign mtt_qry_pop_fire = (mtt_qry_pop_valid && mtt_qry_pop_ready); // @ BaseType.scala l305
  assign hit_miss_logic_miss_info = ((((! hit_miss_logic_hit) && mtt_qry_pop_fire) && (! mtt_qry_pop_payload_mr_tran_din_err)) && mtt_qry_pop_payload_mr_tran_din_need_trans); // @ BaseType.scala l305
  assign miss_dma_logic_on_epge_range = (! (|(mtt_qry_pop_payload_epge_idx[25 : 5] ^ mtt_qry_pop_payload_spge_idx[25 : 5]))); // @ BaseType.scala l299
  assign miss_dma_logic_dma_page_num = 6'h20; // @ Expression.scala l2368
  assign miss_dma_logic_spge_ofst = ({3'd0,tmp_miss_dma_logic_spge_ofst} <<< 2'd3); // @ BaseType.scala l299
  assign miss_dma_logic_dma_rreq_push_payload_dma_pa = (mtt_qry_pop_payload_mr_tran_din_mtt_pba + tmp_miss_dma_logic_dma_rreq_push_payload_dma_pa); // @ mtt_cache.scala l117
  assign miss_dma_logic_dma_rreq_push_payload_dma_len = ({3'd0,miss_dma_logic_dma_page_num} <<< 2'd3); // @ mtt_cache.scala l118
  assign miss_dma_logic_dma_rreq_push_payload_cl_num = plru_ctrl_plru_entry; // @ mtt_cache.scala l119
  assign miss_dma_logic_dma_rreq_push_valid = (((mtt_qry_pop_fire && (! hit_miss_logic_hit)) && (! mtt_qry_pop_payload_mr_tran_din_err)) && mtt_qry_pop_payload_mr_tran_din_need_trans); // @ mtt_cache.scala l120
  assign dma_rreq_fifo_din = {miss_dma_logic_dma_rreq_push_payload_cl_num,{miss_dma_logic_dma_rreq_push_payload_dma_pa,miss_dma_logic_dma_rreq_push_payload_dma_len}}; // @ rdma_ctyun_sfifo.scala l34
  assign miss_dma_logic_dma_rreq_push_ready = (! dma_rreq_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign dma_rdreq_valid = (! dma_rreq_fifo_empty); // @ mtt_cache.scala l121
  assign dma_rdreq_dma_len = dma_rreq_fifo_dout[8 : 0]; // @ mtt_cache.scala l121
  assign dma_rdreq_dma_pa = dma_rreq_fifo_dout[72 : 9]; // @ mtt_cache.scala l121
  assign dma_rdreq_cl_num = dma_rreq_fifo_dout[77 : 73]; // @ mtt_cache.scala l121
  assign qry_tmp_reorder_fifo_din = {qry_tmp_reorder_push_payload_cl_ofst,{qry_tmp_reorder_push_payload_cl_idx,{qry_tmp_reorder_push_payload_hit,{qry_tmp_reorder_push_payload_mr_trans_tmp_mr_idx,{qry_tmp_reorder_push_payload_mr_trans_tmp_trans_sofst,{qry_tmp_reorder_push_payload_mr_trans_tmp_trans_len,{qry_tmp_reorder_push_payload_mr_trans_tmp_mtt_pba,{qry_tmp_reorder_push_payload_mr_trans_tmp_log_entity_sz,{qry_tmp_reorder_push_payload_mr_trans_tmp_need_trans,{qry_tmp_reorder_push_payload_mr_trans_tmp_err,{tmp_din,tmp_din_1}}}}}}}}}}}; // @ rdma_ctyun_sfifo.scala l34
  assign qry_tmp_reorder_push_ready = (! qry_tmp_reorder_fifo_full); // @ rdma_ctyun_sfifo.scala l35
  assign qry_tmp_reorder_pop_valid = (! qry_tmp_reorder_fifo_empty); // @ rdma_ctyun_sfifo.scala l39
  assign tmp_qry_tmp_reorder_pop_payload_mr_trans_tmp_sop = qry_tmp_reorder_fifo_dout[151 : 0]; // @ BaseType.scala l299
  assign qry_tmp_reorder_pop_payload_mr_trans_tmp_sop = tmp_qry_tmp_reorder_pop_payload_mr_trans_tmp_sop[0]; // @ Bool.scala l209
  assign qry_tmp_reorder_pop_payload_mr_trans_tmp_eop = tmp_qry_tmp_reorder_pop_payload_mr_trans_tmp_sop[1]; // @ Bool.scala l209
  assign qry_tmp_reorder_pop_payload_mr_trans_tmp_err = tmp_qry_tmp_reorder_pop_payload_mr_trans_tmp_sop[2]; // @ Bool.scala l209
  assign qry_tmp_reorder_pop_payload_mr_trans_tmp_need_trans = tmp_qry_tmp_reorder_pop_payload_mr_trans_tmp_sop[3]; // @ Bool.scala l209
  assign qry_tmp_reorder_pop_payload_mr_trans_tmp_log_entity_sz = tmp_qry_tmp_reorder_pop_payload_mr_trans_tmp_sop[8 : 4]; // @ UInt.scala l381
  assign qry_tmp_reorder_pop_payload_mr_trans_tmp_mtt_pba = tmp_qry_tmp_reorder_pop_payload_mr_trans_tmp_sop[72 : 9]; // @ UInt.scala l381
  assign qry_tmp_reorder_pop_payload_mr_trans_tmp_trans_len = tmp_qry_tmp_reorder_pop_payload_mr_trans_tmp_sop[104 : 73]; // @ UInt.scala l381
  assign qry_tmp_reorder_pop_payload_mr_trans_tmp_trans_sofst = tmp_qry_tmp_reorder_pop_payload_mr_trans_tmp_sop[136 : 105]; // @ UInt.scala l381
  assign qry_tmp_reorder_pop_payload_mr_trans_tmp_mr_idx = tmp_qry_tmp_reorder_pop_payload_mr_trans_tmp_sop[151 : 137]; // @ Bits.scala l133
  assign qry_tmp_reorder_pop_payload_hit = qry_tmp_reorder_fifo_dout[152]; // @ Bool.scala l209
  assign qry_tmp_reorder_pop_payload_cl_idx = qry_tmp_reorder_fifo_dout[157 : 153]; // @ UInt.scala l381
  assign qry_tmp_reorder_pop_payload_cl_ofst = qry_tmp_reorder_fifo_dout[162 : 158]; // @ UInt.scala l381
  assign dma_rrsp_fifo_din = {dma_rrsp_sop,{dma_rrsp_eop,{dma_rrsp_cl_num,dma_rrsp_data}}}; // @ rdma_ctyun_sfifo.scala l46
  assign dma_rrsp_ready = (! dma_rrsp_fifo_full); // @ rdma_ctyun_sfifo.scala l47
  assign dma_rrsp_pop_valid = (! dma_rrsp_fifo_empty); // @ rdma_ctyun_sfifo.scala l51
  assign dma_rrsp_pop_payload_data = dma_rrsp_fifo_dout[511 : 0]; // @ Bits.scala l133
  assign dma_rrsp_pop_payload_channel = dma_rrsp_fifo_dout[516 : 512]; // @ UInt.scala l381
  assign dma_rrsp_pop_payload_eop = dma_rrsp_fifo_dout[517]; // @ Bool.scala l209
  assign dma_rrsp_pop_payload_sop = dma_rrsp_fifo_dout[518]; // @ Bool.scala l209
  always @(*) begin
    qry_tmp_reorder_pop_ready = tmp_pop_pipe_ready; // @ Stream.scala l374
    if((! tmp_pop_pipe_valid)) begin
      qry_tmp_reorder_pop_ready = 1'b1; // @ Stream.scala l375
    end
  end

  assign tmp_pop_pipe_valid = qry_tmp_reorder_pop_rValid; // @ Stream.scala l377
  assign tmp_pop_pipe_payload_mr_trans_tmp_sop = qry_tmp_reorder_pop_rData_mr_trans_tmp_sop; // @ Stream.scala l378
  assign tmp_pop_pipe_payload_mr_trans_tmp_eop = qry_tmp_reorder_pop_rData_mr_trans_tmp_eop; // @ Stream.scala l378
  assign tmp_pop_pipe_payload_mr_trans_tmp_err = qry_tmp_reorder_pop_rData_mr_trans_tmp_err; // @ Stream.scala l378
  assign tmp_pop_pipe_payload_mr_trans_tmp_need_trans = qry_tmp_reorder_pop_rData_mr_trans_tmp_need_trans; // @ Stream.scala l378
  assign tmp_pop_pipe_payload_mr_trans_tmp_log_entity_sz = qry_tmp_reorder_pop_rData_mr_trans_tmp_log_entity_sz; // @ Stream.scala l378
  assign tmp_pop_pipe_payload_mr_trans_tmp_mtt_pba = qry_tmp_reorder_pop_rData_mr_trans_tmp_mtt_pba; // @ Stream.scala l378
  assign tmp_pop_pipe_payload_mr_trans_tmp_trans_len = qry_tmp_reorder_pop_rData_mr_trans_tmp_trans_len; // @ Stream.scala l378
  assign tmp_pop_pipe_payload_mr_trans_tmp_trans_sofst = qry_tmp_reorder_pop_rData_mr_trans_tmp_trans_sofst; // @ Stream.scala l378
  assign tmp_pop_pipe_payload_mr_trans_tmp_mr_idx = qry_tmp_reorder_pop_rData_mr_trans_tmp_mr_idx; // @ Stream.scala l378
  assign tmp_pop_pipe_payload_hit = qry_tmp_reorder_pop_rData_hit; // @ Stream.scala l378
  assign tmp_pop_pipe_payload_cl_idx = qry_tmp_reorder_pop_rData_cl_idx; // @ Stream.scala l378
  assign tmp_pop_pipe_payload_cl_ofst = qry_tmp_reorder_pop_rData_cl_ofst; // @ Stream.scala l378
  assign cache_ram_rw_logic_rden_int = (((qry_tmp_reorder_pop_valid && qry_tmp_reorder_pop_payload_hit) && qry_tmp_reorder_pop_payload_mr_trans_tmp_need_trans) && (! qry_tmp_reorder_pop_payload_mr_trans_tmp_err)); // @ BaseType.scala l305
  assign cache_ram_rw_logic_raddr_int = {qry_tmp_reorder_pop_payload_cl_idx,qry_tmp_reorder_pop_payload_cl_ofst[4 : 3]}; // @ BaseType.scala l318
  assign cache_ram_rw_logic_wren = (dma_rrsp_pop_valid && (dma_rrsp_pop_ready || dma_rrsp_pop_ready)); // @ BaseType.scala l305
  assign cache_ram_rw_logic_waddr = (tmp_cache_ram_rw_logic_waddr + tmp_cache_ram_rw_logic_waddr_1); // @ BaseType.scala l299
  assign cache_ram_rw_logic_cache_rd_out_0 = data_ram_dout[63 : 0]; // @ BaseType.scala l299
  assign cache_ram_rw_logic_cache_rd_out_1 = data_ram_dout[127 : 64]; // @ BaseType.scala l299
  assign cache_ram_rw_logic_cache_rd_out_2 = data_ram_dout[191 : 128]; // @ BaseType.scala l299
  assign cache_ram_rw_logic_cache_rd_out_3 = data_ram_dout[255 : 192]; // @ BaseType.scala l299
  assign cache_ram_rw_logic_cache_rd_out_4 = data_ram_dout[319 : 256]; // @ BaseType.scala l299
  assign cache_ram_rw_logic_cache_rd_out_5 = data_ram_dout[383 : 320]; // @ BaseType.scala l299
  assign cache_ram_rw_logic_cache_rd_out_6 = data_ram_dout[447 : 384]; // @ BaseType.scala l299
  assign cache_ram_rw_logic_cache_rd_out_7 = data_ram_dout[511 : 448]; // @ BaseType.scala l299
  assign cache_ram_rw_logic_ruw = (((cache_ram_rw_logic_rden && cache_ram_rw_logic_wren) && (cache_ram_rw_logic_waddr == cache_ram_rw_logic_raddr)) && dma_rrsp_pop_payload_eop); // @ BaseType.scala l305
  assign cache_ram_rw_logic_rden = (cache_ram_rw_logic_ruw_d ? cache_ram_rw_logic_rden_int_regNext : cache_ram_rw_logic_rden_int); // @ mtt_cache.scala l142
  assign cache_ram_rw_logic_raddr = (cache_ram_rw_logic_ruw_d ? cache_ram_rw_logic_raddr_int_regNext : cache_ram_rw_logic_raddr_int); // @ mtt_cache.scala l143
  assign mtt_trans_gen_logic_mtt_pa_sel = tmp_pop_pipe_payload_cl_ofst[2 : 0]; // @ BaseType.scala l318
  assign mtt_trans_gen_logic_rpl_mtt_pa = (tmp_mtt_trans_gen_logic_rpl_mtt_pa + tmp_mtt_trans_gen_logic_rpl_mtt_pa_1); // @ BaseType.scala l299
  assign mtt_trans_gen_logic_row_sel = (tmp_pop_pipe_payload_cl_ofst >>> 2'd3); // @ BaseType.scala l299
  assign mtt_trans_gen_logic_cached_mtt_pa = (tmp_mtt_trans_gen_logic_cached_mtt_pa + (tmp_pop_pipe_payload_mr_trans_tmp_need_trans ? tmp_mtt_trans_gen_logic_cached_mtt_pa_2 : tmp_pop_pipe_payload_mr_trans_tmp_mtt_pba)); // @ BaseType.scala l299
  assign tmp_pop_pipe_ready = (tmp_pop_pipe_payload_hit ? (mtt_trans_ready && (! cache_ram_rw_logic_ruw_d)) : (((dma_rrsp_pop_valid && dma_rrsp_pop_payload_eop) && mtt_trans_ready) || (tmp_pop_pipe_payload_mr_trans_tmp_err && mtt_trans_ready))); // @ mtt_cache.scala l167
  assign mtt_trans_valid = (tmp_pop_pipe_payload_hit ? (tmp_pop_pipe_valid && (! cache_ram_rw_logic_ruw_d)) : (((tmp_pop_pipe_valid && (dma_rsp_cnt == mtt_trans_gen_logic_row_sel)) && dma_rrsp_pop_valid) || (tmp_pop_pipe_valid && tmp_pop_pipe_payload_mr_trans_tmp_err))); // @ mtt_cache.scala l172
  assign mtt_trans_sop = tmp_pop_pipe_payload_mr_trans_tmp_sop; // @ mtt_cache.scala l177
  assign mtt_trans_eop = tmp_pop_pipe_payload_mr_trans_tmp_eop; // @ mtt_cache.scala l178
  assign mtt_trans_log_entity_sz = tmp_pop_pipe_payload_mr_trans_tmp_log_entity_sz; // @ mtt_cache.scala l179
  assign mtt_trans_trans_len = tmp_pop_pipe_payload_mr_trans_tmp_trans_len; // @ mtt_cache.scala l180
  assign mtt_trans_trans_pba = (tmp_pop_pipe_payload_hit ? (tmp_pop_pipe_payload_mr_trans_tmp_err ? 64'h0 : mtt_trans_gen_logic_cached_mtt_pa) : mtt_trans_gen_logic_rpl_mtt_pa); // @ mtt_cache.scala l181
  assign mtt_trans_gen_logic_dma_cl_err = (((dma_rrsp_pop_payload_channel != tmp_pop_pipe_payload_cl_idx) && (dma_rrsp_pop_valid && (dma_rrsp_pop_ready || dma_rrsp_pop_ready))) && tmp_pop_pipe_valid); // @ BaseType.scala l305
  assign mtt_qry_ff_afull = mtt_qry_fifo_almost_full; // @ mtt_cache.scala l187
  assign tmp_1 = ({31'd0,1'b1} <<< plru_ctrl_plru_entry); // @ BaseType.scala l299
  assign tmp_2 = tmp_1[0]; // @ BaseType.scala l305
  assign tmp_3 = tmp_1[1]; // @ BaseType.scala l305
  assign tmp_4 = tmp_1[2]; // @ BaseType.scala l305
  assign tmp_5 = tmp_1[3]; // @ BaseType.scala l305
  assign tmp_6 = tmp_1[4]; // @ BaseType.scala l305
  assign tmp_7 = tmp_1[5]; // @ BaseType.scala l305
  assign tmp_8 = tmp_1[6]; // @ BaseType.scala l305
  assign tmp_9 = tmp_1[7]; // @ BaseType.scala l305
  assign tmp_10 = tmp_1[8]; // @ BaseType.scala l305
  assign tmp_11 = tmp_1[9]; // @ BaseType.scala l305
  assign tmp_12 = tmp_1[10]; // @ BaseType.scala l305
  assign tmp_13 = tmp_1[11]; // @ BaseType.scala l305
  assign tmp_14 = tmp_1[12]; // @ BaseType.scala l305
  assign tmp_15 = tmp_1[13]; // @ BaseType.scala l305
  assign tmp_16 = tmp_1[14]; // @ BaseType.scala l305
  assign tmp_17 = tmp_1[15]; // @ BaseType.scala l305
  assign tmp_18 = tmp_1[16]; // @ BaseType.scala l305
  assign tmp_19 = tmp_1[17]; // @ BaseType.scala l305
  assign tmp_20 = tmp_1[18]; // @ BaseType.scala l305
  assign tmp_21 = tmp_1[19]; // @ BaseType.scala l305
  assign tmp_22 = tmp_1[20]; // @ BaseType.scala l305
  assign tmp_23 = tmp_1[21]; // @ BaseType.scala l305
  assign tmp_24 = tmp_1[22]; // @ BaseType.scala l305
  assign tmp_25 = tmp_1[23]; // @ BaseType.scala l305
  assign tmp_26 = tmp_1[24]; // @ BaseType.scala l305
  assign tmp_27 = tmp_1[25]; // @ BaseType.scala l305
  assign tmp_28 = tmp_1[26]; // @ BaseType.scala l305
  assign tmp_29 = tmp_1[27]; // @ BaseType.scala l305
  assign tmp_30 = tmp_1[28]; // @ BaseType.scala l305
  assign tmp_31 = tmp_1[29]; // @ BaseType.scala l305
  assign tmp_32 = tmp_1[30]; // @ BaseType.scala l305
  assign tmp_33 = tmp_1[31]; // @ BaseType.scala l305
  assign tmp_qry_tags_0_spge_tag = ({5'd0,tmp_tmp_qry_tags_0_spge_tag} <<< 3'd5); // @ BaseType.scala l299
  assign mtt_qry_pop_ready = (qry_tmp_reorder_push_ready && (hit_miss_logic_hit ? 1'b1 : (miss_dma_logic_dma_rreq_push_ready && plru_qry_update_ready))); // @ mtt_cache.scala l194
  assign qry_tmp_reorder_push_valid = mtt_qry_pop_fire; // @ mtt_cache.scala l196
  assign qry_tmp_reorder_push_payload_mr_trans_tmp_sop = mtt_qry_pop_payload_mr_tran_din_sop; // @ mtt_cache.scala l197
  assign qry_tmp_reorder_push_payload_mr_trans_tmp_eop = mtt_qry_pop_payload_mr_tran_din_eop; // @ mtt_cache.scala l197
  assign qry_tmp_reorder_push_payload_mr_trans_tmp_err = mtt_qry_pop_payload_mr_tran_din_err; // @ mtt_cache.scala l197
  assign qry_tmp_reorder_push_payload_mr_trans_tmp_need_trans = mtt_qry_pop_payload_mr_tran_din_need_trans; // @ mtt_cache.scala l197
  assign qry_tmp_reorder_push_payload_mr_trans_tmp_log_entity_sz = mtt_qry_pop_payload_mr_tran_din_log_entity_sz; // @ mtt_cache.scala l197
  assign qry_tmp_reorder_push_payload_mr_trans_tmp_mtt_pba = mtt_qry_pop_payload_mr_tran_din_mtt_pba; // @ mtt_cache.scala l197
  assign qry_tmp_reorder_push_payload_mr_trans_tmp_trans_len = mtt_qry_pop_payload_mr_tran_din_trans_len; // @ mtt_cache.scala l197
  assign qry_tmp_reorder_push_payload_mr_trans_tmp_trans_sofst = mtt_qry_pop_payload_mr_tran_din_trans_sofst; // @ mtt_cache.scala l197
  assign qry_tmp_reorder_push_payload_mr_trans_tmp_mr_idx = mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l197
  assign qry_tmp_reorder_push_payload_cl_idx = (hit_miss_logic_hit ? hit_miss_logic_hit_idx : plru_ctrl_plru_entry); // @ mtt_cache.scala l198
  assign qry_tmp_reorder_push_payload_hit = hit_miss_logic_hit; // @ mtt_cache.scala l199
  assign qry_tmp_reorder_push_payload_cl_ofst = mtt_qry_pop_payload_spge_idx[4 : 0]; // @ mtt_cache.scala l200
  assign plru_qry_update_valid = ((mtt_qry_pop_fire && (! mtt_qry_pop_payload_mr_tran_din_err)) && mtt_qry_pop_payload_mr_tran_din_need_trans); // @ mtt_cache.scala l202
  assign plru_qry_update_payload_hit_or_miss = hit_miss_logic_hit; // @ mtt_cache.scala l203
  assign plru_qry_update_payload_id = hit_miss_logic_hit_idx; // @ mtt_cache.scala l204
  assign dma_rrsp_pop_ready = ((! tmp_pop_pipe_payload_hit) && (! tmp_pop_pipe_payload_mr_trans_tmp_err)); // @ mtt_cache.scala l206
  assign dma_rpl_end_valid = ((dma_rrsp_pop_valid && (dma_rrsp_pop_ready || dma_rrsp_pop_ready)) && dma_rrsp_pop_payload_eop); // @ mtt_cache.scala l207
  assign dma_rpl_end_payload = tmp_pop_pipe_payload_cl_idx; // @ mtt_cache.scala l208
  always @(*) begin
    qry_cnt_willIncrement = 1'b0; // @ Utils.scala l594
    if(mtt_qry_pop_fire) begin
      qry_cnt_willIncrement = 1'b1; // @ Utils.scala l598
    end
  end

  assign qry_cnt_willClear = 1'b0; // @ Utils.scala l595
  assign qry_cnt_willOverflowIfInc = (qry_cnt_value == 16'hffff); // @ BaseType.scala l305
  assign qry_cnt_willOverflow = (qry_cnt_willOverflowIfInc && qry_cnt_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    qry_cnt_valueNext = (qry_cnt_value + tmp_qry_cnt_valueNext); // @ Utils.scala l606
    if(qry_cnt_willClear) begin
      qry_cnt_valueNext = 16'h0; // @ Utils.scala l616
    end
  end

  always @(*) begin
    hit_cnt_willIncrement = 1'b0; // @ Utils.scala l594
    if((mtt_qry_pop_fire && hit_miss_logic_hit)) begin
      hit_cnt_willIncrement = 1'b1; // @ Utils.scala l598
    end
  end

  assign hit_cnt_willClear = 1'b0; // @ Utils.scala l595
  assign hit_cnt_willOverflowIfInc = (hit_cnt_value == 16'hffff); // @ BaseType.scala l305
  assign hit_cnt_willOverflow = (hit_cnt_willOverflowIfInc && hit_cnt_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    hit_cnt_valueNext = (hit_cnt_value + tmp_hit_cnt_valueNext); // @ Utils.scala l606
    if(hit_cnt_willClear) begin
      hit_cnt_valueNext = 16'h0; // @ Utils.scala l616
    end
  end

  always @(posedge clk) begin
    if(reset) begin
      plru_ctrl_aging_logic_cnts_0_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_1_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_2_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_3_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_4_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_5_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_6_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_7_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_8_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_9_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_10_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_11_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_12_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_13_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_14_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_15_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_16_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_17_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_18_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_19_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_20_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_21_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_22_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_23_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_24_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_25_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_26_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_27_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_28_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_29_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_30_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_cnts_31_value <= 12'h0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_0 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_1 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_2 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_3 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_4 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_5 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_6 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_7 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_8 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_9 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_10 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_11 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_12 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_13 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_14 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_15 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_16 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_17 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_18 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_19 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_20 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_21 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_22 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_23 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_24 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_25 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_26 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_27 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_28 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_29 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_30 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_valids_31 <= 1'b0; // @ Data.scala l409
      plru_ctrl_aging_logic_filled <= 32'h0; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_0 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_1 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_2 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_3 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_4 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_5 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_6 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_7 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_8 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_9 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_10 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_11 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_12 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_13 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_14 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_15 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_16 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_17 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_18 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_19 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_20 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_21 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_22 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_23 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_24 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_25 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_26 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_27 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_28 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_29 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_30 <= 1'b1; // @ Data.scala l409
      plru_ctrl_rpl_blk_logic_blks_vec_31 <= 1'b1; // @ Data.scala l409
      plru_ctrl_state_0 <= 1'b0; // @ Data.scala l409
      plru_ctrl_state_1 <= 2'b00; // @ Data.scala l409
      plru_ctrl_state_2 <= 4'b0000; // @ Data.scala l409
      plru_ctrl_state_3 <= 8'h0; // @ Data.scala l409
      plru_ctrl_state_4 <= 16'h0; // @ Data.scala l409
      dma_rsp_cnt <= 2'b00; // @ Data.scala l409
      qry_tmp_reorder_pop_rValid <= 1'b0; // @ Data.scala l409
      cache_ram_rw_logic_ruw_d <= 1'b0; // @ Data.scala l409
      cache_ram_rw_logic_rden_int_regNext <= 1'b0; // @ Data.scala l409
      qry_cnt_value <= 16'h0; // @ Data.scala l409
      hit_cnt_value <= 16'h0; // @ Data.scala l409
    end else begin
      plru_ctrl_aging_logic_cnts_0_value <= plru_ctrl_aging_logic_cnts_0_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_1_value <= plru_ctrl_aging_logic_cnts_1_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_2_value <= plru_ctrl_aging_logic_cnts_2_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_3_value <= plru_ctrl_aging_logic_cnts_3_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_4_value <= plru_ctrl_aging_logic_cnts_4_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_5_value <= plru_ctrl_aging_logic_cnts_5_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_6_value <= plru_ctrl_aging_logic_cnts_6_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_7_value <= plru_ctrl_aging_logic_cnts_7_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_8_value <= plru_ctrl_aging_logic_cnts_8_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_9_value <= plru_ctrl_aging_logic_cnts_9_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_10_value <= plru_ctrl_aging_logic_cnts_10_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_11_value <= plru_ctrl_aging_logic_cnts_11_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_12_value <= plru_ctrl_aging_logic_cnts_12_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_13_value <= plru_ctrl_aging_logic_cnts_13_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_14_value <= plru_ctrl_aging_logic_cnts_14_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_15_value <= plru_ctrl_aging_logic_cnts_15_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_16_value <= plru_ctrl_aging_logic_cnts_16_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_17_value <= plru_ctrl_aging_logic_cnts_17_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_18_value <= plru_ctrl_aging_logic_cnts_18_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_19_value <= plru_ctrl_aging_logic_cnts_19_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_20_value <= plru_ctrl_aging_logic_cnts_20_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_21_value <= plru_ctrl_aging_logic_cnts_21_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_22_value <= plru_ctrl_aging_logic_cnts_22_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_23_value <= plru_ctrl_aging_logic_cnts_23_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_24_value <= plru_ctrl_aging_logic_cnts_24_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_25_value <= plru_ctrl_aging_logic_cnts_25_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_26_value <= plru_ctrl_aging_logic_cnts_26_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_27_value <= plru_ctrl_aging_logic_cnts_27_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_28_value <= plru_ctrl_aging_logic_cnts_28_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_29_value <= plru_ctrl_aging_logic_cnts_29_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_30_value <= plru_ctrl_aging_logic_cnts_30_valueNext; // @ Reg.scala l39
      plru_ctrl_aging_logic_cnts_31_value <= plru_ctrl_aging_logic_cnts_31_valueNext; // @ Reg.scala l39
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0))) begin
        plru_ctrl_aging_logic_filled[0] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when) begin
        plru_ctrl_aging_logic_cnts_0_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_0_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_0 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0))) begin
        plru_ctrl_aging_logic_valids_0 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h01))) begin
        plru_ctrl_aging_logic_filled[1] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_1) begin
        plru_ctrl_aging_logic_cnts_1_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_1_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_1 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h01))) begin
        plru_ctrl_aging_logic_valids_1 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h02))) begin
        plru_ctrl_aging_logic_filled[2] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_2) begin
        plru_ctrl_aging_logic_cnts_2_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_2_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_2 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h02))) begin
        plru_ctrl_aging_logic_valids_2 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h03))) begin
        plru_ctrl_aging_logic_filled[3] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_3) begin
        plru_ctrl_aging_logic_cnts_3_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_3_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_3 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h03))) begin
        plru_ctrl_aging_logic_valids_3 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h04))) begin
        plru_ctrl_aging_logic_filled[4] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_4) begin
        plru_ctrl_aging_logic_cnts_4_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_4_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_4 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h04))) begin
        plru_ctrl_aging_logic_valids_4 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h05))) begin
        plru_ctrl_aging_logic_filled[5] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_5) begin
        plru_ctrl_aging_logic_cnts_5_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_5_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_5 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h05))) begin
        plru_ctrl_aging_logic_valids_5 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h06))) begin
        plru_ctrl_aging_logic_filled[6] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_6) begin
        plru_ctrl_aging_logic_cnts_6_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_6_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_6 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h06))) begin
        plru_ctrl_aging_logic_valids_6 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h07))) begin
        plru_ctrl_aging_logic_filled[7] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_7) begin
        plru_ctrl_aging_logic_cnts_7_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_7_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_7 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h07))) begin
        plru_ctrl_aging_logic_valids_7 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h08))) begin
        plru_ctrl_aging_logic_filled[8] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_8) begin
        plru_ctrl_aging_logic_cnts_8_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_8_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_8 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h08))) begin
        plru_ctrl_aging_logic_valids_8 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h09))) begin
        plru_ctrl_aging_logic_filled[9] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_9) begin
        plru_ctrl_aging_logic_cnts_9_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_9_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_9 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h09))) begin
        plru_ctrl_aging_logic_valids_9 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0a))) begin
        plru_ctrl_aging_logic_filled[10] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_10) begin
        plru_ctrl_aging_logic_cnts_10_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_10_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_10 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0a))) begin
        plru_ctrl_aging_logic_valids_10 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0b))) begin
        plru_ctrl_aging_logic_filled[11] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_11) begin
        plru_ctrl_aging_logic_cnts_11_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_11_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_11 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0b))) begin
        plru_ctrl_aging_logic_valids_11 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0c))) begin
        plru_ctrl_aging_logic_filled[12] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_12) begin
        plru_ctrl_aging_logic_cnts_12_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_12_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_12 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0c))) begin
        plru_ctrl_aging_logic_valids_12 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0d))) begin
        plru_ctrl_aging_logic_filled[13] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_13) begin
        plru_ctrl_aging_logic_cnts_13_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_13_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_13 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0d))) begin
        plru_ctrl_aging_logic_valids_13 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0e))) begin
        plru_ctrl_aging_logic_filled[14] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_14) begin
        plru_ctrl_aging_logic_cnts_14_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_14_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_14 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0e))) begin
        plru_ctrl_aging_logic_valids_14 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0f))) begin
        plru_ctrl_aging_logic_filled[15] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_15) begin
        plru_ctrl_aging_logic_cnts_15_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_15_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_15 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h0f))) begin
        plru_ctrl_aging_logic_valids_15 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h10))) begin
        plru_ctrl_aging_logic_filled[16] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_16) begin
        plru_ctrl_aging_logic_cnts_16_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_16_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_16 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h10))) begin
        plru_ctrl_aging_logic_valids_16 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h11))) begin
        plru_ctrl_aging_logic_filled[17] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_17) begin
        plru_ctrl_aging_logic_cnts_17_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_17_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_17 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h11))) begin
        plru_ctrl_aging_logic_valids_17 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h12))) begin
        plru_ctrl_aging_logic_filled[18] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_18) begin
        plru_ctrl_aging_logic_cnts_18_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_18_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_18 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h12))) begin
        plru_ctrl_aging_logic_valids_18 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h13))) begin
        plru_ctrl_aging_logic_filled[19] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_19) begin
        plru_ctrl_aging_logic_cnts_19_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_19_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_19 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h13))) begin
        plru_ctrl_aging_logic_valids_19 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h14))) begin
        plru_ctrl_aging_logic_filled[20] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_20) begin
        plru_ctrl_aging_logic_cnts_20_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_20_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_20 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h14))) begin
        plru_ctrl_aging_logic_valids_20 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h15))) begin
        plru_ctrl_aging_logic_filled[21] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_21) begin
        plru_ctrl_aging_logic_cnts_21_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_21_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_21 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h15))) begin
        plru_ctrl_aging_logic_valids_21 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h16))) begin
        plru_ctrl_aging_logic_filled[22] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_22) begin
        plru_ctrl_aging_logic_cnts_22_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_22_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_22 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h16))) begin
        plru_ctrl_aging_logic_valids_22 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h17))) begin
        plru_ctrl_aging_logic_filled[23] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_23) begin
        plru_ctrl_aging_logic_cnts_23_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_23_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_23 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h17))) begin
        plru_ctrl_aging_logic_valids_23 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h18))) begin
        plru_ctrl_aging_logic_filled[24] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_24) begin
        plru_ctrl_aging_logic_cnts_24_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_24_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_24 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h18))) begin
        plru_ctrl_aging_logic_valids_24 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h19))) begin
        plru_ctrl_aging_logic_filled[25] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_25) begin
        plru_ctrl_aging_logic_cnts_25_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_25_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_25 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h19))) begin
        plru_ctrl_aging_logic_valids_25 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1a))) begin
        plru_ctrl_aging_logic_filled[26] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_26) begin
        plru_ctrl_aging_logic_cnts_26_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_26_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_26 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1a))) begin
        plru_ctrl_aging_logic_valids_26 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1b))) begin
        plru_ctrl_aging_logic_filled[27] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_27) begin
        plru_ctrl_aging_logic_cnts_27_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_27_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_27 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1b))) begin
        plru_ctrl_aging_logic_valids_27 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1c))) begin
        plru_ctrl_aging_logic_filled[28] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_28) begin
        plru_ctrl_aging_logic_cnts_28_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_28_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_28 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1c))) begin
        plru_ctrl_aging_logic_valids_28 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1d))) begin
        plru_ctrl_aging_logic_filled[29] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_29) begin
        plru_ctrl_aging_logic_cnts_29_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_29_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_29 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1d))) begin
        plru_ctrl_aging_logic_valids_29 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1e))) begin
        plru_ctrl_aging_logic_filled[30] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_30) begin
        plru_ctrl_aging_logic_cnts_30_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_30_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_30 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1e))) begin
        plru_ctrl_aging_logic_valids_30 <= 1'b1; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1f))) begin
        plru_ctrl_aging_logic_filled[31] <= 1'b1; // @ PlruControl.scala l35
      end
      if(tmp_when_31) begin
        plru_ctrl_aging_logic_cnts_31_value <= 12'h0; // @ BitVector.scala l494
      end
      if(plru_ctrl_aging_logic_cnts_31_willOverflowIfInc) begin
        plru_ctrl_aging_logic_valids_31 <= 1'b0; // @ PlruControl.scala l43
      end
      if(((plru_ctrl_update_fire && (! plru_ctrl_update_payload_hit_or_miss)) && (plru_ctrl_plru_entry == 5'h1f))) begin
        plru_ctrl_aging_logic_valids_31 <= 1'b1; // @ PlruControl.scala l43
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! (|plru_ctrl_aging_logic_entries_died))); // PlruControl.scala:L47
        `else
          if(!(! (|plru_ctrl_aging_logic_entries_died))) begin
            $display("WARNING %t, A cache line died: %x", $time, plru_ctrl_aging_logic_entries_died); // PlruControl.scala:L47
          end
        `endif
      `endif
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h0))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_0 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h0))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_0 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h01))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_1 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h01))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_1 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h02))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_2 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h02))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_2 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h03))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_3 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h03))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_3 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h04))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_4 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h04))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_4 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h05))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_5 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h05))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_5 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h06))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_6 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h06))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_6 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h07))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_7 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h07))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_7 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h08))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_8 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h08))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_8 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h09))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_9 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h09))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_9 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h0a))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_10 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h0a))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_10 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h0b))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_11 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h0b))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_11 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h0c))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_12 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h0c))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_12 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h0d))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_13 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h0d))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_13 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h0e))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_14 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h0e))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_14 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h0f))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_15 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h0f))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_15 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h10))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_16 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h10))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_16 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h11))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_17 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h11))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_17 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h12))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_18 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h12))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_18 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h13))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_19 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h13))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_19 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h14))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_20 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h14))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_20 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h15))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_21 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h15))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_21 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h16))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_22 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h16))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_22 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h17))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_23 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h17))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_23 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h18))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_24 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h18))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_24 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h19))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_25 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h19))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_25 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h1a))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_26 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h1a))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_26 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h1b))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_27 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h1b))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_27 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h1c))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_28 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h1c))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_28 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h1d))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_29 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h1d))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_29 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h1e))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_30 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h1e))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_30 <= 1'b1; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_blk_logic_rpl_start_valid && (plru_ctrl_rpl_blk_logic_rpl_start_payload == 5'h1f))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_31 <= 1'b0; // @ PlruControl.scala l58
      end
      if((plru_ctrl_rpl_end_valid && (plru_ctrl_rpl_end_payload == 5'h1f))) begin
        plru_ctrl_rpl_blk_logic_blks_vec_31 <= 1'b1; // @ PlruControl.scala l58
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! plru_ctrl_rpl_blk_logic_rpl_same_err)); // PlruControl.scala:L62
        `else
          if(!(! plru_ctrl_rpl_blk_logic_rpl_same_err)) begin
            $display("WARNING %t, Replace the replacing cache line: %x!!!", $time, plru_ctrl_rpl_blk_logic_rpl_start_payload); // PlruControl.scala:L62
          end
        `endif
      `endif
      if(plru_ctrl_update_fire) begin
        plru_ctrl_state_0 <= plru_ctrl_plru_io_update_state_0; // @ PlruControl.scala l70
        plru_ctrl_state_1 <= plru_ctrl_plru_io_update_state_1; // @ PlruControl.scala l70
        plru_ctrl_state_2 <= plru_ctrl_plru_io_update_state_2; // @ PlruControl.scala l70
        plru_ctrl_state_3 <= plru_ctrl_plru_io_update_state_3; // @ PlruControl.scala l70
        plru_ctrl_state_4 <= plru_ctrl_plru_io_update_state_4; // @ PlruControl.scala l70
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! hit_miss_logic_miss_info)); // mtt_cache.scala:L99
        `else
          if(!(! hit_miss_logic_miss_info)) begin
            $display("WARNING %t ps cache miss, mr_idx: %x, spge_idx: %x, plru_entry: %x!", $time, mtt_qry_pop_payload_mr_tran_din_mr_idx, mtt_qry_pop_payload_spge_idx, plru_ctrl_plru_entry); // mtt_cache.scala:L99
          end
        `endif
      `endif
      if(qry_tmp_reorder_pop_ready) begin
        qry_tmp_reorder_pop_rValid <= qry_tmp_reorder_pop_valid; // @ Stream.scala l365
      end
      cache_ram_rw_logic_ruw_d <= cache_ram_rw_logic_ruw; // @ Reg.scala l39
      cache_ram_rw_logic_rden_int_regNext <= cache_ram_rw_logic_rden_int; // @ Reg.scala l39
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! cache_ram_rw_logic_ruw)); // mtt_cache.scala:L145
        `else
          if(!(! cache_ram_rw_logic_ruw)) begin
            $display("WARNING %t ps, read under write! %x", $time, cache_ram_rw_logic_raddr); // mtt_cache.scala:L145
          end
        `endif
      `endif
      if((dma_rrsp_pop_valid && (dma_rrsp_pop_ready || dma_rrsp_pop_ready))) begin
        if(dma_rrsp_pop_payload_eop) begin
          dma_rsp_cnt <= 2'b00; // @ BitVector.scala l494
        end else begin
          dma_rsp_cnt <= (dma_rsp_cnt + 2'b01); // @ mtt_cache.scala l164
        end
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! mtt_trans_gen_logic_dma_cl_err)); // mtt_cache.scala:L184
        `else
          if(!(! mtt_trans_gen_logic_dma_cl_err)) begin
            $display("FAILURE %t ps, DMA response cl_num: %x equal not to qry_tmp_pop cl_idx: %x !", $time, dma_rrsp_pop_payload_channel, tmp_pop_pipe_payload_cl_idx); // mtt_cache.scala:L184
            $finish;
          end
        `endif
      `endif
      qry_cnt_value <= qry_cnt_valueNext; // @ Reg.scala l39
      hit_cnt_value <= hit_cnt_valueNext; // @ Reg.scala l39
    end
  end

  always @(posedge clk) begin
    if(qry_tmp_reorder_pop_ready) begin
      qry_tmp_reorder_pop_rData_mr_trans_tmp_sop <= qry_tmp_reorder_pop_payload_mr_trans_tmp_sop; // @ Stream.scala l366
      qry_tmp_reorder_pop_rData_mr_trans_tmp_eop <= qry_tmp_reorder_pop_payload_mr_trans_tmp_eop; // @ Stream.scala l366
      qry_tmp_reorder_pop_rData_mr_trans_tmp_err <= qry_tmp_reorder_pop_payload_mr_trans_tmp_err; // @ Stream.scala l366
      qry_tmp_reorder_pop_rData_mr_trans_tmp_need_trans <= qry_tmp_reorder_pop_payload_mr_trans_tmp_need_trans; // @ Stream.scala l366
      qry_tmp_reorder_pop_rData_mr_trans_tmp_log_entity_sz <= qry_tmp_reorder_pop_payload_mr_trans_tmp_log_entity_sz; // @ Stream.scala l366
      qry_tmp_reorder_pop_rData_mr_trans_tmp_mtt_pba <= qry_tmp_reorder_pop_payload_mr_trans_tmp_mtt_pba; // @ Stream.scala l366
      qry_tmp_reorder_pop_rData_mr_trans_tmp_trans_len <= qry_tmp_reorder_pop_payload_mr_trans_tmp_trans_len; // @ Stream.scala l366
      qry_tmp_reorder_pop_rData_mr_trans_tmp_trans_sofst <= qry_tmp_reorder_pop_payload_mr_trans_tmp_trans_sofst; // @ Stream.scala l366
      qry_tmp_reorder_pop_rData_mr_trans_tmp_mr_idx <= qry_tmp_reorder_pop_payload_mr_trans_tmp_mr_idx; // @ Stream.scala l366
      qry_tmp_reorder_pop_rData_hit <= qry_tmp_reorder_pop_payload_hit; // @ Stream.scala l366
      qry_tmp_reorder_pop_rData_cl_idx <= qry_tmp_reorder_pop_payload_cl_idx; // @ Stream.scala l366
      qry_tmp_reorder_pop_rData_cl_ofst <= qry_tmp_reorder_pop_payload_cl_ofst; // @ Stream.scala l366
    end
    cache_ram_rw_logic_raddr_int_regNext <= cache_ram_rw_logic_raddr_int; // @ Reg.scala l39
    if((mtt_qry_pop_fire && (! hit_miss_logic_hit))) begin
      if(tmp_2) begin
        qry_tags_0_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_3) begin
        qry_tags_1_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_4) begin
        qry_tags_2_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_5) begin
        qry_tags_3_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_6) begin
        qry_tags_4_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_7) begin
        qry_tags_5_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_8) begin
        qry_tags_6_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_9) begin
        qry_tags_7_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_10) begin
        qry_tags_8_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_11) begin
        qry_tags_9_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_12) begin
        qry_tags_10_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_13) begin
        qry_tags_11_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_14) begin
        qry_tags_12_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_15) begin
        qry_tags_13_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_16) begin
        qry_tags_14_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_17) begin
        qry_tags_15_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_18) begin
        qry_tags_16_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_19) begin
        qry_tags_17_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_20) begin
        qry_tags_18_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_21) begin
        qry_tags_19_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_22) begin
        qry_tags_20_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_23) begin
        qry_tags_21_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_24) begin
        qry_tags_22_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_25) begin
        qry_tags_23_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_26) begin
        qry_tags_24_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_27) begin
        qry_tags_25_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_28) begin
        qry_tags_26_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_29) begin
        qry_tags_27_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_30) begin
        qry_tags_28_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_31) begin
        qry_tags_29_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_32) begin
        qry_tags_30_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_33) begin
        qry_tags_31_spge_tag <= tmp_qry_tags_0_spge_tag; // @ mtt_cache.scala l190
      end
      if(tmp_2) begin
        qry_tags_0_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_3) begin
        qry_tags_1_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_4) begin
        qry_tags_2_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_5) begin
        qry_tags_3_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_6) begin
        qry_tags_4_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_7) begin
        qry_tags_5_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_8) begin
        qry_tags_6_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_9) begin
        qry_tags_7_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_10) begin
        qry_tags_8_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_11) begin
        qry_tags_9_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_12) begin
        qry_tags_10_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_13) begin
        qry_tags_11_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_14) begin
        qry_tags_12_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_15) begin
        qry_tags_13_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_16) begin
        qry_tags_14_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_17) begin
        qry_tags_15_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_18) begin
        qry_tags_16_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_19) begin
        qry_tags_17_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_20) begin
        qry_tags_18_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_21) begin
        qry_tags_19_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_22) begin
        qry_tags_20_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_23) begin
        qry_tags_21_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_24) begin
        qry_tags_22_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_25) begin
        qry_tags_23_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_26) begin
        qry_tags_24_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_27) begin
        qry_tags_25_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_28) begin
        qry_tags_26_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_29) begin
        qry_tags_27_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_30) begin
        qry_tags_28_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_31) begin
        qry_tags_29_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_32) begin
        qry_tags_30_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
      if(tmp_33) begin
        qry_tags_31_mr_idx <= mtt_qry_pop_payload_mr_tran_din_mr_idx; // @ mtt_cache.scala l191
      end
    end
  end


endmodule
