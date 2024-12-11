package tool

import org.apache.poi.ss.usermodel.WorkbookFactory
import spinal.core._
import spinal.lib.bus.regif._

import java.io.{File, FileInputStream, PrintWriter}
import scala.collection.JavaConverters.asScalaIteratorConverter
import scala.collection.mutable
import scala.collection.mutable.ArrayBuffer
import scala.language.postfixOps
import scala.util.matching.Regex

case class FieldDescription(fieldName: String, width: Int, pos: Int, accessType: AccessType, resetValue: BigInt, doc: String)

object BusIfExt {

  /** @param s
    *   verilog format numeric: 16'h1f, 12'd9, 4'b0010 etc.
    * @return
    *   integer: 31, 9, 2
    */
  def parse_verilog_num(s: String): BigInt = {
    val trimmed = s.trim()
    val binaryPattern:  Regex = """(\d+)'b([01]+)""".r
    val hexPattern:     Regex = """(\d+)'h([0-9a-fA-F]+)""".r
    val decimalPattern: Regex = """(\d+)'d(\d+)""".r

    trimmed match {
      case binaryPattern(_, value) =>
        BigInt(value, 2)
      case hexPattern(_, value) =>
        BigInt(value, 16)
      case decimalPattern(_, value) =>
        BigInt(value, 10)
      case _ =>
        throw new IllegalArgumentException(s"Unsupported format: $s")
    }
  }

  /** @param s
    *   verilog format field section: [31:16], [4:0], [11] etc.
    * @return
    *   (offset, width): (16, 16), (0, 5), (11, 1)
    */
  def parse_verilog_section(s: String): (Int, Int) = {
    val rangePattern: Regex = """\[(\d+)(?::(\d+))?\]""".r
    s match {
      case rangePattern(high, lowOpt) =>
        val highInt  = high.toInt
        val lowInt   = Option(lowOpt).map(_.toInt).getOrElse(highInt)
        val posInt   = math.min(highInt, lowInt)
        val widthInt = math.max(highInt, lowInt) - posInt + 1
        (posInt, widthInt)
      case _ =>
        throw new IllegalArgumentException(s"Unsupported format: $s")
    }
  }

  implicit class BusIfExtCla(busIf: BusIf) {
    def parseFromXlsx(path: String, ROAsInput: Boolean = true): Unit = {
      val excelFile = new FileInputStream(new File(path))
      val fileNameWithExtension = new File(path).getName
      val fileName = fileNameWithExtension.substring(0, fileNameWithExtension.lastIndexOf('.'))
      val workbook  = WorkbookFactory.create(excelFile)
      val sheet     = workbook.getSheetAt(0)
      val regInstDict: mutable.Map[String, RegInst] = mutable.Map[String, RegInst]()
      val fieldDesDict = mutable.Map[String, ArrayBuffer[FieldDescription]]()
      var regNameHold  = ""
      //----------------------------解析xlsx表格-------------------------------------------------------------------------
      sheet.iterator().asScala.drop(1).foreach { row =>
        if (row.getCell(0) != null) {
          val regName = row.getCell(1).getStringCellValue
          if (!regInstDict.contains(regName) && regName != "") {
            regNameHold = regName
            val description          = row.getCell(2).getStringCellValue
            val width                = row.getCell(3).getNumericCellValue.toInt
            val addressOffset        = row.getCell(0).getStringCellValue
            val cleanedAddressOffset = addressOffset.replace("0x", "")
            val addr                 = Integer.parseInt(cleanedAddressOffset, 16)
            val regInst              = busIf.newRegAt(addr, description)
            regInst.setName(regName)
            regInstDict += (regName -> regInst)
            fieldDesDict(regName) = ArrayBuffer[FieldDescription]()
            println(s"-------Find reg at address: 0x${addr.toHexString}----------")
          }
          (4 until row.getLastCellNum by 5).foreach { i =>
            val sectionStr          = row.getCell(i).getStringCellValue
            val fieldName           = row.getCell(i + 1).getStringCellValue
            val rw                  = row.getCell(i + 2).getStringCellValue
            val resetValueStr       = row.getCell(i + 3).getStringCellValue
            val fieldDescriptionStr = row.getCell(i + 4).getStringCellValue
            if (fieldName != "--") {
              println(sectionStr + " " + fieldName + " " + rw + " " + resetValueStr + " " + fieldDescriptionStr)
              val resetValue   = parse_verilog_num(resetValueStr)
              val (pos, width) = parse_verilog_section(sectionStr)
              val accessType = rw match {
                case "RW" => AccessType.RW
                case "RO" => AccessType.RO
                case _    => ???
              }
              val fieldDesc = FieldDescription(fieldName, width, pos, accessType, resetValue, fieldDescriptionStr)
              fieldDesDict(regNameHold).append(fieldDesc)
              println("")
            }
          }
        }
      }
      excelFile.close()
      //----------------------------------------生成结构体svh文件---------------------------------------------------------

      if (ROAsInput){
        // 根据寄存器字段的前缀对 RO 字段进行分组
        val groupedFields = fieldDesDict.values.flatten
          .filter(field => field.accessType == AccessType.RO) // 只筛选 RO 字段
          .toList
          .groupBy(field => field.fieldName.split("_")(0))
        val structBuilder = new StringBuilder
        // 生成独立结构体
        for ((moduleName, moduleFields) <- groupedFields) {
          structBuilder.append(s"typedef struct packed{\n")
          for (field <- moduleFields) {
            structBuilder.append(s"  logic [${field.width - 1}:0] ${field.fieldName}; // ${field.doc}\n")
          }
          structBuilder.append(s"} t_${moduleName}_dfx;\n\n")
        }

        // 生成大嵌套结构体
        structBuilder.append(s"typedef struct packed{\n")
        for (moduleName <- groupedFields.keys) {
          structBuilder.append(s"  t_${moduleName}_dfx ${moduleName};\n")
        }
        structBuilder.append(s"} ${fileName};\n")
        val writer = new PrintWriter(s"verilogGen/rdma/rdmaDfx/${fileName}.svh")
        writer.write(structBuilder.toString())
        writer.close()
      }
      //----------------------------------------生成寄存器RTL文件---------------------------------------------------------
      fieldDesDict.foreach { case (regName, fieldArr) =>
        while (fieldArr.nonEmpty) {
          val length    = fieldArr.length
          val fieldDesc = fieldArr.remove(length - 1)
          val reg_field = Bits(fieldDesc.width bits) setAsReg ()
          reg_field.setName(fieldDesc.fieldName)
          fieldDesc.accessType match {
            case AccessType.RW => {
              reg_field.setAsReg() init fieldDesc.resetValue
              regInstDict(regName).registerAtWithWriteLogic(fieldDesc.pos, reg_field, AccessType.RW, fieldDesc.resetValue, fieldDesc.doc)
            }
            case AccessType.RO => {
              reg_field.init(fieldDesc.resetValue)
              if (ROAsInput) {
                val reg_field_i = Bits(fieldDesc.width bits).setName(fieldDesc.fieldName + "_i") asInput ()
                reg_field := reg_field_i
              }
              regInstDict(regName).registerAtOnlyReadLogic(fieldDesc.pos, reg_field, AccessType.RO, fieldDesc.resetValue, fieldDesc.doc)
            }
            case _ => ???
          }
        }
        regInstDict.remove(regName)
      }

    }

  }
}
