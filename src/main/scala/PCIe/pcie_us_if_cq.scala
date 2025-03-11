package PCIe

import spinal.core._
import spinal.lib.bus.amba4.axis.Axi4Stream
import spinal.lib._
import tool.BusExt.AXI4SExt

import scala.language.postfixOps

case class pcie_us_if_cq(pcieUsConfig: PcieUsConfig) extends Component {
  import PcieUsConfig._
  import pcieUsConfig._
  val io = new Bundle {
    val s_axis_cq: Stream[Axi4StreamXilinx] = slave Stream (Axi4StreamXilinx(axisPcieDataWidth, cqUsrWidth))
    val rx_req_tlp: Vec[Stream[TlpIf]] = Vec.fill(tlpSegCount)(master Stream (TlpIf(rxReqTlpCfg)))
  }
  noIoPrefix()

  val tlp_hdr:         Vec[TlpHeader] = Vec.fill(intTlpSegCount)(TlpHeader())
  val tlp_bar_id:      Vec[UInt]      = Vec.fill(intTlpSegCount)(UInt(3 bits))
  val tlp_func_num:    Vec[UInt]      = Vec.fill(intTlpSegCount)(UInt(8 bits))
  val cq_data:         Bits           = io.s_axis_cq.tdata
  val axis_cq_users:   Vec[CqUser]    = Vec.fill(intTlpSegCount)(CqUser())
  val cq_data_int_reg: Bits           = RegNextWhen(io.s_axis_cq.tdata, io.s_axis_cq.fire)
  val cq_data_full:    Bits           = cq_data ## cq_data_int_reg
  val cq_strb:         Bits           = Bits(tlpStrbWidth bits)
  val cq_strb_reg:     Bits           = RegNextWhen(cq_strb, io.s_axis_cq.fire)
  val cq_strb_full:    Vec[Bits]      = Vec(cq_strb, cq_strb_reg)
  val valid:           Bool           = Bool()
  val cq_strb_sop:     Vec[Bool]      = Vec.fill(tlpStrbWidth)(Bool())
  val cq_strb_eop:     Vec[Bool]      = Vec.fill(tlpStrbWidth)(Bool())
  val cq_sop:          Vec[Bool]      = Vec.fill(intTlpSegCount)(Bool())
  val cq_eop:          Vec[Bool]      = Vec.fill(intTlpSegCount)(Bool())
  val cq_eop_int_reg:  Vec[Bool]      = RegNextWhen(cq_eop, io.s_axis_cq.fire)
  val cq_sop_int_reg:  Vec[Bool]      = RegNextWhen(cq_sop, io.s_axis_cq.fire)
  val cq_valid:        Bits           = Bits(intTlpSegCount bits)

  val rx_req_tlp_valid_reg = Bits(intTlpSegCount bits)

  val push = Vec.fill(tlpSegCount)(Stream(TlpIf(rxReqTlpCfg)))

  val paser_header = for (seg <- 0 until intTlpSegCount) yield new Area {
    val cq_data_fmt        = ReqType()
    val axis_cq_tlp_desctr = AxisCqDescriptor()
    cq_data_fmt.assignFromBits(cq_data_full(intTlpSegDataWidth * seg + 75, 4 bits))
    axis_cq_tlp_desctr.assignFromBits(cq_data_full(intTlpSegDataWidth * seg, 128 bits))
    switch(cq_data_fmt) {
      is(ReqType.REQ_MEM_READ) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW
        tlp_hdr(seg).type_ := 0
      }
      is(ReqType.REQ_MEM_WRITE) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW_DATA
        tlp_hdr(seg).type_ := 0
      }
      is(ReqType.REQ_IO_READ) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW
        tlp_hdr(seg).type_ := 2
      }
      is(ReqType.REQ_IO_WRITE) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW_DATA
        tlp_hdr(seg).type_ := 2
      }
      is(ReqType.REQ_MEM_FETCH_ADD) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW
        tlp_hdr(seg).type_ := 12
      }
      is(ReqType.REQ_MEM_SWAP) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW_DATA
        tlp_hdr(seg).type_ := 13
      }
      is(ReqType.REQ_MEM_CAS) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW_DATA
        tlp_hdr(seg).type_ := 14
      }
      is(ReqType.REQ_MEM_READ_LOCKED) {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW
        tlp_hdr(seg).type_ := 1
      }
      is(ReqType.REQ_MSG) {
        when(axis_cq_tlp_desctr.dword_count.orR) {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW_DATA
        } otherwise {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW
        }
        tlp_hdr(seg).type_ := B(2, 2 bits) ## axis_cq_tlp_desctr.bar_id.asBits
      }
      is(ReqType.REQ_MSG_VENDOR) {
        when(axis_cq_tlp_desctr.dword_count.orR) {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW_DATA
        } otherwise {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW
        }
        tlp_hdr(seg).type_ := B(2, 2 bits) ## axis_cq_tlp_desctr.bar_id.asBits
      }
      is(ReqType.REQ_MSG_ATS) {
        when(axis_cq_tlp_desctr.dword_count.orR) {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW_DATA
        } otherwise {
          tlp_hdr(seg).fmt := TlpFmt.FMT_4DW
        }
        tlp_hdr(seg).type_ := B(2, 2 bits) ## axis_cq_tlp_desctr.bar_id.asBits
      }
      default {
        tlp_hdr(seg).fmt   := TlpFmt.FMT_4DW
        tlp_hdr(seg).type_ := 0
      }
    }
    tlp_hdr(seg).rsv0        := 0
    tlp_hdr(seg).tc          := axis_cq_tlp_desctr.tc
    tlp_hdr(seg).rsv1        := 0
    tlp_hdr(seg).attr_h      := axis_cq_tlp_desctr.attr(2).asBits
    tlp_hdr(seg).rsv2        := 0
    tlp_hdr(seg).th          := 0
    tlp_hdr(seg).td          := 0
    tlp_hdr(seg).ep          := 0
    tlp_hdr(seg).attr_l      := axis_cq_tlp_desctr.attr(1 downto 0)
    tlp_hdr(seg).at          := axis_cq_tlp_desctr.address_type
    tlp_hdr(seg).length      := axis_cq_tlp_desctr.dword_count.resized
    tlp_hdr(seg).last_dw_be  := axis_cq_users(seg).first_be(7 downto 4)
    tlp_hdr(seg).first_dw_be := axis_cq_users(seg).first_be(3 downto 0)
    tlp_hdr(seg).address     := axis_cq_tlp_desctr.address
    tlp_hdr(seg).ph          := 0

    tlp_bar_id(seg)   := axis_cq_tlp_desctr.bar_id
    tlp_func_num(seg) := axis_cq_tlp_desctr.target_function
  }

  axis_cq_users(0).assignFromBits(io.s_axis_cq.tuser)
  axis_cq_users(1).assignFromBits(RegNextWhen(io.s_axis_cq.tuser, io.s_axis_cq.fire))

  if (tlpDataWidth == 64) {} else {
    cq_strb_sop.foreach(_ := False)
    cq_strb_eop.foreach(_ := False)
    val greater_64 = for (seg <- 0 until intTlpSegCount) yield new Area {
      push(seg).data := (cq_data_full >> (128 + seg * intTlpSegDataWidth)).resized
      when(cq_sop_int_reg(seg)) {
        push(seg).hdr      := tlp_hdr(seg)
        push(seg).bar_id   := tlp_bar_id(seg)
        push(seg).func_num := tlp_func_num(seg)
      }
      when(axis_cq_users(0).is_sop(seg)) {
        cq_strb_sop(axis_cq_users(0).is_sop_ptr(seg) << 2) := True
      }
      when(axis_cq_users(0).is_eop(seg)) {
        cq_strb_eop(axis_cq_users(0).is_eop_ptr(seg)) := True
      }
      push(seg).sop := cq_sop_int_reg(seg)
      when(cq_eop_int_reg(seg)) {
        push(seg).strb := cq_strb_full(seg) >> 4
        when(cq_sop_int_reg(seg) || (cq_strb_full(seg) >> 4).orR) {
          push(seg).eop   := True
          push(seg).valid := True
        }
      } otherwise {
        push(seg).strb := cq_strb_full(seg) >> (4 + intTlpSegStrbWidth * seg)
      }
    }
    cq_sop.zip(cq_strb_sop.grouped(tlpStrbWidth / 2).toList).foreach { case (c, s) => c := Vec(s).asBits.orR }
    valid := cq_strb_sop.asBits.orR

    cq_eop.zip(cq_strb_eop.grouped(tlpStrbWidth / 2).toList).foreach { case (c, s) => c := Vec(s).asBits.orR }
    cq_strb  := B(tlpStrbWidth bits, default -> valid)
    cq_valid := 0
    when(valid) {
      cq_valid := B(intTlpSegCount bits, default -> valid)
    }
  }

  // TODO
  io.s_axis_cq.ready.set()
  io.rx_req_tlp.foreach { t =>
    t.valid.clear()
    t.payload.clearAll()
  }
  rx_req_tlp_valid_reg := 0

  // name style
  io.s_axis_cq.payload.setPartialName("")
  io.s_axis_cq.valid.setPartialName("tvalid")
  io.s_axis_cq.ready.setPartialName("tready")
  io.rx_req_tlp.foreach(_.payload.setPartialName(""))
  clockDomain.reset.setName("rst")

}
