import chisel3._
import chisel3.util._

class Synth(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val Out = Output(UInt(20.W))

    val SCL = Input(Bool())
    val SDA = Input(Bool())

    val WaveReg = Output(UInt(19.W))
  })

  val Com = Module(new Com(200000000))

  val Voice0 = Module(new Voice(maxCount))

  //Voice0.io.Mod := Com.io.Mod
  io.Out := (Voice0.io.WaveOut + "h7ffff".U.asSInt).asUInt

  Com.io.SDA := io.SDA
  Com.io.SCL := io.SCL

}
// generate Verilog
object Synth extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Synth(200000000))
}

