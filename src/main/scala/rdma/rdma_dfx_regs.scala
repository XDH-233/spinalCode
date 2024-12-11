package rdma
import spinal.core._
import spinal.lib._
import spinal.lib.bus.avalon._
import spinal.lib.bus.regif._
import tool.AvalonMMBusInterface
import tool.BusIfExt.BusIfExtCla
import scala.language.postfixOps


case class rdma_dfx_regs() extends Component {
  val avmmConfig: AvalonMMConfig = AvalonMMConfig(
    addressWidth     = 32,
    dataWidth        = 32,
    burstCountWidth  = 0,
    useByteEnable    = false,
    useDebugAccess   = false,
    useRead          = true,
    useWrite         = true,
    useResponse      = false,
    useLock          = false,
    useWaitRequestn  = true,
    useReadDataValid = true,
    useBurstCount    = false
  )

  val io = new Bundle {
    val dfx_avmm: AvalonMM = slave(AvalonMM(avmmConfig))
  }
  noIoPrefix()
  val avmm_bus_if = new AvalonMMBusInterface(io.dfx_avmm, (0x80000, 16 * 1024 Bytes))
  avmm_bus_if.setReservedAddressReadValue(BigInt("deaddead", 16))
  avmm_bus_if.parseFromXlsx("verilogGen/rdma/rdmaDfx/rdma_dfx_regs.xlsx")

  avmm_bus_if.accept(HtmlGenerator("RDMA DFX Regs", "Avalon MM regs csr"))

//  avmm_bus_if.accept(JsonGenerator("RDMA DFX Regs"))
//  avmm_bus_if.accept(SystemRdlGenerator("RDMA DFX Regs",""))
//  avmm_bus_if.accept(CHeaderGenerator("RDMA DFX Regs",""))
}
