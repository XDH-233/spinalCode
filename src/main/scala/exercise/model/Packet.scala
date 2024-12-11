package exercise.model

import scala.util.matching.Regex
case class Packet(fragments: Array[Fragment]) {
  val dataWidth: Int = fragments.head.dataWidth
  val byteWidth: Int = fragments.head.byteWidth
  require(dataWidth > byteWidth & dataWidth % byteWidth == 0)
  private val byteNum = dataWidth / byteWidth
  private val fragmentCount: Int = fragments.length
  val mtyS:                  Int = fragments.head.mty
  val mtyE:                  Int = fragments.last.mty

  def concat2Packet(): Packet = {
    if (fragmentCount == 1) this
    else {
      val noLastFragment = fragments.last.datas.length == 1 & fragments.head.mty + fragments.last.mty >= byteNum
      val mtyO           = (mtyS + mtyE) % byteNum
      val headFragment = Fragment(
        mty       = if (noLastFragment & fragmentCount == 2) mtyO else 0,
        datas     = fragments.head.datas.init :+ concatData(fragments.head.datas.last, fragments(1).datas.head, mtyS, sof = true),
        sof       = true,
        eof       = if (noLastFragment & fragmentCount == 2) true else false, // two fragment and only get one after concat
        dataWidth = dataWidth,
        byteWidth = byteWidth
      )
      val middleFragment = fragments.tail.init
        .zip(fragments.tail.tail)
        .map { case (i, t) =>
          val append = i.datas :+ t.datas.head
          append.init.zip(append.tail).map { case (di, dt) => concatData(di, dt, mtyS) }
        }
        .zipWithIndex
        .map { case (sb, i) =>
          Fragment(
            mty       = if (noLastFragment & i == fragmentCount - 3) mtyO else 0,
            datas     = sb,
            sof       = false,
            eof       = if (noLastFragment & i == fragmentCount - 3) true else false,
            dataWidth = dataWidth,
            byteWidth = byteWidth
          )
        }
      val lastInit = fragments.last.datas.init.zip(fragments.last.datas.tail).map { case (i, t) => concatData(i, t, mtyS) }
      val lastEop  = concatData(fragments.last.datas.last, BigInt(0), mtyS)
      val lastFragment = Fragment(
        mty       = mtyO,
        datas     = if (mtyS + mtyE >= byteNum) lastInit else lastInit :+ lastEop,
        sof       = false,
        eof       = true,
        dataWidth = dataWidth,
        byteWidth = byteWidth
      )
      if (noLastFragment) Packet(headFragment +: middleFragment) else Packet(headFragment +: middleFragment :+ lastFragment)
    }
  }

  def concat2Fragment(): Fragment = {
    val p = concat2Packet()
    val data = p.fragments.map(_.datas).reduce(_ ++ _)
    Fragment(mty = p.fragments.last.mty, sof = false, eof = false, dataWidth = dataWidth, byteWidth = byteWidth, datas = data)
  }

  private def concatData(rDin: BigInt, din: BigInt, mty: Int, sof: Boolean = false): BigInt = {
    val rDinShift = if (sof) rDin % (BigInt(1) << (dataWidth - mty * byteWidth)) else rDin >> (mty * byteWidth)
    val shiftOut  = (din % (BigInt(1) << (mty * byteWidth))) << (dataWidth - mty * byteWidth)
    rDinShift | shiftOut
  }

  def display(): Unit = {
    fragments.foreach { f =>
      f.display()
    }
  }

  def compare(that: Packet) = { // TODO

  }

}

object Packet {
  def apply(fragments: Fragment*): Packet = new Packet(fragments.toArray)
  def apply(dataWidth: Int = 512, byteWidth: Int = 8, maxFragmentNum: Int, maxFragmentLength: Int): Packet = {
    val lengthArr = Array.fill(scala.util.Random.nextInt(maxFragmentNum) + 1)(scala.util.Random.nextInt(maxFragmentLength) + 1) // [1, L]
    val head = Fragment(
      dataWidth = dataWidth,
      byteWidth = byteWidth,
      mty       = scala.util.Random.nextInt(dataWidth / byteWidth),
      sof       = true,
      eof       = if (lengthArr.length == 1) true else false,
      dataNum   = lengthArr.head
    )
    if (lengthArr.length == 1) {
      Packet(head)
    } else {
      val mid = lengthArr.tail.init.map(l => Fragment(dataWidth = dataWidth, byteWidth = byteWidth, mty = 0, sof = false, eof = false, dataNum = l))
      val last = Fragment(
        dataWidth = dataWidth,
        byteWidth = byteWidth,
        mty       = scala.util.Random.nextInt(dataWidth / byteWidth),
        sof       = false,
        eof       = true,
        dataNum   = lengthArr.last
      )
      Packet(head +: mid :+ last)
    }
  }

  def apply(s: String): Packet = {
    val sf         = s.split("\n")
    val fn         = sf.length
    val widthPaten = "[0-9]+'h".r
    val dataWidth  = (widthPaten findFirstIn s).toArray.head.slice(0, 2).toInt
    val fragments: Array[Fragment] = sf.zipWithIndex.map { case (fs, i) =>
      val dataPatten: Regex = "[A-Z0-9]{8}".r
      val mtyPatten = "mty:.?[0-9]+".r
      val mty       = (mtyPatten findFirstIn fs).toArray.head.slice(4, 6).trim.toInt
      val dataArr   = (dataPatten.findAllIn(fs)).toArray.map(s => BigInt(s, 16))
      val sof       = i == 0
      val eof       = i == (fn - 1)
      Fragment(mty = mty, sof = sof, eof = eof, dataWidth = dataWidth, byteWidth = 8, datas = dataArr)
    }
    Packet(fragments)
  }

}
