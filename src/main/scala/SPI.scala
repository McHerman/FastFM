import chisel3._
import chisel3.util._

class Com(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val SCL = Input(Bool())
    val SDA = Input(Bool())
    val BitCnt = Input(UInt(8.W))
    val Data = Output(UInt(20.W))
    val Valid = Output(Bool())

  })


  val CntReg = RegInit(0.U(8.W))

  val Data = ShiftRegister(io.SDA, 20 ,ClockReg)
  val ClockReg = RegInit(false.B(Bool()))

  // OpCounter logic

  when(io.SCL =/= ClockReg){
    ClockReg := io.SCL
    CntReg := CntReg + 1.U
  }

  when(CntReg === io.BitCnt){

  }

}
