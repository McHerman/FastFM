circuit Synth :
  module Com :
    input clock : Clock
    input reset : Reset
    output io : { flip SCL : UInt<1>, flip SDA : UInt<1>, Mod : UInt<18>}

    reg io_Mod_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r <= io.SDA @[Reg.scala 16:23]
    reg io_Mod_r_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_1) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_1 <= io_Mod_r @[Reg.scala 16:23]
    reg io_Mod_r_2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_2) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_2 <= io_Mod_r_1 @[Reg.scala 16:23]
    reg io_Mod_r_3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_3) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_3 <= io_Mod_r_2 @[Reg.scala 16:23]
    reg io_Mod_r_4 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_4) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_4 <= io_Mod_r_3 @[Reg.scala 16:23]
    reg io_Mod_r_5 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_5) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_5 <= io_Mod_r_4 @[Reg.scala 16:23]
    reg io_Mod_r_6 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_6) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_6 <= io_Mod_r_5 @[Reg.scala 16:23]
    reg io_Mod_r_7 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_7) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_7 <= io_Mod_r_6 @[Reg.scala 16:23]
    reg io_Mod_r_8 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_8) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_8 <= io_Mod_r_7 @[Reg.scala 16:23]
    reg io_Mod_r_9 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_9) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_9 <= io_Mod_r_8 @[Reg.scala 16:23]
    reg io_Mod_r_10 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_10) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_10 <= io_Mod_r_9 @[Reg.scala 16:23]
    reg io_Mod_r_11 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_11) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_11 <= io_Mod_r_10 @[Reg.scala 16:23]
    reg io_Mod_r_12 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_12) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_12 <= io_Mod_r_11 @[Reg.scala 16:23]
    reg io_Mod_r_13 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_13) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_13 <= io_Mod_r_12 @[Reg.scala 16:23]
    reg io_Mod_r_14 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_14) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_14 <= io_Mod_r_13 @[Reg.scala 16:23]
    reg io_Mod_r_15 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_15) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_15 <= io_Mod_r_14 @[Reg.scala 16:23]
    reg io_Mod_r_16 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_16) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_16 <= io_Mod_r_15 @[Reg.scala 16:23]
    reg io_Mod_r_17 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_Mod_r_17) @[Reg.scala 15:16]
    when UInt<1>("h1") : @[Reg.scala 16:19]
      io_Mod_r_17 <= io_Mod_r_16 @[Reg.scala 16:23]
    io.Mod <= io_Mod_r_17 @[Com.scala 29:10]

  module DSP :
    input clock : Clock
    input reset : Reset
    output io : { flip Input1 : SInt<18>, flip Input2 : SInt<18>, Out : SInt<36>}

    node _io_Out_T = mul(io.Input1, io.Input2) @[DSP.scala 11:23]
    io.Out <= _io_Out_T @[DSP.scala 11:10]

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
    reg OpCounter : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Voice.scala 21:26]
    node _OpCounter_T = add(OpCounter, UInt<1>("h1")) @[Voice.scala 23:26]
    node _OpCounter_T_1 = tail(_OpCounter_T, 1) @[Voice.scala 23:26]
    OpCounter <= _OpCounter_T_1 @[Voice.scala 23:13]
    node _T_1 = eq(OpCounter, UInt<1>("h1")) @[Voice.scala 25:18]
    when _T_1 : @[Voice.scala 25:26]
      OpCounter <= UInt<1>("h0") @[Voice.scala 26:15]
    reg WaveReg : SInt<19>, clock with :
      reset => (reset, asSInt(UInt<19>("h0"))) @[Voice.scala 29:24]
    reg IndexReg : UInt<18>, clock with :
      reset => (reset, UInt<18>("h0")) @[Voice.scala 30:25]
    reg WaveReg2 : SInt<18>, clock with :
      reset => (reset, asSInt(UInt<18>("h0"))) @[Voice.scala 31:25]
    io.Wave_Out <= WaveReg2 @[Voice.scala 33:15]
    node _DSP_io_Input1_T = bits(OpCounter, 0, 0) @[Voice.scala 53:34]
    node _DSP_io_Input1_T_1 = bits(IndexReg, 16, 0) @[Voice.scala 53:51]
    node _DSP_io_Input1_T_2 = sub(_DSP_io_Input1_T_1, UInt<14>("h3fff")) @[Voice.scala 53:58]
    node _DSP_io_Input1_T_3 = tail(_DSP_io_Input1_T_2, 1) @[Voice.scala 53:58]
    node _DSP_io_Input1_T_4 = asSInt(_DSP_io_Input1_T_3) @[Voice.scala 53:71]
    node _DSP_io_Input1_T_5 = mux(_DSP_io_Input1_T, _DSP_io_Input1_T_4, WaveReg) @[Voice.scala 53:23]
    DSP.io.Input1 <= _DSP_io_Input1_T_5 @[Voice.scala 53:17]
    node _DSP_io_Input2_T = bits(OpCounter, 0, 0) @[Voice.scala 54:34]
    node _DSP_io_Input2_T_1 = bits(IndexReg, 16, 0) @[Voice.scala 54:51]
    node _DSP_io_Input2_T_2 = sub(_DSP_io_Input2_T_1, UInt<14>("h3fff")) @[Voice.scala 54:58]
    node _DSP_io_Input2_T_3 = tail(_DSP_io_Input2_T_2, 1) @[Voice.scala 54:58]
    node _DSP_io_Input2_T_4 = asSInt(_DSP_io_Input2_T_3) @[Voice.scala 54:71]
    node _DSP_io_Input2_T_5 = asSInt(io.Mod) @[Voice.scala 54:86]
    node _DSP_io_Input2_T_6 = mux(_DSP_io_Input2_T, _DSP_io_Input2_T_4, _DSP_io_Input2_T_5) @[Voice.scala 54:23]
    DSP.io.Input2 <= _DSP_io_Input2_T_6 @[Voice.scala 54:17]
    node _WaveReg2_T = add(DSP.io.Out, asSInt(UInt<36>("h400000000"))) @[Voice.scala 56:27]
    node _WaveReg2_T_1 = tail(_WaveReg2_T, 1) @[Voice.scala 56:27]
    node _WaveReg2_T_2 = asSInt(_WaveReg2_T_1) @[Voice.scala 56:27]
    node _WaveReg2_T_3 = bits(_WaveReg2_T_2, 35, 17) @[Voice.scala 56:44]
    node _WaveReg2_T_4 = asSInt(_WaveReg2_T_3) @[Voice.scala 56:52]
    WaveReg2 <= _WaveReg2_T_4 @[Voice.scala 56:12]

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
    Voice0.io.Mod <= Com.io.Mod @[Synth.scala 16:17]
    node _io_Out_T = asUInt(Voice0.io.Wave_Out) @[Synth.scala 17:32]
    io.Out <= _io_Out_T @[Synth.scala 17:10]
    Com.io.SDA <= io.SDA @[Synth.scala 19:14]
    Com.io.SCL <= io.SCL @[Synth.scala 20:14]

