module Com(
  input         clock,
  input         io_SDA,
  output [17:0] io_Mod
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
`endif // RANDOMIZE_REG_INIT
  reg  io_Mod_r; // @[Reg.scala 15:16]
  reg  io_Mod_r_1; // @[Reg.scala 15:16]
  reg  io_Mod_r_2; // @[Reg.scala 15:16]
  reg  io_Mod_r_3; // @[Reg.scala 15:16]
  reg  io_Mod_r_4; // @[Reg.scala 15:16]
  reg  io_Mod_r_5; // @[Reg.scala 15:16]
  reg  io_Mod_r_6; // @[Reg.scala 15:16]
  reg  io_Mod_r_7; // @[Reg.scala 15:16]
  reg  io_Mod_r_8; // @[Reg.scala 15:16]
  reg  io_Mod_r_9; // @[Reg.scala 15:16]
  reg  io_Mod_r_10; // @[Reg.scala 15:16]
  reg  io_Mod_r_11; // @[Reg.scala 15:16]
  reg  io_Mod_r_12; // @[Reg.scala 15:16]
  reg  io_Mod_r_13; // @[Reg.scala 15:16]
  reg  io_Mod_r_14; // @[Reg.scala 15:16]
  reg  io_Mod_r_15; // @[Reg.scala 15:16]
  reg  io_Mod_r_16; // @[Reg.scala 15:16]
  reg  io_Mod_r_17; // @[Reg.scala 15:16]
  assign io_Mod = {{17'd0}, io_Mod_r_17}; // @[Com.scala 29:10]
  always @(posedge clock) begin
    io_Mod_r <= io_SDA; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_1 <= io_Mod_r; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_2 <= io_Mod_r_1; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_3 <= io_Mod_r_2; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_4 <= io_Mod_r_3; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_5 <= io_Mod_r_4; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_6 <= io_Mod_r_5; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_7 <= io_Mod_r_6; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_8 <= io_Mod_r_7; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_9 <= io_Mod_r_8; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_10 <= io_Mod_r_9; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_11 <= io_Mod_r_10; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_12 <= io_Mod_r_11; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_13 <= io_Mod_r_12; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_14 <= io_Mod_r_13; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_15 <= io_Mod_r_14; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_16 <= io_Mod_r_15; // @[Reg.scala 15:16 16:{19,23}]
    io_Mod_r_17 <= io_Mod_r_16; // @[Reg.scala 15:16 16:{19,23}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_Mod_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  io_Mod_r_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  io_Mod_r_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  io_Mod_r_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  io_Mod_r_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  io_Mod_r_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  io_Mod_r_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  io_Mod_r_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  io_Mod_r_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  io_Mod_r_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  io_Mod_r_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  io_Mod_r_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  io_Mod_r_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  io_Mod_r_13 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  io_Mod_r_14 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  io_Mod_r_15 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  io_Mod_r_16 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  io_Mod_r_17 = _RAND_17[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DSP(
  input  [17:0] io_Input1,
  input  [17:0] io_Input2,
  output [35:0] io_Out
);
  assign io_Out = $signed(io_Input1) * $signed(io_Input2); // @[DSP.scala 11:23]
endmodule
module Voice(
  input         clock,
  input         reset,
  output [17:0] io_Wave_Out,
  input  [17:0] io_Mod
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [17:0] DSP_io_Input1; // @[Voice.scala 11:19]
  wire [17:0] DSP_io_Input2; // @[Voice.scala 11:19]
  wire [35:0] DSP_io_Out; // @[Voice.scala 11:19]
  reg  OpCounter; // @[Voice.scala 21:26]
  reg [17:0] WaveReg2; // @[Voice.scala 31:25]
  wire [16:0] _DSP_io_Input1_T_4 = 17'h0 - 17'h3fff; // @[Voice.scala 53:71]
  wire [18:0] _DSP_io_Input1_T_5 = OpCounter ? $signed({{2{_DSP_io_Input1_T_4[16]}},_DSP_io_Input1_T_4}) : $signed(19'sh0
    ); // @[Voice.scala 53:23]
  wire [35:0] _WaveReg2_T_2 = $signed(DSP_io_Out) + 36'sh400000000; // @[Voice.scala 56:27]
  wire [18:0] _WaveReg2_T_4 = _WaveReg2_T_2[35:17]; // @[Voice.scala 56:52]
  wire [18:0] _GEN_4 = reset ? $signed(19'sh0) : $signed(_WaveReg2_T_4); // @[Voice.scala 31:{25,25} 56:12]
  DSP DSP ( // @[Voice.scala 11:19]
    .io_Input1(DSP_io_Input1),
    .io_Input2(DSP_io_Input2),
    .io_Out(DSP_io_Out)
  );
  assign io_Wave_Out = WaveReg2; // @[Voice.scala 33:15]
  assign DSP_io_Input1 = _DSP_io_Input1_T_5[17:0]; // @[Voice.scala 53:17]
  assign DSP_io_Input2 = OpCounter ? $signed({{1{_DSP_io_Input1_T_4[16]}},_DSP_io_Input1_T_4}) : $signed(io_Mod); // @[Voice.scala 54:23]
  always @(posedge clock) begin
    if (reset) begin // @[Voice.scala 21:26]
      OpCounter <= 1'h0; // @[Voice.scala 21:26]
    end else if (OpCounter) begin // @[Voice.scala 25:26]
      OpCounter <= 1'h0; // @[Voice.scala 26:15]
    end else begin
      OpCounter <= OpCounter + 1'h1; // @[Voice.scala 23:13]
    end
    WaveReg2 <= _GEN_4[17:0]; // @[Voice.scala 31:{25,25} 56:12]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  OpCounter = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  WaveReg2 = _RAND_1[17:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Synth(
  input         clock,
  input         reset,
  output [19:0] io_Out,
  input         io_SCL,
  input         io_SDA
);
  wire  Com_clock; // @[Synth.scala 12:19]
  wire  Com_io_SDA; // @[Synth.scala 12:19]
  wire [17:0] Com_io_Mod; // @[Synth.scala 12:19]
  wire  Voice0_clock; // @[Synth.scala 14:22]
  wire  Voice0_reset; // @[Synth.scala 14:22]
  wire [17:0] Voice0_io_Wave_Out; // @[Synth.scala 14:22]
  wire [17:0] Voice0_io_Mod; // @[Synth.scala 14:22]
  wire [17:0] _io_Out_T = Voice0_io_Wave_Out; // @[Synth.scala 17:32]
  Com Com ( // @[Synth.scala 12:19]
    .clock(Com_clock),
    .io_SDA(Com_io_SDA),
    .io_Mod(Com_io_Mod)
  );
  Voice Voice0 ( // @[Synth.scala 14:22]
    .clock(Voice0_clock),
    .reset(Voice0_reset),
    .io_Wave_Out(Voice0_io_Wave_Out),
    .io_Mod(Voice0_io_Mod)
  );
  assign io_Out = {{2'd0}, _io_Out_T}; // @[Synth.scala 17:10]
  assign Com_clock = clock;
  assign Com_io_SDA = io_SDA; // @[Synth.scala 19:14]
  assign Voice0_clock = clock;
  assign Voice0_reset = reset;
  assign Voice0_io_Mod = Com_io_Mod; // @[Synth.scala 16:17]
endmodule
