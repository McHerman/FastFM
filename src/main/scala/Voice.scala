import chisel3._
import chisel3.util._

class Voice(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val WaveOut = Output(SInt(23.W))
    val Freq = Input(Vec(6, UInt(20.W)))
    val Amp = Input(Vec(6, UInt(20.W)))
    val Algorithm = Input(UInt(5.W))
  })

  val WaveReg = Vec(6, RegInit(0.S(20.W)))

  val OpCounter = RegInit(0.U(3.W))
  val ScaleReg = RegInit(0.U(2.W))

  val SineGenerator = Module(new SineGenerator(200000000))

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

  val IndexTemp = Wire(UInt(20.W))
  val OutputTemp = Wire(SInt(23.W))

  for(i <- 0 until 5){
    when(Mem.io.ReadReg(i)){
      IndexTemp := IndexTemp + WaveReg(i)
    }
  }

  when(IndexTemp > "hfffff".U){
    IndexTemp - "hfffff".U
  }

  SineGenerator.io.Index := IndexTemp
  SineGenerator.io.Amp := io.Amp(OpCounter)

  when(ScaleReg === 2.U){
    WaveReg(Mem.io.WriteReg) := SineGenerator.io.Wave_Out

    when(Mem.io.IsOutput){
      OutputTemp := OutputTemp + SineGenerator.io.Wave_Out
    }
  }

  when(OpCounter === 5.U){
    io.WaveOut := OutputTemp
    OutputTemp := 0.S
  }

}

