package rdma

import spinal.core._
import spinal.lib._
import tool.BusExt._

import scala.language.postfixOps

case class crrl_top() extends Component {
  val dw: Int = CrrlIfDat().getBitsWidth
  val io = new Bundle {
    val create_qp_clr_req: Stream[Bits] = slave Stream (Bits(dw bits))
    val tx_wqe_wr_req:     Stream[Bits] = slave Stream (Bits(dw bits))
    val rx_pkt_rd_req:     Stream[Bits] = slave Stream (Bits(dw bits))
    val rx_wqe_wr_req:     Stream[Bits] = slave Stream (Bits(dw bits))
    val db_sche_rd_req:    Stream[Bits] = slave Stream (Bits(dw bits))

    val creat_qp_clr_rsp: Stream[Bits] = master Stream (Bits(dw bits))
    val tx_wqe_wr_rsp:    Stream[Bits] = master Stream (Bits(dw bits))
    val rx_pkt_rd_rsp:    Stream[Bits] = master Stream (Bits(dw bits))
    val rx_wqe_wr_rsp:    Stream[Bits] = master Stream (Bits(dw bits))
    val db_sche_rd_rsp:   Stream[Bits] = master Stream (Bits(dw bits))
  }

  noIoPrefix()

  val sched_req_bits: Stream[Bits] =
    StreamArbiterFactory.roundRobin.onArgs(io.create_qp_clr_req, io.tx_wqe_wr_req, io.rx_pkt_rd_req, io.rx_wqe_wr_req, io.db_sche_rd_req)
  val crrl_update_inst: crrl_update       = crrl_update().setDefinitionName("update")
  val sel:              UInt              = UInt(3 bits)
  val stream_demux:     Vec[Stream[Bits]] = StreamDemux(crrl_update_inst.io.crrl_rsp.toBits, sel, 5)

  crrl_update_inst.io.crrl_req <> sched_req_bits.asBundle(CrrlIfDat())
  switch(crrl_update_inst.io.crrl_rsp.crrl_sdb.module_id) {
    is(rdma_vh.CMDQ_MNG)(sel     := 0)
    is(rdma_vh.TX_WQE_PROC)(sel  := 1)
    is(rdma_vh.RX_PKT_PROCE)(sel := 2)
    is(rdma_vh.RX_WQE_PROC)(sel  := 3)
    is(rdma_vh.DB_SCHEDULER)(sel := 4)
    default(sel                  := 7)
  }
  io.creat_qp_clr_rsp <> stream_demux(0)
  io.tx_wqe_wr_rsp    <> stream_demux(1)
  io.rx_pkt_rd_rsp    <> stream_demux(2)
  io.rx_wqe_wr_rsp    <> stream_demux(3)
  io.db_sche_rd_rsp   <> stream_demux(4)
}
