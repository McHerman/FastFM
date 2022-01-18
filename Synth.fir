circuit Synth :
  module Com :
    input clock : Clock
    input reset : Reset
    output io : { flip SCL : UInt<1>, flip SDA : UInt<1>}

    skip

  module DSP :
    input clock : Clock
    input reset : Reset
    output io : { flip Input1 : SInt<18>, flip Input2 : SInt<18>, flip Op : UInt<1>, Out : SInt<36>}

    when io.Op : @[DSP.scala 12:14]
      node _io_Out_T = mul(io.Input1, io.Input2) @[DSP.scala 13:25]
      io.Out <= _io_Out_T @[DSP.scala 13:12]
    else :
      io.Out <= asSInt(UInt<1>("h0")) @[DSP.scala 15:12]

  module Voice :
    input clock : Clock
    input reset : Reset
    output io : { Wave_Out : SInt<18>, flip Mod : UInt<18>}

    inst DSP of DSP @[Voice.scala 11:19]
    DSP.clock <= clock
    DSP.reset <= reset
    reg Index : UInt<18>, clock with :
      reset => (reset, UInt<18>("h0")) @[Voice.scala 13:22]
    node _Index_T = add(Index, UInt<1>("h1")) @[Voice.scala 15:18]
    node _Index_T_1 = tail(_Index_T, 1) @[Voice.scala 15:18]
    Index <= _Index_T_1 @[Voice.scala 15:9]
    node _T = eq(Index, UInt<19>("h40000")) @[Voice.scala 17:14]
    when _T : @[Voice.scala 17:27]
      Index <= UInt<1>("h0") @[Voice.scala 18:11]
    reg OpCounter : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[Voice.scala 21:26]
    node _OpCounter_T = add(OpCounter, UInt<1>("h1")) @[Voice.scala 23:26]
    node _OpCounter_T_1 = tail(_OpCounter_T, 1) @[Voice.scala 23:26]
    OpCounter <= _OpCounter_T_1 @[Voice.scala 23:13]
    node _T_1 = eq(OpCounter, UInt<3>("h5")) @[Voice.scala 25:18]
    when _T_1 : @[Voice.scala 25:26]
      OpCounter <= UInt<1>("h0") @[Voice.scala 26:15]
    reg WaveReg : SInt<19>, clock with :
      reset => (reset, asSInt(UInt<19>("h0"))) @[Voice.scala 29:24]
    reg IndexReg : UInt<18>, clock with :
      reset => (reset, UInt<18>("h0")) @[Voice.scala 31:25]
    reg WaveReg2 : SInt<18>, clock with :
      reset => (reset, asSInt(UInt<18>("h0"))) @[Voice.scala 33:25]
    io.Wave_Out <= WaveReg2 @[Voice.scala 35:15]
    wire Input1 : SInt<18> @[Voice.scala 37:20]
    wire Input2 : SInt<18> @[Voice.scala 38:20]
    wire DSPOut : SInt<36> @[Voice.scala 39:20]
    DSP.io.Input1 <= Input1 @[Voice.scala 41:17]
    DSP.io.Input2 <= Input2 @[Voice.scala 42:17]
    DSPOut <= DSP.io.Out @[Voice.scala 43:10]
    Input1 <= asSInt(UInt<1>("h0")) @[Voice.scala 45:10]
    Input2 <= asSInt(UInt<1>("h0")) @[Voice.scala 46:10]
    DSP.io.Op <= UInt<1>("h0") @[Voice.scala 48:13]
    node _T_2 = eq(UInt<1>("h0"), OpCounter) @[Voice.scala 50:20]
    when _T_2 : @[Voice.scala 50:20]
      IndexReg <= Index @[Voice.scala 52:16]
      node _Input1_T = bits(IndexReg, 16, 0) @[Voice.scala 53:26]
      node _Input1_T_1 = sub(_Input1_T, UInt<14>("h3fff")) @[Voice.scala 53:33]
      node _Input1_T_2 = tail(_Input1_T_1, 1) @[Voice.scala 53:33]
      node _Input1_T_3 = asSInt(_Input1_T_2) @[Voice.scala 53:46]
      Input1 <= _Input1_T_3 @[Voice.scala 53:14]
      node _Input2_T = bits(IndexReg, 16, 0) @[Voice.scala 54:26]
      node _Input2_T_1 = sub(_Input2_T, UInt<14>("h3fff")) @[Voice.scala 54:33]
      node _Input2_T_2 = tail(_Input2_T_1, 1) @[Voice.scala 54:33]
      node _Input2_T_3 = asSInt(_Input2_T_2) @[Voice.scala 54:46]
      Input2 <= _Input2_T_3 @[Voice.scala 54:14]
      DSP.io.Op <= UInt<1>("h1") @[Voice.scala 55:17]
    else :
      node _T_3 = eq(UInt<1>("h1"), OpCounter) @[Voice.scala 50:20]
      when _T_3 : @[Voice.scala 50:20]
        DSP.io.Op <= UInt<1>("h1") @[Voice.scala 58:17]
      else :
        node _T_4 = eq(UInt<2>("h2"), OpCounter) @[Voice.scala 50:20]
        when _T_4 : @[Voice.scala 50:20]
          node _WaveReg_T = add(DSPOut, asSInt(UInt<36>("h400000000"))) @[Voice.scala 61:26]
          node _WaveReg_T_1 = tail(_WaveReg_T, 1) @[Voice.scala 61:26]
          node _WaveReg_T_2 = asSInt(_WaveReg_T_1) @[Voice.scala 61:26]
          node _WaveReg_T_3 = bits(_WaveReg_T_2, 35, 17) @[Voice.scala 61:43]
          node _WaveReg_T_4 = asSInt(_WaveReg_T_3) @[Voice.scala 61:51]
          WaveReg <= _WaveReg_T_4 @[Voice.scala 61:15]
          DSP.io.Op <= UInt<1>("h1") @[Voice.scala 62:17]
        else :
          node _T_5 = eq(UInt<2>("h3"), OpCounter) @[Voice.scala 50:20]
          when _T_5 : @[Voice.scala 50:20]
            Input1 <= WaveReg @[Voice.scala 65:14]
            node _Input2_T_4 = asSInt(io.Mod) @[Voice.scala 66:24]
            Input2 <= _Input2_T_4 @[Voice.scala 66:14]
            DSP.io.Op <= UInt<1>("h1") @[Voice.scala 67:17]
          else :
            node _T_6 = eq(UInt<3>("h4"), OpCounter) @[Voice.scala 50:20]
            when _T_6 : @[Voice.scala 50:20]
              DSP.io.Op <= UInt<1>("h1") @[Voice.scala 70:17]
            else :
              node _T_7 = eq(UInt<3>("h5"), OpCounter) @[Voice.scala 50:20]
              when _T_7 : @[Voice.scala 50:20]
                node _WaveReg2_T = bits(DSPOut, 35, 17) @[Voice.scala 73:25]
                node _WaveReg2_T_1 = asSInt(_WaveReg2_T) @[Voice.scala 73:33]
                WaveReg2 <= _WaveReg2_T_1 @[Voice.scala 73:16]
                DSP.io.Op <= UInt<1>("h1") @[Voice.scala 74:17]

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
    Voice0.io.Mod <= UInt<18>("h3ffff") @[Synth.scala 16:17]
    node _io_Out_T = asUInt(Voice0.io.Wave_Out) @[Synth.scala 17:32]
    io.Out <= _io_Out_T @[Synth.scala 17:10]
    Com.io.SDA <= io.SDA @[Synth.scala 19:14]
    Com.io.SCL <= io.SCL @[Synth.scala 20:14]

