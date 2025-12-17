package hash

import spinal.core._
import spinal.lib._

import scala.language.postfixOps

object MultiHashOutputStatus extends SpinalEnum {
  val SUCCESS, NON_EXIST, UNAVAILABLE, EXIST = newElement()
}

case class MultiHashOut(keyWidth: Int) extends Bundle {
  val key:    Bits                                        = Bits(keyWidth bits)
  val op:     SpinalEnumCraft[HashOperation.type]         = HashOperation()
  val status: SpinalEnumCraft[MultiHashOutputStatus.type] = MultiHashOutputStatus()
}

case class MultiHashTable(keyWidth: Int, hashValueWidth: Int, bucketDepth: Int) extends Component {
  val io = new Bundle {
    val key:        Flow[HashAccess]   = slave Flow (HashAccess(keyWidth))
    val access_out: Flow[MultiHashOut] = master Flow (MultiHashOut(keyWidth))
  }
  noIoPrefix()
  val crc_init_cdma:    Bits = B(0xff, hashValueWidth bits)
  val crc_poly_cdma:    Bits = B(0x9b, hashValueWidth bits)
  val hash_value_cdma:  Bits = Bits(hashValueWidth bits)
  val crc_init_hitag:   Bits = B(0xff, hashValueWidth bits)
  val crc_poly_hitag:   Bits = B(0x1d, hashValueWidth bits)
  val hash_value_hitag: Bits = Bits(hashValueWidth bits)

  val crc_cdma:  CRC = CRC(io.key.key, crc_poly_cdma, crc_init_cdma, hash_value_cdma)
  val crc_hitag: CRC = CRC(io.key.key, crc_poly_hitag, crc_init_hitag, hash_value_hitag)

  val key_d1:              Flow[HashAccess] = RegNext(io.key)
  val hash_value_cdma_d1:  Bits             = RegNext(hash_value_cdma)
  val hash_value_hitag_d1: Bits             = RegNext(hash_value_hitag)

  val table:             Mem[Bits] = Mem(Bits((keyWidth + 1) * bucketDepth bits), 1 << hashValueWidth)
  val table_rdout_cdma:  Bits      = table.readSync(hash_value_cdma.asUInt, io.key.valid)
  val table_rdout_hitag: Bits      = table.readSync(hash_value_hitag.asUInt, io.key.valid)

  val same_hash_value: Bool = io.key.valid && (hash_value_cdma === hash_value_hitag)

  val entrys_wr:       Vec[HashEntry] = Vec.fill(bucketDepth)(HashEntry(keyWidth))
  val entrys_wr_d1:    Vec[HashEntry] = RegNext(entrys_wr)
  val entrys_wr_en:    Bool           = Bool()
  val entrys_wr_en_d1: Bool           = RegNext(entrys_wr_en) init (False)
  val entrys_waddr:    UInt           = UInt(hashValueWidth bits)
  val entrys_waddr_d1: UInt           = RegNext(entrys_waddr)
  val hash_cdma_proc  = rdout_proc(table_rdout_cdma, entrys_wr_en_d1, entrys_waddr_d1, hash_value_cdma_d1)
  val hash_hitag_proc = rdout_proc(table_rdout_hitag, entrys_wr_en_d1, entrys_waddr_d1, hash_value_hitag_d1)
  val unavailable: Bool = hash_cdma_proc.unavailable & hash_hitag_proc.unavailable
  val exist:       Bool = hash_cdma_proc.exist | hash_hitag_proc.exist

  // table ram write back
  entrys_wr_en := False
  entrys_waddr := 0
  entrys_wr.foreach(e => e.assignFromBits(B(0, (keyWidth + 1) bits))) // default value
  switch(key_d1.op) {
    is(HashOperation.APPEND) {
      entrys_wr_en := ~unavailable & ~exist & key_d1.valid
      when(~hash_cdma_proc.unavailable) {
        entrys_waddr := hash_value_cdma_d1.asUInt
        entrys_wr.zip(hash_cdma_proc.avail_one_hot.asBools).zip(hash_cdma_proc.entrys_rdout).foreach { case ((w, i), r) =>
          when(i) {
            w.key   := key_d1.key
            w.valid := True
          } otherwise {
            w := r
          }
        }
      } elsewhen (~hash_hitag_proc.unavailable) {
        entrys_waddr := hash_value_hitag_d1.asUInt
        entrys_wr.zip(hash_hitag_proc.avail_one_hot.asBools).zip(hash_hitag_proc.entrys_rdout).foreach { case ((w, i), r) =>
          when(i) {
            w.key   := key_d1.key
            w.valid := True
          } otherwise {
            w := r
          }
        }
      }
    }
    is(HashOperation.DELETE) { // 如果一个key在两个hash值下都存在(存在重复append，则需要删除两个hash位置的对应key，如果要规避这种情况，则需要在append时判断key是否存在，如果存在则不append，否则append)
      entrys_wr_en := exist & key_d1.valid
      when(hash_cdma_proc.exist) {
        entrys_waddr := hash_value_cdma_d1.asUInt
        entrys_wr.zip(hash_cdma_proc.entrys_rdout).foreach { case (w, r) =>
          when(key_d1.key === r.key && r.valid) {
            w.key   := r.key
            w.valid := False
          } otherwise {
            w := r
          }
        }
      } elsewhen (hash_hitag_proc.exist) {
        entrys_waddr := hash_value_hitag_d1.asUInt
        entrys_wr.zip(hash_hitag_proc.entrys_rdout).foreach { case (w, r) =>
          when(key_d1.key === r.key && r.valid) {
            w.key   := r.key
            w.valid := False
          } otherwise {
            w := r
          }
        }
      }
    }
  }

  // output logic
  io.access_out.valid := key_d1.valid
  io.access_out.key   := key_d1.key
  io.access_out.op    := key_d1.op

  io.access_out.status := MultiHashOutputStatus.SUCCESS
  switch(key_d1.op) {
    is(HashOperation.APPEND) {
      when(exist) {
        io.access_out.status := MultiHashOutputStatus.EXIST
      } elsewhen (unavailable) {
        io.access_out.status := MultiHashOutputStatus.UNAVAILABLE
      }
    }

    is(HashOperation.DELETE) {
      when(~exist) {
        io.access_out.status := MultiHashOutputStatus.NON_EXIST
      }
    }

    is(HashOperation.QUERY) {
      when(~exist) {
        io.access_out.status := MultiHashOutputStatus.NON_EXIST
      }
    }
  }

  table.write(entrys_waddr, entrys_wr.asBits, entrys_wr_en & key_d1.valid)

  def rdout_proc(b: Bits, wr_en: Bool, wr_addr: UInt, hash_value: Bits) = new Area {
    val entrys_rdout:     Vec[HashEntry] = Vec.fill(bucketDepth)(HashEntry(keyWidth))
    val entry_vld_bitmap: Bits           = Vec(entrys_rdout.map(_.valid)).asBits
    val unavailable:      Bool           = entry_vld_bitmap.andR
    val bitmap_plus:      Bits           = (entry_vld_bitmap.asUInt + U(1)).asBits
    val avail_one_hot:    Bits           = (bitmap_plus ^ entry_vld_bitmap) & bitmap_plus
    val exist:            Bool           = Vec(entrys_rdout.map(e => e.valid & e.key === key_d1.key)).asBits.orR
    when(wr_en & key_d1.valid & wr_addr === hash_value.asUInt) {
      entrys_rdout := entrys_wr_d1
    } otherwise {
      entrys_rdout.zip(b.subdivideIn(keyWidth + 1 bits)).foreach { case (l, r) => l.assignFromBits(r) }
    }
  }
}

object MultiHashTableRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(MultiHashTable(64, 8, 8))
}
