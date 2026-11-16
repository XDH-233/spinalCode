import spinal.core._
import spinal.lib._

import scala.language.postfixOps

/**
 * radix-4 tree id manager, 用来替代整条 bitmap 扫描式的 id 管理。
 *
 * 叶层是 id_num bit 的空闲位图（1 = 空闲），上层每个节点是 4bit 组，
 * 每一位是其子节点"是否存在空闲"的标志位（即 subtree free flag）：
 *  - alloc : 组合逻辑从根到叶逐层取最低空闲位(OHMasking.first)拼出当前最低空闲 id；
 *            握手成功后叶层清 1bit，上层仅在子节点变空时才清父层标志位；
 *  - recycle: 叶层置回 1bit，上层仅在子节点原本为满(标志位为 0)时置父层标志位。
 *
 * 相比整条 bitmap：优先译码逻辑深度 O(log4(id_num))，寄存器约 (4/3)*id_num bit。
 *
 * 协议假设：recycle 的 id 必须是已分配且未重复回收的 id。
 * 同一周期对同一 id 同时 alloc+recycle 时 alloc 优先（该 id 视为被分配走）。
 */
case class RadixIdTree(id_num: Int) extends Component {
  require(isPow2(id_num) && id_num >= 2, s"id_num must be pow of 2 and >= 2, got $id_num")

  val io = new Bundle {
    /** 当前可用 id（最低空闲 id 优先），握手成功即分配弹出 */
    val avail_id:   Stream[UInt] = master Stream (UInt(log2Up(id_num) bits))
    /** 回收 id */
    val recycle_id: Stream[UInt] = slave Stream (UInt(log2Up(id_num) bits))
    /** 当前空闲 id 总数（组合输出，流控/调试用） */
    val avail_cnt:  UInt         = out UInt (log2Up(id_num + 1) bits)
  }

  noIoPrefix()

  val idWidth:    Int = log2Up(id_num)
  val levelNum:   Int = (idWidth + 1) / 2 // radix-4 层数
  val idPadWidth: Int = 2 * levelNum      // id 补齐到每层 2bit（idWidth 为奇数时最高位恒 0）

  // 每层节点(4bit 组)位宽：仅 id_num==2 时根节点即叶子，只有 2bit
  def nodeW(l: Int): Int     = if (levelNum == 1) scala.math.min(4, id_num) else 4
  // 第 l 层总 bit 数 = min(4^(l+1), id_num)，容量超出 id_num 的位恒为 0，永不分配
  def levelBits(l: Int): Int = scala.math.min(1 << (2 * (l + 1)), id_num)
  // 第 l 层有效位数（覆盖 id < id_num 的位）
  def validBits(l: Int): Int = id_num >> (2 * (levelNum - 1 - l))

  // 每层空闲位图：1 = 对应 id/子树空闲，复位有效位全 1 = 全部空闲（无效位恒 0）
  val tree: Array[Bits] =
    (0 until levelNum).map(l => Bits(levelBits(l) bits) setAsReg () init (BigInt(2).pow(validBits(l)) - 1)).toArray

  val recId: UInt = io.recycle_id.payload.resize(idPadWidth)

  val doAlloc = io.avail_id.fire
  val doRecyc = io.recycle_id.fire

  // ---------------- 组合读出：alloc 从根到叶译码 / recycle 按 id 分段 ----------------
  val allocNode: Array[Bits] = Array.tabulate(levelNum)(l => Bits(nodeW(l) bits)) // alloc 路径每层命中的节点
  val allocOh:   Array[Bits] = Array.tabulate(levelNum)(l => Bits(nodeW(l) bits)) // 节点内选中的 one-hot
  val allocBase: Array[UInt] = Array.tabulate(levelNum)(l => UInt(idWidth bits))  // 节点在本层位图中的 bit 基址
  val recOh:     Array[Bits] = Array.tabulate(levelNum)(l => Bits(nodeW(l) bits)) // recycle 在节点内的 one-hot
  val recBase:   Array[UInt] = Array.tabulate(levelNum)(l => UInt(idWidth bits))

  {
    var acc = U(0, idPadWidth bits) // 从根到叶逐层拼出 2*levelNum bit 的补齐 id
    for (l <- 0 until levelNum) {
      val w    = nodeW(l)
      val base = if (l == 0) U(0, idWidth bits) else (acc(2 * l - 1 downto 0) << 2).resized
      val node = (tree(l) >> base).resize(w)
      val oh   = OHMasking.first(node)
      allocBase(l) := base
      allocNode(l) := node
      allocOh(l)   := oh
      acc          = (acc |<< log2Up(w)) | OHToUInt(oh).resized
    }
    io.avail_id.payload := acc.resize(idWidth)
  }

  {
    // 组位段从低位端累计：grp(l) 占 recId[bot(l)+gw-1 : bot(l)]，
    // bot(l) = 更高各层组宽之和。id_num==2 时根层组只有 1bit，若按 2*(L-l) 对齐
    // 会取到 resize 补零的高位（回归已抓到该 bug）
    var bot = 0
    for (l <- (0 until levelNum).reverse) {
      val w  = nodeW(l)
      val gw = log2Up(w)
      val grp  = recId(bot + gw - 1 downto bot) // 本层对应的 id 位段
      val base = if (l == 0) U(0, idWidth bits) else (recId(idPadWidth - 1 downto bot + gw) << 2).resized
      recBase(l) := base
      recOh(l)   := (B(1, w bits) << grp).resize(w)
      bot += gw
    }
  }

  // ---------------- 每层写掩码：叶层直接清/置，上层维护子树空闲标志 ----------------
  // aClear(l): alloc 后第 l 层选中节点变空 -> 需要清第 l-1 层的父标志位（叶层恒清）
  val aClear: Array[Bool] = Array.fill(levelNum)(Bool())
  aClear(levelNum - 1) := True // 叶层选中的 id bit 握手后必被清

  val allocClr: Array[Bits] = Array.tabulate(levelNum)(l => Bits(levelBits(l) bits))
  val recySet:  Array[Bits] = Array.tabulate(levelNum)(l => Bits(levelBits(l) bits))

  // 自底向上：第 l 层节点写完后是否为空，取决于其子节点(l+1)的实际写入结果
  for (l <- (0 until levelNum - 1).reverse) {
    val cw        = nodeW(l + 1)
    val sameChild = allocBase(l + 1) === recBase(l + 1)
    val childAfter = (allocNode(l + 1) & ~(aClear(l + 1) ? allocOh(l + 1) | B(0, cw bits))) |
      Mux(doRecyc & sameChild, recOh(l + 1), B(0, cw bits))
    aClear(l) := !childAfter.orR
  }

  for (l <- 0 until levelNum) {
    val flatOhA = (allocOh(l) << allocBase(l)).resize(levelBits(l))
    val flatOhR = (recOh(l) << recBase(l)).resize(levelBits(l))
    if (l == levelNum - 1) {
      allocClr(l) := doAlloc ? flatOhA | B(0)
      recySet(l)  := doRecyc ? flatOhR | B(0)
    } else {
      // recycle 时子节点原本为满（无任何空闲位）
      val childREmpty = !((tree(l + 1) >> recBase(l + 1)).resize(nodeW(l + 1))).orR
      allocClr(l) := (doAlloc & aClear(l)) ? flatOhA | B(0)
      recySet(l)  := (doRecyc & childREmpty) ? flatOhR | B(0)
    }
  }

  io.avail_id.valid   := tree(0).orR
  io.recycle_id.ready := True // 无反压：回收永远当拍接受
  io.avail_cnt        := CountOne(tree(levelNum - 1))

  // 同周期 alloc+recycle 同一 id 时 alloc 后写优先
  when(doRecyc) {
    (0 until levelNum).foreach(l => tree(l) := tree(l) | recySet(l))
  }
  when(doAlloc) {
    (0 until levelNum).foreach(l => tree(l) := tree(l) & ~allocClr(l))
  }
}

object RadixIdTreeRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(RadixIdTree(256))
}
