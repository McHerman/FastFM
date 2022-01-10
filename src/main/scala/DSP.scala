import chisel3._
import chisel3.util._

class DSP(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val Input1 = Input(UInt(16.W))
    val Input2 = Input(UInt(16.W))

    val Operation = Input(UInt(16.W))

    val Output = Output(UInt(16.W))
  })


}
