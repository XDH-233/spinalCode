package tool

import org.slf4j.{Logger, LoggerFactory}
import spinal.core._
import spinal.lib._
import spinal.lib.bus.avalon._

import scala.language.postfixOps

case class AvstExpand(avst: AvalonST, cnt: Int = 2) extends ImplicitArea[AvalonST] {
  val retWidth: Int = avst.config.dataWidth * cnt
  val retConfig: AvalonSTConfig = AvalonSTConfig(
    useChannels  = avst.config.useChannels,
    channelWidth = avst.config.channelWidth,
    useData      = true,
    dataWidth    = retWidth,
    useSOP       = true,
    useEOP       = true,
    useEmpty     = true,
    emptyWidth   = log2Up(retWidth / 8)
  )
  val ret = AvalonST(retConfig)

  val step: Counter = Counter(0, cnt - 1)

  val data_regs: Vec[Bits] = Vec(Bits(avst.config.dataWidth bits) setAsReg (), cnt - 1)
  val bytes_num: UInt      = (step +^ 1) * avst.config.dataWidth +^ (avst.payload.empty << 3)

  val overflow: Bool = bytes_num >= retWidth
  val sop_reg:  Bool = RegInit(False)
  val ret_data: Bits = avst.payload.data ## data_regs.asBits

  when(avst.fire) {
    data_regs.last := avst.payload.data
    data_regs.init.zip(data_regs.tail).foreach { case (i, t) => i := t }
  }

  when(avst.fire) {
    when(overflow) {
      sop_reg.clear()
    } elsewhen (avst.payload.sop) {
      sop_reg.set()
    }
  }

  when(avst.fire) {
    when(overflow || avst.payload.eop) {
      step.clear()
    } otherwise ({
      step.increment()
    })
  }

  ret.valid         := avst.valid & (overflow | avst.payload.eop)
  ret.payload.sop   := avst.payload.sop | sop_reg
  ret.payload.eop   := avst.payload.eop
  ret.payload.empty := (((U(cnt - 1) - step) * (avst.config.dataWidth / 8)) +^ avst.payload.empty).resize(retConfig.emptyWidth)
  switch(step.value) {
    for (s <- (0 until cnt)) {
      is(s) {
        ret.payload.data := ret_data |>> ((cnt - 1 - s) * avst.config.dataWidth)
      }
    }
  }
  if (avst.config.useChannels) {
    ret.payload.channel := avst.payload.channel
  }
  avst.ready := Mux(overflow | avst.payload.eop, ret.ready, True)
  override def implicitValue: AvalonST = ret
}

case class AvstDivide(avst: AvalonST, cnt: Int = 2) extends ImplicitArea[AvalonST] {
  val retWidth: Int = avst.config.dataWidth / cnt
  val retConfig: AvalonSTConfig = AvalonSTConfig(
    useChannels  = avst.config.useChannels,
    channelWidth = avst.config.channelWidth,
    useData      = true,
    dataWidth    = retWidth,
    useSOP       = true,
    useEOP       = true,
    useEmpty     = true,
    emptyWidth   = log2Up(retWidth / 8)
  )
  val ret:  AvalonST = AvalonST(retConfig)
  val step: Counter  = new Counter(0, cnt - 1)

  val datas:     Vec[Bits] = avst.payload.data.subdivideIn(cnt slices)
  val bytes_num: UInt      = ((step.value +^ 1) * retWidth) +^ (avst.payload.empty << 3)
  val overflow:  Bool      = bytes_num >= avst.config.dataWidth

  when(ret.fire) {
    when(ret.payload.eop) {
      step.clear()
    } otherwise (step.increment())
  }

  ret.valid         := avst.valid
  ret.payload.data  := datas(step)
  ret.payload.sop   := avst.payload.sop & step === 0
  ret.payload.eop   := avst.payload.eop & overflow
  ret.payload.empty := Mux(ret.payload.eop, (avst.payload.empty % (retWidth)).resize(retConfig.emptyWidth), U(0))
  if (avst.config.useChannels) {
    ret.payload.channel := avst.payload.channel
  }

  avst.ready := ret.ready & overflow
  override def implicitValue: AvalonST = ret
}

object BusExt {
  def avst_lock(arbi: StreamArbiter[AvalonSTPayload]) = new Area {
    arbi.locked clearWhen (arbi.io.output.fire & arbi.io.output.payload.eop) setWhen (arbi.io.output.fire & arbi.io.output.payload.sop & ~arbi.io.output.payload.eop)
  }

  implicit class AvstExt(avst: AvalonST) {
    val logger: Logger = LoggerFactory.getLogger(this.getClass)
    def toStream: Stream[AvalonSTPayload] = {
      val st = Stream(avst.payload) //setName(avst.name + "_st")
      st.valid   := avst.valid
      st.payload := avst.payload
      avst.ready := st.ready
      st
    }
    def divide(cnt: Int = 2, name: String = "") = {
      var retName = avst.name
      if (avst.name == null) {
        if (name == "") {
          val stackTrace = Thread.currentThread().getStackTrace
          val caller     = stackTrace(2)
          val lineNumber = caller.getLineNumber
          val fullPath   = caller.getClassName.replaceAll("\\.", "/") + ".scala"
          logger.warn(s"In $fullPath, Line: $lineNumber,AvalonST interface has no name!!!")
          retName = "avst"
        } else {
          retName = name
        }
      }
      AvstDivide(avst, cnt).setName(retName + "_divide").ret
    }
    def expand(cnt: Int = 2, name: String = "") = {
      var retName = avst.name
      if (avst.name == null) {
        if (name == "") {
          val stackTrace = Thread.currentThread().getStackTrace
          val caller     = stackTrace(2)
          val lineNumber = caller.getLineNumber
          val fullPath   = caller.getClassName.replaceAll("\\.", "/") + ".scala"
          logger.warn(s"In $fullPath, Line: $lineNumber,AvalonST interface has no name!!!")
          retName = "avst"
        } else {
          retName = name
        }
      }
      AvstExpand(avst, cnt).setName(retName + "_expand").ret
    }
    def check = new Area {
      val dup_sop:         Bool       = RegInit(False)
      val channel_changed: Bool       = avst.config.useChannels generate  RegInit(False)
      val trans_outside:   Bool       = RegInit(False)
      val pkt_byte_cnt:    UInt       = UInt(16 bits) setAsReg () init 0
      val pkt_size:        Flow[UInt] = Flow(UInt(16 bits))
      val pkt_count:       UInt       = UInt(32 bits) setAsReg () init 0

      val fire:        Bool = avst.fire
      val sop:         Bool = avst.payload.sop
      val eop:         Bool = avst.payload.eop
      val soped:       Bool = RegInit(False)
      val channel_reg: UInt = avst.config.useChannels generate RegNext(avst.payload.channel)

      soped.clearWhen(eop & fire) setWhen (sop & ~eop & fire)
      dup_sop         := fire & sop & soped
      if (avst.config.useChannels)
        channel_changed := fire & soped & (channel_reg =/= avst.payload.channel)
      trans_outside   := fire & ~soped & ~sop
      when(eop & fire) {
        pkt_count := pkt_count + 1
      }
      val byte_num: Int = (avst.config.dataWidth + 7) / 8
      when(fire) {
        when(eop) {
          pkt_byte_cnt.clearAll()
        } otherwise {
          pkt_byte_cnt := pkt_byte_cnt + byte_num
        }
      }
      if (avst.config.useEmpty)
        pkt_size.payload := RegNext(pkt_byte_cnt + byte_num - avst.payload.empty) init 0
      else
        pkt_size.payload := RegNext(pkt_byte_cnt + byte_num) init 0

      pkt_size.valid   := RegNext(eop & fire) init False
      assert(~dup_sop, L"${REPORT_TIME} ${avst.name} received duplicated sop!", WARNING)
      assert(~channel_changed, L"${REPORT_TIME} ${avst.name} channel changed during trans!", WARNING)
      assert(~trans_outside, L"${REPORT_TIME} ${avst.name} transfer a word outside!", WARNING)
    }
  }

  implicit class StreamExt(st: Stream[Bits]) {
    def asBundle[T <: Bundle](t: HardType[T]): Stream[T] = {
      val ret = Stream(t)
//      ret.setName(st.name + "_bits")
      ret.valid := st.valid
      ret.payload.assignFromBits(st.payload)
      st.ready := ret.ready
      ret
    }

  }
  implicit class StreamBundleExt[T <: Data](st: Stream[T]) {
    def toBits: Stream[Bits] = {
      val dw  = st.payload.getBitsWidth
      val ret = Stream(Bits(dw bits))
      ret.valid   := st.valid
      ret.payload := st.payload.asBits
      st.ready    := ret.ready
      ret
    }
    def toAvalonSt(config: AvalonSTConfig): AvalonST = {
//      require(st.payload.isInstanceOf[AvalonSTPayload])
      val avst = AvalonST(config)
      if (st.valid.isInput) {
        st.valid := avst.valid
        st.payload.assignFromBits(avst.payload.asBits)
        avst.ready := st.ready
      } else {
        avst.valid := st.valid
        st.ready   := avst.ready
        avst.payload.assignFromBits(st.payload.asBits)
      }

      avst
    }
  }
}
