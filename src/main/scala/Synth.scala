import chisel3._
import chisel3.util._

class Synth(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val Out = Output(UInt(20.W))

    val SCL = Input(Bool())
    val SDA = Input(Bool())
  })

  val Com = Module(new Com(200000000))

  val Voice0 = Module(new Voice(maxCount))

  Voice0.io.Mod := "h3ffff".U
  io.Out := Voice0.io.Wave_Out.asUInt

  Com.io.SDA := io.SDA
  Com.io.SCL := io.SCL

}
// generate Verilog
object Synth extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Synth(100000))
}

