package rdma.command_queue

import intel_ip.rdma_ctyun_sfifo._
import spinal.core._
import spinal.lib.bus.avalon.{AvalonST, AvalonSTPayload}
import spinal.lib._
import scala.language.postfixOps
import tool.BusExt._

case class cmd_rsp_divide() extends Component {
  val io = new Bundle {
    val cmd_rsp:              AvalonST         = slave(AvalonST(AvstConfig.cmdRspConfig))
    val rd:                   Bool             = out Bool ()
    val raddr:                UInt             = out UInt (5 bits)
    val db_id_dout:           UInt             = in UInt (5 bits)
    val cmdq_phy_base_addr:   UInt             = in UInt (64 bits)
    val cmd_out_entry_stored: CmdEntryOutStore = in(CmdEntryOutStore())
    val cmd_rsp_dma_wreq:     AvalonST         = master(AvalonST(AvstConfig.dmaRRspWReqConfig))
    val cmd_id_finish:        Stream[UInt]     = master Stream (UInt(5 bits))
  }
  noIoPrefix()
  val cmd_rsp_sdb: CmdRspSdb = CmdRspSdb()
  val divide = new Area {
    val cmd_rsp_pipe:                Stream[AvalonSTPayload] = io.cmd_rsp.toStream.m2sPipe()
    val cmd_rsp_pip_out_inline_data: Bits                    = cmd_rsp_pipe.payload.data.takeLow(128)
    val cmd_rsp_pipe_sdb:            CmdRspSdb               = CmdRspSdb()
    val with_mb_pipe:                Bool                    = cmd_rsp_pipe_sdb.data_len > 16
    val no_eop:                      Bool                    = io.cmd_rsp.payload.eop & io.cmd_rsp.payload.empty >= 48 & ~io.cmd_rsp.payload.sop
    val no_eop_pipe:                 Bool                    = cmd_rsp_pipe.payload.eop & (cmd_rsp_pipe.empty >= 48)
    val cmd_rsp_header:              CmdRspHeader            = CmdRspHeader()
    val cmd_rsp_mb_dat:              Bits                    = Bits(512 bits)
    val cmd_rsp_hd_push:             Stream[CmdRspHeader]    = Stream(CmdRspHeader())
    val cmd_rsp_mb_push:             AvalonST                = AvalonST(AvstConfig.cmdRspMbConfig)
    val cmd_rsp_with_mb:             Bool                    = cmd_rsp_sdb.data_len > 16

    cmd_rsp_pipe_sdb.assignFromBits((cmd_rsp_pipe.channel.asBits))

    cmd_rsp_header.cmd_id          := cmd_rsp_pipe_sdb.cmd_id.resized
    cmd_rsp_header.opcode          := cmd_rsp_pipe_sdb.opcode
    cmd_rsp_header.data_len        := cmd_rsp_pipe_sdb.data_len
    cmd_rsp_header.out_inline_data := cmd_rsp_pip_out_inline_data
    cmd_rsp_header.db_id           := io.db_id_dout
    cmd_rsp_header.out_mb_point    := io.cmd_out_entry_stored.output_mb_point
    cmd_rsp_hd_push.payload        := cmd_rsp_header
    cmd_rsp_hd_push.valid          := cmd_rsp_pipe.fire & cmd_rsp_pipe.payload.sop

    cmd_rsp_mb_dat                := io.cmd_rsp.payload.data.takeLow(128) ## cmd_rsp_pipe.payload.data.takeHigh(512 - 128)
    cmd_rsp_mb_push.payload.sop   := cmd_rsp_pipe.payload.sop
    cmd_rsp_mb_push.payload.data  := cmd_rsp_mb_dat
    cmd_rsp_mb_push.payload.empty := Mux(cmd_rsp_mb_push.payload.eop, Mux(no_eop_pipe, io.cmd_rsp.payload.empty + 16, cmd_rsp_pipe.payload.empty + 16), U(0))

    when(with_mb_pipe) {
      when(cmd_rsp_pipe.payload.eop) {
        cmd_rsp_mb_push.payload.eop := ~no_eop_pipe
      } elsewhen (io.cmd_rsp.payload.eop) {
        cmd_rsp_mb_push.payload.eop := no_eop
      } otherwise {
        cmd_rsp_mb_push.payload.eop.clear()
      }
    } otherwise {
      cmd_rsp_mb_push.payload.eop.set()
    }

    when(with_mb_pipe) {
      when(cmd_rsp_pipe.eop) {
        cmd_rsp_mb_push.valid := ~no_eop_pipe & cmd_rsp_pipe.valid
      } otherwise {
        cmd_rsp_mb_push.valid := cmd_rsp_pipe.valid & cmd_rsp_pipe.valid
      }
    } otherwise {
      cmd_rsp_mb_push.valid.clear()
    }

    when(cmd_rsp_pipe.sop) {
      when(with_mb_pipe) {
        cmd_rsp_pipe.ready := cmd_rsp_hd_push.ready & cmd_rsp_mb_push.ready
      } otherwise {
        cmd_rsp_pipe.ready := cmd_rsp_mb_push.ready
      }
    } otherwise {
      cmd_rsp_pipe.ready := cmd_rsp_mb_push.ready | (no_eop_pipe)
    }

  }

  val dma_wreq_gen = new Area {
    val cmd_rsp_hd_pop:  Stream[CmdRspHeader] = buffer(divide.cmd_rsp_hd_push, 32)
    val cmd_rsp_mb_pop:  AvalonST             = bufferAvst(divide.cmd_rsp_mb_push, 32)
    val cmd_hd_dma_addr: UInt                 = DMAFun.db_id2cmdqe_phy_addr(cmd_rsp_hd_pop.db_id, io.cmdq_phy_base_addr) + 32
    val cmd_hd_dma_desc: DMAWReqDesc          = DMAFun.gen_dma_wreq(U(32), cmd_hd_dma_addr)
    val cmd_mb_dma_desc: DMAWReqDesc          = DMAFun.gen_dma_wreq((cmd_rsp_hd_pop.data_len - 16).resize(17), cmd_rsp_hd_pop.out_mb_point)
    val cmd_hd_dma_data: CmdEntryOut          = CmdEntryOut()

    val hd_pop_flag:    Bool = Bool() setAsReg () init False
    val with_mb_hd_pop: Bool = cmd_rsp_hd_pop.payload.data_len > 17

    cmd_hd_dma_data.clearAll()
    cmd_hd_dma_data.allowOverride()
    cmd_hd_dma_data.output_inline_data.assignFromBits(cmd_rsp_hd_pop.payload.out_inline_data)
    cmd_hd_dma_data.output_length        := cmd_rsp_hd_pop.payload.data_len.resized
    cmd_hd_dma_data.output_mb_point_high := cmd_rsp_hd_pop.payload.out_mb_point.takeHigh(32)
    cmd_hd_dma_data.output_mb_point_low  := cmd_rsp_hd_pop.payload.out_mb_point(31 downto 9).asBits

    when(with_mb_hd_pop & cmd_rsp_mb_pop.payload.eop & cmd_rsp_mb_pop.fire) {
      hd_pop_flag.set()
    } elsewhen (cmd_rsp_hd_pop.fire) {
      hd_pop_flag.clear()
    }

    cmd_rsp_hd_pop.ready := Mux(with_mb_hd_pop, hd_pop_flag, True) & io.cmd_rsp_dma_wreq.ready

    cmd_rsp_mb_pop.ready                := io.cmd_rsp_dma_wreq.ready & with_mb_hd_pop & ~hd_pop_flag
    io.cmd_rsp_dma_wreq.payload.sop     := Mux(with_mb_hd_pop, cmd_rsp_mb_pop.payload.sop | hd_pop_flag, True)
    io.cmd_rsp_dma_wreq.payload.eop     := Mux(with_mb_hd_pop, Mux(hd_pop_flag, True, cmd_rsp_mb_pop.payload.eop), True)
    io.cmd_rsp_dma_wreq.payload.channel := Mux(~with_mb_hd_pop | hd_pop_flag, cmd_hd_dma_desc.asBits.asUInt, cmd_mb_dma_desc.asBits.asUInt)
    io.cmd_rsp_dma_wreq.payload.data    := Mux(~with_mb_hd_pop | hd_pop_flag, B(0, 256 bits) ## cmd_hd_dma_data.asBits, cmd_rsp_mb_pop.payload.data)
    io.cmd_rsp_dma_wreq.payload.empty := Mux(
      io.cmd_rsp_dma_wreq.payload.eop,
      Mux(~with_mb_hd_pop | hd_pop_flag, U(32), (U(64) - (cmd_rsp_hd_pop.data_len +^ 48).resize(6)).resize(6)),
      U(0)
    )
    io.cmd_rsp_dma_wreq.valid := Mux(with_mb_hd_pop & ~hd_pop_flag, cmd_rsp_mb_pop.valid, cmd_rsp_hd_pop.valid)
  }

  io.rd    := io.cmd_rsp.payload.sop & io.cmd_rsp.valid
  io.raddr := cmd_rsp_sdb.cmd_id.resized
  cmd_rsp_sdb.assignFromBits(io.cmd_rsp.payload.channel.asBits)

  io.cmd_id_finish.valid   := dma_wreq_gen.cmd_rsp_hd_pop.fire
  io.cmd_id_finish.payload := dma_wreq_gen.cmd_rsp_hd_pop.payload.cmd_id

  // assertion
  val out_inline: CmdOutputInlineData = CmdOutputInlineData()
  out_inline.assignFromBits(dma_wreq_gen.cmd_rsp_hd_pop.payload.out_inline_data)
  assert(
    ~(dma_wreq_gen.cmd_rsp_hd_pop.fire & (out_inline.status =/= 0 || out_inline.syndrome =/= 0)),
    L"${REPORT_TIME} Cmd rsp error: status:${out_inline.status}, syndrome:${out_inline.syndrome}",
    WARNING
  )

}
