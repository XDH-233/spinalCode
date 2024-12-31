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
  val byte12_15_vary_with_type = Bits(32 bits) // DW3
  val bytes8_11_vary_with_type = Bits(32 bits) // DW2
  val first_dw_be              = Bits(4 bits) // DW1
  val last_dw_be               = Bits(4 bits)
  val bytes4_7_vary_with_type  = Bits(24 bits)
  val length                   = Bits(10 bits) // DW0 byte0
  val at                       = Bits(2 bits) // DW0 byte1
  val attr_l                   = Bits(2 bits)
  val ep                       = Bool()
  val td                       = Bool()
  val th                       = Bool() // DW0 byte2
  val rsv2                     = Bits(1 bits)
  val attr_h                   = Bits(1 bits)
  val rsv1                     = Bits(1 bits)
  val tc                       = Bits(3 bits)
  val rsv0                     = Bits(1 bits)
  val type_                    = Bits(5 bits) // DW0 byte3
  val fmt                      = TlpFmt()

}

case class RqUser() extends Bundle { //512
  val first_be    = Bits(8 bits)
  val last_be     = Bits(8 bits)
  val byte_en     = Bits(64 bits)
  val is_sop      = Bits(2 bits)
  val is_sop0_ptr = Bits(2 bits)
  val is_sop1_ptr = Bits(2 bits)
  val is_eop      = Bits(2 bits)
  val is_eop0_ptr = Bits(4 bits)
  val is_eop1_ptr = Bits(4 bits)
  val discontinue = Bool()
  val tph_present = Bits(2 bits)
  val tph_type    = Bits(4 bits)
  val tph_st_tag  = Bits(16 bits)
  val parity      = Bits(64 bits)
}

case class AxisCqTlpHeader() extends Bundle{
  val at = Bits(2 bits)
  val address = Bits( 62 bits)
  val length = Bits(11 bits)
  val fmt_type = Bits(4 bits)
  val rsv0 = Bool()
  val requester_id = UInt(16 bits)
  val tag = Bits(8 bits)
  val func_num = UInt(8 bits)
  val bar_id = UInt(3 bits) // 112
  val rsv1 = Bits(8 bits)
  val tc = Bits(3 bits) // 121
  val attr_l = Bits(2 bits) // 124
  val attr_h = Bits( 1 bits)

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

  val tlpDataWidth    = axisPcieDataWidth
  val hdrWidth        = 128
  val tlpSegCount     = 1
  val tlpSegDataWidth = tlpDataWidth / tlpSegCount
  val rqSeqNumWidth   = if (rqUsrWidth == 60) 4 else 6
  val txSeqNumWidth   = rqSeqNumWidth - 1
  val txSeqNumCount   = if (axisPcieDataWidth < 512) 1 else 2

  val intTlpSegCount     = if (axisPcieDataWidth >= 512) 2 else 1
  val intTlpSegDataWidth = tlpDataWidth / intTlpSegCount
}

object PcieUsConfig {
  val TxWrOpcode = new SpinalEnum {
    val REQ_MEM_READ, REQ_MEM_WRITE, REQ_IO_READ, REQ_IO_WRITE, REQ_MEM_FETCH_ADD, REQ_MEM_SWAP, REQ_MEM_CAS, REQ_MEM_READ_LOCKED, REQ_CFG_READ_0,
        REQ_CFG_READ_1, REQ_CFG_WRITE_0, REQ_CFG_WRITE_1, REQ_MSG, REQ_MSG_VENDOR, REQ_MSG_ATS = newElement()
  }
  val TlpFmt = new SpinalEnum {
    val FM_3DW, FMT_4DW, FMT_3DW_DATA, FMT_PREFIX = newElement()
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
  val cq_data_int_reg: Bits           = RegNextWhen(io.s_axis_cq.data, io.s_axis_cq.fire)
  val cq_data_full:    Bits           = cq_data ## cq_data_int_reg

  val paser_header = for (seg <- 0 until intTlpSegCount) yield new Area {
    val cq_data_fmt = TxWrOpcode()
    cq_data_fmt := cq_data_full(intTlpSegDataWidth * seg + 75, 4 bits)
    switch(cq_data_fmt) {
      is(TxWrOpcode.REQ_MEM_READ) {
        tlp_hdr(seg).fmt := TlpFmt.FMT_4DW
        tlp_hdr(seg).type_ := 0
      }
      is(TxWrOpcode.REQ_MEM_WRITE) {}
      is(TxWrOpcode.REQ_IO_READ) {}
      is(TxWrOpcode.REQ_IO_WRITE) {}
      is(TxWrOpcode.REQ_MEM_FETCH_ADD) {}
      is(TxWrOpcode.REQ_MEM_SWAP) {}
      is(TxWrOpcode.REQ_MEM_CAS) {}
      is(TxWrOpcode.REQ_MEM_READ_LOCKED) {}
      is(TxWrOpcode.REQ_CFG_READ_0) {}
      is(TxWrOpcode.REQ_CFG_READ_1) {}
      is(TxWrOpcode.REQ_CFG_WRITE_0) {}
      is(TxWrOpcode.REQ_CFG_WRITE_1) {}
      is(TxWrOpcode.REQ_MSG) {}
      is(TxWrOpcode.REQ_MSG_VENDOR) {}
      is(TxWrOpcode.REQ_MSG_ATS) {}

    }
  }

}
