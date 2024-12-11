package exercise

import spinal.core._
import spinal.lib._
import spinal.lib.fsm._

// 10011
case class SeqDet() extends Component {
  val io = new Bundle {
    val din:  Bool = in Bool ()
    val flag: Bool = out Bool ()
  }

  io.flag.clear()

  val fsm = new StateMachine {
    val IDLE   = new State() with EntryPoint
    val S1     = new State()
    val S10    = new State()
    val S100   = new State()
    val S1001  = new State()
    val S10011 = new State()

    IDLE.whenIsActive {
      when(io.din)(goto(S1)) otherwise (goto(IDLE))
    }

    S1.whenIsActive {
      when(io.din)(goto(S1)) otherwise (goto(S10))
    }

    S10.whenIsActive {
      when(io.din)(goto(S1)) otherwise (goto(S100))
    }

    S100.whenIsActive {
      when(io.din)(goto(S1001)) otherwise (goto(IDLE))
    }

    S1001.whenIsActive {
      when(io.din)(goto(S10011)) otherwise (goto(S10))
    }

    S10011.whenIsActive {
      io.flag.set()
      when(io.din)(goto(S1)) otherwise (goto(IDLE))
    }
  }

}
