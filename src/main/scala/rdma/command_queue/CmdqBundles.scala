package rdma.command_queue

import spinal.core._
import spinal.lib.bus.avalon.AvalonSTConfig

import scala.language.postfixOps
import scala.util.Random

case class CmdReqSdb() extends Bundle {
  val cmd_id:  UInt = UInt(8 bits)
  val opcode:  Bits = Bits(12 bits)
  val blk_num: UInt = UInt(5 bits)
}

case class CmdRspSdb() extends Bundle {
  val cmd_id:   UInt = UInt(8 bits)
  val opcode:   Bits = Bits(12 bits)
  val blk_num:  UInt = UInt(5 bits)
  val data_len: UInt = UInt(10 bits)
}

case class DMARReqDesc() extends Bundle {
  val addr:            UInt = UInt(64 bits) //
  val length:          UInt = UInt(17 bits)
  val queue_id:        Bits = Bits(6 bits)
  val vf_num:          Bits = Bits(11 bits)
  val vf_active:       Bool = Bool()
  val pf_num:          Bits = Bits(5 bits)
  val tag:             Bits = Bits(9 bits)
  val rdma_channel_id: Bits = Bits(5 bits)
  val at:              Bool = Bool()
  val attr:            Bool = Bool()
  val channel_id:      UInt = UInt(6 bits)
  val rsv0:            Bits = Bits(2 bits)
}

case class DMAWReqDesc() extends Bundle {
  val addr:           UInt = UInt(64 bits) //
  val length:         UInt = UInt(17 bits)
  val queue_id:       Bits = Bits(6 bits)
  val vf_active:      Bool = Bool()
  val vf_num:         Bits = Bits(11 bits)
  val pf_num:         Bits = Bits(5 bits)
  val desc_type:      Bits = Bits(5 bits)
  val rsv:            Bits = Bits(17 bits)
  val tlp_channel_id: Bits = Bits(2 bits)
}

object AvstConfig {
  val dmaRReqConfig: AvalonSTConfig = AvalonSTConfig(useChannels = true, channelWidth = 128, useData = false, dataWidth = 512)
  val dmaRRspWReqConfig: AvalonSTConfig =
    AvalonSTConfig(useChannels = true, channelWidth = 128, useData = true, dataWidth = 512, useSOP = true, useEOP = true, useEmpty = true, emptyWidth = 6)
  val cmdReqConfig: AvalonSTConfig =
    AvalonSTConfig(useChannels = true, channelWidth = 25, useData = true, dataWidth = 512, useSOP = true, useEOP = true, useEmpty = true, emptyWidth = 6)
  val qpCmdReqConfig: AvalonSTConfig =
    AvalonSTConfig(useChannels = true, channelWidth = 25, useData = true, dataWidth = 256, useSOP = true, useEOP = true, useEmpty = true, emptyWidth = 5)
  val cmdRspConfig: AvalonSTConfig =
    AvalonSTConfig(useChannels = true, channelWidth = 35, useData = true, dataWidth = 512, useSOP = true, useEOP = true, useEmpty = true, emptyWidth = 6)
  val qpCmdRspConfig: AvalonSTConfig =
    AvalonSTConfig(useChannels = true, channelWidth = 35, useData = true, dataWidth = 256, useSOP = true, useEOP = true, useEmpty = true, emptyWidth = 5)
  val cmdRspMbConfig: AvalonSTConfig =
    AvalonSTConfig(useData = true, dataWidth = 512, useSOP = true, useEOP = true, useEmpty = true, emptyWidth = 6)
}

object CmdOpcode extends Enumeration {
  val SET_ROCE_ADDRESS:   Value = Value(0x761)
  val QUERY_ROCE_ADDRESS: Value = Value(0x760)
  val CREATE_MKEY:        Value = Value(0x200)
  val DESTROY_MKEY:       Value = Value(0x202)
  val CREATE_EQ:          Value = Value(0x301)
  val DESTROY_EQ:         Value = Value(0x302)
  val CREATE_CQ:          Value = Value(0x400)
  val DESTROY_CQ:         Value = Value(0x401)
  val CREATE_QP:          Value = Value(0x500)
  val DESTROY_QP:         Value = Value(0x501)
  val RST2INIT_QP:        Value = Value(0x502)
  val INIT2RTR_QP:        Value = Value(0x503)
  val RTR2RTS_QP:         Value = Value(0x504)
  val TORST_QP:           Value = Value(0x50a)
  val QUERY_QP:           Value = Value(0x50b)

  def inputLen(opcode: CmdOpcode.Value): Int = {
    opcode match {
      case SET_ROCE_ADDRESS   => 0x30
      case QUERY_ROCE_ADDRESS => 0x10
      case CREATE_MKEY        => 0x50
      case DESTROY_MKEY       => 0x10
      case CREATE_EQ          => 0x78
      case DESTROY_EQ         => 0x10
      case CREATE_CQ          => 0x50
      case DESTROY_CQ         => 0x10
      case CREATE_QP          => 0xd8
      case DESTROY_QP         => 0x10
      case RST2INIT_QP        => 0xd8
      case INIT2RTR_QP        => 0xd8
      case RTR2RTS_QP         => 0xd8
      case TORST_QP           => 0x10
      case QUERY_QP           => 0x10
      case _                  => 0
    }
  }

  def outputLen(opcode: CmdOpcode.Value): Int = {
    opcode match {
      case SET_ROCE_ADDRESS   => 0x10
      case QUERY_ROCE_ADDRESS => 0x30
      case CREATE_MKEY        => 0x10
      case DESTROY_MKEY       => 0x10
      case CREATE_EQ          => 0x10
      case DESTROY_EQ         => 0x10
      case CREATE_CQ          => 0x10
      case DESTROY_CQ         => 0x10
      case CREATE_QP          => 0x10
      case DESTROY_QP         => 0x10
      case RST2INIT_QP        => 0x10
      case INIT2RTR_QP        => 0x10
      case RTR2RTS_QP         => 0x10
      case TORST_QP           => 0x10
      case QUERY_QP           => 0xd8
      case _                  => 0
    }
  }
  def randOpcode: Int = {
    val opcodes = CmdOpcode.values.toSeq
    val randIdx = Random.nextInt(opcodes.length)
    opcodes(randIdx).id
  }
}

case class CmdInputInlineData() extends Bundle {
  val uid:        Bits = Bits(16 bits)
  val opcode:     Bits = Bits(16 bits)
  val op_mod:     Bits = Bits(16 bits)
  val rsv:        Bits = Bits(16 bits)
  val inline_cmd: Bits = Bits(64 bits)
}

object CmdqEntryStatusValue {
  val ZJ_CMD_OP_SUCCESS         = 0
  val ZJ_CMD_OP_INPUT_LEN_ERR   = 7
  val ZJ_CMD_OP_OUTPUT_LEN_ERR  = 8
  val ZJ_CMD_OP_BAD_OPCODE_TYPE = 0xb
}

object CmdOutDataStatusValue {
  val ZJ_CMD_STAT_SUCCESS            = 0
  val ZJ_CMD_STAT_INTERNAL_ERR       = 1
  val ZJ_CMD_STAT_BAD_PARAM_ERR      = 2
  val ZJ_CMD_STAT_BAD_INPUT_LEN_ERR  = 3
  val ZJ_CMD_STAT_BAD_OUTPUT_LEN_ERR = 4
  val ZJ_CMD_STAT_NO_RESOURCES       = 5
  val ZJ_CMD_STAT_BAD_QP_STATE_ERR   = 6
  val ZJ_CMD_STAT_BAD_QP_TYPE_ERR    = 7
  val ZJ_CMD_STAT_BAD_INPUT_MAILBOX  = 8
}

case class CmdOutputInlineData() extends Bundle {
  val rsv:        Bits = Bits(24 bits) //
  val status:     Bits = Bits(8 bits)
  val syndrome:   Bits = Bits(32 bits)
  val cmd_output: Bits = Bits(64 bits)
}

case class CmdEntryIn() extends Bundle {
  val rsv3:                Bits               = Bits(24 bits) //
  val type_              : Bits               = Bits(8 bits)
  val input_len:           UInt               = UInt(32 bits)
  val input_mb_point_high: Bits               = Bits(32 bits)
  val rsv2:                Bits               = Bits(9 bits)
  val input_mb_point_low:  Bits               = Bits(23 bits)
  val input_inline_data:   CmdInputInlineData = CmdInputInlineData()
}

case class CmdEntryOut() extends Bundle {
  val output_inline_data:   CmdOutputInlineData = CmdOutputInlineData() //
  val output_mb_point_high: Bits                = Bits(32 bits)
  val rsv1:                 Bits                = Bits(9 bits)
  val output_mb_point_low:  Bits                = Bits(23 bits)
  val output_length:        UInt                = UInt(32 bits)
  val own:                  Bool                = Bool()
  val status:               Bits                = Bits(7 bits)
  val rsv0:                 Bits                = Bits(8 bits)
  val signature:            Bits                = Bits(8 bits)
  val token:                Bits                = Bits(8 bits)
}

case class CmdqEntry() extends Bundle {
  val cmd_entry_in:   CmdEntryIn  = CmdEntryIn()
  val cmd_entry_out:  CmdEntryOut = CmdEntryOut()
  def input_mb_addr:  UInt        = (cmd_entry_in.input_mb_point_high ## cmd_entry_in.input_mb_point_low ## B(0, 9 bits)).asUInt
  def output_mb_addr: UInt        = (cmd_entry_out.output_mb_point_high ## cmd_entry_out.output_mb_point_low ## B(0, 9 bits)).asUInt
}

case class ErrCmdqeDMAWReqPkt() extends Bundle {
  val desc:    DMAWReqDesc = DMAWReqDesc()
  val cmd_out: CmdEntryOut = CmdEntryOut()
}

case class CmdReqCMDQEElements() extends Bundle {
  val cmd_id:          UInt               = UInt(log2Up(32) bits)
  val input_len:       UInt               = UInt(8 bits)
  val cmd_inline_data: CmdInputInlineData = CmdInputInlineData()
}

case class CmdEntryOutStore() extends Bundle {
  val output_mb_point: UInt = UInt(64 bits)
  val output_length:   UInt = UInt(32 bits)
  val signature:       Bits = Bits(8 bits)
  val token:           Bits = Bits(8 bits)
}

case class CmdRspHeader() extends Bundle {
  val cmd_id:          UInt = UInt(5 bits)
  val opcode:          Bits = Bits(12 bits)
  val data_len:        UInt = UInt(10 bits)
  val out_inline_data: Bits = Bits(128 bits)
  val db_id:           UInt = UInt(5 bits)
  val out_mb_point:    UInt = UInt(64 bits)
}

object DMAFun {
  def db_id2cmdqe_phy_addr(db_id: UInt, cmdq_phy_addr: UInt): UInt = cmdq_phy_addr + (db_id << 6)

  def gen_dma_rreq(data_len: UInt, raddr: UInt, mb_or_not: Bool): DMARReqDesc = {
    val desc: DMARReqDesc = DMARReqDesc()
    desc.assignFromBits(B(0, desc.getBitsWidth bits))
    desc.allowOverride()
    desc.addr            := raddr
    desc.length          := data_len
    desc.rdma_channel_id := 9
    desc.channel_id      := 9
    desc.pf_num          := 6
    desc.tag             := mb_or_not.asBits.resized
    desc
  }

  def gen_dma_wreq(data_len: UInt, waddr: UInt): DMAWReqDesc = {
    val desc = DMAWReqDesc()
    desc.assignFromBits(B(0, desc.getBitsWidth bits))
    desc.allowOverride()
    desc.addr           := waddr
    desc.length         := data_len
    desc.tlp_channel_id := 2
    desc
  }
}
