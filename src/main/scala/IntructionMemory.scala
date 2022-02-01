import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile

class IntructionMemory(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val Algorithm = Input(UInt(5.W))
    val Step = Input(UInt(3.W))

    val ReadReg = Output(UInt(6.W))
    val WriteReg = Output(UInt(6.W))
    val IsOutput = Output(Bool())
  })

  val Mem = Mem(256, UInt(10.W))

  loadMemoryFromFile(Mem, "Algorithm.txt")

  val Data = Wire(0.U(UInt(10.W)))

  Data := Mem((io.Algorithm << 3).asUInt + io.Step)
  io.ReadReg := Data(0,5)
  io.WriteReg := Data(6,8)
  io.IsOutput := Data(9)
}