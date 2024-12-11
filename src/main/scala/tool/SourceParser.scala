package tool

import tool.BusIfExt.parse_verilog_num

import java.nio.file.{Files, Path, Paths, StandardOpenOption}
import scala.collection.mutable
import scala.io.Source
import scala.util.matching.Regex

object SourceParser {
  def vhParser(sourcePath: String, targetDir: String, packageName:String=""): Unit = {
    val path: Path = Paths.get(sourcePath)
    val fileNameWithoutExtension = path.getFileName.toString.replaceFirst("\\.[^.]+$", "")
    // 从文件中读取内容
    val lines = Source.fromFile(sourcePath).getLines().toList

    // 定义正则表达式，用于匹配 `define` 语句
    val definePattern: Regex = """`define\s+(\w+)\s+(.+)""".r

    // 生成的单例对象的内容
    val sb = new StringBuilder
    if(packageName!=""){
      sb.append(s"package $packageName\n")
    }
    sb.append("import spinal.core.log2Up\n")
    sb.append(s"object ${fileNameWithoutExtension}_vh {\n")

    // 解析每一行，提取名称和值
    val nameMap = mutable.Map[String, String]()
    for (line <- lines) {
      // 去掉注释部分
      val cleanedLine = line.split("//").headOption.map(_.trim)

      cleanedLine.foreach {
        case definePattern(name, value) => {
          if (!nameMap.contains(name)) {
            val scalaValue = value.trim match {
              case v if v.startsWith("$clog2") =>
                // 替换为 log2Up() 函数
                v.replace("`", "").replace("$clog2", "log2Up")
              case v if v.startsWith("`") =>
                // 移除反引号
                v.replace("`", "")
              case v if v.contains("*") =>
                v.replace("(", "").replace(")", "").replace("`", "")
              case v if v.startsWith("\"") =>
                v
              case v if v.forall(Character.isDigit) =>
                // 处理纯数字
                v.toLong.toString // 直接转换为 Long
              case v =>
                // 处理 Verilog 数字格式
                try {
                  parse_verilog_num(v).toString
                } catch {
                  case e: IllegalArgumentException =>
                    println(line)
                    throw new IllegalArgumentException(s"Invalid Verilog number format in value: $v", e)
                }
            }

            // 添加到单例对象中
            val scalaValue_str = if (scalaValue.forall(Character.isDigit)) "BigInt(" + "\"" + scalaValue + "\"" + ")" else scalaValue
            sb.append(s"  val $name = $scalaValue_str\n")
            nameMap(name) = scalaValue_str
          } else {}
        }

        case _ =>
      }
    }

    sb.append("}\n")

    // 打印生成的 Scala 代码
    // 写入到目标文件
    val targetPath = targetDir + "/" + fileNameWithoutExtension + "_vh.scala"
    try {
      Files.write(Paths.get(targetPath), sb.toString().getBytes, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING)
      println(s"Generated Scala file written to: $targetDir")
    } catch {
      case e: Exception =>
        println(s"Error writing to file: ${e.getMessage}")
    }

  }
  def structParser(struct: String)  = {} //TODO
  def svhParser(sourcePath: String) = {}//TODO
}

object vhParserGen extends App {
  SourceParser.vhParser(
    sourcePath="/Users/xiangtyy/Documents/code/RDMA/crs_fpga/design/rdma_subsystem/top/rdma.vh",
    targetDir = "/Users/xiangtyy/IdeaProjects/spinalCode/src/main/scala/rdma",
    packageName="rdma"
  )
}
