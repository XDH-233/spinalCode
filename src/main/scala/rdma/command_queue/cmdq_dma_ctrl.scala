package rdma.command_queue

import intel_ip.rdma_ctyun_sfifo._
import spinal.core._
import spinal.lib.bus.avalon.{AvalonST, AvalonSTPayload}
import spinal.lib._

import scala.language.postfixOps

import tool.BusExt._

case class cmdq_dma_ctrl() extends Component {
  val io = new Bundle {
    val cmdqe_dma_rreq_s:     Stream[DMARReqDesc]        = slave Stream (DMARReqDesc())
    val mb_dma_dma_rreq_s:    Stream[DMARReqDesc]        = slave Stream (DMARReqDesc())
    val dma_rreq_m:           AvalonST                   = master(AvalonST(AvstConfig.dmaRReqConfig))

    val cmdqe_dma_rrsp_m:     Stream[CmdqEntry]          = master Stream (CmdqEntry())
    val mb_dma_rrsp_m:        AvalonST                   = master(AvalonST(AvstConfig.dmaRRspWReqConfig))
    val dma_rrsp_s:           AvalonST                   = slave(AvalonST(AvstConfig.dmaRRspWReqConfig))

    val err_cmdqe_dma_wreq_s: Stream[ErrCmdqeDMAWReqPkt] = slave Stream (ErrCmdqeDMAWReqPkt())
    val cmd_rsp_dma_wreq_s:   AvalonST                   = slave(AvalonST(AvstConfig.dmaRRspWReqConfig))
    val dma_wreq_m:           AvalonST                   = master(AvalonST(AvstConfig.dmaRRspWReqConfig))
  }
  noIoPrefix()
  val cmdqe_dma_rreq_fifo_pop:     Stream[DMARReqDesc]        = buffer(io.cmdqe_dma_rreq_s, 32)
  val mb_dma_rreq_fifo_pop:        Stream[DMARReqDesc]        = buffer(io.mb_dma_dma_rreq_s, 32)
  val err_cmdqe_dma_wreq_fifo_pop: Stream[ErrCmdqeDMAWReqPkt] = buffer(io.err_cmdqe_dma_wreq_s, 32)
  val cmd_rsp_wreq_fifo_pop:       AvalonST                   = bufferAvst(io.cmd_rsp_dma_wreq_s, 128)
  val dma_rreq_arbi:       Stream[Bits]            = StreamArbiterFactory.lowerFirst.onArgs(mb_dma_rreq_fifo_pop.toBits, cmdqe_dma_rreq_fifo_pop.toBits)
  val err_dma_wreq_pop_st: Stream[AvalonSTPayload] = Stream(io.dma_wreq_m.payload)
  val cmd_rsp_wreq_pop_st: Stream[AvalonSTPayload] = cmd_rsp_wreq_fifo_pop.toStream
  val dma_wreq_arbi: StreamArbiter[AvalonSTPayload] = new StreamArbiter(AvalonSTPayload(AvstConfig.dmaRRspWReqConfig), 2)(
    StreamArbiter.Arbitration.lowerFirst,
    tool.BusExt.avst_lock
  )
  val dma_rrsp_desc:  DMARReqDesc       = DMARReqDesc()
  val select:         UInt              = UInt(1 bits)
  val dma_rrsp_demux: Vec[Stream[Bits]] = StreamDemux(io.dma_rrsp_s.toStream.toBits, select, 2)

  // dma_rreq
  io.dma_rreq_m.valid           := dma_rreq_arbi.valid
  io.dma_rreq_m.payload.channel := dma_rreq_arbi.payload.asBits.asUInt
  dma_rreq_arbi.ready           := io.dma_rreq_m.ready

  //dma_rrsp demux
  dma_rrsp_desc.assignFromBits(io.dma_rrsp_s.payload.channel.asBits)
  select              := dma_rrsp_desc.tag.lsb.asUInt(1 bits)
  io.cmdqe_dma_rrsp_m <> buffer(dma_rrsp_demux(0).asBundle(CmdqEntry()), 32, "cmdqe_dma_rrsp")
  io.mb_dma_rrsp_m    <> bufferAvst(dma_rrsp_demux(1).toAvalonSt(AvstConfig.dmaRRspWReqConfig), 128, "mb_dma_rrsp")

  // dma_wreq
  err_dma_wreq_pop_st.valid           := err_cmdqe_dma_wreq_fifo_pop.valid
  err_dma_wreq_pop_st.payload.channel := err_cmdqe_dma_wreq_fifo_pop.desc.asBits.asUInt
  err_dma_wreq_pop_st.payload.sop     := True
  err_dma_wreq_pop_st.payload.eop     := True
  err_dma_wreq_pop_st.payload.empty   := 0x20
  err_dma_wreq_pop_st.payload.data    := err_cmdqe_dma_wreq_fifo_pop.cmd_out.asBits.resized
  err_cmdqe_dma_wreq_fifo_pop.ready   := err_dma_wreq_pop_st.ready
  io.dma_wreq_m                       <> dma_wreq_arbi.io.output.toAvalonSt(AvstConfig.dmaRRspWReqConfig)
  dma_wreq_arbi.io.inputs.zip(Seq(err_dma_wreq_pop_st, cmd_rsp_wreq_pop_st)).foreach { case (i, p) => i <> p }
}
