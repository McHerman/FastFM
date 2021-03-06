import chisel3._
import chisel3.util._

class SineGenerator extends Module {
  val io = IO(new Bundle {
    val WaveOut = Output(SInt(20.W))
    val Amp = Input(UInt(18.W))
    val Index = Input(UInt(20.W))
    val OutputValid = Output(Bool())
  })

  val DSP = Module(new DSP)

  val OpCounter = RegInit(0.U(1.W))

  OpCounter := OpCounter + 1.U

  when(OpCounter === 1.U){
    OpCounter := 0.U
  }

  val WaveReg = RegInit(0.U(18.W))
  val WaveReg2 = RegInit(0.S(20.W))
  val IndexAr = Wire(UInt(18.W))

  io.WaveOut := WaveReg2

  val DSPOut = Wire(UInt(36.W))

  DSPOut := DSP.io.Out

  when(io.Index(18).asBool){
    IndexAr := io.Index(17,0)
  }.otherwise{
    IndexAr := "h3ffff".U - io.Index(17,0)
  }

  DSP.io.Input1 := Mux(OpCounter.asBool, WaveReg, IndexAr)
  DSP.io.Input2 := Mux(OpCounter.asBool, io.Amp, IndexAr)

  when(OpCounter.asBool){
    when(io.Index(19).asBool){
      io.WaveOut := -DSPOut(35,17).zext
      WaveReg2 := -DSPOut(35,17).zext
    }.otherwise{
      io.WaveOut := DSPOut(35,17).zext
      WaveReg2 := DSPOut(35,17).zext
    }

    io.OutputValid := true.B
  }.otherwise{
    WaveReg := 262143.U - DSPOut(35,18)

    io.OutputValid := false.B
  }
}


