package hash

import spinal.core._
import spinal.lib._

import scala.language.postfixOps

/** 桶内表项：src 标记该 key 是通过 h0(src=0) 还是 h1(src=1) 放入当前桶的 */
case class CuckooHashEntry(keyWidth: Int) extends Bundle {
  val valid: Bool = Bool()
  val src:   Bool = Bool()
  val key:   Bits = Bits(keyWidth bits)
}

object CuckooHashState extends SpinalEnum {
  val IDLE, EVAL, READ, FINISH = newElement()
}

/** 统计输出。所有计数器在 reset 时清零，假设表/ stash 同时被清空。 */
case class CuckooHashStats(
    entryCntWidth: Int,
    stashUsedWidth: Int,
    kickBits: Int,
    maxKicks: Int,
    statWidth: Int = 32
) extends Bundle {
  val appendCnt:         UInt = UInt(statWidth bits)
  val appendBothFullCnt: UInt = UInt(statWidth bits)
  val appendSlowCnt:     UInt = UInt(statWidth bits)
  val appendUnavailCnt:  UInt = UInt(statWidth bits)
  val appendExistCnt:    UInt = UInt(statWidth bits)
  val queryCnt:          UInt = UInt(statWidth bits)
  val queryHitCnt:       UInt = UInt(statWidth bits)
  val deleteCnt:         UInt = UInt(statWidth bits)
  val deleteHitCnt:      UInt = UInt(statWidth bits)
  val stashHitCnt:       UInt = UInt(statWidth bits)
  val slowPlaceCnt:      UInt = UInt(statWidth bits)
  val slowStashCnt:      UInt = UInt(statWidth bits)
  val kickHist:          Vec[UInt] = Vec.fill(maxKicks + 1)(UInt(statWidth bits))
  val entryCnt:          UInt = UInt(entryCntWidth bits)
  val entryUsedMax:      UInt = UInt(entryCntWidth bits)
  val stashUsed:         UInt = UInt(stashUsedWidth bits)
  val stashUsedMax:      UInt = UInt(stashUsedWidth bits)
  val maxKick:           UInt = UInt(kickBits bits)
}

/**
 * 布谷鸟哈希表 v1（FPGA）
 *
 * 快路径：QUERY / DELETE / 有空位的 APPEND，2 拍延迟，1 次/拍
 * 慢路径：两个候选桶都满时，逐出 victim 并沿 cuckoo 链改投；失败项进 stash
 *
 * 失败策略：进入慢路径前先预检 stash 空位，满则直接返回 UNAVAILABLE 且不产生任何写；
 * 因此慢路径失败时只需把 pending 写进预留的 stash 位，不需要 undo log 回滚。
 */
case class CuckooHashTable(
    keyWidth: Int,
    hashValueWidth: Int,
    bucketDepth: Int,
    maxKicks: Int = 8,
    stashDepth: Int = 4,
    statWidth: Int = 32
) extends Component {

  require(bucketDepth >= 2, "bucketDepth must be >= 2")
  require((bucketDepth & (bucketDepth - 1)) == 0, "bucketDepth must be a power of 2")
  require(maxKicks >= 1, "maxKicks must be >= 1")
  require(stashDepth >= 1, "stashDepth must be >= 1")

  val entryWidth     = keyWidth + 2
  val bucketWidth    = entryWidth * bucketDepth
  val tableDepth     = 1 << hashValueWidth
  val capacity       = tableDepth * bucketDepth
  val wayBits        = log2Up(bucketDepth)
  val kickBits       = log2Up(maxKicks + 1)
  val entryCntWidth  = log2Up(capacity + 1)
  val stashUsedWidth = log2Up(stashDepth + 1)

  val io = new Bundle {
    val key:        Stream[HashAccess]   = slave Stream (HashAccess(keyWidth))
    val access_out: Stream[MultiHashOut] = master Stream (MultiHashOut(keyWidth))
    val stat:       CuckooHashStats      = out (CuckooHashStats(entryCntWidth, stashUsedWidth, kickBits, maxKicks, statWidth))
  }
  noIoPrefix()

  // ================================================================ hash
  val crcInit:  Bits = B(0xFF, hashValueWidth bits)
  val crcPoly0: Bits = B(0x9B, hashValueWidth bits)
  val crcPoly1: Bits = B(0x1D, hashValueWidth bits)

  // 慢路径复用流水线的两组 CRC：trigger 时算 victim，EVAL 时算下一跳 victim，其余时刻算输入 key
  val hashIn: Bits = Bits(keyWidth bits)
  val hash0:  Bits = Bits(hashValueWidth bits)
  val hash1:  Bits = Bits(hashValueWidth bits)
  val crc0: CRC = CRC(hashIn, crcPoly0, crcInit, hash0)
  val crc1: CRC = CRC(hashIn, crcPoly1, crcInit, hash1)

  // ================================================================ table
  val table: Mem[Bits] = Mem(Bits(bucketWidth bits), tableDepth)

  // ================================================================ lfsr
  // x^16 + x^14 + x^13 + x^11 + 1
  val lfsr: UInt = Reg(UInt(16 bits)) init 0xACE1
  val lfsrFeedback: Bool = lfsr(15) ^ lfsr(13) ^ lfsr(12) ^ lfsr(10)
  val lfsrShift: UInt = (lfsr << 1).resize(16)
  lfsr := lfsrShift | lfsrFeedback.asUInt.resize(16)

  val bucketSelBit: Bool = lfsr(0)
  val waySelRandom: UInt = lfsr(wayBits downto 1)

  // ================================================================ pipeline regs
  val v_d1:   Bool = RegInit(False)
  val key_d1: Bits = Reg(Bits(keyWidth bits)) init 0
  val op_d1:  SpinalEnumCraft[HashOperation.type] = Reg(HashOperation()) init HashOperation.QUERY
  val h0_d1:  Bits = Reg(Bits(hashValueWidth bits)) init 0
  val h1_d1:  Bits = Reg(Bits(hashValueWidth bits)) init 0

  // ================================================================ stash
  val stashValid: Bits = Reg(Bits(stashDepth bits)) init 0
  val stashKey:   Vec[Bits] = Vec.fill(stashDepth)(Reg(Bits(keyWidth bits)) init 0)

  val stashPlus:   Bits = (stashValid.asUInt + U(1)).asBits
  val stashFreeOH: Bits = (stashPlus ^ stashValid) & stashPlus
  val stashFree:   Bool = stashFreeOH.orR

  // ================================================================ slow path regs
  val state: SpinalEnumCraft[CuckooHashState.type] =
    Reg(CuckooHashState()) init CuckooHashState.IDLE
  val pendingKey: Bits = Reg(Bits(keyWidth bits)) init 0
  val pendingSrc: Bool = RegInit(False)
  val fsmAlt:     Bits = Reg(Bits(hashValueWidth bits)) init 0
  val kickCnt:    UInt = Reg(UInt(kickBits bits)) init 0
  val slowKey:    Bits = Reg(Bits(keyWidth bits)) init 0
  val slowOp:     SpinalEnumCraft[HashOperation.type] = Reg(HashOperation()) init HashOperation.QUERY
  val needStash:  Bool = RegInit(False)

  // ================================================================ write bus
  // 先声明写总线，供写前递寄存器使用；最后再驱动
  val wrEn:   Bool = Bool()
  val wrAddr: UInt = UInt(hashValueWidth bits)
  val wrData: Bits = Bits(bucketWidth bits)

  val wrEnD1:   Bool = RegNext(wrEn) init False
  val wrAddrD1: UInt = RegNext(wrAddr) init 0
  val wrDataD1: Bits = RegNext(wrData) init 0

  table.write(wrAddr, wrData, wrEn)

  // ================================================================ read ports
  val fsmRdEn:   Bool = Bool()
  val fsmRdAddr: UInt = UInt(hashValueWidth bits)

  val rdEn0:   Bool = io.key.fire || fsmRdEn
  val rdAddr0: UInt = Mux(fsmRdEn, fsmRdAddr, hash0.asUInt)
  val rdEn1:   Bool = io.key.fire
  val rdAddr1: UInt = hash1.asUInt

  val ramOut0: Bits = table.readSync(rdAddr0, rdEn0)
  val ramOut1: Bits = table.readSync(rdAddr1, rdEn1)

  // 写前递：上一拍发起的写还没落 RAM 时直接旁路，解决 back-to-back 同桶 RAW
  val bucket0Word: Bits = Mux(wrEnD1 && wrAddrD1 === h0_d1.asUInt, wrDataD1, ramOut0)
  val bucket1Word: Bits = Mux(wrEnD1 && wrAddrD1 === h1_d1.asUInt, wrDataD1, ramOut1)

  val entries0: Vec[CuckooHashEntry] = Vec.fill(bucketDepth)(CuckooHashEntry(keyWidth))
  val entries1: Vec[CuckooHashEntry] = Vec.fill(bucketDepth)(CuckooHashEntry(keyWidth))
  entries0.zip(bucket0Word.subdivideIn(entryWidth bits)).foreach { case (e, b) => e.assignFromBits(b) }
  entries1.zip(bucket1Word.subdivideIn(entryWidth bits)).foreach { case (e, b) => e.assignFromBits(b) }

  // 在 valid 位图里取最低的 0（=最低空闲 way）的 one-hot；全满时返回 0
  def freeOneHotOf(entries: Vec[CuckooHashEntry]): Bits = {
    val bitmap: Bits = Vec(entries.map(_.valid)).asBits
    val plus:   Bits = (bitmap.asUInt + U(1)).asBits
    (plus ^ bitmap) & plus
  }

  val freeOH0: Bits = freeOneHotOf(entries0)
  val freeOH1: Bits = freeOneHotOf(entries1)
  val free0:   Bool = freeOH0.orR
  val free1:   Bool = freeOH1.orR

  // ================================================================ fast path decision
  val hit0: Bool = Vec(entries0.map(e => e.valid && e.key === key_d1)).asBits.orR
  val hit1: Bool = Vec(entries1.map(e => e.valid && e.key === key_d1)).asBits.orR

  val stashHitMask: Bits = Bits(stashDepth bits)
  for (i <- 0 until stashDepth) {
    stashHitMask(i) := stashValid(i) && (stashKey(i) === key_d1)
  }
  val stashHit: Bool = stashHitMask.orR

  val exist: Bool = hit0 || hit1 || stashHit
  val append: Bool = op_d1 === HashOperation.APPEND
  val del:    Bool = op_d1 === HashOperation.DELETE

  val bothFull: Bool = !free0 && !free1
  val appendFull: Bool = append && !exist && bothFull
  // 慢路径触发条件：两桶全满且 stash 还有空位（stash 满则直接 UNAVAILABLE，不写任何东西）
  val slowTriggerCond: Bool = appendFull && stashFree

  val wrTo0: Bool = Mux(append, free0, hit0)
  val wrTo1: Bool = Mux(append, !free0 && free1, !hit0 && hit1)

  val doAppendWr: Bool = append && !exist && (free0 || free1)
  val doDeleteWr: Bool = del && (hit0 || hit1)
  val fastWrEn:   Bool = v_d1 && (doAppendWr || doDeleteWr)

  val wrEntries0: Vec[CuckooHashEntry] = Vec.fill(bucketDepth)(CuckooHashEntry(keyWidth))
  val wrEntries1: Vec[CuckooHashEntry] = Vec.fill(bucketDepth)(CuckooHashEntry(keyWidth))
  for (i <- 0 until bucketDepth) {
    wrEntries0(i) := entries0(i)
    wrEntries1(i) := entries1(i)

    when(v_d1 && wrTo0) {
      when(append && freeOH0(i)) {
        wrEntries0(i).valid := True
        wrEntries0(i).src   := False
        wrEntries0(i).key   := key_d1
      }
      when(del && entries0(i).valid && entries0(i).key === key_d1) {
        wrEntries0(i).valid := False
      }
    }

    when(v_d1 && wrTo1) {
      when(append && freeOH1(i)) {
        wrEntries1(i).valid := True
        wrEntries1(i).src   := True
        wrEntries1(i).key   := key_d1
      }
      when(del && entries1(i).valid && entries1(i).key === key_d1) {
        wrEntries1(i).valid := False
      }
    }
  }

  val fastWrAddr: UInt = Mux(wrTo0, h0_d1.asUInt, h1_d1.asUInt)
  val fastWrData: Bits = Mux(wrTo0, wrEntries0.asBits, wrEntries1.asBits)

  val fastStatus: SpinalEnumCraft[MultiHashOutputStatus.type] = MultiHashOutputStatus()
  switch(op_d1) {
    is(HashOperation.APPEND) {
      fastStatus := MultiHashOutputStatus.SUCCESS
      when(exist) {
        fastStatus := MultiHashOutputStatus.EXIST
      }
      when(appendFull) { // stash 满时才会真正返回 UNAVAILABLE；stash 未满则走慢路径，本状态不会输出
        fastStatus := MultiHashOutputStatus.UNAVAILABLE
      }
    }
    is(HashOperation.DELETE) {
      fastStatus := Mux(exist, MultiHashOutputStatus.SUCCESS, MultiHashOutputStatus.NON_EXIST)
    }
    default { // QUERY
      fastStatus := Mux(exist, MultiHashOutputStatus.SUCCESS, MultiHashOutputStatus.NON_EXIST)
    }
  }

  // ================================================================ slow path
  // 触发拍：从随机桶、随机 way 踢出 victim，新 key 直接填入空出的位置
  val slowBucketIsH0: Bool = (h0_d1 === h1_d1) || !bucketSelBit
  val slowBucket:     UInt = Mux(slowBucketIsH0, h0_d1.asUInt, h1_d1.asUInt)
  val slowNewSrc:     Bool = !slowBucketIsH0

  val chosenEntries: Vec[CuckooHashEntry] = Vec.fill(bucketDepth)(CuckooHashEntry(keyWidth))
  for (i <- 0 until bucketDepth) {
    chosenEntries(i).assignFromBits(Mux(slowBucketIsH0, entries0(i).asBits, entries1(i).asBits))
  }
  val chosenKeys = Vec(chosenEntries.map(_.key))
  val chosenSrcs = Vec(chosenEntries.map(e => e.src))
  val firstVictimKey: Bits = chosenKeys(waySelRandom)
  val firstVictimSrc: Bool = chosenSrcs(waySelRandom)

  val firstWrEntries: Vec[CuckooHashEntry] = Vec.fill(bucketDepth)(CuckooHashEntry(keyWidth))
  for (i <- 0 until bucketDepth) {
    firstWrEntries(i) := chosenEntries(i)
    when(waySelRandom === U(i)) {
      firstWrEntries(i).valid := True
      firstWrEntries(i).src   := slowNewSrc
      firstWrEntries(i).key   := key_d1
    }
  }

  // EVAL 拍读回的 alt 桶（慢路径的读写地址在时间上错开，不需要 forwarding，这里加上也无害）
  val altWord: Bits = Mux(wrEnD1 && wrAddrD1 === fsmAlt.asUInt, wrDataD1, ramOut0)
  val altEntries: Vec[CuckooHashEntry] = Vec.fill(bucketDepth)(CuckooHashEntry(keyWidth))
  altEntries.zip(altWord.subdivideIn(entryWidth bits)).foreach { case (e, b) => e.assignFromBits(b) }

  val altFreeOH: Bits = freeOneHotOf(altEntries)
  val altFree:   Bool = altFreeOH.orR

  val altKeys = Vec(altEntries.map(_.key))
  val altSrcs = Vec(altEntries.map(e => e.src))
  val evalVictimKey: Bits = altKeys(waySelRandom)
  val evalVictimSrc: Bool = altSrcs(waySelRandom)

  // 下一跳位置：victim 的另一个候选桶
  // 必须带 v_d1：否则慢路径 FINISH 回到 IDLE 后，S1 寄存器里的旧 APPEND 会再次触发慢路径
  val triggerNow: Bool = v_d1 && slowTriggerCond && (state === CuckooHashState.IDLE)
  val altSrc:   Bool = Mux(triggerNow, firstVictimSrc, evalVictimSrc)
  val altValue: Bits = Mux(altSrc, hash0, hash1) // src=0 表示当前在 h0，另一候选为 h1
  val firstAltValid: Bool = altValue.asUInt =/= slowBucket

  fsmRdEn   := (triggerNow && firstAltValid) || (state === CuckooHashState.READ)
  fsmRdAddr := Mux(triggerNow, altValue.asUInt, fsmAlt.asUInt)

  hashIn := Mux(triggerNow, firstVictimKey,
             Mux(state === CuckooHashState.EVAL, evalVictimKey, io.key.key))

  // EVAL 拍：优先填空位；否则踢掉随机 way，把 pending 放进去
  val evalWrEntries: Vec[CuckooHashEntry] = Vec.fill(bucketDepth)(CuckooHashEntry(keyWidth))
  val evalTarget:    Vec[Bool]            = Vec.fill(bucketDepth)(Bool())
  for (i <- 0 until bucketDepth) {
    evalWrEntries(i) := altEntries(i)
    when(altFree) {
      evalTarget(i) := altFreeOH(i)
    } otherwise {
      evalTarget(i) := waySelRandom === U(i)
    }
    when(evalTarget(i)) {
      evalWrEntries(i).valid := True
      evalWrEntries(i).src   := !pendingSrc
      evalWrEntries(i).key   := pendingKey
    }
  }

  val evalWrEn: Bool = (state === CuckooHashState.EVAL) && (altFree || kickCnt =/= U(maxKicks))
  val fsmWrEn:  Bool = triggerNow || evalWrEn
  val fsmWrAddr: UInt = Mux(triggerNow, slowBucket, fsmAlt.asUInt)
  val fsmWrData: Bits = Mux(triggerNow, firstWrEntries.asBits, evalWrEntries.asBits)

  switch(state) {
    is(CuckooHashState.IDLE) {
      when(triggerNow) {
        pendingKey := firstVictimKey
        pendingSrc := firstVictimSrc
        kickCnt    := 1
        slowKey    := key_d1
        slowOp     := op_d1
        when(firstAltValid) {
          needStash := False
          fsmAlt    := altValue
          state     := CuckooHashState.EVAL
        } otherwise {
          // victim 的两个哈希撞在同一桶，无法改投，直接进 stash
          needStash := True
          state     := CuckooHashState.FINISH
        }
      }
    }

    is(CuckooHashState.EVAL) {
      when(altFree) {
        needStash := False
        state     := CuckooHashState.FINISH
      } elsewhen (kickCnt === U(maxKicks)) {
        needStash := True
        state     := CuckooHashState.FINISH
      } otherwise {
        pendingKey := evalVictimKey
        pendingSrc := evalVictimSrc
        kickCnt    := kickCnt + 1
        when(altValue.asUInt === fsmAlt.asUInt) {
          needStash := True
          state     := CuckooHashState.FINISH
        } otherwise {
          needStash := False
          fsmAlt    := altValue
          state     := CuckooHashState.READ
        }
      }
    }

    is(CuckooHashState.READ) {
      state := CuckooHashState.EVAL
    }

    is(CuckooHashState.FINISH) {
      when(io.access_out.fire) {
        when(needStash) {
          for (i <- 0 until stashDepth) {
            when(stashFreeOH(i)) {
              stashValid(i) := True
              stashKey(i)   := pendingKey
            }
          }
        }
        state := CuckooHashState.IDLE
      }
    }
  }

  // ================================================================ write bus mux
  wrEn   := fastWrEn || fsmWrEn
  wrAddr := Mux(fsmWrEn, fsmWrAddr, fastWrAddr)
  wrData := Mux(fsmWrEn, fsmWrData, fastWrData)

  // ================================================================ flow control
  val fastRespValid: Bool = v_d1 && !triggerNow
  val slowRespValid: Bool = state === CuckooHashState.FINISH

  val s1Advance: Bool = v_d1 && (triggerNow || io.access_out.ready)
  val s0CanLoad: Bool = !v_d1 || s1Advance

  io.key.ready := (state === CuckooHashState.IDLE) && s0CanLoad && !triggerNow

  when(s0CanLoad) {
    key_d1 := io.key.key
    op_d1  := io.key.op
    h0_d1  := hash0
    h1_d1  := hash1
    v_d1   := io.key.fire
  }

  // 快路径响应直接由 S1 驱动；慢路径响应在 FINISH 态保持，直到下游接收
  io.access_out.valid := fastRespValid || slowRespValid
  when(slowRespValid) {
    io.access_out.key    := slowKey
    io.access_out.op     := slowOp
    io.access_out.status := MultiHashOutputStatus.SUCCESS
  } otherwise {
    io.access_out.key    := key_d1
    io.access_out.op     := op_d1
    io.access_out.status := fastStatus
  }

  // ================================================================ stash clear
  when(v_d1 && del && stashHit) {
    stashValid := stashValid & ~stashHitMask
  }

  // ================================================================ statistics
  // 计数在响应被下游接收（valid && ready）时更新，保证反压/慢路径下只计一次。
  val statAppendCnt:         UInt = Reg(UInt(statWidth bits)) init 0
  val statAppendBothFullCnt: UInt = Reg(UInt(statWidth bits)) init 0
  val statAppendSlowCnt:     UInt = Reg(UInt(statWidth bits)) init 0
  val statAppendUnavailCnt:  UInt = Reg(UInt(statWidth bits)) init 0
  val statAppendExistCnt:    UInt = Reg(UInt(statWidth bits)) init 0
  val statQueryCnt:          UInt = Reg(UInt(statWidth bits)) init 0
  val statQueryHitCnt:       UInt = Reg(UInt(statWidth bits)) init 0
  val statDeleteCnt:         UInt = Reg(UInt(statWidth bits)) init 0
  val statDeleteHitCnt:      UInt = Reg(UInt(statWidth bits)) init 0
  val statStashHitCnt:       UInt = Reg(UInt(statWidth bits)) init 0
  val statSlowPlaceCnt:      UInt = Reg(UInt(statWidth bits)) init 0
  val statSlowStashCnt:      UInt = Reg(UInt(statWidth bits)) init 0
  val statKickHist:          Vec[UInt] = Vec.fill(maxKicks + 1)(Reg(UInt(statWidth bits)) init 0)
  val statEntryCnt:          UInt = Reg(UInt(entryCntWidth bits)) init 0
  val statEntryUsedMax:      UInt = Reg(UInt(entryCntWidth bits)) init 0
  val statStashUsed:         UInt = Reg(UInt(stashUsedWidth bits)) init 0
  val statStashUsedMax:      UInt = Reg(UInt(stashUsedWidth bits)) init 0
  val statMaxKick:           UInt = Reg(UInt(kickBits bits)) init 0

  val statFastFire: Bool = fastRespValid && io.access_out.ready
  val statSlowFire: Bool = slowRespValid && io.access_out.ready

  val statFastAppend: Bool = statFastFire && (op_d1 === HashOperation.APPEND)
  val statFastQuery:  Bool = statFastFire && (op_d1 === HashOperation.QUERY)
  val statFastDelete: Bool = statFastFire && (op_d1 === HashOperation.DELETE)

  // 快路径成功插入：key 不存在且两桶没有全满（必有一个空位）
  val statFastAppendSuccess:   Bool = statFastAppend && !exist && !appendFull
  val statFastAppendExist:     Bool = statFastAppend && exist
  // 快路径返回 UNAVAILABLE：两桶全满且 stash 满（stash 未满会转慢路径）
  val statFastAppendUnavail:   Bool = statFastAppend && appendFull
  val statFastDeleteBucketHit: Bool = statFastDelete && (hit0 || hit1)

  def statInc(reg: UInt, cond: Bool): Unit = when(cond) { reg := reg + 1 }

  statInc(statAppendCnt,         statFastAppend || statSlowFire)
  statInc(statAppendBothFullCnt, statFastAppendUnavail || statSlowFire)
  statInc(statAppendSlowCnt,     statSlowFire)
  statInc(statAppendUnavailCnt,  statFastAppendUnavail)
  statInc(statAppendExistCnt,    statFastAppendExist)
  statInc(statQueryCnt,          statFastQuery)
  statInc(statQueryHitCnt,       statFastQuery && exist)
  statInc(statDeleteCnt,         statFastDelete)
  statInc(statDeleteHitCnt,      statFastDelete && exist)
  statInc(statStashHitCnt,       statFastFire && stashHit)
  statInc(statSlowPlaceCnt,      statSlowFire && !needStash)
  statInc(statSlowStashCnt,      statSlowFire && needStash)

  // 踢出次数分布：bin0 = 快路径成功插入；bin k = 慢路径成功且踢出 k 次
  for (k <- 0 to maxKicks) {
    if (k == 0) {
      when(statFastAppendSuccess) {
        statKickHist(k) := statKickHist(k) + 1
      }
    } else {
      when(statSlowFire && kickCnt === U(k)) {
        statKickHist(k) := statKickHist(k) + 1
      }
    }
  }
  when(statSlowFire && kickCnt > statMaxKick) {
    statMaxKick := kickCnt
  }

  // 表内有效 key 数（不含 stash）；慢路径只有最终放下了 pending 才 +1
  val statEntryNext: UInt = UInt(entryCntWidth bits)
  statEntryNext := statEntryCnt + (statFastAppendSuccess || (statSlowFire && !needStash)).asUInt - statFastDeleteBucketHit.asUInt
  when(statEntryNext > statEntryUsedMax) {
    statEntryUsedMax := statEntryNext
  }
  statEntryCnt := statEntryNext

  // stash 占用数；stash 写入发生在 FINISH fire，删除命中 stash 时 -1
  val statStashNext: UInt = UInt(stashUsedWidth bits)
  statStashNext := statStashUsed + (statSlowFire && needStash).asUInt - (statFastDelete && stashHit).asUInt
  when(statStashNext > statStashUsedMax) {
    statStashUsedMax := statStashNext
  }
  statStashUsed := statStashNext

  io.stat.appendCnt         := statAppendCnt
  io.stat.appendBothFullCnt := statAppendBothFullCnt
  io.stat.appendSlowCnt     := statAppendSlowCnt
  io.stat.appendUnavailCnt  := statAppendUnavailCnt
  io.stat.appendExistCnt    := statAppendExistCnt
  io.stat.queryCnt          := statQueryCnt
  io.stat.queryHitCnt       := statQueryHitCnt
  io.stat.deleteCnt         := statDeleteCnt
  io.stat.deleteHitCnt      := statDeleteHitCnt
  io.stat.stashHitCnt       := statStashHitCnt
  io.stat.slowPlaceCnt      := statSlowPlaceCnt
  io.stat.slowStashCnt      := statSlowStashCnt
  for (k <- 0 to maxKicks) {
    io.stat.kickHist(k) := statKickHist(k)
  }
  io.stat.entryCnt     := statEntryCnt
  io.stat.entryUsedMax := statEntryUsedMax
  io.stat.stashUsed    := statStashUsed
  io.stat.stashUsedMax := statStashUsedMax
  io.stat.maxKick      := statMaxKick
}

object CuckooHashTableRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(CuckooHashTable(64, 8, 4))
}
