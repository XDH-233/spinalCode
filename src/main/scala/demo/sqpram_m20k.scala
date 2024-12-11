package demo

import intel_ip.{SqpPort, ctyun_sqpram}
import spinal.core._

case class sqpram_m20k() extends Component {
  val awSegNum = 8
  val awStart  = 8
  val dwSegNum = 1
  val io = new Bundle {
    val sqp_ram_port: Vec[Vec[Bool]] =
      Vec.tabulate(awSegNum)(aw => Vec.tabulate(dwSegNum)(w => out(Bool().setName(s"w${(w + 1) * 8}_aw${aw + awStart}"))))
  }
  val sqp_ram_port: Vec[Vec[SqpPort]] =
    Vec.tabulate(awSegNum)(aw => Vec.tabulate(dwSegNum)(w => SqpPort((w + 1) * 8, aw + awStart).setName(s"w${(w + 1) * 8}_aw${aw + awStart}")))
  val rams: Array[Array[ctyun_sqpram]] =
    sqp_ram_port.map(p_vec => p_vec.map(p => ctyun_sqpram(p, 2).setName(s"ram_dw${p.dataWidth}_aw${p.addrWidth}")).toArray).toArray
  sqp_ram_port.foreach(p_vec => p_vec.foreach(p => p.clearAll()))
  io.sqp_ram_port.zip(sqp_ram_port).foreach { case (io_p_vec, p_vec) =>
    io_p_vec.zip(p_vec).foreach { case (io_p, p) =>
      io_p := (p.dout_a ## p.dout_b).orR
    }
  }
}

object sqpram_synth_m20k_rtl extends App {
  SpinalConfig(
    nameWhenByFile     = false,
    anonymSignalPrefix = "tmp"
  ).generateVerilog(sqpram_m20k())
}
