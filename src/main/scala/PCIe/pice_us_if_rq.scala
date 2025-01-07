package PCIe

import spinal.core._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.{Stream, master, slave}

import scala.language.postfixOps
import spinal.core

case class RqTuser() extends Bundle { // 512 bit axis
  val first_be            = Bits(8 bits)
  val last_be             = Bits(8 bits)
  val addr_offset         = UInt(4 bits)
  val is_sop              = Bool()
  val is_sop_ptr          = Vec.fill(2)(UInt(2 bits))
  val is_eop              = Bool()
  val is_eop_ptr          = Vec.fill(2)(UInt(4 bits))
  val discontinue         = Bool()
  val tph_present         = Bits(2 bits)
  val tph_type            = Bits(4 bits)
  val tph_indirect_tag_en = Bits(2 bits)
  val tph_st_tag          = Bits(16 bits)
  val seq_num             = Vec.fill(2)(UInt(6 bits))
  val parity              = Bits(64 bits)
}

case class pice_us_if_rq(pcieUsConfig: PcieUsConfig) extends Component {
  import pcieUsConfig._
  val io = new Bundle {
    val m_axis_rq         = master Stream (Axi4StreamXilinx(axisPcieDataWidth, rqSeqNumWidth))
    val s_axis_rq_seq_num = Vec.fill(2)(slave Flow (UInt(rqSeqNumWidth bits)))
    val tx_rd_req_tlp     = Vec.fill(tlpSegCount)(slave Stream (TlpIf(txRdReqTlpCfg)))
    val tx_wr_req_tlp     = Vec.fill(tlpSegCount)(slave Stream (TlpIf(txWrReqTlpCfg)))

    val m_axis_rd_req_tx_seq_num = Vec.fill(txSeqNumCount)(master Flow (UInt(txSeqNumWidth bits)))
    val m_axis_wr_req_tx_seq_num = Vec.fill(txSeqNumCount)(master Flow (UInt(txSeqNumWidth bits)))

  }

  val rd_req_tlp_pops: Vec[Stream[TlpIf]] = Vec(io.tx_rd_req_tlp.map(_.queue(512)))
  val wr_req_tlp_pops: Vec[Stream[TlpIf]] = Vec(io.tx_wr_req_tlp.map(_.queue(512)))
}
