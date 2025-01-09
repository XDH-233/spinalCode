package tool

import spinal.core._
import spinal.core.sim._
import spinal.sim.VCSFlags

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

object GeneralConfig {
  // 获取当前日期和时间
  val now: LocalDateTime = LocalDateTime.now()

  // 定义日期时间格式
  val formatter: DateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")

  // 将日期时间格式化为字符串
  val dateTimeString: String = now.format(formatter)
  def rtlGenConfig(path: String = "./", prefix: String = "", widthTime: Boolean = false): SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
    nameWhenByFile               = false,
    anonymSignalPrefix           = "tmp",
//    oneFilePerComponent          = true,
    targetDirectory = path,
    genLineComments = true,
    globalPrefix    = prefix,
    withTimescale   = false,
//    svInterface                  = true,
    rtlHeader = if (widthTime) s"Gen time  : $dateTimeString" else ""
  )

  val simSpinalConfig: SpinalConfig = SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
    nameWhenByFile               = false,
    anonymSignalPrefix           = "tmp",
    genLineComments              = true
  )
  val verilatorSimConfig: SpinalSimConfig = SimConfig.withWave
//    .addSimulatorFlag("-sv -Wno-INITIALDLY -Wno-COMBDLY -Wno-MULTIDRIVEN -Wno-PINMISSING -Wno-MISINDENT -Wno-BLKANDNBLK")
    .withConfig(simSpinalConfig)

  val vcsFlags = VCSFlags(
    compileFlags   = List("-kdb"),
    elaborateFlags = List("-LDFLAGS -Wl,--no-as-needed")
  )

  def generalSimConfig: SpinalSimConfig = {
    val vcsHome  = sys.env.get("VCS_HOME")
    val vcsFound = !vcsHome.isEmpty
    val pathEnv  = sys.env.get("PATH").getOrElse("")
    val pathList = pathEnv.split(java.io.File.pathSeparator)

    val verilatorFound = pathList.exists { path =>
      val fullPath = java.nio.file.Paths.get(path, "verilator").toString
      val executable = if (System.getProperty("os.name").toLowerCase.contains("win")) {
        s"$fullPath.exe"
      } else {
        fullPath
      }
      new java.io.File(executable).exists()
    }
    val simConfig = SimConfig.withConfig(simSpinalConfig)
    if (vcsFound) {
      return simConfig.withVcs.withFSDBWave
    } else {
      return simConfig.withWave // use verilator
    }
  }

}
