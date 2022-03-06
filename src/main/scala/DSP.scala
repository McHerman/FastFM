import chisel3._
import chisel3.util._

class DSP extends Module {
  val io = IO(new Bundle {
    val Input1 = Input(UInt(18.W))
    val Input2 = Input(UInt(18.W))
    val Out = Output(UInt(36.W))
  })

  io.Out := io.Input1 * io.Input2

}

