package exercise

import spinal.core._
import spinal.core.sim._
import model._
import scala.util.Random._
import RandomBigInt._
import BigIntExt._

object FragmentConcatSimMeth {
  implicit class FragmentSplitSim(fs: FragmentConcat) {
    import fs._
    def init(): Unit = {
      io.dataOut.ready  #= false
      io.dataIn.valid   #= false
      io.dataIn.mty     #= 0
      io.dataIn.data    #= 0
      io.dataIn.sop     #= false
      io.dataIn.eop     #= false
      io.dataIn.sbd.sof #= false
      io.dataIn.sbd.eof #= false
      io.dataIn.sbd.len #= 0
      io.dataOut.ready  #= false
      clockDomain.waitSampling()
    }
    def packetAssignBack2Back(p: model.Packet): Unit = {
      io.dataIn.valid  #= true
      io.dataOut.ready #= true
      p.fragments.foreach { f =>
        io.dataIn.sbd.sof #= f.sof
        io.dataIn.sbd.eof #= f.eof
        io.dataIn.data    #= f.datas.head
        io.dataIn.mty     #= (if (f.dataCount == 1) f.mty else 0)
        io.dataIn.sop     #= true
        io.dataIn.eop     #= (if (f.dataCount == 1) true else false)
        clockDomain.waitSampling()
        if (f.dataCount > 1) {
          f.datas.tail.init.foreach { fd =>
            io.dataIn.data #= fd
            io.dataIn.sop  #= false
            io.dataIn.mty  #= 0
            clockDomain.waitSampling()
          }
          io.dataIn.sop  #= false
          io.dataIn.data #= f.datas.last
          io.dataIn.eop  #= true
          io.dataIn.mty  #= f.mty
          clockDomain.waitSampling()
        }
      }
    }

    def packet2AssignRand(ps: Packet*): Unit = {
      var pi = 0
      val pl = ps.length
      var fi = 0
      var fl = ps(pi).fragments.length
      var di = 0
      var dl = ps(pi).fragments(fi).dataCount

      while (pi < pl) {
        val lastVld  = io.dataIn.valid.toBoolean
        val lastRdy  = io.dataIn.ready.toBoolean
        val lastData = io.dataIn.data.toBigInt
        val vld      = nextBoolean()
        io.dataOut.ready #= nextInt(10) < 7
        if (lastVld & lastRdy) { // handshake success, update new index
          di = di + 1
          if (di == dl) { // new di and dl
            di = 0
            fi = fi + 1
            if (fi == fl) { //new fi and fl
              fi = 0
              pi = pi + 1
              if (pi == pl) {
                println("assign done !")
              } else {
                fl = ps(pi).fragments.length
                dl = ps(pi).fragments(fi).dataCount
              }
            } else {
              dl = ps(pi).fragments(fi).dataCount
            }
          }
        }
        if (pi < pl) {
          val data = ps(pi).fragments(fi).datas(di)
          val sop  = di == 0
          val eop  = di == (dl - 1)
          val sof  = ps(pi).fragments(fi).sof
          val eof  = ps(pi).fragments(fi).eof
          val mty  = if (eop) ps(pi).fragments(fi).mty else 0
          io.dataIn.sbd.sof #= sof
          io.dataIn.sbd.eof #= eof
          if (lastVld & lastRdy) {
            if (vld) {
              io.dataIn.data  #= data
              io.dataIn.valid #= true
              io.dataIn.sop   #= sop
              io.dataIn.eop   #= eop
              io.dataIn.mty   #= mty
            } else {
              io.dataIn.randomize()
              io.dataIn.valid   #= false
              io.dataIn.sop     #= false
              io.dataIn.eop     #= false
              io.dataIn.mty     #= 0
              io.dataIn.sbd.sof #= sof
              io.dataIn.sbd.eof #= eof
            }
          } else if (lastVld & !lastRdy) {
            io.dataIn.valid #= true
            io.dataIn.data  #= lastData
          } else {
            if (vld) {
              io.dataIn.data  #= data
              io.dataIn.valid #= true
              io.dataIn.sop   #= sop
              io.dataIn.eop   #= eop
              io.dataIn.mty   #= mty
            } else {
              io.dataIn.randomize()
              io.dataIn.valid   #= false
              io.dataIn.sop     #= false
              io.dataIn.eop     #= false
              io.dataIn.mty     #= 0
              io.dataIn.sbd.sof #= sof
              io.dataIn.sbd.eof #= eof
            }
          }
          clockDomain.waitSampling()
        }
      }
      init()
      (0 until 10).foreach { _ =>
        io.dataOut.ready.randomize()
        clockDomain.waitSampling()
      }

    }

    def monitor(cycles: Int): Array[Packet] = {
      val fragmentsQue = scala.collection.mutable.Queue[model.Fragment]()
      val dataQue      = scala.collection.mutable.Queue[BigInt]()
      val packetQue    = scala.collection.mutable.Queue[model.Packet]()
      (0 until cycles).foreach { _ =>
        clockDomain.waitSampling()
        val sof  = io.dataOut.sbd.sof.toBoolean
        val eof  = io.dataOut.sbd.eof.toBoolean
        val eop  = io.dataOut.eop.toBoolean
        val mty  = io.dataOut.mty.toInt
        val fire = io.dataOut.valid.toBoolean & io.dataOut.ready.toBoolean
        if (fire) {
          dataQue.enqueue(io.dataOut.data.toBigInt)
          if (eop) {
            fragmentsQue.enqueue(
              model.Fragment(mty = mty, sof = sof, eof = eof, dataWidth = fs.dataWidth, byteWidth = fs.byteWidth, datas = dataQue.toArray)
            )
            dataQue.clear()
            if (eof) {
              packetQue.enqueue(Packet(fragmentsQue.toArray))
              fragmentsQue.clear()
            }
          }
        }
      }
      packetQue.toArray
    }

    def fragmentMonitor(cycles: Int): Array[Fragment] = {
      val fragmentsQue = scala.collection.mutable.Queue[model.Fragment]()
      val dataQue      = scala.collection.mutable.Queue[BigInt]()
      (0 until cycles).foreach { _ =>
        clockDomain.waitSampling()
        val eop  = io.dataOut.eop.toBoolean
        val mty  = io.dataOut.mty.toInt
        val fire = io.dataOut.valid.toBoolean & io.dataOut.ready.toBoolean
        if (fire) {
          dataQue.enqueue(io.dataOut.data.toBigInt)
          if (eop) {
            fragmentsQue.enqueue(model.Fragment(mty = mty, sof = false, eof = false, dataWidth = dataWidth, byteWidth = byteWidth, datas = dataQue.toArray))
            dataQue.clear()
          }
        }
      }
//      println("-" * 60 + "monitor res" + "-" * 60)
//      fragmentsQue.foreach(_.display())
//      println("-" * 60 + "monitor done" + "-" * 60)
      fragmentsQue.toArray
    }
  }
}
