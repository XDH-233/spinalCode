package exercise
import spinal.core._
import spinal.lib._
import spinal.core.sim._
import UIntExt._
import BitsExt._

import scala.language.postfixOps

case class FragmentConcat(dataWidth: Int = 512, byteWidth: Int = 8, length: Int) extends Component {
  val io = new Bundle {
    val dataIn:  DataInterface = slave(DataInterface(dataWidth, byteWidth, length))
    val dataOut: DataInterface = master(DataInterface(dataWidth, byteWidth, length))
  }

  private val byteNum: Int = dataWidth / byteWidth

  val rValid, rSop, rEop: Bool = RegInit(False)
  val rMty:               UInt = Reg(UInt(log2Up(byteNum) bits)) init (0)
  val rMtyO:              UInt = Reg(UInt(log2Up(byteNum) bits)) init (0)
  val overRange:          Bool = (io.dataIn.mty +^ rMty >= byteNum) & io.dataIn.fire
  val pipeIn, pipeOut = Stream(Bits(dataWidth + log2Up(byteNum) + 2 bits))

  //----------rValid ----------------------
  when(overRange) {
    rValid.clear()
  } elsewhen (io.dataIn.fire) {
    rValid.set()
  } elsewhen (rEop & pipeIn.ready) {
    rValid.clear()
  }

  // ---------rSop --------------------------
  when(io.dataIn.fire & io.dataIn.sofSop) {
    rSop.set()
  } elsewhen (pipeIn.ready) {
    rSop.clear()
  }

  // -----------------rMty--------------------
  when(io.dataIn.eofEop & io.dataIn.fire) {
    rMty.clearAll()
  } elsewhen (io.dataIn.sofEop & io.dataIn.fire) {
    rMty := io.dataIn.mty
  }
// ---------------rMtyO-------------------------
  when(io.dataIn.fire & io.dataIn.eop & io.dataIn.sbd.eof & (rMty +^ io.dataIn.mty < byteNum)) {
    rMtyO := io.dataIn.mty + rMty
  } elsewhen (pipeIn.ready) {
    rMtyO.clearAll()
  }

  // --------------------rEop--------------------
  when(io.dataIn.eofEop & io.dataIn.fire) {
    when(rMty +^ io.dataIn.mty >= byteNum) {
      rEop.clear()
    } otherwise {
      rEop.set()
    }
  } elsewhen (pipeIn.ready) {
    rEop.clear()
  }
  val concat = new Area {
    val rDin: Bits = RegNextWhen(io.dataIn.data.shift(rMty, segWidth = 8, r = true), io.dataIn.fire) init (0)
    val data: Bits = io.dataIn.data.shiftRightOut(rMty, 8) ^ (rDin & ~rMty.highOneMask.bit2ByteExt)
  }

  pipeIn.valid := Mux(rEop, True, rValid & io.dataIn.fire)
  pipeIn      >-> pipeOut
  val eopP: Bool = overRange | rEop
  val mtyP: UInt = Mux(overRange, io.dataIn.mty + rMty, Mux(eopP, rMtyO, U(0)))
  pipeIn.payload  := rSop ## eopP ## mtyP ## concat.data
  pipeOut.ready   := io.dataOut.ready
  io.dataOut.data := pipeOut.payload.takeLow(dataWidth)
  //-------------dout_valid----------------------------------------------------------
  io.dataOut.valid := pipeOut.valid
  io.dataIn.ready  := pipeIn.ready | ~rValid
  io.dataOut.mty   := pipeOut.payload(dataWidth + log2Up(byteNum) - 1 downto dataWidth).asUInt
  io.dataOut.sop   := pipeOut.payload(dataWidth + log2Up(byteNum) + 1)
  // -------------dout_eop------------------------------------------------------------------------------
  io.dataOut.eop := pipeOut.payload(dataWidth + log2Up(byteNum))
  io.dataOut.sbd.sof.clear()
  io.dataOut.sbd.eof.clear()
  io.dataOut.sbd.len := RegNext(io.dataIn.sbd.len)

}
