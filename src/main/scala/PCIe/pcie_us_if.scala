package PCIe

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axis.{Axi4Stream, Axi4StreamConfig}

import scala.language.postfixOps

case class TLP(hdrWidth: Int, dataWidth: Int = -1, seqNumWidth: Int = -1, withBar: Boolean = false, withErr: Boolean = false) extends Bundle {

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
}

object PcieUsConfig {
  val TxWrOpcode = new SpinalEnum {
    val REQ_MEM_READ, REQ_MEM_READ_LOCKED, REQ_MEM_WRITE, REQ_IO_READ, REQ_IO_WRITE, REQ_CFG_READ_0, REQ_CFG_WRITE_0, REQ_CFG_READ_1, REQ_CFG_WRITE_1,
        REQ_MEM_FETCH_ADD, REQ_MEM_SWAP, REQ_MEM_CAS = newElement()
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

    val rx_req_tlp               = Vec.fill(tlpSegCount)(master Stream (TLP(hdrWidth, tlpSegDataWidth, withBar = true)))
    val rx_cpl_tlp               = Vec.fill(tlpSegCount)(master Stream (TLP(hdrWidth, tlpSegDataWidth, withErr = true)))
    val tx_rd_req_tlp            = Vec.fill(tlpSegCount)(slave Stream (TLP(hdrWidth)))
    val tx_wr_req_tlp            = Vec.fill(tlpSegCount)(slave Stream (TLP(hdrWidth, tlpSegDataWidth, txSeqNumWidth)))
    val m_axis_rd_req_tx_seq_num = Vec.fill(txSeqNumCount)(master Flow (UInt(txSeqNumWidth bits)))
    val m_axis_wr_req_tx_seq_num = Vec.fill(txSeqNumCount)(master Flow (UInt(txSeqNumWidth bits)))
    val tx_cpl_tlp               = Vec.fill(tlpSegCount)(slave Stream (TLP(hdrWidth, tlpSegDataWidth)))
    val tx_msix_wr_req_tlp       = slave Stream (TLP(32, hdrWidth))
  }
}

