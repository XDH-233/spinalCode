package rdma.command_queue

import intel_ip.rdma_ctyun_sfifo
import spinal.core._
import spinal.lib._
import spinal.lib.bus.avalon.AvalonST
import spinal.lib.fsm._
import tool.BusExt.AvstExt

import scala.collection.immutable
import scala.language.postfixOps

case class cmd_req_gen() extends Component {
  val io = new Bundle {
    val cmdqe_elements: Stream[CmdReqCMDQEElements] = slave Stream (CmdReqCMDQEElements())
    val mb_dma_rrsp:    AvalonST                    = slave(AvalonST(AvstConfig.dmaRRspWReqConfig))
    val cmd_req:        AvalonST                    = master(AvalonST(AvstConfig.cmdReqConfig))
  }
  noIoPrefix()

  val header:         Bits      = Bits(128 bits)
  val low_part:       Bits      = Bits(384 bits)
  val high_tail:      Bits      = RegNextWhen(io.mb_dma_rrsp.payload.data(511 downto 384), io.mb_dma_rrsp.fire)
  val with_mb_i:      Bool      = io.cmdqe_elements.input_len > 16
  val concat_done:    Bool      = Bool()
  val cmd_req_data:   Bits      = Bits(512 bits)
  val empty_overflow: Bool      = io.mb_dma_rrsp.payload.eop & io.mb_dma_rrsp.payload.empty >= 16 & io.mb_dma_rrsp.valid
  val extra_blk:      Bool      = RegNext(io.mb_dma_rrsp.payload.eop & io.mb_dma_rrsp.payload.empty < 16 & io.mb_dma_rrsp.fire)
  val cmd_req_sdb:    CmdReqSdb = CmdReqSdb()

  low_part     := io.mb_dma_rrsp.payload.data(383 downto 0)
  header       := Mux(io.mb_dma_rrsp.payload.sop, io.cmdqe_elements.cmd_inline_data.asBits, high_tail)
  cmd_req_data := Mux(extra_blk, B(0, 384 bits) ## high_tail, Mux(with_mb_i, low_part ## header, B(0, 384 bits) ## io.cmdqe_elements.cmd_inline_data.asBits))

  cmd_req_sdb.cmd_id := io.cmdqe_elements.cmd_id.resized
  cmd_req_sdb.blk_num.clearAll()
  cmd_req_sdb.opcode := io.cmdqe_elements.cmd_inline_data.opcode.resized

  concat_done             := empty_overflow | extra_blk
  io.cmdqe_elements.ready := (~with_mb_i | concat_done) & io.cmd_req.ready & io.cmdqe_elements.valid
  io.mb_dma_rrsp.ready    := io.cmd_req.ready & ~extra_blk

  io.cmd_req.payload.data    := cmd_req_data
  io.cmd_req.payload.sop     := Mux(with_mb_i, io.mb_dma_rrsp.payload.sop & io.mb_dma_rrsp.valid, True)
  io.cmd_req.payload.eop     := ~with_mb_i | concat_done
  io.cmd_req.payload.channel := cmd_req_sdb.asBits.asUInt
  io.cmd_req.valid           := Mux(with_mb_i, (io.cmdqe_elements.valid & io.mb_dma_rrsp.valid) | extra_blk, io.cmdqe_elements.valid)
  when(io.cmd_req.payload.eop) {
    when(with_mb_i) {
      when(empty_overflow) {
        io.cmd_req.payload.empty := io.mb_dma_rrsp.payload.empty + 48
      } otherwise {
        io.cmd_req.payload.empty := RegNext(io.mb_dma_rrsp.payload.empty + 48)
      }
    } otherwise {
      io.cmd_req.payload.empty := U(48)
    }

  } otherwise (io.cmd_req.payload.empty.clearAll())

  // assertion
  val mb_check = io.mb_dma_rrsp.check
  val input_len_reg: UInt = RegNext(io.cmdqe_elements.input_len)
  val mb_len_err: Bool = mb_check.pkt_size.valid & (input_len_reg =/= mb_check.pkt_size.payload + 0x10)
  assert(~mb_len_err, L"${REPORT_TIME} Mb received data size err: ${mb_check.pkt_size.payload}", WARNING)
}

object cmd_req_gen {
  def apply(cmdqe_st: Stream[CmdReqCMDQEElements], mb_avst: AvalonST, cmd_req: AvalonST): cmd_req_gen = {
    val inst = new cmd_req_gen()
    inst.io.cmdqe_elements <> cmdqe_st
    inst.io.mb_dma_rrsp    <> mb_avst
    inst.io.cmd_req        <> cmd_req
    inst
  }
}
