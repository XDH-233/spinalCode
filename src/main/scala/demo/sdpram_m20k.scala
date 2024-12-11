package demo

import intel_ip.{SdpPort, rdma_ctyun_sdpram}
import spinal.core.{Bool, Bundle, Component, log2Up, out}

case class sdpram_m20k(width: Int, depth: Int) extends Component {
  val io = new Bundle {
    val dout: Bool = out Bool ()
  }
  val ram_port: SdpPort = SdpPort(width, log2Up(depth)).setName("")
  io.dout := ram_port.dout.orR
  ram_port.clearAll()
  ram_port.allowOverride()

  val sdpram: rdma_ctyun_sdpram = intel_ip.rdma_ctyun_sdpram(width, log2Up(depth))
  sdpram.io.ram_port <> ram_port
}
