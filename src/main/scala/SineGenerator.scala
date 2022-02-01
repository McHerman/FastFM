import chisel3._
import chisel3.util._

class SineGenerator(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val Wave_Out = Output(SInt(20.W))
    val Amp = Input(UInt(18.W))
    val Index = Input(UInt(20.W))
  })

  val DSP = Module(new DSP(maxCount))

  val OpCounter = RegInit(0.U(1.W))

  OpCounter := OpCounter + 1.U

  when(OpCounter === 1.U){
    OpCounter := 0.U
  }

  val WaveReg = RegInit(0.U(18.W))
  val WaveReg2 = RegInit(0.S(20.W))
  val IndexAr = Wire(UInt(18.W))

  io.Wave_Out := WaveReg2

  val DSPOut = Wire(UInt(36.W))

  DSPOut := DSP.io.Out

  when(io.Index(18).asBool){
    IndexAr := io.Index(17,0)
  }.otherwise{
    IndexAr := "h3ffff".U - io.Index(17,0)
  }

  DSP.io.Input1 := Mux(OpCounter.asBool, WaveReg, IndexAr)
  DSP.io.Input2 := Mux(OpCounter.asBool, io.Amp, IndexAr)

  WaveReg := WaveReg

  when(OpCounter.asBool){
    when(io.Index(19).asBool){
      WaveReg2 := -DSPOut(35,17).zext
    }.otherwise{
      WaveReg2 := DSPOut(35,17).zext
    }
  }.otherwise{
    WaveReg := 262143.U - DSPOut(35,18)
  }
}


