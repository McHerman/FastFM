circuit Synth :
  module Com :
    input clock : Clock
    input reset : Reset
    output io : { flip SCL : UInt<1>, flip SDA : UInt<1>}

    skip

  module DSP :
    input clock : Clock
    input reset : Reset
    output io : { flip Input1 : UInt<18>, flip Input2 : UInt<18>, Out : UInt<36>}

    node _io_Out_T = mul(io.Input1, io.Input2) @[DSP.scala 11:23]
    io.Out <= _io_Out_T @[DSP.scala 11:10]

  module SineGenerator :
    input clock : Clock
    input reset : Reset
    output io : { WaveOut : SInt<20>, flip Amp : UInt<18>, flip Index : UInt<20>}

    inst DSP of DSP @[SineGenerator.scala 11:19]
    DSP.clock <= clock
    DSP.reset <= reset
    reg OpCounter : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[SineGenerator.scala 13:26]
    node _OpCounter_T = add(OpCounter, UInt<1>("h1")) @[SineGenerator.scala 15:26]
    node _OpCounter_T_1 = tail(_OpCounter_T, 1) @[SineGenerator.scala 15:26]
    OpCounter <= _OpCounter_T_1 @[SineGenerator.scala 15:13]
    node _T = eq(OpCounter, UInt<1>("h1")) @[SineGenerator.scala 17:18]
    when _T : @[SineGenerator.scala 17:26]
      OpCounter <= UInt<1>("h0") @[SineGenerator.scala 18:15]
    reg WaveReg : UInt<18>, clock with :
      reset => (reset, UInt<18>("h0")) @[SineGenerator.scala 21:24]
    reg WaveReg2 : SInt<20>, clock with :
      reset => (reset, asSInt(UInt<20>("h0"))) @[SineGenerator.scala 22:25]
    wire IndexAr : UInt<18> @[SineGenerator.scala 23:21]
    io.WaveOut <= WaveReg2 @[SineGenerator.scala 25:14]
    wire DSPOut : UInt<36> @[SineGenerator.scala 27:20]
    DSPOut <= DSP.io.Out @[SineGenerator.scala 29:10]
    node _T_1 = bits(io.Index, 18, 18) @[SineGenerator.scala 31:16]
    node _T_2 = bits(_T_1, 0, 0) @[SineGenerator.scala 31:21]
    when _T_2 : @[SineGenerator.scala 31:28]
      node _IndexAr_T = bits(io.Index, 17, 0) @[SineGenerator.scala 32:24]
      IndexAr <= _IndexAr_T @[SineGenerator.scala 32:13]
    else :
      node _IndexAr_T_1 = bits(io.Index, 17, 0) @[SineGenerator.scala 34:37]
      node _IndexAr_T_2 = sub(UInt<18>("h3ffff"), _IndexAr_T_1) @[SineGenerator.scala 34:27]
      node _IndexAr_T_3 = tail(_IndexAr_T_2, 1) @[SineGenerator.scala 34:27]
      IndexAr <= _IndexAr_T_3 @[SineGenerator.scala 34:13]
    node _DSP_io_Input1_T = bits(OpCounter, 0, 0) @[SineGenerator.scala 37:34]
    node _DSP_io_Input1_T_1 = mux(_DSP_io_Input1_T, WaveReg, IndexAr) @[SineGenerator.scala 37:23]
    DSP.io.Input1 <= _DSP_io_Input1_T_1 @[SineGenerator.scala 37:17]
    node _DSP_io_Input2_T = bits(OpCounter, 0, 0) @[SineGenerator.scala 38:34]
    node _DSP_io_Input2_T_1 = mux(_DSP_io_Input2_T, io.Amp, IndexAr) @[SineGenerator.scala 38:23]
    DSP.io.Input2 <= _DSP_io_Input2_T_1 @[SineGenerator.scala 38:17]
    WaveReg <= WaveReg @[SineGenerator.scala 40:11]
    node _T_3 = bits(OpCounter, 0, 0) @[SineGenerator.scala 42:18]
    when _T_3 : @[SineGenerator.scala 42:25]
      node _T_4 = bits(io.Index, 19, 19) @[SineGenerator.scala 43:18]
      node _T_5 = bits(_T_4, 0, 0) @[SineGenerator.scala 43:23]
      when _T_5 : @[SineGenerator.scala 43:30]
        node _WaveReg2_T = bits(DSPOut, 35, 17) @[SineGenerator.scala 44:26]
        node _WaveReg2_T_1 = cvt(_WaveReg2_T) @[SineGenerator.scala 44:34]
        node _WaveReg2_T_2 = sub(asSInt(UInt<1>("h0")), _WaveReg2_T_1) @[SineGenerator.scala 44:19]
        node _WaveReg2_T_3 = tail(_WaveReg2_T_2, 1) @[SineGenerator.scala 44:19]
        node _WaveReg2_T_4 = asSInt(_WaveReg2_T_3) @[SineGenerator.scala 44:19]
        WaveReg2 <= _WaveReg2_T_4 @[SineGenerator.scala 44:16]
      else :
        node _WaveReg2_T_5 = bits(DSPOut, 35, 17) @[SineGenerator.scala 46:25]
        node _WaveReg2_T_6 = cvt(_WaveReg2_T_5) @[SineGenerator.scala 46:33]
        WaveReg2 <= _WaveReg2_T_6 @[SineGenerator.scala 46:16]
    else :
      node _WaveReg_T = bits(DSPOut, 35, 18) @[SineGenerator.scala 49:33]
      node _WaveReg_T_1 = sub(UInt<18>("h3ffff"), _WaveReg_T) @[SineGenerator.scala 49:25]
      node _WaveReg_T_2 = tail(_WaveReg_T_1, 1) @[SineGenerator.scala 49:25]
      WaveReg <= _WaveReg_T_2 @[SineGenerator.scala 49:13]

  module IntructionMemory :
    input clock : Clock
    input reset : Reset
    output io : { flip Algorithm : UInt<5>, flip Step : UInt<3>, ReadReg : UInt<6>, WriteReg : UInt<3>, IsOutput : UInt<1>}

    smem Mem : UInt<10> [256] @[IntructionMemory.scala 15:24]
    wire Data : UInt<10> @[IntructionMemory.scala 19:18]
    Data <= UInt<1>("h0") @[IntructionMemory.scala 20:8]
    node _Data_T = shl(io.Algorithm, 3) @[IntructionMemory.scala 22:29]
    node _Data_T_1 = add(_Data_T, io.Step) @[IntructionMemory.scala 22:42]
    node _Data_T_2 = tail(_Data_T_1, 1) @[IntructionMemory.scala 22:42]
    infer mport Data_MPORT = Mem[_Data_T_2], clock @[IntructionMemory.scala 22:14]
    Data <= Data_MPORT @[IntructionMemory.scala 22:8]
    node _io_ReadReg_T = bits(Data, 5, 0) @[IntructionMemory.scala 23:21]
    io.ReadReg <= _io_ReadReg_T @[IntructionMemory.scala 23:14]
    node _io_WriteReg_T = bits(Data, 8, 6) @[IntructionMemory.scala 24:22]
    io.WriteReg <= _io_WriteReg_T @[IntructionMemory.scala 24:15]
    node _io_IsOutput_T = bits(Data, 9, 9) @[IntructionMemory.scala 25:22]
    node _io_IsOutput_T_1 = bits(_io_IsOutput_T, 0, 0) @[IntructionMemory.scala 25:26]
    io.IsOutput <= _io_IsOutput_T_1 @[IntructionMemory.scala 25:15]

  module Voice :
    input clock : Clock
    input reset : Reset
    output io : { WaveOut : SInt<23>, flip Freq : UInt<20>[6], flip Amp : UInt<20>[6], flip Algorithm : UInt<5>}

    reg WaveReg : SInt<20>[6], clock with :
      reset => (UInt<1>("h0"), WaveReg) @[Voice.scala 12:20]
    reg OpCounter : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[Voice.scala 16:26]
    reg ScaleReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Voice.scala 17:25]
    inst SineGenerator of SineGenerator @[Voice.scala 19:29]
    SineGenerator.clock <= clock
    SineGenerator.reset <= reset
    reg FreqReg : UInt<20>[6], clock with :
      reset => (UInt<1>("h0"), FreqReg) @[Voice.scala 21:20]
    reg IndexReg : UInt<20>[6], clock with :
      reset => (UInt<1>("h0"), IndexReg) @[Voice.scala 22:21]
    reg OutputReg : SInt<23>, clock with :
      reset => (reset, asSInt(UInt<23>("h0"))) @[Voice.scala 24:26]
    node _FreqReg_0_T = add(FreqReg[0], UInt<1>("h1")) @[Voice.scala 27:30]
    node _FreqReg_0_T_1 = tail(_FreqReg_0_T, 1) @[Voice.scala 27:30]
    FreqReg[0] <= _FreqReg_0_T_1 @[Voice.scala 27:16]
    node _T = eq(FreqReg[0], io.Freq[0]) @[Voice.scala 29:21]
    when _T : @[Voice.scala 29:36]
      FreqReg[0] <= UInt<1>("h0") @[Voice.scala 30:18]
      node _IndexReg_0_T = add(IndexReg[0], UInt<1>("h1")) @[Voice.scala 31:34]
      node _IndexReg_0_T_1 = tail(_IndexReg_0_T, 1) @[Voice.scala 31:34]
      IndexReg[0] <= _IndexReg_0_T_1 @[Voice.scala 31:19]
    node _FreqReg_1_T = add(FreqReg[1], UInt<1>("h1")) @[Voice.scala 27:30]
    node _FreqReg_1_T_1 = tail(_FreqReg_1_T, 1) @[Voice.scala 27:30]
    FreqReg[1] <= _FreqReg_1_T_1 @[Voice.scala 27:16]
    node _T_1 = eq(FreqReg[1], io.Freq[1]) @[Voice.scala 29:21]
    when _T_1 : @[Voice.scala 29:36]
      FreqReg[1] <= UInt<1>("h0") @[Voice.scala 30:18]
      node _IndexReg_1_T = add(IndexReg[1], UInt<1>("h1")) @[Voice.scala 31:34]
      node _IndexReg_1_T_1 = tail(_IndexReg_1_T, 1) @[Voice.scala 31:34]
      IndexReg[1] <= _IndexReg_1_T_1 @[Voice.scala 31:19]
    node _FreqReg_2_T = add(FreqReg[2], UInt<1>("h1")) @[Voice.scala 27:30]
    node _FreqReg_2_T_1 = tail(_FreqReg_2_T, 1) @[Voice.scala 27:30]
    FreqReg[2] <= _FreqReg_2_T_1 @[Voice.scala 27:16]
    node _T_2 = eq(FreqReg[2], io.Freq[2]) @[Voice.scala 29:21]
    when _T_2 : @[Voice.scala 29:36]
      FreqReg[2] <= UInt<1>("h0") @[Voice.scala 30:18]
      node _IndexReg_2_T = add(IndexReg[2], UInt<1>("h1")) @[Voice.scala 31:34]
      node _IndexReg_2_T_1 = tail(_IndexReg_2_T, 1) @[Voice.scala 31:34]
      IndexReg[2] <= _IndexReg_2_T_1 @[Voice.scala 31:19]
    node _FreqReg_3_T = add(FreqReg[3], UInt<1>("h1")) @[Voice.scala 27:30]
    node _FreqReg_3_T_1 = tail(_FreqReg_3_T, 1) @[Voice.scala 27:30]
    FreqReg[3] <= _FreqReg_3_T_1 @[Voice.scala 27:16]
    node _T_3 = eq(FreqReg[3], io.Freq[3]) @[Voice.scala 29:21]
    when _T_3 : @[Voice.scala 29:36]
      FreqReg[3] <= UInt<1>("h0") @[Voice.scala 30:18]
      node _IndexReg_3_T = add(IndexReg[3], UInt<1>("h1")) @[Voice.scala 31:34]
      node _IndexReg_3_T_1 = tail(_IndexReg_3_T, 1) @[Voice.scala 31:34]
      IndexReg[3] <= _IndexReg_3_T_1 @[Voice.scala 31:19]
    node _FreqReg_4_T = add(FreqReg[4], UInt<1>("h1")) @[Voice.scala 27:30]
    node _FreqReg_4_T_1 = tail(_FreqReg_4_T, 1) @[Voice.scala 27:30]
    FreqReg[4] <= _FreqReg_4_T_1 @[Voice.scala 27:16]
    node _T_4 = eq(FreqReg[4], io.Freq[4]) @[Voice.scala 29:21]
    when _T_4 : @[Voice.scala 29:36]
      FreqReg[4] <= UInt<1>("h0") @[Voice.scala 30:18]
      node _IndexReg_4_T = add(IndexReg[4], UInt<1>("h1")) @[Voice.scala 31:34]
      node _IndexReg_4_T_1 = tail(_IndexReg_4_T, 1) @[Voice.scala 31:34]
      IndexReg[4] <= _IndexReg_4_T_1 @[Voice.scala 31:19]
    node _FreqReg_5_T = add(FreqReg[5], UInt<1>("h1")) @[Voice.scala 27:30]
    node _FreqReg_5_T_1 = tail(_FreqReg_5_T, 1) @[Voice.scala 27:30]
    FreqReg[5] <= _FreqReg_5_T_1 @[Voice.scala 27:16]
    node _T_5 = eq(FreqReg[5], io.Freq[5]) @[Voice.scala 29:21]
    when _T_5 : @[Voice.scala 29:36]
      FreqReg[5] <= UInt<1>("h0") @[Voice.scala 30:18]
      node _IndexReg_5_T = add(IndexReg[5], UInt<1>("h1")) @[Voice.scala 31:34]
      node _IndexReg_5_T_1 = tail(_IndexReg_5_T, 1) @[Voice.scala 31:34]
      IndexReg[5] <= _IndexReg_5_T_1 @[Voice.scala 31:19]
    node _ScaleReg_T = add(ScaleReg, UInt<1>("h1")) @[Voice.scala 35:24]
    node _ScaleReg_T_1 = tail(_ScaleReg_T, 1) @[Voice.scala 35:24]
    ScaleReg <= _ScaleReg_T_1 @[Voice.scala 35:12]
    node _T_6 = eq(ScaleReg, UInt<2>("h2")) @[Voice.scala 37:17]
    when _T_6 : @[Voice.scala 37:25]
      node _OpCounter_T = add(OpCounter, UInt<1>("h1")) @[Voice.scala 38:28]
      node _OpCounter_T_1 = tail(_OpCounter_T, 1) @[Voice.scala 38:28]
      OpCounter <= _OpCounter_T_1 @[Voice.scala 38:15]
    node _T_7 = eq(OpCounter, UInt<3>("h6")) @[Voice.scala 41:18]
    when _T_7 : @[Voice.scala 41:26]
      OpCounter <= UInt<1>("h0") @[Voice.scala 42:15]
    inst Mem of IntructionMemory @[Voice.scala 45:19]
    Mem.clock <= clock
    Mem.reset <= reset
    Mem.io.Step <= OpCounter @[Voice.scala 47:15]
    Mem.io.Algorithm <= io.Algorithm @[Voice.scala 48:20]
    wire OutputTemp : SInt<23> @[Voice.scala 51:24]
    reg OutputTempReg : SInt<23>, clock with :
      reset => (reset, asSInt(UInt<23>("h0"))) @[Voice.scala 52:30]
    OutputTemp <= asSInt(UInt<1>("h0")) @[Voice.scala 54:14]
    wire IndexTemp : SInt<23>[6] @[Voice.scala 56:23]
    node _T_8 = bits(Mem.io.ReadReg, 0, 0) @[Voice.scala 59:24]
    when _T_8 : @[Voice.scala 59:28]
      IndexTemp[0] <= WaveReg[0] @[Voice.scala 61:22]
    else :
      IndexTemp[0] <= asSInt(UInt<1>("h0")) @[Voice.scala 67:22]
    node _T_9 = bits(Mem.io.ReadReg, 1, 1) @[Voice.scala 59:24]
    when _T_9 : @[Voice.scala 59:28]
      node _IndexTemp_1_T = add(IndexTemp[0], WaveReg[1]) @[Voice.scala 63:40]
      node _IndexTemp_1_T_1 = tail(_IndexTemp_1_T, 1) @[Voice.scala 63:40]
      node _IndexTemp_1_T_2 = asSInt(_IndexTemp_1_T_1) @[Voice.scala 63:40]
      IndexTemp[1] <= _IndexTemp_1_T_2 @[Voice.scala 63:22]
    else :
      IndexTemp[1] <= IndexTemp[0] @[Voice.scala 69:22]
    node _T_10 = bits(Mem.io.ReadReg, 2, 2) @[Voice.scala 59:24]
    when _T_10 : @[Voice.scala 59:28]
      node _IndexTemp_2_T = add(IndexTemp[1], WaveReg[2]) @[Voice.scala 63:40]
      node _IndexTemp_2_T_1 = tail(_IndexTemp_2_T, 1) @[Voice.scala 63:40]
      node _IndexTemp_2_T_2 = asSInt(_IndexTemp_2_T_1) @[Voice.scala 63:40]
      IndexTemp[2] <= _IndexTemp_2_T_2 @[Voice.scala 63:22]
    else :
      IndexTemp[2] <= IndexTemp[1] @[Voice.scala 69:22]
    node _T_11 = bits(Mem.io.ReadReg, 3, 3) @[Voice.scala 59:24]
    when _T_11 : @[Voice.scala 59:28]
      node _IndexTemp_3_T = add(IndexTemp[2], WaveReg[3]) @[Voice.scala 63:40]
      node _IndexTemp_3_T_1 = tail(_IndexTemp_3_T, 1) @[Voice.scala 63:40]
      node _IndexTemp_3_T_2 = asSInt(_IndexTemp_3_T_1) @[Voice.scala 63:40]
      IndexTemp[3] <= _IndexTemp_3_T_2 @[Voice.scala 63:22]
    else :
      IndexTemp[3] <= IndexTemp[2] @[Voice.scala 69:22]
    node _T_12 = bits(Mem.io.ReadReg, 4, 4) @[Voice.scala 59:24]
    when _T_12 : @[Voice.scala 59:28]
      node _IndexTemp_4_T = add(IndexTemp[3], WaveReg[4]) @[Voice.scala 63:40]
      node _IndexTemp_4_T_1 = tail(_IndexTemp_4_T, 1) @[Voice.scala 63:40]
      node _IndexTemp_4_T_2 = asSInt(_IndexTemp_4_T_1) @[Voice.scala 63:40]
      IndexTemp[4] <= _IndexTemp_4_T_2 @[Voice.scala 63:22]
    else :
      IndexTemp[4] <= IndexTemp[3] @[Voice.scala 69:22]
    node _T_13 = bits(Mem.io.ReadReg, 5, 5) @[Voice.scala 59:24]
    when _T_13 : @[Voice.scala 59:28]
      node _IndexTemp_5_T = add(IndexTemp[4], WaveReg[5]) @[Voice.scala 63:40]
      node _IndexTemp_5_T_1 = tail(_IndexTemp_5_T, 1) @[Voice.scala 63:40]
      node _IndexTemp_5_T_2 = asSInt(_IndexTemp_5_T_1) @[Voice.scala 63:40]
      IndexTemp[5] <= _IndexTemp_5_T_2 @[Voice.scala 63:22]
    else :
      IndexTemp[5] <= IndexTemp[4] @[Voice.scala 69:22]
    node _SineGenerator_io_Index_T = asUInt(IndexTemp[5]) @[Voice.scala 74:42]
    SineGenerator.io.Index <= _SineGenerator_io_Index_T @[Voice.scala 74:26]
    SineGenerator.io.Amp <= io.Amp[OpCounter] @[Voice.scala 75:24]
    node _T_14 = eq(ScaleReg, UInt<2>("h2")) @[Voice.scala 77:17]
    when _T_14 : @[Voice.scala 77:25]
      node _T_15 = sub(Mem.io.WriteReg, UInt<1>("h1")) @[Voice.scala 78:29]
      node _T_16 = tail(_T_15, 1) @[Voice.scala 78:29]
      WaveReg[_T_16] <= SineGenerator.io.WaveOut @[Voice.scala 78:36]
      when Mem.io.IsOutput : @[Voice.scala 80:26]
        node _OutputTemp_T = add(OutputTempReg, SineGenerator.io.WaveOut) @[Voice.scala 81:35]
        node _OutputTemp_T_1 = tail(_OutputTemp_T, 1) @[Voice.scala 81:35]
        node _OutputTemp_T_2 = asSInt(_OutputTemp_T_1) @[Voice.scala 81:35]
        OutputTemp <= _OutputTemp_T_2 @[Voice.scala 81:18]
        OutputTempReg <= OutputTemp @[Voice.scala 82:21]
      else :
        OutputTempReg <= OutputTempReg @[Voice.scala 84:21]
    node _T_17 = eq(OpCounter, UInt<3>("h5")) @[Voice.scala 88:18]
    when _T_17 : @[Voice.scala 88:26]
      OutputReg <= OutputTemp @[Voice.scala 89:15]
      OutputTempReg <= asSInt(UInt<1>("h0")) @[Voice.scala 90:19]
      io.WaveOut <= OutputTemp @[Voice.scala 91:16]
    io.WaveOut <= OutputReg @[Voice.scala 94:14]

  module Synth :
    input clock : Clock
    input reset : UInt<1>
    output io : { Out : UInt<20>, flip SCL : UInt<1>, flip SDA : UInt<1>}

    inst Com of Com @[Synth.scala 12:19]
    Com.clock <= clock
    Com.reset <= reset
    inst Voice0 of Voice @[Synth.scala 14:22]
    Voice0.clock <= clock
    Voice0.reset <= reset
    node _io_Out_T = asSInt(UInt<23>("h7fffff")) @[Synth.scala 17:46]
    node _io_Out_T_1 = add(Voice0.io.WaveOut, _io_Out_T) @[Synth.scala 17:32]
    node _io_Out_T_2 = tail(_io_Out_T_1, 1) @[Synth.scala 17:32]
    node _io_Out_T_3 = asSInt(_io_Out_T_2) @[Synth.scala 17:32]
    node _io_Out_T_4 = asUInt(_io_Out_T_3) @[Synth.scala 17:54]
    io.Out <= _io_Out_T_4 @[Synth.scala 17:10]
    Com.io.SDA <= io.SDA @[Synth.scala 19:14]
    Com.io.SCL <= io.SCL @[Synth.scala 20:14]
    Voice0.io.Freq[0] <= UInt<1>("h1") @[Synth.scala 22:21]
    Voice0.io.Freq[1] <= UInt<1>("h1") @[Synth.scala 23:21]
    Voice0.io.Freq[2] <= UInt<1>("h1") @[Synth.scala 24:21]
    Voice0.io.Freq[3] <= UInt<1>("h1") @[Synth.scala 25:21]
    Voice0.io.Freq[4] <= UInt<1>("h1") @[Synth.scala 26:21]
    Voice0.io.Freq[5] <= UInt<1>("h1") @[Synth.scala 27:21]
    Voice0.io.Amp[0] <= UInt<18>("h3ffff") @[Synth.scala 29:20]
    Voice0.io.Amp[1] <= UInt<18>("h3ffff") @[Synth.scala 30:20]
    Voice0.io.Amp[2] <= UInt<18>("h3ffff") @[Synth.scala 31:20]
    Voice0.io.Amp[3] <= UInt<18>("h3ffff") @[Synth.scala 32:20]
    Voice0.io.Amp[4] <= UInt<18>("h3ffff") @[Synth.scala 33:20]
    Voice0.io.Amp[5] <= UInt<18>("h3ffff") @[Synth.scala 34:20]
    Voice0.io.Algorithm <= UInt<1>("h0") @[Synth.scala 36:23]

