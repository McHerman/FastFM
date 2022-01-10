import chisel3._
import chisel3.util._

class Synth(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val Out = Output(UInt(20.W))

    val SCL = Input(Bool())
    val SDA = Input(Bool())
  })

  val Com = Module(new Com(200000000))




}