module DSP(
  input  [17:0] io_Input1,
  input  [17:0] io_Input2,
  input         io_Op,
  output [35:0] io_Out
);
  wire [35:0] _io_Out_T = $signed(io_Input1) * $signed(io_Input2); // @[DSP.scala 13:25]
  assign io_Out = io_Op ? $signed(_io_Out_T) : $signed(36'sh0); // @[DSP.scala 12:14 13:12 15:12]
endmodule
module Voice(
  input         clock,
  input         reset,
  output [17:0] io_Wave_Out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire [17:0] DSP_io_Input1; // @[Voice.scala 11:19]
  wire [17:0] DSP_io_Input2; // @[Voice.scala 11:19]
  wire  DSP_io_Op; // @[Voice.scala 11:19]
  wire [35:0] DSP_io_Out; // @[Voice.scala 11:19]
  reg [17:0] Index; // @[Voice.scala 13:22]
  wire [17:0] _Index_T_1 = Index + 18'h1; // @[Voice.scala 15:18]
  wire [18:0] _GEN_26 = {{1'd0}, Index}; // @[Voice.scala 17:14]
  reg [2:0] OpCounter; // @[Voice.scala 21:26]
  wire [2:0] _OpCounter_T_1 = OpCounter + 3'h1; // @[Voice.scala 23:26]
  reg [18:0] WaveReg; // @[Voice.scala 29:24]
  reg [17:0] IndexReg; // @[Voice.scala 31:25]
  reg [17:0] WaveReg2; // @[Voice.scala 33:25]
  wire [16:0] _Input1_T_3 = IndexReg[16:0] - 17'h3fff; // @[Voice.scala 53:46]
  wire [35:0] DSPOut = DSP_io_Out; // @[Voice.scala 39:20 43:10]
  wire [35:0] _WaveReg_T_2 = $signed(DSPOut) + 36'sh400000000; // @[Voice.scala 61:26]
  wire [18:0] _WaveReg_T_4 = _WaveReg_T_2[35:17]; // @[Voice.scala 61:51]
  wire [18:0] _WaveReg2_T_1 = DSPOut[35:17]; // @[Voice.scala 73:33]
  wire [18:0] _GEN_2 = 3'h5 == OpCounter ? $signed(_WaveReg2_T_1) : $signed({{1{WaveReg2[17]}},WaveReg2}); // @[Voice.scala 50:20 73:16 33:25]
  wire  _GEN_4 = 3'h4 == OpCounter | 3'h5 == OpCounter; // @[Voice.scala 50:20 70:17]
  wire [18:0] _GEN_5 = 3'h4 == OpCounter ? $signed({{1{WaveReg2[17]}},WaveReg2}) : $signed(_GEN_2); // @[Voice.scala 50:20 33:25]
  wire [18:0] _GEN_6 = 3'h3 == OpCounter ? $signed(WaveReg) : $signed(19'sh0); // @[Voice.scala 45:10 50:20 65:14]
  wire [17:0] _GEN_7 = 3'h3 == OpCounter ? $signed(-18'sh1) : $signed(18'sh0); // @[Voice.scala 46:10 50:20 66:14]
  wire  _GEN_8 = 3'h3 == OpCounter | _GEN_4; // @[Voice.scala 50:20 67:17]
  wire [18:0] _GEN_9 = 3'h3 == OpCounter ? $signed({{1{WaveReg2[17]}},WaveReg2}) : $signed(_GEN_5); // @[Voice.scala 50:20 33:25]
  wire  _GEN_11 = 3'h2 == OpCounter | _GEN_8; // @[Voice.scala 50:20 62:17]
  wire [18:0] _GEN_12 = 3'h2 == OpCounter ? $signed(19'sh0) : $signed(_GEN_6); // @[Voice.scala 45:10 50:20]
  wire [17:0] _GEN_13 = 3'h2 == OpCounter ? $signed(18'sh0) : $signed(_GEN_7); // @[Voice.scala 46:10 50:20]
  wire [18:0] _GEN_14 = 3'h2 == OpCounter ? $signed({{1{WaveReg2[17]}},WaveReg2}) : $signed(_GEN_9); // @[Voice.scala 50:20 33:25]
  wire  _GEN_15 = 3'h1 == OpCounter | _GEN_11; // @[Voice.scala 50:20 58:17]
  wire [18:0] _GEN_17 = 3'h1 == OpCounter ? $signed(19'sh0) : $signed(_GEN_12); // @[Voice.scala 45:10 50:20]
  wire [17:0] _GEN_18 = 3'h1 == OpCounter ? $signed(18'sh0) : $signed(_GEN_13); // @[Voice.scala 46:10 50:20]
  wire [18:0] _GEN_19 = 3'h1 == OpCounter ? $signed({{1{WaveReg2[17]}},WaveReg2}) : $signed(_GEN_14); // @[Voice.scala 50:20 33:25]
  wire [18:0] _GEN_21 = 3'h0 == OpCounter ? $signed({{2{_Input1_T_3[16]}},_Input1_T_3}) : $signed(_GEN_17); // @[Voice.scala 50:20 53:14]
  wire [18:0] _GEN_25 = 3'h0 == OpCounter ? $signed({{1{WaveReg2[17]}},WaveReg2}) : $signed(_GEN_19); // @[Voice.scala 50:20 33:25]
  wire [18:0] _GEN_29 = reset ? $signed(19'sh0) : $signed(_GEN_25); // @[Voice.scala 33:{25,25}]
  DSP DSP ( // @[Voice.scala 11:19]
    .io_Input1(DSP_io_Input1),
    .io_Input2(DSP_io_Input2),
    .io_Op(DSP_io_Op),
    .io_Out(DSP_io_Out)
  );
  assign io_Wave_Out = WaveReg2; // @[Voice.scala 35:15]
  assign DSP_io_Input1 = _GEN_21[17:0]; // @[Voice.scala 37:20]
  assign DSP_io_Input2 = 3'h0 == OpCounter ? $signed({{1{_Input1_T_3[16]}},_Input1_T_3}) : $signed(_GEN_18); // @[Voice.scala 50:20 54:14]
  assign DSP_io_Op = 3'h0 == OpCounter | _GEN_15; // @[Voice.scala 50:20 55:17]
  always @(posedge clock) begin
    if (reset) begin // @[Voice.scala 13:22]
      Index <= 18'h0; // @[Voice.scala 13:22]
    end else if (_GEN_26 == 19'h40000) begin // @[Voice.scala 17:27]
      Index <= 18'h0; // @[Voice.scala 18:11]
    end else begin
      Index <= _Index_T_1; // @[Voice.scala 15:9]
    end
    if (reset) begin // @[Voice.scala 21:26]
      OpCounter <= 3'h0; // @[Voice.scala 21:26]
    end else if (OpCounter == 3'h5) begin // @[Voice.scala 25:26]
      OpCounter <= 3'h0; // @[Voice.scala 26:15]
    end else begin
      OpCounter <= _OpCounter_T_1; // @[Voice.scala 23:13]
    end
    if (reset) begin // @[Voice.scala 29:24]
      WaveReg <= 19'sh0; // @[Voice.scala 29:24]
    end else if (!(3'h0 == OpCounter)) begin // @[Voice.scala 50:20]
      if (!(3'h1 == OpCounter)) begin // @[Voice.scala 50:20]
        if (3'h2 == OpCounter) begin // @[Voice.scala 50:20]
          WaveReg <= _WaveReg_T_4; // @[Voice.scala 61:15]
        end
      end
    end
    if (reset) begin // @[Voice.scala 31:25]
      IndexReg <= 18'h0; // @[Voice.scala 31:25]
    end else if (3'h0 == OpCounter) begin // @[Voice.scala 50:20]
      IndexReg <= Index; // @[Voice.scala 52:16]
    end
    WaveReg2 <= _GEN_29[17:0]; // @[Voice.scala 33:{25,25}]
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
  Index = _RAND_0[17:0];
  _RAND_1 = {1{`RANDOM}};
  OpCounter = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  WaveReg = _RAND_2[18:0];
  _RAND_3 = {1{`RANDOM}};
  IndexReg = _RAND_3[17:0];
  _RAND_4 = {1{`RANDOM}};
  WaveReg2 = _RAND_4[17:0];
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
  wire  Voice0_clock; // @[Synth.scala 14:22]
  wire  Voice0_reset; // @[Synth.scala 14:22]
  wire [17:0] Voice0_io_Wave_Out; // @[Synth.scala 14:22]
  wire [17:0] _io_Out_T = Voice0_io_Wave_Out; // @[Synth.scala 17:32]
  Voice Voice0 ( // @[Synth.scala 14:22]
    .clock(Voice0_clock),
    .reset(Voice0_reset),
    .io_Wave_Out(Voice0_io_Wave_Out)
  );
  assign io_Out = {{2'd0}, _io_Out_T}; // @[Synth.scala 17:10]
  assign Voice0_clock = clock;
  assign Voice0_reset = reset;
endmodule
