package PCIe

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axis.{Axi4Stream, Axi4StreamConfig}

import scala.language.postfixOps

case class TlpIf(hdrWidth: Int, dataWidth: Int = -1, seqNumWidth: Int = -1, withBar: Boolean = false, withErr: Boolean = false) extends Bundle {

  val data     = dataWidth > 0 generate Bits(dataWidth bits)
  val strb     = dataWidth > 0 generate Bits((dataWidth + 32) / 32 bits)
  val hdr      = Bits(hdrWidth bits)
  val bar_id   = withBar generate UInt(3 bits)
  val func_num = withBar generate UInt(8 bits)
  val error    = withErr generate Bool()
  val seq      = seqNumWidth > 0 generate UInt(seqNumWidth bits)
  val sop      = Bool()
  val eop      = Bool()
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

case class CqUser() extends Bundle { //512
  val first_be    = Bits(8 bits)
  val last_be     = Bits(8 bits)
  val byte_en     = Bits(64 bits)
  val is_sop      = Bits(2 bits)
  val is_sop_ptr  = Vec.fill(2)(Bits(2 bits)) // FIXME: may cause err for vec reverse
  val is_eop      = Bits(2 bits)
  val is_eop_ptr  = Vec.fill(2)(Bits(2 bits))
  val discontinue = Bool()
  val tph_present = Bits(2 bits)
  val tph_type    = Bits(4 bits)
  val tph_st_tag  = Bits(16 bits)
  val parity      = Bits(64 bits)
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

  val rcAxisConfig: Axi4StreamConfig = Axi4StreamConfig(dataWidth = axisPcieDataWidth, useLast = true, useUser = true, userWidth = rcUsrWidth)
  val rqAxisConfig: Axi4StreamConfig = Axi4StreamConfig(dataWidth = axisPcieDataWidth, useLast = true, useUser = true, userWidth = rqUsrWidth)
  val cqAxisConfig: Axi4StreamConfig = Axi4StreamConfig(dataWidth = axisPcieDataWidth, useLast = true, useUser = true, userWidth = cqUsrWidth)
  val ccAxisConfig: Axi4StreamConfig = Axi4StreamConfig(dataWidth = axisPcieDataWidth, useLast = true, useUser = true, userWidth = ccUsrWidth)

  val tlpDataWidth: Int = axisPcieDataWidth
  val tlpStrbWidth: Int = tlpDataWidth / 32
  val hdrWidth    = 128
  val tlpSegCount = 1
  val tlpSegDataWidth: Int = tlpDataWidth / tlpSegCount
  val rqSeqNumWidth:   Int = if (rqUsrWidth == 60) 4 else 6
  val txSeqNumWidth:   Int = rqSeqNumWidth - 1
  val txSeqNumCount:   Int = if (axisPcieDataWidth < 512) 1 else 2

  val intTlpSegCount:     Int = if (axisPcieDataWidth >= 512) 2 else 1 // cq_straddle default
  val intTlpSegDataWidth: Int = tlpDataWidth / intTlpSegCount
  val intTlpSegStrbWidth: Int = tlpStrbWidth / intTlpSegCount
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
    val s_axis_rc         = slave(Axi4Stream(rcAxisConfig))
    val m_axis_rq         = master(Axi4Stream(rqAxisConfig))
    val s_axis_cq         = slave(Axi4Stream(cqAxisConfig))
    val m_axis_cc         = master(Axi4Stream(ccAxisConfig))
    val s_axis_rq_seq_num = Vec.fill(2)(slave Flow (UInt(rqSeqNumWidth bits)))

    val rx_req_tlp               = Vec.fill(tlpSegCount)(master Stream (TlpIf(hdrWidth, tlpSegDataWidth, withBar = true)))
    val rx_cpl_tlp               = Vec.fill(tlpSegCount)(master Stream (TlpIf(hdrWidth, tlpSegDataWidth, withErr = true)))
    val tx_rd_req_tlp            = Vec.fill(tlpSegCount)(slave Stream (TlpIf(hdrWidth)))
    val tx_wr_req_tlp            = Vec.fill(tlpSegCount)(slave Stream (TlpIf(hdrWidth, tlpSegDataWidth, txSeqNumWidth)))
    val m_axis_rd_req_tx_seq_num = Vec.fill(txSeqNumCount)(master Flow (UInt(txSeqNumWidth bits)))
    val m_axis_wr_req_tx_seq_num = Vec.fill(txSeqNumCount)(master Flow (UInt(txSeqNumWidth bits)))
    val tx_cpl_tlp               = Vec.fill(tlpSegCount)(slave Stream (TlpIf(hdrWidth, tlpSegDataWidth)))
    val tx_msix_wr_req_tlp       = slave Stream (TlpIf(32, hdrWidth))
  }
}

case class pcie_us_if_cq(pcieUsConfig: PcieUsConfig) extends Component {
  import PcieUsConfig._
  import pcieUsConfig._
  val io = new Bundle {
    val s_axis_cq  = slave(Axi4Stream(cqAxisConfig))
    val rx_req_tlp = Vec.fill(tlpSegCount)(master Stream (TlpIf(hdrWidth, tlpSegDataWidth, withBar = true)))

  }

  val tlp_hdr:         Vec[TlpHeader] = Vec.fill(intTlpSegCount)(TlpHeader())
  val tlp_bar_id:      Vec[UInt]      = Vec.fill(intTlpSegCount)(UInt(3 bits))
  val tlp_func_num:    Vec[UInt]      = Vec.fill(intTlpSegCount)(UInt(8 bits))
  val cq_data:         Bits           = io.s_axis_cq.data
  val axis_cq_users:   Vec[CqUser]    = Vec.fill(intTlpSegCount)(CqUser())
  val cq_data_int_reg: Bits           = RegNextWhen(io.s_axis_cq.data, io.s_axis_cq.fire)
  val cq_data_full:    Bits           = cq_data ## cq_data_int_reg
  val cq_strb:         Bits           = Bits(tlpStrbWidth bits)
  val cq_strb_reg:     Bits           = RegNextWhen(cq_strb, io.s_axis_cq.fire)
  val cq_strb_full:    Bits           = cq_strb ## cq_strb_reg
  val valid:           Bool           = Bool()
  val cq_strb_sop:     Bits           = Bits(tlpStrbWidth bits)

  val rx_req_tlp_data: Vec[Bits] = Vec.fill(tlpSegCount)(Bits(intTlpSegDataWidth bits))
  val rx_req_tlp_strb: Vec[Bits] = Vec.fill(tlpSegCount)(Bits(intTlpSegStrbWidth bits))

  if (axisPcieDataWidth >= 512) { // and cq_straddle
    val sop_proc_512 = for (seg <- 0 until intTlpSegCount) yield new Area {
      when(axis_cq_users.head.is_sop(seg)) {}
    }

  } else {}

  val paser_header = for (seg <- 0 until intTlpSegCount) yield new Area {
    val cq_data_fmt        = ReqType()
    val axis_cq_tlp_desctr = AxisCqDescriptor()
    cq_data_fmt.assignFromBits(cq_data_full(intTlpSegDataWidth * seg + 75, 4 bits))
    axis_cq_tlp_desctr.assignFromBits(cq_data_full(intTlpSegDataWidth * seg, 7 bits))
    switch(cq_data_fmt) {
      is(ReqType.REQ_MEM_READ) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW
        tlp_hdr(seg).type_ := 0
      }
      is(ReqType.REQ_MEM_WRITE) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW_DATA
        tlp_hdr(seg).type_ := 0
      }
      is(ReqType.REQ_IO_READ) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW
        tlp_hdr(seg).type_ := 2
      }
      is(ReqType.REQ_IO_WRITE) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW_DATA
        tlp_hdr(seg).type_ := 2
      }
      is(ReqType.REQ_MEM_FETCH_ADD) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW
        tlp_hdr(seg).type_ := 12
      }
      is(ReqType.REQ_MEM_SWAP) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW_DATA
        tlp_hdr(seg).type_ := 13
      }
      is(ReqType.REQ_MEM_CAS) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW_DATA
        tlp_hdr(seg).type_ := 14
      }
      is(ReqType.REQ_MEM_READ_LOCKED) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW
        tlp_hdr(seg).type_ := 1
      }
      is(ReqType.REQ_MSG) {
        when(axis_cq_tlp_desctr.dword_count.orR) {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW_DATA
        } otherwise {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW
        }
        tlp_hdr(seg).type_ := B(2, 2 bits) ## axis_cq_tlp_desctr.bar_id.asBits
      }
      is(ReqType.REQ_MSG_VENDOR) {
        when(axis_cq_tlp_desctr.dword_count.orR) {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW_DATA
        } otherwise {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW
        }
        tlp_hdr(seg).type_ := B(2, 2 bits) ## axis_cq_tlp_desctr.bar_id.asBits
      }
      is(ReqType.REQ_MSG_ATS) {
        when(axis_cq_tlp_desctr.dword_count.orR) {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW_DATA
        } otherwise {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW
        }
        tlp_hdr(seg).type_ := B(2, 2 bits) ## axis_cq_tlp_desctr.bar_id.asBits
      }
      default {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW
        tlp_hdr(seg).type_ := 0
      }
    }
    tlp_hdr(seg).rsv0        := 0
    tlp_hdr(seg).tc          := axis_cq_tlp_desctr.tc
    tlp_hdr(seg).rsv1        := 0
    tlp_hdr(seg).attr_h      := axis_cq_tlp_desctr.attr(3).asBits
    tlp_hdr(seg).rsv2        := 0
    tlp_hdr(seg).th          := 0
    tlp_hdr(seg).td          := 0
    tlp_hdr(seg).ep          := 0
    tlp_hdr(seg).attr_l      := axis_cq_tlp_desctr.attr(1 downto 0)
    tlp_hdr(seg).at          := axis_cq_tlp_desctr.address_type
    tlp_hdr(seg).length      := axis_cq_tlp_desctr.dword_count
    tlp_hdr(seg).last_dw_be  := axis_cq_users(seg).first_be(7 downto 4)
    tlp_hdr(seg).first_dw_be := axis_cq_users(seg).first_be(4 downto 0)
    tlp_hdr(seg).address     := axis_cq_tlp_desctr.address
    tlp_hdr(seg).ph          := 0

    tlp_bar_id(seg)   := axis_cq_tlp_desctr.bar_id
    tlp_func_num(seg) := axis_cq_tlp_desctr.target_function
  }

  axis_cq_users(0).assignFromBits(io.s_axis_cq.user)
  axis_cq_users(1).assignFromBits(RegNextWhen(io.s_axis_cq.user, io.s_axis_cq.fire))

  if (tlpDataWidth == 64) {} else {
    val greater_64 = for (seg <- 0 until intTlpSegCount) yield new Area {
      rx_req_tlp_data(seg) := cq_data_full >> (128 + seg * intTlpSegDataWidth)
      when(axis_cq_users(0).is_sop(seg)){
        
      }
      // rx_req_tlp_strb(seg) := 
    }
  }

}
