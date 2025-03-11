package PCIe

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axis.{Axi4StreamConfig}

import scala.language.postfixOps

//case class Axi4StreamXilinxCfg(dataWidth: Int) {}

case class Axi4StreamXilinx(dataWidth: Int, userWidth: Int) extends Bundle {
  val tdata: Bits = Bits(dataWidth bits)
  val tkeep: Bits = Bits(dataWidth / 32 bits)
  val tlast: Bool = Bool()
  val tuser: Bits = Bits(userWidth bits)
}

case class TlpIfConfig(dataWidth: Int = -1, seqNumWidth: Int = -1, withBar: Boolean = false, withErr: Boolean = false)

case class TlpIf(tlpIfConfig: TlpIfConfig) extends Bundle {
  import tlpIfConfig._
  val data:     Bits      = dataWidth > 0 generate Bits(dataWidth bits)
  val strb:     Bits      = dataWidth > 0 generate Bits((dataWidth + 32) / 32 bits)
  val hdr:      TlpHeader = TlpHeader()
  val bar_id:   UInt      = withBar generate UInt(3 bits)
  val func_num: UInt      = withBar generate UInt(8 bits)
  val error:    Bool      = withErr generate Bool()
  val seq:      UInt      = seqNumWidth > 0 generate UInt(seqNumWidth bits)
  val sop:      Bool      = Bool()
  val eop:      Bool      = Bool()
}

case class TlpHeader() extends Bundle { // big endian
  import PCIe.PcieUsConfig.TlpFmt
  val ph           = Bits(2 bits)
  val address      = Bits(62 bits)
  val first_dw_be  = Bits(4 bits) // DW1
  val last_dw_be   = Bits(4 bits)
  val tag          = Bits(8 bits)
  val requested_id = UInt(16 bits)
  val length       = UInt(10 bits) // DW0 byte0
  val at           = Bits(2 bits) // DW0 byte1
  val attr_l       = Bits(2 bits)
  val ep           = Bits(1 bits)
  val td           = Bits(1 bits)
  val th           = Bits(1 bits) // DW0 byte2
  val rsv2         = Bits(1 bits)
  val attr_h       = Bits(1 bits)
  val rsv1         = Bits(1 bits)
  val tc           = Bits(3 bits)
  val rsv0         = Bits(1 bits)
  val type_        = Bits(5 bits) // DW0 byte3
  val fmt          = TlpFmt()
}

case class CqUser(DW: Int = 512) extends Bundle { // pg213, p23 and p35
  val first_be:    Bits      = if (DW == 512) Bits(8 bits) else Bits(4 bits)
  val last_be:     Bits      = if (DW == 512) Bits(8 bits) else Bits(4 bits)
  val byte_en:     Bits      = if (DW == 512) Bits(64 bits) else Bits(32 bits)
  val is_sop:      Bits      = if (DW == 512) Bits(2 bits) else Bits(1 bits)
  val is_sop_ptr:  Vec[UInt] = (DW == 512) generate Vec.fill(2)(UInt(2 bits)) // FIXME: may cause err for vec reverse
  val is_eop:      Bits      = (DW == 512) generate Bits(2 bits)
  val is_eop_ptr:  Vec[UInt] = (DW == 512) generate Vec.fill(2)(UInt(4 bits))
  val discontinue: Bool      = Bool()
  val tph_present: Bits      = if (DW == 512) Bits(2 bits) else Bits(1 bits)
  val tph_type:    Bits      = if (DW == 512) Bits(4 bits) else Bits(2 bits)
  val tph_st_tag:  Bits      = if (DW == 512) Bits(16 bits) else Bits(8 bits)
  val parity:      Bits      = if (DW == 512) Bits(64 bits) else Bits(32 bits)
  val rsv:         Bits      = (DW < 512) generate Bits(3 bits)
}

object CqUser {
  def apply(b: Bits): CqUser = {
    val cq_user = CqUser()
    cq_user.assignFromBits(b)
    cq_user
  }
}

case class AxisCqDescriptor() extends Bundle { // 512 bits cq, Memory, I/O, and Atomic Operation
  val address_type    = Bits(2 bits)
  val address         = Bits(62 bits)
  val dword_count     = UInt(11 bits)
  val request_type    = Bits(4 bits)
  val rsv0            = Bits(1 bits)
  val requester_id    = UInt(16 bits) // Bus and Device/function
  val tag             = Bits(8 bits)
  val target_function = UInt(8 bits)
  val bar_id          = UInt(3 bits)
  val bar_aperture    = Bits(6 bits)
  val tc              = Bits(3 bits)
  val attr            = Bits(3 bits)
  val rsv1            = Bits(1 bits)

}

case class PcieUsConfig(axisPcieDataWidth: Int) {
  val rcUsrWidth: Int = if (axisPcieDataWidth < 512) 75 else 161
  val rqUsrWidth: Int = if (axisPcieDataWidth < 512) 60 else 137
  val cqUsrWidth: Int = if (axisPcieDataWidth < 512) 85 else 183
  val ccUsrWidth: Int = if (axisPcieDataWidth < 512) 33 else 81

  val tlpDataWidth:    Int = axisPcieDataWidth
  val tlpStrbWidth:    Int = tlpDataWidth / 32
  val tlpSegCount:     Int = 1
  val tlpSegDataWidth: Int = tlpDataWidth / tlpSegCount
  val rqSeqNumWidth:   Int = if (rqUsrWidth == 60) 4 else 6
  val txSeqNumWidth:   Int = rqSeqNumWidth - 1
  val txSeqNumCount:   Int = if (axisPcieDataWidth < 512) 1 else 2

  val intTlpSegCount:     Int = if (axisPcieDataWidth >= 512) 2 else 1 // cq_straddle default
  val intTlpSegDataWidth: Int = tlpDataWidth / intTlpSegCount
  val intTlpSegStrbWidth: Int = tlpStrbWidth / intTlpSegCount

  val rxReqTlpCfg:    TlpIfConfig = TlpIfConfig(tlpSegDataWidth, withErr = true)
  val rxCplTlpCfg:    TlpIfConfig = TlpIfConfig(tlpSegDataWidth, withErr = true)
  val txRdReqTlpCfg:  TlpIfConfig = TlpIfConfig()
  val txWrReqTlpCfg:  TlpIfConfig = TlpIfConfig(tlpSegDataWidth, txSeqNumWidth)
  val txCplTlpCfg:    TlpIfConfig = TlpIfConfig(tlpSegDataWidth)
  val txMsixWrReqTlp: TlpIfConfig = TlpIfConfig(32)

}

object PcieUsConfig {
  val ReqType = new SpinalEnum {
    val REQ_MEM_READ, REQ_MEM_WRITE, REQ_IO_READ, REQ_IO_WRITE, REQ_MEM_FETCH_ADD, REQ_MEM_SWAP, REQ_MEM_CAS, REQ_MEM_READ_LOCKED, REQ_CFG_READ_0,
        REQ_CFG_READ_1, REQ_CFG_WRITE_0, REQ_CFG_WRITE_1, REQ_MSG, REQ_MSG_VENDOR, REQ_MSG_ATS = newElement()
  }

  val TlpFmt = new SpinalEnum {
    val FM_3DW, FMT_4DW, FMT_3DW_DATA, FMT_4DW_DATA, FMT_PREFIX = newElement()
  }
}

case class pcie_us_if(pcieUsConfig: PcieUsConfig) extends Component {
  import pcieUsConfig._

  val io = new Bundle {
    val s_axis_rc         = slave Stream (Axi4StreamXilinx(axisPcieDataWidth, rcUsrWidth))
    val m_axis_rq         = slave Stream (Axi4StreamXilinx(axisPcieDataWidth, rqUsrWidth))
    val s_axis_cq         = slave Stream (Axi4StreamXilinx(axisPcieDataWidth, cqUsrWidth))
    val m_axis_cc         = master Stream (Axi4StreamXilinx(axisPcieDataWidth, rcUsrWidth))
    val s_axis_rq_seq_num = Vec.fill(2)(slave Flow (UInt(rqSeqNumWidth bits)))

    val rx_req_tlp               = Vec.fill(tlpSegCount)(master Stream (TlpIf(rxReqTlpCfg)))
    val rx_cpl_tlp               = Vec.fill(tlpSegCount)(master Stream (TlpIf(rxCplTlpCfg)))
    val tx_rd_req_tlp            = Vec.fill(tlpSegCount)(slave Stream (TlpIf(txRdReqTlpCfg)))
    val tx_wr_req_tlp            = Vec.fill(tlpSegCount)(slave Stream (TlpIf(txWrReqTlpCfg)))
    val m_axis_rd_req_tx_seq_num = Vec.fill(txSeqNumCount)(master Flow (UInt(txSeqNumWidth bits)))
    val m_axis_wr_req_tx_seq_num = Vec.fill(txSeqNumCount)(master Flow (UInt(txSeqNumWidth bits)))
    val tx_cpl_tlp               = Vec.fill(tlpSegCount)(slave Stream (TlpIf(txCplTlpCfg)))
    val tx_msix_wr_req_tlp       = slave Stream (TlpIf(txMsixWrReqTlp))
  }
}
