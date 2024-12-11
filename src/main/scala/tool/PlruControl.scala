package tool

import intel_ip.rdma_ctyun_sdpram
import spinal.core._
import spinal.lib.misc.Plru
import spinal.lib._
import rdma.rdma_vh._
import spinal.core.sim.SimConfig

import scala.collection.mutable
import scala.language.postfixOps
import scala.util.Random

case class Access(num: Int) extends Bundle {
  val id:          UInt = UInt(log2Up(num) bits)
  val hit_or_miss: Bool = Bool() // 1 for hit
}
case class PlruControl(cacheEntryNum: Int, with_rpl_blk: Boolean = false, aging_cycles: Int = -1) extends Area {
  val update:     Stream[Access] = Stream(Access(cacheEntryNum))
  val plru_entry: UInt           = UInt(log2Up(cacheEntryNum) bits)
  val rpl_end:    Flow[UInt]     = with_rpl_blk generate (Flow(UInt(log2Up(cacheEntryNum) bits)))

  val plru:  Plru      = Plru(cacheEntryNum, withEntriesValid = with_rpl_blk)
  val state: Vec[Bits] = Plru.State(cacheEntryNum)

  val with_aging: Boolean = aging_cycles > 0

  val aging_logic = with_aging generate new Area {
    val cnts:         Seq[Counter] = Seq.fill(cacheEntryNum)(Counter(0, aging_cycles))
    val valids:       Vec[Bool]    = Vec.fill(cacheEntryNum)(Bool() setAsReg () init (False))
    val filled:       Bits         = Bits(cacheEntryNum bits) setAsReg () init 0
    val entries_died: Bits         = Bits(cacheEntryNum bits)
    (0 until cacheEntryNum) foreach { i =>
      //filled
      filled(i) setWhen (update.fire & ~update.hit_or_miss & plru_entry === i)
      //cnt
      when(update.fire & Mux(update.hit_or_miss, update.id === i, plru_entry === i)) {
        cnts(i).clearAll()
      } elsewhen (!cnts(i).willOverflowIfInc & filled(i)) {
        cnts(i).increment()
      }
      // valids
      valids(i) clearWhen (cnts(i).willOverflowIfInc) setWhen (update.fire & ~update.hit_or_miss & plru_entry === i)
      // assert
      entries_died(i) := cnts(i).willOverflowIfInc & valids(i)
    }
    assert(~entries_died.orR, L"$REPORT_TIME, A cache line died: $entries_died", WARNING)
  }

  val rpl_blk_logic = with_rpl_blk generate new Area {
    val rpl_start: Flow[UInt] = Flow(UInt(log2Up(cacheEntryNum) bits))
    val blks_vec:  Vec[Bool]  = Vec.fill(cacheEntryNum)(RegInit(True))
    val no_more:   Bool       = ~plru.io.context.valids.orR
    plru.io.context.valids := blks_vec.asBits
    rpl_start.valid        := update.fire & ~update.hit_or_miss
    rpl_start.payload      := plru_entry
    // rpl_end to driver outside
    blks_vec.zipWithIndex.foreach { case (b, i) => b.clearWhen(rpl_start.valid && rpl_start.payload === i) setWhen (rpl_end.valid & rpl_end.payload === i) }

    //assert
    val rpl_same_err: Bool = (rpl_start.valid & rpl_end.valid) && (rpl_start.payload === rpl_end.payload)
    assert(~rpl_same_err, L"$REPORT_TIME, Replace the replacing cache line: ${rpl_start.payload}!!!", WARNING)
  }
  state.foreach { s =>
    s.setAsReg()
    s.init(0)
  }
  plru.io.context.state := state
  when(update.fire) {
    state := plru.io.update.state
  }
  plru_entry        := plru.io.evict.id
  plru.io.update.id := Mux(update.hit_or_miss, update.id, plru.io.evict.id)
  if (with_rpl_blk) {
    update.ready := Mux(update.hit_or_miss, True, ~rpl_blk_logic.no_more)
  } else {
    update.ready := True
  }
}

object PlruControl {
  def plruControlFactory: PlruControlFactory = PlruControlFactory()
  def apply(upt: Stream[Access], aging_cycles: CyclesCount): PlruControl = {
    val cl_num_bw = upt.id.getBitsWidth
    val plru_ctrl = PlruControl(1 << cl_num_bw, aging_cycles = aging_cycles.toInt)
    plru_ctrl.update.valid   := upt.valid
    plru_ctrl.update.payload := upt.payload
    upt.ready                := plru_ctrl.update.ready
    plru_ctrl
  }

  def apply(upt: Stream[Access], rpl_end: Flow[UInt], aging_cycles: CyclesCount): PlruControl = {
    val cl_num_bw = upt.id.getBitsWidth

    val plru_ctrl = PlruControl(1 << cl_num_bw, with_rpl_blk = true, aging_cycles = aging_cycles.toInt)
    plru_ctrl.update.valid   := upt.valid
    plru_ctrl.update.payload := upt.payload
    upt.ready                := plru_ctrl.update.ready
    plru_ctrl.rpl_end        := rpl_end
    plru_ctrl
  }
}

case class PlruControlFactory() {
  private var with_rpl_blk = false
  private var aging_cycles = -1
  private var cl_num       = -1
  private var rpl_end_op: Option[Flow[UInt]] = None
  private val plru_ctrl_buff = mutable.Queue[PlruControl]()

  private def build(): Unit = {
    val plru_ctrl = PlruControl(cl_num, with_rpl_blk, aging_cycles).setName("plru_ctrl")
    plru_ctrl_buff.enqueue(plru_ctrl)
  }

  def die_after(cyclesCount: CyclesCount): PlruControlFactory = {
    aging_cycles = cyclesCount.value.toInt
    this
  }

  def get_aging_valids: Vec[Bool] = plru_ctrl_buff.head.aging_logic.valids
  def get_plru_entry: UInt = plru_ctrl_buff.head.plru_entry

  def update_from(upt: Stream[Access]) = {
    val cl_num_bw = upt.payload.id.getBitsWidth
    cl_num = 1 << cl_num_bw
    build()
    plru_ctrl_buff.head.update.valid   := upt.valid
    plru_ctrl_buff.head.update.payload := upt.payload
    upt.ready                          := plru_ctrl_buff.head.update.ready
    rpl_end_op match {
      case Some(value) => plru_ctrl_buff.head.rpl_end := value
      case _           =>
    }
    this
  }

  def rpl_blk_release(rpl_end: Flow[UInt]): PlruControlFactory = {
    with_rpl_blk = true
    rpl_end_op   = Some(rpl_end)
    this
  }

}
