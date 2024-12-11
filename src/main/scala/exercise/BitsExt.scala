package exercise
import spinal.core._

import scala.language.postfixOps

object BitsExt {
  implicit class BitsExtCla(b: Bits) {
    val width: Int = b.getWidth
    def shift(u: UInt, segWidth: Int = 8, r: Boolean): Bits = {
      require((u.maxValue + 1) * segWidth <= width)

      val signal: Seq[Bits] = Seq(b) ++ Seq.fill(u.getWidth)(Bits(width bits))
      signal.tail.zip(signal.init).zip(u.asBools).zipWithIndex.foreach { case (((t, i), b), index) =>
        t := Mux(b, if (r) i |>> (1 << index) * segWidth else i |<< (1 << index) * segWidth, i)
      }
      signal.last
    }

    // ----abc => abc0000
    def shiftRightOut(u: UInt, segWidth: Int): Bits = {
      require((u.maxValue.toInt + 1) * segWidth <= b.getWidth)
      (b ## B(0, b.getWidth bits)).shift(u, segWidth, r = true).takeLow(b.getWidth)
    }

    def bit2ByteExt: Bits = b.asBools.map(b => B(8 bits, default -> b)).reverse.reduce(_ ## _)
  }
}
