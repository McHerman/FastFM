import chisel3._
import chisel3.util._

class DSP(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val Input1 = Input(SInt(18.W))
    val Input2 = Input(SInt(18.W))
    val Op = Input(Bool())
    val Out = Output(SInt(36.W))
  })

  when(io.Op){
    io.Out := io.Input1 * io.Input2
  }.otherwise{
    io.Out := 0.S
  }

}

