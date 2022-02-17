import chisel3._
import chisel3.util._


class Com(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val SCL = Input(Bool())
    val SDA = Input(Bool())

  })

  // 6 * Amp / 20-bit
  // 6 * Freq / 20-bit
  // 1 * Gate / 1-Bit
  // 1 * Algorithm / 5 Bit

  val OpCounter = RegInit(0.U(16.W))
  val ScaleReg = RegInit(0.U(5.W))

  // OpCounter logic

  ScaleReg := ScaleReg + 1.U

  when(ScaleReg === 19.U){
    when(OpCounter =/= 19.U){ // Arbitrary width
      OpCounter := OpCounter + 1.U
    }.otherwise{
      OpCounter := 0.U
    }
    ScaleReg := 0.U
  }

  val Data = ShiftRegister(io.SDA, 20 ,ClockReg)

  val ClockReg = RegInit(false.B(Bool()))

  when(io.SCL =/= ClockReg){
    ClockReg := io.SCL
  }


}
