import chisel3._
import chisel3.util._
import Envelope._

object Envelope{
  val Wait = 0.U
  val A = 1.U
  val D = 2.U
  val S = 3.U
  val R = 4.U
}

class Envelope extends Module {
  val io = IO(new Bundle {
    val A = Input(UInt(18.W))
    val D = Input(UInt(18.W))
    val S = Input(UInt(20.W))
    val R = Input(UInt(18.W))
    val Gate = Input(Bool())
    val Out = Output(UInt(20.W))
  })

  val EnvReg = RegInit(0.U(20.W))
  val StateReg = RegInit(0.U(3.W))

  switch(StateReg){
    is(Wait){
     when(io.Gate){
       StateReg := A
     }
    }
    is(A){
      EnvReg := EnvReg + io.A

      when(EnvReg === "hfffff".U){
        StateReg := D
      }
    }
    is(D){
      EnvReg := EnvReg - io.D

      when(io.S >= EnvReg){
        StateReg := S
      }
    }
    is(S){
      when(!io.Gate){
       StateReg := R
      }
    }
    is(R){
      EnvReg := EnvReg - io.R

      when(EnvReg === 0.U){
        StateReg := Wait
      }
    }
  }



}

