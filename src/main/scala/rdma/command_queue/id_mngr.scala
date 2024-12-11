package rdma.command_queue

import intel_ip.rdma_ctyun_sfifo._
import spinal.core._
import spinal.lib._

import scala.language.postfixOps

case class id_mngr(idNum: Int) extends Component {

  val io = new Bundle {
    val clear: Stream[UInt] = slave Stream (UInt(log2Up(idNum) bits))
    val fetch: Stream[UInt] = master Stream (UInt(log2Up(idNum) bits))
  }

  val init_push: Bool    = Bool() setAsReg () init (True)
  val cnt:       Counter = Counter(0, idNum - 1)

  val push: Stream[UInt] = Stream(UInt(log2Up(idNum) bits))

  io.fetch <> buffer(push, idNum, "id")

  when(cnt === idNum - 1)(init_push.clear())
  when(init_push) {
    cnt.increment()
    io.clear.ready.clear()
    push.valid.set()
    push.payload := cnt.value
  } otherwise {
    io.clear <> push
  }
}
