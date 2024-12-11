package rdma.command_queue

import intel_ip._
import spinal.core._
import spinal.lib._
import spinal.lib.bus.avalon._
import tool.BusExt.AvstExt
import tool.BusExt.StreamBundleExt
import tool.BusExt.StreamExt

import DMAFun._

import scala.language.postfixOps
import scala.util.Random

case class command_queue_proc_top(cmdqSize: Int = 32) extends Component {

  val io = new Bundle {
    val db_vec_s:           Stream[Bits] = slave Stream (Bits(cmdqSize bits))
    val dma_rreq_m:         AvalonST     = master(AvalonST(AvstConfig.dmaRReqConfig))
    val dma_rrsp_s:         AvalonST     = slave(AvalonST(AvstConfig.dmaRRspWReqConfig))
    val dma_wreq_m:         AvalonST     = master(AvalonST(AvstConfig.dmaRRspWReqConfig))
    val cmdq_phy_addr_i:    UInt         = in UInt (64 bits)
    val cq_cmd_req:         AvalonST     = master(AvalonST(AvstConfig.cmdReqConfig))
    val eq_cmd_req:         AvalonST     = master(AvalonST(AvstConfig.cmdReqConfig))
    val mr_cmd_req:         AvalonST     = master(AvalonST(AvstConfig.cmdReqConfig))
    val qp_cmd_req:         AvalonST     = master(AvalonST(AvstConfig.qpCmdReqConfig))
    val cq_cmd_rsp:         AvalonST     = slave(AvalonST(AvstConfig.cmdRspConfig))
    val eq_cmd_rsp:         AvalonST     = slave(AvalonST(AvstConfig.cmdRspConfig))
    val mr_cmd_rsp:         AvalonST     = slave(AvalonST(AvstConfig.cmdRspConfig))
    val qp_cmd_rsp:         AvalonST     = slave(AvalonST(AvstConfig.qpCmdRspConfig))
    val err_cmdqe_dma_wreq: AvalonST     = out(AvalonST(AvstConfig.dmaRRspWReqConfig))
    val cmd_rsp_dma_wreq:   AvalonST     = out(AvalonST(AvstConfig.dmaRRspWReqConfig))
  }
  noIoPrefix()

  val cmdq_proc: command_queue_proc = command_queue_proc()

  val cmd_req_sel:   UInt = UInt(2 bits)

  val cmd_req_demux: Vec[Stream[Bits]] = StreamDemux(cmdq_proc.io.cmd_req.toStream.toBits, cmd_req_sel, 4)
  cmdq_proc.io.db_vec_s        <> io.db_vec_s
  cmdq_proc.io.dma_rreq_m      <> io.dma_rreq_m
  cmdq_proc.io.dma_rrsp_s      <> io.dma_rrsp_s
  cmdq_proc.io.dma_wreq_m      <> io.dma_wreq_m
  cmdq_proc.io.cmdq_phy_addr_i := io.cmdq_phy_addr_i

  val cmd_rsp_sche = new StreamArbiter(AvalonSTPayload(AvstConfig.cmdRspConfig), 4)(tool.BusExt.avst_lock, StreamArbiter.Arbitration.roundRobin)
  cmd_rsp_sche.io.inputs.zip(Vec(io.cq_cmd_rsp, io.eq_cmd_rsp, io.mr_cmd_rsp, io.qp_cmd_rsp.toStream.m2sPipe().toAvalonSt(AvstConfig.qpCmdRspConfig).expand(2,"qp_cmd_rsp"))).foreach { case (i, r) => i <> r.toStream }
  cmdq_proc.io.cmd_rsp <> cmd_rsp_sche.io.output.toAvalonSt(AvstConfig.cmdRspConfig)

  val cmd_req_sdb: CmdReqSdb = CmdReqSdb()
  cmd_req_sdb.assignFromBits(cmdq_proc.io.cmd_req.payload.channel.asBits)
  switch(cmd_req_sdb.opcode) {
    is(rdma.rdma_vh.CREATE_CQ)(cmd_req_sel          := 0)
    is(rdma.rdma_vh.DESTROY_CQ)(cmd_req_sel         := 0)
    is(rdma.rdma_vh.CREATE_EQ)(cmd_req_sel          := 1)
    is(rdma.rdma_vh.DESTROY_EQ)(cmd_req_sel         := 1)
    is(rdma.rdma_vh.CREATE_MKEY)(cmd_req_sel        := 2)
    is(rdma.rdma_vh.DESTROY_MKEY)(cmd_req_sel       := 2)
    is(rdma.rdma_vh.SET_ROCE_ADDRESS)(cmd_req_sel   := 3)
    is(rdma.rdma_vh.QUERY_ROCE_ADDRESS)(cmd_req_sel := 3)
    is(rdma.rdma_vh.CREATE_QP)(cmd_req_sel          := 3)
    is(rdma.rdma_vh.DESTROY_QP)(cmd_req_sel         := 3)
    is(rdma.rdma_vh.RST2INIT_QP)(cmd_req_sel        := 3)
    is(rdma.rdma_vh.INIT2RTR_QP)(cmd_req_sel        := 3)
    is(rdma.rdma_vh.RTR2RTS_QP)(cmd_req_sel         := 3)
    is(rdma.rdma_vh.TORST_QP)(cmd_req_sel           := 3)
    is(rdma.rdma_vh.QUERY_QP)(cmd_req_sel           := 3)
    default { cmd_req_sel := 0 }
  }
  Seq(io.cq_cmd_req, io.eq_cmd_req, io.mr_cmd_req).zip(cmd_req_demux.init).foreach { case (i, d) => i <> d.toAvalonSt(AvstConfig.cmdReqConfig) }
  io.qp_cmd_req <> cmd_req_demux(3).toAvalonSt(AvstConfig.cmdReqConfig).divide(2, "qp_cmd_req").m2sPipe()

  // dfx
  val cmdqe_out: CmdEntryOut = CmdEntryOut()
  val dma_hit: Bool =
    io.dma_wreq_m.payload.sop & io.dma_wreq_m.payload.eop & (io.dma_wreq_m.payload.empty === 32) & ((io.dma_wreq_m.payload.channel
      .takeLow(64)
      .asBits >> 12) === (io.cmdq_phy_addr_i.asBits >> 12))
  val err_cmdqe_out:  Bool = (cmdqe_out.status =/= 0 || cmdqe_out.output_inline_data.status =/= 0)
  val err_cmdqe_flag: Bool = dma_hit & err_cmdqe_out
  cmdqe_out.assignFromBits(io.dma_wreq_m.payload.data.takeLow(256))

  io.err_cmdqe_dma_wreq.payload := io.dma_wreq_m.payload
  io.cmd_rsp_dma_wreq.payload   := io.dma_wreq_m.payload
  io.err_cmdqe_dma_wreq.ready   := io.dma_wreq_m.ready
  io.cmd_rsp_dma_wreq.ready     := io.dma_wreq_m.ready
  io.err_cmdqe_dma_wreq.valid   := err_cmdqe_flag & io.dma_wreq_m.valid
  io.cmd_rsp_dma_wreq.valid     := ~err_cmdqe_flag & io.dma_wreq_m.valid

  Seq(
    io.cq_cmd_req,
    io.eq_cmd_req,
    io.mr_cmd_req,
    io.qp_cmd_req,
    io.cq_cmd_rsp,
    io.eq_cmd_rsp,
    io.mr_cmd_rsp,
    io.qp_cmd_rsp,
    io.dma_rreq_m,
    io.dma_rrsp_s,
    io.dma_wreq_m
  ).foreach(a => a.payload.setPartialName(""))

  io.db_vec_s.payload.setPartialName("data")
  Seq(io.cq_cmd_req, io.eq_cmd_req, io.mr_cmd_req, io.qp_cmd_req, io.cq_cmd_rsp, io.eq_cmd_rsp, io.mr_cmd_rsp, io.qp_cmd_rsp).foreach(r =>
    r.payload.channel.setPartialName("sdb")
  )
  Seq(io.dma_rreq_m, io.dma_rrsp_s, io.dma_wreq_m).foreach(d => d.payload.channel.setPartialName("desc"))
}
