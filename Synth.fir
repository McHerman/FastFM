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

  module Voice :
    input clock : Clock
    input reset : Reset
    output io : { Wave_Out : SInt<19>, flip Mod : UInt<18>}

    inst DSP of DSP @[Voice.scala 85:19]
    DSP.clock <= clock
    DSP.reset <= reset
    reg Index : UInt<20>, clock with :
      reset => (reset, UInt<20>("h0")) @[Voice.scala 87:22]
    node _Index_T = add(Index, UInt<1>("h1")) @[Voice.scala 89:18]
    node _Index_T_1 = tail(_Index_T, 1) @[Voice.scala 89:18]
    Index <= _Index_T_1 @[Voice.scala 89:9]
    node _T = eq(Index, UInt<20>("hfffff")) @[Voice.scala 91:14]
    when _T : @[Voice.scala 91:29]
      Index <= UInt<1>("h0") @[Voice.scala 92:11]
    reg OpCounter : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Voice.scala 95:26]
    node _OpCounter_T = add(OpCounter, UInt<1>("h1")) @[Voice.scala 97:26]
    node _OpCounter_T_1 = tail(_OpCounter_T, 1) @[Voice.scala 97:26]
    OpCounter <= _OpCounter_T_1 @[Voice.scala 97:13]
    node _T_1 = eq(OpCounter, UInt<1>("h1")) @[Voice.scala 99:18]
    when _T_1 : @[Voice.scala 99:26]
      OpCounter <= UInt<1>("h0") @[Voice.scala 100:15]
    reg WaveReg : UInt<18>, clock with :
      reset => (reset, UInt<18>("h0")) @[Voice.scala 103:24]
    reg WaveReg2 : SInt<19>, clock with :
      reset => (reset, asSInt(UInt<19>("h0"))) @[Voice.scala 104:25]
    wire IndexAr : UInt<18> @[Voice.scala 105:21]
    io.Wave_Out <= WaveReg2 @[Voice.scala 107:15]
    wire DSPOut : UInt<36> @[Voice.scala 109:20]
    DSPOut <= DSP.io.Out @[Voice.scala 111:10]
    node _T_2 = bits(Index, 18, 18) @[Voice.scala 113:13]
    node _T_3 = bits(_T_2, 0, 0) @[Voice.scala 113:18]
    when _T_3 : @[Voice.scala 113:25]
      node _IndexAr_T = bits(Index, 17, 0) @[Voice.scala 114:21]
      IndexAr <= _IndexAr_T @[Voice.scala 114:13]
    else :
      node _IndexAr_T_1 = bits(Index, 17, 0) @[Voice.scala 116:34]
      node _IndexAr_T_2 = sub(UInt<18>("h3ffff"), _IndexAr_T_1) @[Voice.scala 116:27]
      node _IndexAr_T_3 = tail(_IndexAr_T_2, 1) @[Voice.scala 116:27]
      IndexAr <= _IndexAr_T_3 @[Voice.scala 116:13]
    node _DSP_io_Input1_T = bits(OpCounter, 0, 0) @[Voice.scala 119:34]
    node _DSP_io_Input1_T_1 = mux(_DSP_io_Input1_T, IndexAr, WaveReg) @[Voice.scala 119:23]
    DSP.io.Input1 <= _DSP_io_Input1_T_1 @[Voice.scala 119:17]
    node _DSP_io_Input2_T = bits(OpCounter, 0, 0) @[Voice.scala 120:34]
    node _DSP_io_Input2_T_1 = mux(_DSP_io_Input2_T, IndexAr, io.Mod) @[Voice.scala 120:23]
    DSP.io.Input2 <= _DSP_io_Input2_T_1 @[Voice.scala 120:17]
    node _T_4 = bits(OpCounter, 0, 0) @[Voice.scala 122:18]
    when _T_4 : @[Voice.scala 122:25]
      node _T_5 = bits(Index, 17, 17) @[Voice.scala 123:15]
      node _T_6 = bits(_T_5, 0, 0) @[Voice.scala 123:20]
      when _T_6 : @[Voice.scala 123:27]
        node _WaveReg2_T = bits(DSPOut, 35, 18) @[Voice.scala 124:25]
        node _WaveReg2_T_1 = asSInt(_WaveReg2_T) @[Voice.scala 124:33]
        WaveReg2 <= _WaveReg2_T_1 @[Voice.scala 124:16]
      else :
        node _WaveReg2_T_2 = bits(DSPOut, 35, 18) @[Voice.scala 126:26]
        node _WaveReg2_T_3 = asSInt(_WaveReg2_T_2) @[Voice.scala 126:34]
        node _WaveReg2_T_4 = sub(asSInt(UInt<1>("h0")), _WaveReg2_T_3) @[Voice.scala 126:19]
        node _WaveReg2_T_5 = tail(_WaveReg2_T_4, 1) @[Voice.scala 126:19]
        node _WaveReg2_T_6 = asSInt(_WaveReg2_T_5) @[Voice.scala 126:19]
        WaveReg2 <= _WaveReg2_T_6 @[Voice.scala 126:16]
    else :
      node _WaveReg_T = bits(DSPOut, 35, 18) @[Voice.scala 129:35]
      node _WaveReg_T_1 = sub(UInt<18>("h3ffff"), _WaveReg_T) @[Voice.scala 129:27]
      node _WaveReg_T_2 = tail(_WaveReg_T_1, 1) @[Voice.scala 129:27]
      WaveReg <= _WaveReg_T_2 @[Voice.scala 129:13]

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
    Voice0.io.Mod <= UInt<17>("h1ffff") @[Synth.scala 17:17]
    node _io_Out_T = asSInt(UInt<17>("h1ffff")) @[Synth.scala 18:46]
    node _io_Out_T_1 = add(Voice0.io.Wave_Out, _io_Out_T) @[Synth.scala 18:33]
    node _io_Out_T_2 = tail(_io_Out_T_1, 1) @[Synth.scala 18:33]
    node _io_Out_T_3 = asSInt(_io_Out_T_2) @[Synth.scala 18:33]
    node _io_Out_T_4 = asUInt(_io_Out_T_3) @[Synth.scala 18:54]
    io.Out <= _io_Out_T_4 @[Synth.scala 18:10]
    Com.io.SDA <= io.SDA @[Synth.scala 20:14]
    Com.io.SCL <= io.SCL @[Synth.scala 21:14]

