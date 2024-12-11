import spinal.core._
import spinal.core.sim.{SimDataPimper, SimPublic}
import spinal.lib._

import scala.language.postfixOps
import scala.tools.nsc.doc.base.comment.Bold

case class PLRUUpdateRequest(entryNum: Int) extends Bundle {
  val plru_state:        Bits = Bits((entryNum - 1) bits) // LRU State entryNum row,entryNum col
  val plru_update_entry: UInt = UInt(log2Up(entryNum) bits)
}

case class PlruCtrl(entryNum: Int) extends Component {
  val treeDepth: Int = log2Up(entryNum)
  val io = new Bundle {
    val plru_state:         Bits              = in Bits ((entryNum - 1) bits) //PLRU状态,完全二叉树,root节点位于比特0
    val plru_entry:         UInt              = out UInt (log2Up(entryNum) bits) //最近最少被使用
    val plru_update_req:    PLRUUpdateRequest = in(PLRUUpdateRequest(entryNum))
    val plru_update_result: Bits              = out(Bits(entryNum - 1 bits))
  }
  noIoPrefix()

  val entrys_onehot_vec: Vec[Bool] = Bits(entryNum bits).asBools
  entrys_onehot_vec.zipWithIndex.foreach { case (b, entryIdx) =>
    b := (0 until treeDepth)
      .map { l =>
        val layer1stIdx = (1 << l) - 1
        val selIdx       = entryIdx / (entryNum / (1 << l)) + layer1stIdx
        val mod           = entryIdx % (entryNum / (1 << l))
        val left_or_not   = if (mod >= (entryNum / (1 << l)) / 2) io.plru_state(selIdx) else ~io.plru_state(selIdx)
        left_or_not
      }
      .reduceBalancedTree((l, r) => l & r)
  }
  val entrys_onehot: Bits = entrys_onehot_vec.asBits

  io.plru_entry := OHToUInt(entrys_onehot)

  val plru_update_entry_oh: Bits = UIntToOh(io.plru_update_req.plru_update_entry) //转换成独热码
  for (depthIndex <- 0 until treeDepth) {
    val currentDepthNodeNum = 1  << depthIndex
    val startNodeId         = (1 << depthIndex) - 1
    val leafNum             = entryNum / currentDepthNodeNum //当前层每个节点具备的叶子节点个数
    for (nodeIdOffset <- 0 until currentDepthNodeNum) {
      val nodeId           = nodeIdOffset + startNodeId
      val startLeafLeftId  = 0 + leafNum * nodeIdOffset
      val startLeafRightId = startLeafLeftId + leafNum / 2
      val leafNumHalf      = leafNum / 2
      when(plru_update_entry_oh(startLeafLeftId, leafNumHalf bits).orR) { //左子树更新
        io.plru_update_result(nodeId).set()
      } elsewhen (plru_update_entry_oh(startLeafRightId, leafNumHalf bits).orR) { //右子树更新
        io.plru_update_result(nodeId).clear()
      } otherwise {
        io.plru_update_result(nodeId) := io.plru_update_req.plru_state(nodeId)
      }
    }
  }
}

case class UpdateLRU(entryNum: Int) extends Component {
  val io = new Bundle {
    val update_en:    Bool = in Bool ()
    val hit_or_not:   Bool = in Bool ()
    val hit_entry_id: UInt = in UInt (log2Up(entryNum) bits)
    val lru_entry_id: UInt = out UInt (log2Up(entryNum) bits)
  }

  val node_state: Bits = Reg(Bits(entryNum - 1 bits)) init (0) simPublic ()

  val plru_control: PlruCtrl = PlruCtrl(entryNum)
  plru_control.io.plru_state                        := node_state
  plru_control.io.plru_update_req.plru_update_entry := Mux(io.hit_or_not, io.hit_entry_id, plru_control.io.plru_entry)
  plru_control.io.plru_update_req.plru_state        := node_state
  io.lru_entry_id                                   := plru_control.io.plru_entry
  when(io.update_en) {
    node_state := plru_control.io.plru_update_result
  }
}

import spinal.core.sim._
import spinal.lib.tools.BigIntToListBoolean

object UpdateLRUSim extends App {
  SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
    defaultClockDomainFrequency  = FixedFrequency(100 MHz),
    nameWhenByFile               = false,
    anonymSignalPrefix           = "tmp"
  ).generateVerilog(UpdateLRU(8).setDefinitionName("plru_update_256"))

  SimConfig.withWave
    .withConfig(
      SpinalConfig(
        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
        defaultClockDomainFrequency  = FixedFrequency(100 MHz),
        nameWhenByFile               = false,
        anonymSignalPrefix           = "tmp"
      )
    )
    .compile(UpdateLRU(8))
    .doSim { dut =>
      import dut._
      var lruState = BigInt(0)
      def showLruState(): Unit = {
        val lru_state_boolean = BigIntToListBoolean(lruState, dut.entryNum - 1 bits)
        println("--------------------lru state-----------------------")
        for (depth <- 0 until dut.plru_control.treeDepth) {
          val startId  = (1 << depth) - 1
          val entryNum = 1  << depth
          println(s"${lru_state_boolean.slice(startId, startId + entryNum).map(_.toInt)}")
        }
      }

      dut.clockDomain.forkStimulus(10)
      io.update_en    #= false
      io.hit_or_not   #= false
      io.hit_entry_id #= 0
      clockDomain.waitSampling()
      io.update_en #= true
      (0 until 10).foreach { _ =>
        io.hit_entry_id.randomize()
        io.hit_or_not.randomize()
        clockDomain.waitSampling()
        lruState = dut.node_state.toBigInt
        showLruState()
        if (io.hit_or_not.toBoolean) {
          println("Hit entry: " + io.hit_entry_id.toBigInt)
        } else {
          println("Miss! update lru entry: " + io.lru_entry_id.toBigInt)
        }

      }
      io.update_en #= false
      clockDomain.waitSampling(10)
    }
}
