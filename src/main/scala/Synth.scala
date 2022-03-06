import chisel3._
import chisel3.util._

class Synth(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val Out = Output(UInt(20.W))

    //val SCL = Input(Bool())
    //val SDA = Input(Bool())
  })

  //val Com = Module(new Com(200000000))

  val Voice0 = Module(new Voice)

  //Voice0.io.Mod := Com.io.Mod
  io.Out := Voice0.io.WaveOut.asUInt

  //Com.io.SDA := io.SDA
  //Com.io.SCL := io.SCL
  
  for(i <- 0 until 6){
    Voice0.io.Freq(i) := (i+1).U
  }
  for(i <- 0 until 6){
    Voice0.io.Amp(i) := "hfffff".U
  }

  Voice0.io.Algorithm := 1.U

}
// generate Verilog
object Synth extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Synth(100000000))
}

