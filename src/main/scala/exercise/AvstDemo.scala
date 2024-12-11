package main.scala.exercise
import spinal.core._
import spinal.lib.bus.avalon._
import spinal.lib._
import spinal.core.sim._

import scala.language.postfixOps

case class AvstDemo(depth: Int) extends Module {
  val avstConfig: AvalonSTConfig =
    AvalonSTConfig(dataWidth = 512, useSOP = true, useEmpty = true, useEOP = true, useChannels = true, channelWidth = 25, emptyWidth = 8)

  val io = new Bundle {
    val cmdReq:      AvalonST      = slave(AvalonST(avstConfig))
    val cmdReqDeMux: Vec[AvalonST] = Vec(master(AvalonST(avstConfig)), 4)
  }

  val cmdReqBuf: StreamFifo[AvalonSTPayload] = StreamFifo(AvalonSTPayload(avstConfig), depth)
  cmdReqBuf.io.push.valid   := io.cmdReq.valid
  io.cmdReq.ready           := cmdReqBuf.io.push.ready
  cmdReqBuf.io.push.payload := io.cmdReq.payload

  val opcode: Bits = RegNextWhen(cmdReqBuf.io.pop.payload.data(31 downto 16), cmdReqBuf.io.pop.payload.sop & cmdReqBuf.io.pop.fire)
  val sel:    UInt = UInt(2 bits)

  switch(opcode) {
    (0 until 4).foreach { i =>
      is(i) {
        sel := i
      }
    }
    default {
      sel := 0
    }
  }

  val bufSTDeMux: Vec[Stream[AvalonSTPayload]] = StreamDemux(cmdReqBuf.io.pop.m2sPipe(), sel, 4)

  io.cmdReqDeMux.zipWithIndex.foreach { case (rd, i) =>
    rd.payload          := bufSTDeMux(i).payload
    rd.valid            := bufSTDeMux(i).valid
    bufSTDeMux(i).ready := rd.ready
  }

}

object AvstDemoSim extends App {
  SimConfig.withWave
    .withConfig(
      SpinalConfig(
        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
        defaultClockDomainFrequency  = FixedFrequency(100 MHz),
        nameWhenByFile               = false,
        anonymSignalPrefix           = "tmp"
      )
    )
    .compile(new AvstDemo(8))
    .doSim { dut =>
      import dut._
      dut.clockDomain.forkStimulus(10)
      io.cmdReq.valid                #= false
      io.cmdReq.payload.sop          #= false;
      io.cmdReq.payload.eop          #= false
      io.cmdReq.payload.empty        #= 0
      io.cmdReq.payload.data         #= 0
      io.cmdReq.payload.channel      #= 0
      io.cmdReqDeMux.foreach(_.ready #= false)
      clockDomain.waitSampling()
      io.cmdReq.valid        #= true
      io.cmdReq.payload.sop  #= true
      io.cmdReq.payload.data #= BigInt(3) << 16
      clockDomain.waitSampling()
      io.cmdReq.payload.sop #= false
      (0 until 6).foreach { _ =>
        io.cmdReq.payload.data.randomize()
        clockDomain.waitSampling()
      }
      io.cmdReq.payload.data.randomize()
      io.cmdReq.payload.eop #= true
      clockDomain.waitSampling()
      io.cmdReq.payload.eop          #= false
      io.cmdReq.payload.data         #= 0
      io.cmdReq.valid                #= false
      io.cmdReqDeMux.foreach(_.ready #= true)
      clockDomain.waitSampling()
      io.cmdReq.valid        #= true
      io.cmdReq.payload.sop  #= true
      io.cmdReq.payload.data #= BigInt(2) << 16
      clockDomain.waitSampling()
      io.cmdReq.payload.sop #= false
      (0 until 6).foreach { _ =>
        io.cmdReq.payload.data.randomize()
        clockDomain.waitSampling()
      }
      io.cmdReq.payload.data.randomize()
      io.cmdReq.payload.eop #= true
      clockDomain.waitSampling()
      io.cmdReq.payload.eop  #= false
      io.cmdReq.payload.data #= 0
      io.cmdReq.valid        #= false
      clockDomain.waitSampling()
      io.cmdReq.valid        #= true
      io.cmdReq.payload.sop  #= true
      io.cmdReq.payload.data #= BigInt(1) << 16
      clockDomain.waitSampling()
      io.cmdReq.payload.sop #= false
      (0 until 6).foreach { _ =>
        io.cmdReq.payload.data.randomize()
        clockDomain.waitSampling()
      }
      io.cmdReq.payload.data.randomize()
      io.cmdReq.payload.eop #= true
      clockDomain.waitSampling()
      io.cmdReq.payload.eop  #= false
      io.cmdReq.payload.data #= 0
      io.cmdReq.valid        #= false
      clockDomain.waitSampling(50)
    }
}
