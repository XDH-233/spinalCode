package demo

import spinal.core._
import spinal.core.sim._

import spinal.lib._
import tool.GeneralConfig.generalSimConfig

import spinal.lib.sim.{StreamMonitor, StreamDriver, StreamReadyRandomizer, ScoreboardInOrder}

object StreamFifoDemo extends App {
  generalSimConfig
    .compile(StreamFifo(Bits(8 bits), 8))
    .doSim { dut =>
      import dut._
      dut.clockDomain.forkStimulus(10)
      dut.io.push.valid   #= false
      dut.io.push.payload #= 0
      dut.io.pop.ready    #= false
      clockDomain.waitSampling()
      (0 until 10).foreach { _ =>
        io.push.valid #= true
        io.push.payload.randomize()
        clockDomain.waitSampling()
      }
      clockDomain.waitSampling(50)
    }
}
