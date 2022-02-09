
import chisel3._
//import chiseltest.iotesters.Driver
import chiseltest.iotesters.PeekPokeTester
import org.scalatest._
import org.scalatest.flatspec.AnyFlatSpec
import chiseltest._

class Test extends AnyFlatSpec with ChiselScalatestTester {
  "Test " should "pass" in {
    test(new Synth(20)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.clock.setTimeout(1000000)

      for(i <- 0 until 400000){
        dut.clock.step(1)
      }
    }
  }
}



