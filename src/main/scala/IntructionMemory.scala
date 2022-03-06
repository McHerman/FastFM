import chisel3._
import chisel3.util._
//import chisel3.util.experimental.loadMemoryFromFile
import chisel3.util.experimental.loadMemoryFromFileInline

class IntructionMemory extends Module {
  val io = IO(new Bundle {
    val Algorithm = Input(UInt(5.W))
    val Step = Input(UInt(3.W))

    val ReadReg = Output(UInt(6.W))
    val WriteReg = Output(UInt(3.W))
    val IsOutput = Output(Bool())
  })

  /*

  val Mem1 = Mem(256, UInt(10.W))

  loadMemoryFromFileInline(Mem1, "C:\\Users\\Karl\\Desktop\\FPGA FM_SYNTH\\DSP_FPGA_SYNTH\\Algorithm.txt")

  */

  val Mem1 = VecInit("h180".U, "h160".U, "h110".U, "h2c8".U, "h82".U, "h242".U)

  val Data = Wire(UInt(10.W))
  Data := 0.U

  val Address = Wire(UInt(8.W))
  Address := (io.Algorithm << 3).asUInt + io.Step

  //Data := Mem1.read(Address)
  Data := Mem1(Address)

  io.ReadReg := Data(5,0)
  io.WriteReg := Data(8,6)
  io.IsOutput := Data(9).asBool
}