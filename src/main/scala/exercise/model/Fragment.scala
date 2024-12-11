package exercise.model

case class Fragment(mty: Int, sof: Boolean, eof: Boolean, dataWidth: Int = 512, byteWidth: Int = 8, datas: Array[BigInt]) {

  require(mty * byteWidth < dataWidth, "mty to larger!")

  val dataCount: Int = datas.length

  def lastData: BigInt = {
    val value = datas.last
    val bl    = datas.last.bitLength
    if (bl <= dataWidth - mty * 8)
      value
    else {
      var temp: BigInt = value
      (dataWidth - mty * byteWidth + 1 to bl).foreach(b => temp = temp.clearBit(b - 1))
      temp
    }
  }

  def display(): Unit = {
    import exercise.BigIntExt._
    if (dataCount > 8) {
      println("mty: "+mty)
      datas.grouped(8).foreach(g => println(g.map(_.toStringFull(16, dataWidth)).mkString("-->")))
    } else {
      printf("mty: %-2s" + datas.map(_.toStringFull(16, dataWidth)).mkString(" -->") + "\n", mty)
    }
//    printf("mty: %-2s" + datas.map(_.toStringFull(16, dataWidth)).mkString(" -->") + s"$sof, $eof"+"\n", mty)
  }

}

object Fragment {
  def apply(mty: Int, sof: Boolean, eof: Boolean, dataWidth: Int, byteWidth: Int, datas: BigInt*): Fragment =
    new Fragment(mty, sof, eof, dataWidth, byteWidth, datas.toArray)

  def apply(dataWidth: Int, byteWidth: Int, mty: Int, sof: Boolean, eof: Boolean, dataNum: Int): Fragment = {
    import exercise.RandomBigInt._
    Fragment(mty = mty, sof = sof, eof = eof, dataWidth = dataWidth, byteWidth = byteWidth, datas = Array.fill(dataNum)(nextBigInt(dataWidth)))
  }
}
