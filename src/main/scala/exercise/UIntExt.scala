package exercise
import spinal.core._

import scala.language.postfixOps


object UIntExt {
  implicit class UIntExtCla(u: UInt){
    def lowOneMask: Bits = B(0, 1 bits ) ##( 1 to u.maxValue.toInt ).map(i => u >= i).map(_.asBits).reverse.reduce(_ ## _)
    def highOneMask:Bits = (u.maxValue.toInt downto 1).map(i => u >= i).map(_.asBits).reverse.reduce(_ ## _) ## B(0, 1 bits)
  }
}