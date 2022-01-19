import chisel3._
import chisel3.util._


class Com(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val SCL = Input(Bool())
    val SDA = Input(Bool())

    /*

    val VoiceFreq = Output(Vec(12, UInt(18.W)))
    val VoiceGate = Output(Vec(12, Bool()))

    val OpAmp = Output(Vec(5, UInt(18.W)))

    val OpFreq = Output(Vec(6, UInt(18.W)))

    val Envelopes = Output(Vec(6, Vec(5, UInt(18.W))))

    val Algorithm = Output(UInt(5.W))

    */

    val Mod = Output(UInt(18.W))

  })

  io.Mod := ShiftRegister(io.SDA, 18)

}
