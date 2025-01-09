package tool

import org.apache.log4j.{Logger, Level, FileAppender, PatternLayout, ConsoleAppender}
import java.io.File

trait Logging {
  private val logger: Logger = Logger.getLogger(getClass)

  def configureLogging(logFile: String = "application.log", logLevel: Level = Level.DEBUG): Unit = {
    val consoleAppender = new ConsoleAppender()
    consoleAppender.setName("ConsoleLogger")
    consoleAppender.setLayout(new PatternLayout("%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1} - %m%n"))
    consoleAppender.activateOptions()
    logger.addAppender(consoleAppender)

    if (logFile != "") {

      val file = new File(logFile)
      if (file.exists()) {
        file.delete()
      }

      val fileAppender = new FileAppender()
      fileAppender.setName("FileLogger")
      fileAppender.setFile(logFile)
      fileAppender.setLayout(new PatternLayout("%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1} - %m%n"))

      fileAppender.setAppend(false)
      fileAppender.setThreshold(logLevel)
      fileAppender.activateOptions()
      logger.addAppender(fileAppender)
    }

    logger.setLevel(logLevel)
  }

  def debug(message: String): Unit = logger.debug(message)
  def info(message: String):  Unit = logger.info(message)
  def warn(message: String):  Unit = logger.warn(message)
  def error(message: String): Unit = logger.error(message)
}
