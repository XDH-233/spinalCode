package intel_ip

import spinal.core._
import spinal.lib._
import spinal.lib.bus.avalon._

import scala.language.postfixOps
import org.slf4j.LoggerFactory

case class rdma_ctyun_sfifo(width: Int, depth: Int) extends BlackBox {
  val io = new Bundle {
    val clk:          Bool = in Bool () // Clock
    val srst:         Bool = in Bool ()
    val wr_en:        Bool = in Bool ()
    val din:          Bits = in Bits (width bits)
    val full:         Bool = out Bool ()
    val rd_en:        Bool = in Bool ()
    val dout:         Bits = out Bits (width bits)
    val empty:        Bool = out Bool ()
    val almost_empty: Bool = out Bool ()
    val almost_full:  Bool = out Bool ()
    val usedw:        UInt = out UInt (log2Up(depth) bits)
    val overflow:     Bool = out Bool ()
    val underflow:    Bool = out Bool ()
  }

  noIoPrefix()
  mapClockDomain(clock = io.clk, reset = io.srst)

  addGenerics(("DEPTH", depth), ("DATA_WIDTH", width))

  def push_from[T <: Data](st: Stream[T]): Unit = {
    io.wr_en := st.valid
    io.din   := st.payload.asBits
    st.ready := ~io.full
  }

  def pop_to[T <: Data](st: Stream[T]): Unit = {
    st.valid := ~io.empty
    io.rd_en := st.ready
    st.payload.assignFromBits(io.dout)
  }

  def push_from_avst(push_avst: AvalonST): Unit = {
    io.wr_en        := push_avst.valid
    io.din          := push_avst.payload.asBits
    push_avst.ready := ~io.full
  }

  def pop_to_avst(pop_avst: AvalonST): Unit = {
    pop_avst.valid := ~io.empty
    pop_avst.payload.assignFromBits(io.dout)
    io.rd_en := pop_avst.ready
  }

  // only for simulation
  addRTLPath("ipSimModel/scfifo.sv")
  addRTLPath("ipSimModel/ALTERA_DEVICE_FAMILIES.sv")
  addRTLPath("src/main/scala/intel_ip/rdma_ctyun_sfifo.v")
}

object rdma_ctyun_sfifo {
  def apply[T <: Data](depth: Int, push_st: Stream[T], pop_st: Stream[T]): rdma_ctyun_sfifo = {
    val fifo = new rdma_ctyun_sfifo(push_st.payload.getBitsWidth, depth)
    fifo.push_from(push_st)
    fifo.pop_to(pop_st)
    fifo
  }

  def apply(depth: Int, push_avst: AvalonST, pop_avst: AvalonST): rdma_ctyun_sfifo = {
    val fifo = new rdma_ctyun_sfifo(push_avst.payload.getBitsWidth, depth)
    fifo.push_from_avst(push_avst)
    fifo.pop_to_avst(pop_avst)
    fifo
  }

  def buffer_st[T <: Data](push: Stream[T], depth: Int, name: String = ""): Stream[T] ={
    val fifo = StreamFifo(push.payload,depth)
    fifo.io.push <> push
    if (name != ""){
      fifo.setName(name)
    }
    fifo.io.pop
  }

  def buffer[T <: Data](push: Stream[T], depth: Int, name: String = ""): Stream[T] = {
    val fifo     = rdma_ctyun_sfifo(push.payload.getBitsWidth, depth)
    var pushName = push.name
    if (name == "") {
      if(push.name == null){
        val logger     = LoggerFactory.getLogger(this.getClass)
        val stackTrace = Thread.currentThread().getStackTrace
        val caller     = stackTrace(2)
        val lineNumber = caller.getLineNumber
        val fullPath   = caller.getClassName.replaceAll("\\.", "/") + ".scala"
        logger.warn(s"In $fullPath, Line: $lineNumber,This push Stream has no name!!!")
        pushName = "ctyun"
      }else{
        pushName = push.name.replace("_push", "")
      }
    } else {
      pushName = name
    }
    fifo.setName(pushName + "_fifo")
    val pop = Stream(push.payloadType)
    fifo.push_from(push)
    fifo.pop_to(pop)
    pop
  }

  def bufferAvst(avst: AvalonST, depth: Int, name: String = ""): AvalonST = {
    val fifo     = new rdma_ctyun_sfifo(avst.payload.getBitsWidth, depth)
    var pushName = avst.name
    if (avst.name == null) {
      if (name == "") {
        val logger     = LoggerFactory.getLogger(this.getClass)
        val stackTrace = Thread.currentThread().getStackTrace
        val caller     = stackTrace(2)
        val lineNumber = caller.getLineNumber
        val fullPath   = caller.getClassName.replaceAll("\\.", "/") + ".scala"
        logger.warn(s"In $fullPath, Line: $lineNumber,This push Stream has no name!!!")
        pushName = "ctyun"
      } else {
        pushName = name
      }
    } else if (avst.name.contains("_push")) {
      pushName = avst.name.replace("_push", "")
    }
    fifo.setName(pushName + "_fifo")
    val pop = cloneOf(avst)
    fifo.push_from_avst(avst)
    fifo.pop_to_avst(pop)
    pop
  }
}

import rdma_ctyun_sfifo._
case class FactoryDemo() extends Component {
  val io = new Bundle {
    val st_in:  Stream[UInt] = slave Stream (UInt(8 bits))
    val st_out: Stream[UInt] = master Stream (UInt(8 bits))
  }
  noIoPrefix()
  val bufferd: Stream[UInt] = buffer(io.st_in, 16)
  io.st_out <> buffer(bufferd, 16)
}

import spinal.core.sim._
import spinal.lib.sim.{StreamDriver, StreamReadyRandomizer}
object CtyunSfifoFactorySim extends App {
  tool.GeneralConfig.verilatorSimConfig
    .compile(new FactoryDemo())
    .doSim { dut =>
      import dut._
      StreamDriver(dut.io.st_in, dut.clockDomain) { payload =>
        payload.randomize()
        true
      }
      StreamReadyRandomizer(dut.io.st_out, dut.clockDomain)
      dut.clockDomain.forkStimulus(10)
      dut.clockDomain.waitSampling(1000)
    }
}
