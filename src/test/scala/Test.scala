import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class Test extends AnyFlatSpec with ChiselScalatestTester {
  "Test " should "pass" in {
    test(new Synth(20)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.clock.step(200)
    }
  }
}
