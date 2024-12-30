package PCIe

import spinal.core._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib.{Stream, master, slave}

import scala.language.postfixOps

case class pice_us_if_rq(pcieUsConfig: PcieUsConfig) extends Component {
  import pcieUsConfig._
  val io = new Bundle {
    val m_axis_rq         = master(Axi4Stream(rqAxisConfig))
    val s_axis_rq_seq_num = Vec.fill(2)(slave Flow (UInt(rqSeqNumWidth bits)))
    val tx_rd_req_tlp     = Vec.fill(tlpSegCount)(slave Stream (TLP(hdrWidth)))
    val tx_wr_req_tlp     = Vec.fill(tlpSegCount)(slave Stream (TLP(hdrWidth, tlpSegDataWidth, txSeqNumWidth)))

    val m_axis_rd_req_tx_seq_num = Vec.fill(txSeqNumCount)(master Flow (UInt(txSeqNumWidth bits)))
    val m_axis_wr_req_tx_seq_num = Vec.fill(txSeqNumCount)(master Flow (UInt(txSeqNumWidth bits)))

  }

  val rd_req_tlp_pops: Vec[Stream[TLP]] = Vec(io.tx_rd_req_tlp.map(_.queue(512)))
  val wr_req_tlp_pops: Vec[Stream[TLP]] = Vec(io.tx_wr_req_tlp.map(_.queue(512)))
}
