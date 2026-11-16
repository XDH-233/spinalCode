import spinal.core._

val id_num    = 1024*32
val level_num = (log2Up(id_num) + 1) / 2
val tree = (0 until level_num).map { l =>
  var level_node_num = 0
  if (l == 0) {
    if (id_num >= 4) {
      level_node_num = 4
    } else {
      level_node_num = id_num
    }
  } else {
    val tmp = 1 << (2 * l + 1)
    if (tmp == id_num) {
      level_node_num = tmp
    } else {
      level_node_num = tmp * 2
    }
  }
  level_node_num
}.toArray
