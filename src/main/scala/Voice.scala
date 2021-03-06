import chisel3._
import chisel3.util._

class Voice extends Module {
  val io = IO(new Bundle {
    val WaveOut = Output(SInt(23.W))
    val Freq = Input(Vec(6, UInt(20.W)))
    val Amp = Input(Vec(6, UInt(20.W)))
    val Algorithm = Input(UInt(5.W))
  })

  val SineGenerator = Module(new SineGenerator)

  val WaveReg = Reg(Vec(6, SInt(20.W)))

  val OpCounter = RegInit(0.U(3.W))
  val ScaleReg = RegInit(0.U(2.W))

  val FreqReg = Reg(Vec(6, UInt(20.W)))
  val IndexReg = Reg(Vec(6, UInt(20.W)))

  val OutputTempReg = RegInit(0.S(23.W))

  val OutputReg = RegInit(0.S(23.W))

  val IndexTemp = Wire(SInt(23.W))

  // Frequency counter

  for(i <- 0 until 6){
    FreqReg(i) := FreqReg(i) + 1.U

    when(FreqReg(i) === io.Freq(i)){
      FreqReg(i) := 0.U;
      IndexReg(i) := IndexReg(i) + 1.U
    }
  }

  // Opcounter logic

  ScaleReg := ScaleReg + 1.U

  when(ScaleReg === 1.U){
    when(OpCounter =/= 5.U){
      OpCounter := OpCounter + 1.U
    }.otherwise{
      OpCounter := 0.U
    }
    ScaleReg := 0.U
  }

  // Instruction logic
  // Initializes instruction memory and routes signals

  val Mem = Module(new IntructionMemory)

  Mem.io.Step := OpCounter
  Mem.io.Algorithm := io.Algorithm

  // Index logic

  IndexTemp := Mux(Mem.io.ReadReg(0).asBool, WaveReg(0), 0.S) + Mux(Mem.io.ReadReg(1).asBool, WaveReg(1), 0.S) + Mux(Mem.io.ReadReg(2).asBool, WaveReg(2), 0.S) + Mux(Mem.io.ReadReg(3).asBool, WaveReg(3), 0.S) + Mux(Mem.io.ReadReg(4).asBool, WaveReg(4), 0.S) + Mux(Mem.io.ReadReg(5).asBool, WaveReg(5), 0.S)

  SineGenerator.io.Index := IndexTemp.asUInt + IndexReg(OpCounter)
  SineGenerator.io.Amp := io.Amp(OpCounter)

  // Output Logic

  when(SineGenerator.io.OutputValid){
    WaveReg(Mem.io.WriteReg - 1.U) := SineGenerator.io.WaveOut

    when(Mem.io.IsOutput){
      OutputTempReg := OutputTempReg + SineGenerator.io.WaveOut

      when(OpCounter === 5.U && ScaleReg === 1.U){
        OutputTempReg := 0.S
        OutputReg := OutputTempReg + SineGenerator.io.WaveOut
      }
    }
  }

  io.WaveOut := OutputReg

}
