import spinal.core._
import spinal.lib._

import scala.language.postfixOps

case class HashEntry(keyWidth: Int) extends Bundle {
  val valid: Bool = Bool()
  val key:   Bits = Bits(keyWidth bits)
}

object HashOperation extends SpinalEnum {
  val APPEND, DELETE, QUERY = newElement()
}

case class HashAccess(keyWidth: Int) extends Bundle {
  val key: Bits                                = Bits(keyWidth bits)
  val op:  SpinalEnumCraft[HashOperation.type] = HashOperation()
}

case class HashOut(keyWidth: Int) extends Bundle {
  val key:    Bits                                   = Bits(keyWidth bits)
  val op:     SpinalEnumCraft[HashOperation.type]    = HashOperation()
  val status: SpinalEnumCraft[HashOutputStatus.type] = HashOutputStatus()
}

object HashOutputStatus extends SpinalEnum {
  val SUCCESS, NON_EXIST, UNAVAILABLE = newElement()
}

case class HashTable(keyWidth: Int, hashValueWidth: Int, bucketDepth: Int, hashTableDepth: Int) extends Component {
  val io = new Bundle {
    val key:        Flow[HashAccess] = slave Flow (HashAccess(keyWidth))
    val access_out: Flow[HashOut]    = master Flow (HashOut(keyWidth))
  }

  noIoPrefix()

  val crc_init:   Bits = B(12, hashValueWidth bits)
  val crc_poly:   Bits = B(56, hashValueWidth bits)
  val hash_value: Bits = Bits(hashValueWidth bits)

  val crc: CRC = CRC(io.key.key, crc_poly, crc_init, hash_value)

  val table:       Mem[Bits] = Mem(Bits((keyWidth + 1) * bucketDepth bits), hashTableDepth)
  val table_rdout: Bits      = table.readSync(hash_value.asUInt, io.key.valid)

  val key_d1:          Flow[HashAccess] = RegNext(io.key)
  val hash_value_d1:   Bits             = RegNextWhen(hash_value, io.key.valid)
  val same_hash_value: Bool             = hash_value === hash_value_d1 && io.key.valid && key_d1.valid
  val use_wr:          Bool             = RegNext(same_hash_value) init False
  val entrys_rdout:    Vec[HashEntry]   = Vec.fill(bucketDepth)(HashEntry(keyWidth))

  val entry_vld_bitmap: Bits = Vec(entrys_rdout.map(_.valid)).asBits
  val unavailable:      Bool = entry_vld_bitmap.andR
  val bitmap_plus:      Bits = (entry_vld_bitmap.asUInt + U(1)).asBits
  val avail_one_hot:    Bits = (bitmap_plus ^ entry_vld_bitmap) & bitmap_plus

  val entrys_wr:    Vec[HashEntry] = Vec.fill(bucketDepth)(HashEntry(keyWidth))
  val entrys_wr_d1: Vec[HashEntry] = Vec.fill(bucketDepth)(HashEntry(keyWidth))

  entrys_wr_d1 := RegNext(entrys_wr)
  when(use_wr) {
    entrys_rdout := entrys_wr_d1
  } otherwise {
    entrys_rdout.zip(table_rdout.subdivideIn(keyWidth + 1 bits)).foreach { case (l, r) => l.assignFromBits(r) }
  }

  entrys_wr.zip(avail_one_hot.asBools).zip(entrys_rdout).foreach { case ((w, i), r) =>
    switch(key_d1.op) {
      is(HashOperation.APPEND) {
        when(i) {
          w.key   := key_d1.key
          w.valid := True
        } otherwise {
          w := r
        }
      }
      is(HashOperation.DELETE) {
        when(key_d1.key === r.key && r.valid) {
          w.key   := r.key
          w.valid := False
        } otherwise {
          w := r
        }
      }
      is(HashOperation.QUERY) {
        w := r
      }
    }

  }

  val exist: Bool = Vec(entrys_rdout.map(e => e.valid & e.key === key_d1.key)).asBits.orR

  io.access_out.valid := key_d1.valid
  io.access_out.key   := key_d1.key
  io.access_out.op    := key_d1.op

  switch(key_d1.op) {
    is(HashOperation.APPEND) {
      io.access_out.status := Mux(unavailable, HashOutputStatus.UNAVAILABLE, HashOutputStatus.SUCCESS)
    }
    is(HashOperation.DELETE) {
      io.access_out.status := Mux(exist, HashOutputStatus.SUCCESS, HashOutputStatus.NON_EXIST)
    }
    is(HashOperation.QUERY) {
      io.access_out.status := Mux(exist, HashOutputStatus.SUCCESS, HashOutputStatus.NON_EXIST)
    }
  }

  table.write(hash_value_d1.asUInt, entrys_wr.asBits, key_d1.valid)
}

object HashTableRTL extends App {
  tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(HashTable(64, 8, 8, 256))
}
