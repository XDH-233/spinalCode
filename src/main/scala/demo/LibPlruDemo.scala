package demo

import org.jfree.chart.plot.PlotOrientation
import org.jfree.chart.{ChartFactory, ChartPanel}
import org.jfree.data.category.DefaultCategoryDataset
import spinal.core._
import spinal.lib.{Delay, _}
import tool.PlruControl.plruControlFactory
import tool.{Access, PlruControlFactory}

import javax.swing._
import scala.collection.mutable
import scala.language.postfixOps
import scala.util.Random

case class LibPlruDemo(val entries: Int = 8, aging_cycle: Int = 20, with_rpl_blk: Boolean = false) extends Component {
  val io = new Bundle {
    val evict = new Bundle {
      val id: UInt = out UInt (log2Up(entries) bits)
    }
    val update: Stream[Access] = slave Stream (Access(entries))
  }
  noIoPrefix()

  val factory: PlruControlFactory = plruControlFactory.die_after(aging_cycle cycles)
  if (with_rpl_blk) {
    val rpl_end:       Flow[UInt] = Flow(UInt(log2Up(entries) bits))
    val flow_zeo:      Flow[UInt] = Flow(UInt(log2Up(entries) bits))
    val rpl_end_delay: Flow[UInt] = Delay(rpl_end, 50, init = flow_zeo)
    rpl_end.valid   := io.update.fire & ~io.update.hit_or_miss
    rpl_end.payload := io.evict.id
    flow_zeo.valid.clear()
    flow_zeo.payload.clearAll()
    factory.rpl_blk_release(rpl_end_delay)
  }
  factory.update_from(io.update)
  io.evict.id := factory.get_plru_entry
}

import spinal.core.sim._

object LibPlruDemoSim extends App {
  SimConfig.withVerilator.withWave
    .withConfig(
      SpinalConfig(
        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC, resetActiveLevel = HIGH),
        anonymSignalPrefix           = "tmp",
        nameWhenByFile               = false,
        withTimescale                = false
      )
    )
    .compile(new LibPlruDemo(64, 2500, with_rpl_blk = true))
    .doSim { dut =>
      import dut._
      val time_table = Array.fill(dut.entries)(-1L)
      io.update.valid #= false
      dut.clockDomain.forkStimulus(10)
      val startTime          = System.nanoTime()
      val hit_percent_buffer = mutable.Queue[Double]()
      val hit_rank_buffer    = mutable.Queue[Int]()
      (0 until 100000).foreach { i =>
        val time_now = System.nanoTime()
        if (i < dut.entries) {
          io.update.valid       #= true
          io.update.id          #= i
          io.update.hit_or_miss #= false
          clockDomain.waitSampling()
          time_table(i) = time_now - startTime
        } else {
          io.update.payload.randomize()
          io.update.valid #= true
          if (i           == entries) {
            io.update.hit_or_miss #= true
          } else { io.update.hit_or_miss #= Random.nextInt(100) < 60 }
          clockDomain.waitSampling()
          if (io.update.valid.toBoolean & io.update.ready.toBoolean) {
            val plru_entry  = io.evict.id.toInt
            val update_id   = io.update.id.toInt
            val minId       = time_table.zipWithIndex.minBy(_._1)._2
            val plru_value  = time_table(plru_entry)
            val plru_idx    = time_table.sorted.indexOf(plru_value)
            val hit_percent = (dut.entries.toDouble - plru_idx.toDouble) / dut.entries
            hit_percent_buffer.enqueue(hit_percent)
            hit_rank_buffer.enqueue(plru_idx)
//            println("-" * 20)
//            println(hit_percent)
//            println(s"prlu_entry: $plru_entry")
//            println(s"plru_rank:  $plru_idx")
//            println(s"lru_entry:  $minId")
            val hit = io.update.hit_or_miss.toBoolean
            if (hit) {
//              println("hit")
//              println(s"update:     $update_id")
              time_table(update_id) = time_now - startTime
            } else {
//              println("miss")
//              println(s"update:     $plru_entry")
              time_table(plru_entry) = time_now - startTime
//              assert(plru_idx != dut.entries - 1, "Replace the newest cache line!!!")
            }
          }
        }

      }
      val average: Double = hit_percent_buffer.sum / hit_percent_buffer.size
      val min_hit_percent = hit_percent_buffer.min
      val countMap        = hit_rank_buffer.groupBy(identity).map { case (key, values) => (key, values.size) }

      // 输出结果
      countMap.toSeq.sortBy(_._1).foreach { case (key, count) => println(s"$key: $count") }

      println(s"Replacement Efficiency: $average")
      println(s"Worse Replace         : $min_hit_percent")
      val sortedCounts = countMap.toSeq.sortBy(_._1)
      // 创建数据集
      val dataset = new DefaultCategoryDataset()
      sortedCounts.foreach { case (key, count) =>
        dataset.addValue(count, "Occurrences", key)
      }

      // 创建柱状图
      val chart = ChartFactory.createBarChart(
        "Value Occurrences", // 图表标题
        "Value", // X 轴标签
        "Occurrences", // Y 轴标签
        dataset, // 数据集
        PlotOrientation.VERTICAL,
        true, // 是否显示图例
        true, // 是否生成提示工具
        false // 是否生成 URL 链接
      )
      io.update.valid #= false
      dut.clockDomain.waitSampling(10000)
//     创建并显示图表面板
      val chartPanel = new ChartPanel(chart)
      val frame      = new JFrame("Bar Chart Example")
      frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
      frame.add(chartPanel)
      frame.pack()
      frame.setVisible(true)
    }
}
