import chisel3._
import chisel3.util._


class Com(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val SCL = Input(Bool())
    val SDA = Input(Bool())

  })

  // 6 * Amp / 20-bit 
  // 6 * Freq / 20-bit
  // n * Gate / 1-Bit
  // 1 * Algorithm / 5 Bit

  val OpCounter = RegInit(0.U(16.W))
  val ScaleReg = RegInit(0.U(3.W))
  val BitReg = RegInit(0.U(5.W))

  val Data = ShiftRegister(io.SDA, 20 ,ClockReg)
  val Algorithm = ShiftRegister(io.SDA, 20 ,ClockReg)
  val GateReg = RegInit(false.B(Bool()))

  val ClockReg = RegInit(false.B(Bool()))

  val FreqReg = Reg(Vec(6, UInt(20.W)))
  val AmpReg = Reg(Vec(6, UInt(20.W)))

  // OpCounter logic

  switch(OpCounter){
    is(0.U){
      when(io.SCL =/= ClockReg){
        ClockReg := io.SCL
        BitReg := BitReg + 1.U
      }

      when(BitReg === 19.U){
        FreqReg(ScaleReg) := Data

        when(ScaleReg =/= 5.U){
          ScaleReg := ScaleReg + 1.U
        }.otherwise{
          ScaleReg := 0.U
          OpCounter := OpCounter + 1.U
          BitReg := 0.U
        }
      }
    }
    is(1.U){
      when(io.SCL =/= ClockReg){
        ClockReg := io.SCL
        BitReg := BitReg + 1.U
      }

      when(BitReg === 19.U){
        AmpReg(ScaleReg) := Data

        when(ScaleReg =/= 5.U){
          ScaleReg := ScaleReg + 1.U
        }.otherwise{
          ScaleReg := 0.U
          OpCounter := OpCounter + 1.U
          BitReg := 0.U
        }
      }
    }
    is(2.U){
      when(io.SCL =/= ClockReg){
        ClockReg := io.SCL
        GateReg := io.SDA
        OpCounter := OpCounter + 1.U
      }
    }
    is(3.U){
      when(io.SCL =/= ClockReg){
        ClockReg := io.SCL
        BitReg := BitReg + 1.U
      }

      when(BitReg === 4.U){
        AmpReg(ScaleReg) := Data

        when(ScaleReg =/= 0.U){
          ScaleReg := ScaleReg + 1.U
        }.otherwise{
          ScaleReg := 0.U
          OpCounter := 1.U
          BitReg := 0.U
        }
      }
    }
  }
}
