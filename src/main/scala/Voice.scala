import chisel3._
import chisel3.util._

class Voice(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val WaveOut = Output(SInt(23.W))
    val Freq = Input(Vec(6, UInt(20.W)))
    val Amp = Input(Vec(6, UInt(20.W)))
    val Algorithm = Input(UInt(5.W))
  })

  val WaveReg = Reg(Vec(6, SInt(20.W)))

  //val WaveReg = RegInit(Vec(6, 0.S(20.W)))

  val OpCounter = RegInit(0.U(3.W))
  val ScaleReg = RegInit(0.U(2.W))

  val SineGenerator = Module(new SineGenerator(200000000))

  val FreqReg = Reg(Vec(6, UInt(20.W)))
  val IndexReg = Reg(Vec(6, UInt(20.W)))

  val OutputReg = RegInit(0.S(23.W))

  for(i <- 0 until 6){
    FreqReg(i) := FreqReg(i) + 1.U

    when(FreqReg(i) === io.Freq(i)){
      FreqReg(i) := 0.U;
      IndexReg(i) := IndexReg(i) + 1.U
    }
  }

  ScaleReg := ScaleReg + 1.U

  when(ScaleReg === 2.U){
    OpCounter := OpCounter + 1.U
  }

  when(OpCounter === 6.U){
    OpCounter := 0.U
  }

  val Mem = Module(new IntructionMemory(200000000))

  Mem.io.Step := OpCounter
  Mem.io.Algorithm := io.Algorithm

  //val IndexTemp = Wire(SInt(21.W))
  val OutputTemp = Wire(SInt(23.W))
  val OutputTempReg = RegInit(0.S(23.W))

  OutputTemp := 0.S

  val IndexTemp = Wire(Vec(6, SInt(23.W)))

  for(i <- 0 until 6){
    when(Mem.io.ReadReg(i)){
      if(i == 0){
        IndexTemp(0) := WaveReg(0)
      }else{
        IndexTemp(i) := IndexTemp(i-1) + WaveReg(i)
      }
    }.otherwise{
      if(i == 0){
        IndexTemp(0) := 0.S
      }else{
        IndexTemp(i) := IndexTemp(i-1)
      }
    }
  }

  SineGenerator.io.Index := IndexTemp(5).asUInt
  SineGenerator.io.Amp := io.Amp(OpCounter)

  when(ScaleReg === 2.U){
    WaveReg(Mem.io.WriteReg - 1.U) := SineGenerator.io.WaveOut

    when(Mem.io.IsOutput){
      OutputTemp := OutputTempReg + SineGenerator.io.WaveOut
      OutputTempReg := OutputTemp
    }.otherwise{
      OutputTempReg := OutputTempReg
    }
  }

  when(OpCounter === 5.U){
    OutputReg := OutputTemp
    OutputTempReg := 0.S
    io.WaveOut := OutputTemp
  }

  io.WaveOut := OutputReg

}

