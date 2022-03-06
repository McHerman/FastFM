import chisel3._
import chisel3.util._

class SPI extends Module {
  val io = IO(new Bundle {
    val SCL = Input(Bool())
    val SDA = Input(Bool())
    val BitCnt = Input(UInt(5.W))
    val Data = Output(UInt(20.W))
    val Valid = Output(Bool())
  })

  val CntReg = RegInit(0.U(8.W))
  //val ClockReg = RegInit(false.B(Bool()))
  val ClockReg = RegInit(0.U(1.W))

  //val Data = ShiftRegister(io.SDA, 20 ,ClockReg.asBool)

  val DataOut = RegInit(0.U(20.W))

  io.Data := 0.U

  // OpCounter logic

  when(io.SCL =/= ClockReg){
    ClockReg := io.SCL
    CntReg := CntReg + 1.U
    DataOut := (DataOut << 1).asUInt + io.SDA.asUInt
  }

  io.Valid := false.B

  when(CntReg === io.BitCnt){
    io.Valid := true.B


    for(i <- 0 until 20){
      switch(io.BitCnt){
        is(i.U){
          io.Data := DataOut(i,0)
        }
      }
    }
  }
}
