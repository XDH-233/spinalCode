import spinal.core._
import spinal.lib._

import scala.language.postfixOps

// 分治加法树 popcount: 两两计数后逐级合并, 每级数量减半、位宽加一
// N=32 例:
//   级0(配对)   级1       级2       级3       级4
//   2bit计数    3bit加    4bit加    5bit加    6bit加
//   16 个  ──► 8 个  ──► 4 个 ──► 2 个  ──► 1 个 = count_out
//   深度 = log2(N/2) + 1 = 5 级 (对比串行链的 15 级)
//
// 树状示意 (以 N=8 为例, N=32 结构相同只是每级节点数翻倍):
//
//   bits_in:  b0 b1   b2 b3   b4 b5   b6 b7
//              \ /      \ /      \ /      \ /
//   级0:      2bit     2bit     2bit     2bit     {a&b, a^b}, 16个(N=32)
//               \       /          \       /
//   级1:         3bit               3bit            +, 8个(N=32)
//                 \                /
//   级2:              4bit = count_out             +, N=32时到级4收敛
case class PopCountTree(inputNum: Int) extends Component {
  require(inputNum >= 1, "inputNum must be >= 1")

  val io = new Bundle {
    val bits_in = in Bits (inputNum bits)
    val count   = out UInt (log2Up(inputNum + 1) bits)
  }
  noIoPrefix()

  val inBools: Seq[Bool] = io.bits_in.asBools

  // 级0: 两两配对, {a&b, a^b} 得到 2bit 计数
  var nodes: Seq[UInt] = inBools.grouped(2).toSeq.map {
    case Seq(a, b) =>
      val cnt = UInt(2 bits)
      cnt(0) := a ^ b
      cnt(1) := a & b
      cnt
    case Seq(a) => a.asUInt(2 bits) // 奇数个输入时的落单元素
  }

  // 逐级合并: 数量减半, 位宽加一 (两个 k bit 计数之和必能被 k+1 bit 覆盖)
  while (nodes.length > 1) {
    nodes = nodes.grouped(2).toSeq.map {
      case Seq(a, b) => a +^ b
      case Seq(a)    => a.resize(a.getWidth + 1)
    }
  }

  io.count := nodes.head.resize(io.count.getWidth bits)
}

object PopCountTreeGen extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(PopCountTree(128))
}
