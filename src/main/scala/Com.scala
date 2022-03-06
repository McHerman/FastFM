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

  val SPI = Module(new SPI)

  SPI.io.SCL := io.SCL
  SPI.io.SDA := io.SDA

  val OpCounter = RegInit(0.U(2.W))
  val ScaleReg = RegInit(0.U(3.W))

  val AmpReg = Reg(Vec(6,UInt(20.W)))
  val TestReg = RegInit(0.U(20.W))
  val FreqReg = Reg(Vec(6,UInt(20.W)))
  val GateReg = RegInit(0.U(1.W))
  val AlgoReg = RegInit(0.U(5.W))

  SPI.io.BitCnt := 0.U

  switch(OpCounter){
    is(0.U){
      SPI.io.BitCnt := 20.U

      when(SPI.io.Valid && ScaleReg <= 5.U){
        TestReg := SPI.io.Data

        ScaleReg := ScaleReg + 1.U

        when(ScaleReg === 5.U){
          ScaleReg := 0.U
          OpCounter := OpCounter + 1.U
        }
      }
    }
    is(1.U){
      SPI.io.BitCnt := 20.U

      when(SPI.io.Valid && ScaleReg <= 5.U){
        FreqReg(ScaleReg) := SPI.io.Data
        ScaleReg := ScaleReg + 1.U

        when(ScaleReg === 5.U){
          ScaleReg := 0.U
          OpCounter := OpCounter + 1.U
        }
      }
    }
    is(2.U){
      SPI.io.BitCnt := 1.U

      when(SPI.io.Valid){
        GateReg := SPI.io.Data(0)
        OpCounter := OpCounter + 1.U
      }

    }
    is(3.U){
      SPI.io.BitCnt := 5.U

      when(SPI.io.Valid){
        AlgoReg := SPI.io.Data(4,0)
        OpCounter := 0.U
      }
    }
  }
}
