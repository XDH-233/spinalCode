package exercise

object BigIntExt {
  implicit class BigIntExtCla(b: BigInt) {
    def toStringFull(bits: Int = 16, width: Int = 32): String = {
      val fuck = b.bitLength
      require(b.bitLength <= width)
      val bl = if (b == BigInt(0)) 1 else b.bitLength
      bits match {
        case 2 => s"${width - bl}" + "0" * (width - bl) + b.toString(2)
        case 16 => {
          s"$width'h-" + "0" * ((width.toDouble / 4.0).ceil.toInt - (bl.toDouble / 4.0).ceil.toInt) + b.toString(16).toUpperCase
        }
        case _ => b.toString(10)
      }

    }
  }

}
