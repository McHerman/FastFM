import chisel3._
import chisel3.util._

class Voice(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val Wave_Out = Output(SInt(18.W))

    val Mod = Input(UInt(17.W))
  })

  val DSP = Module(new DSP(maxCount))

  val Index = RegInit(0.U(18.W))

  Index := Index + 1.U

  when(Index === 262144.U){
    Index := 0.U
  }

  val OpCounter = RegInit(0.U(1.W))

  OpCounter := OpCounter + 1.U

  when(OpCounter === 1.U){
    OpCounter := 0.U
  }

  val WaveReg = RegInit(0.S(18.W))
  val IndexReg = RegInit(0.U(18.W))
  val WaveReg2 = RegInit(0.S(18.W))

  io.Wave_Out := WaveReg2

  val DSPOut = Wire(SInt(18.W))

  DSPOut := DSP.io.Out

  DSP.io.Input1 := Mux(OpCounter.asBool, (IndexReg(16,0) - "h3fff".U).asSInt, WaveReg)
  DSP.io.Input2 := Mux(OpCounter.asBool, (IndexReg(16,0) - "h3fff".U).asSInt, io.Mod.asSInt)

  when(OpCounter.asBool){
    WaveReg2 := DSPOut(35,18).asSInt
  }.otherwise{
    WaveReg := (DSPOut - 17179869184L.S)(35,18).asSInt
  }

}