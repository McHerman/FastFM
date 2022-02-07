import chisel3._
import chisel3.util._

class Synth(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val Out = Output(UInt(20.W))

    val SCL = Input(Bool())
    val SDA = Input(Bool())

    val AlgorithmTest0 = Output(UInt(6.W))
    val AlgorithmTest1 = Output(UInt(3.W))
    val AlgorithmTest2 = Output(UInt(1.W))
  })

  val Com = Module(new Com(200000000))

  val Voice0 = Module(new Voice(maxCount))

  //Voice0.io.Mod := Com.io.Mod
  io.Out := (Voice0.io.WaveOut + "h7fffff".U.asSInt).asUInt

  Com.io.SDA := io.SDA
  Com.io.SCL := io.SCL

  Voice0.io.Freq(0) := 1.U
  Voice0.io.Freq(1) := 1.U
  Voice0.io.Freq(2) := 1.U
  Voice0.io.Freq(3) := 1.U
  Voice0.io.Freq(4) := 1.U
  Voice0.io.Freq(5) := 1.U

  Voice0.io.Amp(0) := "h3ffff".U
  Voice0.io.Amp(1) := "h3ffff".U
  Voice0.io.Amp(2) := "h3ffff".U
  Voice0.io.Amp(3) := "h3ffff".U
  Voice0.io.Amp(4) := "h3ffff".U
  Voice0.io.Amp(5) := "h3ffff".U

  Voice0.io.Algorithm := 0.U

  io.AlgorithmTest0 := Voice0.io.AlgorithmTest0
  io.AlgorithmTest1 := Voice0.io.AlgorithmTest1
  io.AlgorithmTest2 := Voice0.io.AlgorithmTest2

}
// generate Verilog
object Synth extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Synth(200000000))
}

