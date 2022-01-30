module DSP(
  input  [17:0] io_Input1,
  input  [17:0] io_Input2,
  output [35:0] io_Out
);
  assign io_Out = io_Input1 * io_Input2; // @[DSP.scala 11:23]
endmodule
module Voice(
  input         clock,
  input         reset,
  output [18:0] io_Wave_Out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire [17:0] DSP_io_Input1; // @[Voice.scala 85:19]
  wire [17:0] DSP_io_Input2; // @[Voice.scala 85:19]
  wire [35:0] DSP_io_Out; // @[Voice.scala 85:19]
  reg [19:0] Index; // @[Voice.scala 87:22]
  wire [19:0] _Index_T_1 = Index + 20'h1; // @[Voice.scala 89:18]
  reg  OpCounter; // @[Voice.scala 95:26]
  reg [17:0] WaveReg; // @[Voice.scala 103:24]
  reg [18:0] WaveReg2; // @[Voice.scala 104:25]
  wire [17:0] _IndexAr_T_3 = 18'h3ffff - Index[17:0]; // @[Voice.scala 116:27]
  wire [17:0] IndexAr = Index[18] ? Index[17:0] : _IndexAr_T_3; // @[Voice.scala 113:25 114:13 116:13]
  wire [35:0] DSPOut = DSP_io_Out; // @[Voice.scala 109:20 111:10]
  wire [17:0] _WaveReg2_T_1 = DSPOut[35:18]; // @[Voice.scala 124:33]
  wire [17:0] _WaveReg2_T_6 = 18'sh0 - $signed(_WaveReg2_T_1); // @[Voice.scala 126:19]
  wire [17:0] _GEN_3 = Index[17] ? $signed(_WaveReg2_T_1) : $signed(_WaveReg2_T_6); // @[Voice.scala 123:27 124:16 126:16]
  wire [17:0] _WaveReg_T_2 = 18'h3ffff - DSPOut[35:18]; // @[Voice.scala 129:27]
  DSP DSP ( // @[Voice.scala 85:19]
    .io_Input1(DSP_io_Input1),
    .io_Input2(DSP_io_Input2),
    .io_Out(DSP_io_Out)
  );
  assign io_Wave_Out = WaveReg2; // @[Voice.scala 107:15]
  assign DSP_io_Input1 = OpCounter ? IndexAr : WaveReg; // @[Voice.scala 119:23]
  assign DSP_io_Input2 = OpCounter ? IndexAr : 18'h1ffff; // @[Voice.scala 120:23]
  always @(posedge clock) begin
    if (reset) begin // @[Voice.scala 87:22]
      Index <= 20'h0; // @[Voice.scala 87:22]
    end else if (Index == 20'hfffff) begin // @[Voice.scala 91:29]
      Index <= 20'h0; // @[Voice.scala 92:11]
    end else begin
      Index <= _Index_T_1; // @[Voice.scala 89:9]
    end
    if (reset) begin // @[Voice.scala 95:26]
      OpCounter <= 1'h0; // @[Voice.scala 95:26]
    end else if (OpCounter) begin // @[Voice.scala 99:26]
      OpCounter <= 1'h0; // @[Voice.scala 100:15]
    end else begin
      OpCounter <= OpCounter + 1'h1; // @[Voice.scala 97:13]
    end
    if (reset) begin // @[Voice.scala 103:24]
      WaveReg <= 18'h0; // @[Voice.scala 103:24]
    end else if (!(OpCounter)) begin // @[Voice.scala 122:25]
      WaveReg <= _WaveReg_T_2; // @[Voice.scala 129:13]
    end
    if (reset) begin // @[Voice.scala 104:25]
      WaveReg2 <= 19'sh0; // @[Voice.scala 104:25]
    end else if (OpCounter) begin // @[Voice.scala 122:25]
      WaveReg2 <= {{1{_GEN_3[17]}},_GEN_3};
    end
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
  Index = _RAND_0[19:0];
  _RAND_1 = {1{`RANDOM}};
  OpCounter = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  WaveReg = _RAND_2[17:0];
  _RAND_3 = {1{`RANDOM}};
  WaveReg2 = _RAND_3[18:0];
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
  wire [18:0] Voice0_io_Wave_Out; // @[Synth.scala 14:22]
  wire [18:0] _io_Out_T_4 = $signed(Voice0_io_Wave_Out) - 19'sh1; // @[Synth.scala 18:54]
  Voice Voice0 ( // @[Synth.scala 14:22]
    .clock(Voice0_clock),
    .reset(Voice0_reset),
    .io_Wave_Out(Voice0_io_Wave_Out)
  );
  assign io_Out = {{1'd0}, _io_Out_T_4}; // @[Synth.scala 18:10]
  assign Voice0_clock = clock;
  assign Voice0_reset = reset;
endmodule
