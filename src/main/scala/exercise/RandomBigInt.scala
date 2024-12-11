package exercise

object RandomBigInt {
  def nextBigInt(width: Int): BigInt = {
    var temp = BigInt(0)
    (0 until width).foreach { w => temp = if (scala.util.Random.nextBoolean()) temp.setBit(w) else temp.clearBit(w) }
    temp
  }
}
