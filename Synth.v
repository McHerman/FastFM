module DSP(
  input  [17:0] io_Input1,
  input  [17:0] io_Input2,
  output [35:0] io_Out
);
  assign io_Out = io_Input1 * io_Input2; // @[DSP.scala 11:23]
endmodule
module SineGenerator(
  input         clock,
  input         reset,
  output [19:0] io_WaveOut,
  input  [19:0] io_Index,
  output        io_OutputValid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire [17:0] DSP_io_Input1; // @[SineGenerator.scala 12:19]
  wire [17:0] DSP_io_Input2; // @[SineGenerator.scala 12:19]
  wire [35:0] DSP_io_Out; // @[SineGenerator.scala 12:19]
  reg  OpCounter; // @[SineGenerator.scala 14:26]
  reg [17:0] WaveReg; // @[SineGenerator.scala 22:24]
  reg [19:0] WaveReg2; // @[SineGenerator.scala 23:25]
  wire [17:0] _IndexAr_T_3 = 18'h3ffff - io_Index[17:0]; // @[SineGenerator.scala 35:27]
  wire [17:0] IndexAr = io_Index[18] ? io_Index[17:0] : _IndexAr_T_3; // @[SineGenerator.scala 32:28 33:13 35:13]
  wire [35:0] DSPOut = DSP_io_Out; // @[SineGenerator.scala 28:20 30:10]
  wire [19:0] _io_WaveOut_T_1 = {1'b0,$signed(DSPOut[35:17])}; // @[SineGenerator.scala 43:36]
  wire [19:0] _io_WaveOut_T_4 = 20'sh0 - $signed(_io_WaveOut_T_1); // @[SineGenerator.scala 43:21]
  wire [19:0] _GEN_2 = io_Index[19] ? $signed(_io_WaveOut_T_4) : $signed(_io_WaveOut_T_1); // @[SineGenerator.scala 42:30 43:18 46:18]
  wire [17:0] _WaveReg_T_2 = 18'h3ffff - DSPOut[35:18]; // @[SineGenerator.scala 52:25]
  DSP DSP ( // @[SineGenerator.scala 12:19]
    .io_Input1(DSP_io_Input1),
    .io_Input2(DSP_io_Input2),
    .io_Out(DSP_io_Out)
  );
  assign io_WaveOut = OpCounter ? $signed(_GEN_2) : $signed(WaveReg2); // @[SineGenerator.scala 26:14 41:25]
  assign io_OutputValid = OpCounter; // @[SineGenerator.scala 41:25 50:20 54:20]
  assign DSP_io_Input1 = OpCounter ? WaveReg : IndexAr; // @[SineGenerator.scala 38:23]
  assign DSP_io_Input2 = OpCounter ? 18'h3ffff : IndexAr; // @[SineGenerator.scala 39:23]
  always @(posedge clock) begin
    if (reset) begin // @[SineGenerator.scala 14:26]
      OpCounter <= 1'h0; // @[SineGenerator.scala 14:26]
    end else if (OpCounter) begin // @[SineGenerator.scala 18:26]
      OpCounter <= 1'h0; // @[SineGenerator.scala 19:15]
    end else begin
      OpCounter <= OpCounter + 1'h1; // @[SineGenerator.scala 16:13]
    end
    if (reset) begin // @[SineGenerator.scala 22:24]
      WaveReg <= 18'h0; // @[SineGenerator.scala 22:24]
    end else if (!(OpCounter)) begin // @[SineGenerator.scala 41:25]
      WaveReg <= _WaveReg_T_2; // @[SineGenerator.scala 52:13]
    end
    if (reset) begin // @[SineGenerator.scala 23:25]
      WaveReg2 <= 20'sh0; // @[SineGenerator.scala 23:25]
    end else if (OpCounter) begin // @[SineGenerator.scala 41:25]
      if (io_Index[19]) begin // @[SineGenerator.scala 42:30]
        WaveReg2 <= _io_WaveOut_T_4; // @[SineGenerator.scala 43:18]
      end else begin
        WaveReg2 <= _io_WaveOut_T_1; // @[SineGenerator.scala 46:18]
      end
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
  OpCounter = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  WaveReg = _RAND_1[17:0];
  _RAND_2 = {1{`RANDOM}};
  WaveReg2 = _RAND_2[19:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IntructionMemory(
  input  [2:0] io_Step,
  output [5:0] io_ReadReg,
  output [2:0] io_WriteReg,
  output       io_IsOutput
);
  wire [7:0] _GEN_6 = {{5'd0}, io_Step}; // @[IntructionMemory.scala 30:41]
  wire [7:0] Address = 8'h8 + _GEN_6; // @[IntructionMemory.scala 30:41]
  wire [9:0] _GEN_1 = 3'h1 == Address[2:0] ? 10'h160 : 10'h180; // @[IntructionMemory.scala 33:{8,8}]
  wire [9:0] _GEN_2 = 3'h2 == Address[2:0] ? 10'h110 : _GEN_1; // @[IntructionMemory.scala 33:{8,8}]
  wire [9:0] _GEN_3 = 3'h3 == Address[2:0] ? 10'h2c8 : _GEN_2; // @[IntructionMemory.scala 33:{8,8}]
  wire [9:0] _GEN_4 = 3'h4 == Address[2:0] ? 10'h82 : _GEN_3; // @[IntructionMemory.scala 33:{8,8}]
  wire [9:0] Data = 3'h5 == Address[2:0] ? 10'h242 : _GEN_4; // @[IntructionMemory.scala 33:{8,8}]
  assign io_ReadReg = Data[5:0]; // @[IntructionMemory.scala 35:21]
  assign io_WriteReg = Data[8:6]; // @[IntructionMemory.scala 36:22]
  assign io_IsOutput = Data[9]; // @[IntructionMemory.scala 37:22]
endmodule
module Voice(
  input         clock,
  input         reset,
  output [22:0] io_WaveOut
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
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
`endif // RANDOMIZE_REG_INIT
  wire  SineGenerator_clock; // @[Voice.scala 12:29]
  wire  SineGenerator_reset; // @[Voice.scala 12:29]
  wire [19:0] SineGenerator_io_WaveOut; // @[Voice.scala 12:29]
  wire [19:0] SineGenerator_io_Index; // @[Voice.scala 12:29]
  wire  SineGenerator_io_OutputValid; // @[Voice.scala 12:29]
  wire [2:0] Mem_io_Step; // @[Voice.scala 57:19]
  wire [5:0] Mem_io_ReadReg; // @[Voice.scala 57:19]
  wire [2:0] Mem_io_WriteReg; // @[Voice.scala 57:19]
  wire  Mem_io_IsOutput; // @[Voice.scala 57:19]
  reg [19:0] WaveReg_0; // @[Voice.scala 14:20]
  reg [19:0] WaveReg_1; // @[Voice.scala 14:20]
  reg [19:0] WaveReg_2; // @[Voice.scala 14:20]
  reg [19:0] WaveReg_3; // @[Voice.scala 14:20]
  reg [19:0] WaveReg_4; // @[Voice.scala 14:20]
  reg [19:0] WaveReg_5; // @[Voice.scala 14:20]
  reg [2:0] OpCounter; // @[Voice.scala 16:26]
  reg [1:0] ScaleReg; // @[Voice.scala 18:25]
  reg [19:0] FreqReg_0; // @[Voice.scala 20:20]
  reg [19:0] FreqReg_1; // @[Voice.scala 20:20]
  reg [19:0] FreqReg_2; // @[Voice.scala 20:20]
  reg [19:0] FreqReg_3; // @[Voice.scala 20:20]
  reg [19:0] FreqReg_4; // @[Voice.scala 20:20]
  reg [19:0] FreqReg_5; // @[Voice.scala 20:20]
  reg [19:0] IndexReg_0; // @[Voice.scala 21:21]
  reg [19:0] IndexReg_1; // @[Voice.scala 21:21]
  reg [19:0] IndexReg_2; // @[Voice.scala 21:21]
  reg [19:0] IndexReg_3; // @[Voice.scala 21:21]
  reg [19:0] IndexReg_4; // @[Voice.scala 21:21]
  reg [19:0] IndexReg_5; // @[Voice.scala 21:21]
  reg [22:0] OutputTempReg; // @[Voice.scala 23:30]
  reg [22:0] OutputReg; // @[Voice.scala 25:26]
  wire [19:0] _FreqReg_0_T_1 = FreqReg_0 + 20'h1; // @[Voice.scala 33:30]
  wire [19:0] _IndexReg_0_T_1 = IndexReg_0 + 20'h1; // @[Voice.scala 37:34]
  wire [19:0] _FreqReg_1_T_1 = FreqReg_1 + 20'h1; // @[Voice.scala 33:30]
  wire [19:0] _IndexReg_1_T_1 = IndexReg_1 + 20'h1; // @[Voice.scala 37:34]
  wire [19:0] _FreqReg_2_T_1 = FreqReg_2 + 20'h1; // @[Voice.scala 33:30]
  wire [19:0] _IndexReg_2_T_1 = IndexReg_2 + 20'h1; // @[Voice.scala 37:34]
  wire [19:0] _FreqReg_3_T_1 = FreqReg_3 + 20'h1; // @[Voice.scala 33:30]
  wire [19:0] _IndexReg_3_T_1 = IndexReg_3 + 20'h1; // @[Voice.scala 37:34]
  wire [19:0] _FreqReg_4_T_1 = FreqReg_4 + 20'h1; // @[Voice.scala 33:30]
  wire [19:0] _IndexReg_4_T_1 = IndexReg_4 + 20'h1; // @[Voice.scala 37:34]
  wire [19:0] _FreqReg_5_T_1 = FreqReg_5 + 20'h1; // @[Voice.scala 33:30]
  wire [19:0] _IndexReg_5_T_1 = IndexReg_5 + 20'h1; // @[Voice.scala 37:34]
  wire [1:0] _ScaleReg_T_1 = ScaleReg + 2'h1; // @[Voice.scala 43:24]
  wire  _T_6 = ScaleReg == 2'h1; // @[Voice.scala 45:17]
  wire [2:0] _OpCounter_T_1 = OpCounter + 3'h1; // @[Voice.scala 47:30]
  wire [19:0] _IndexTemp_T_2 = Mem_io_ReadReg[0] ? $signed(WaveReg_0) : $signed(20'sh0); // @[Voice.scala 88:19]
  wire [19:0] _IndexTemp_T_5 = Mem_io_ReadReg[1] ? $signed(WaveReg_1) : $signed(20'sh0); // @[Voice.scala 88:68]
  wire [19:0] _IndexTemp_T_8 = $signed(_IndexTemp_T_2) + $signed(_IndexTemp_T_5); // @[Voice.scala 88:63]
  wire [19:0] _IndexTemp_T_11 = Mem_io_ReadReg[2] ? $signed(WaveReg_2) : $signed(20'sh0); // @[Voice.scala 88:117]
  wire [19:0] _IndexTemp_T_14 = $signed(_IndexTemp_T_8) + $signed(_IndexTemp_T_11); // @[Voice.scala 88:112]
  wire [19:0] _IndexTemp_T_17 = Mem_io_ReadReg[3] ? $signed(WaveReg_3) : $signed(20'sh0); // @[Voice.scala 88:166]
  wire [19:0] _IndexTemp_T_20 = $signed(_IndexTemp_T_14) + $signed(_IndexTemp_T_17); // @[Voice.scala 88:161]
  wire [19:0] _IndexTemp_T_23 = Mem_io_ReadReg[4] ? $signed(WaveReg_4) : $signed(20'sh0); // @[Voice.scala 88:215]
  wire [19:0] _IndexTemp_T_26 = $signed(_IndexTemp_T_20) + $signed(_IndexTemp_T_23); // @[Voice.scala 88:210]
  wire [19:0] _IndexTemp_T_29 = Mem_io_ReadReg[5] ? $signed(WaveReg_5) : $signed(20'sh0); // @[Voice.scala 88:264]
  wire [19:0] _IndexTemp_T_32 = $signed(_IndexTemp_T_26) + $signed(_IndexTemp_T_29); // @[Voice.scala 88:259]
  wire [22:0] _SineGenerator_io_Index_T = {{3{_IndexTemp_T_32[19]}},_IndexTemp_T_32}; // @[Voice.scala 90:39]
  wire [19:0] _GEN_16 = 3'h1 == OpCounter ? IndexReg_1 : IndexReg_0; // @[Voice.scala 90:{46,46}]
  wire [19:0] _GEN_17 = 3'h2 == OpCounter ? IndexReg_2 : _GEN_16; // @[Voice.scala 90:{46,46}]
  wire [19:0] _GEN_18 = 3'h3 == OpCounter ? IndexReg_3 : _GEN_17; // @[Voice.scala 90:{46,46}]
  wire [19:0] _GEN_19 = 3'h4 == OpCounter ? IndexReg_4 : _GEN_18; // @[Voice.scala 90:{46,46}]
  wire [19:0] _GEN_20 = 3'h5 == OpCounter ? IndexReg_5 : _GEN_19; // @[Voice.scala 90:{46,46}]
  wire [22:0] _GEN_45 = {{3'd0}, _GEN_20}; // @[Voice.scala 90:46]
  wire [22:0] _SineGenerator_io_Index_T_2 = _SineGenerator_io_Index_T + _GEN_45; // @[Voice.scala 90:46]
  wire [2:0] _T_9 = Mem_io_WriteReg - 3'h1; // @[Voice.scala 96:29]
  wire [19:0] _WaveReg_T_9 = SineGenerator_io_WaveOut; // @[Voice.scala 96:{36,36}]
  wire [22:0] _GEN_46 = {{3{SineGenerator_io_WaveOut[19]}},SineGenerator_io_WaveOut}; // @[Voice.scala 99:38]
  wire [22:0] _OutputTempReg_T_2 = $signed(OutputTempReg) + $signed(_GEN_46); // @[Voice.scala 99:38]
  SineGenerator SineGenerator ( // @[Voice.scala 12:29]
    .clock(SineGenerator_clock),
    .reset(SineGenerator_reset),
    .io_WaveOut(SineGenerator_io_WaveOut),
    .io_Index(SineGenerator_io_Index),
    .io_OutputValid(SineGenerator_io_OutputValid)
  );
  IntructionMemory Mem ( // @[Voice.scala 57:19]
    .io_Step(Mem_io_Step),
    .io_ReadReg(Mem_io_ReadReg),
    .io_WriteReg(Mem_io_WriteReg),
    .io_IsOutput(Mem_io_IsOutput)
  );
  assign io_WaveOut = OutputReg; // @[Voice.scala 109:14]
  assign SineGenerator_clock = clock;
  assign SineGenerator_reset = reset;
  assign SineGenerator_io_Index = _SineGenerator_io_Index_T_2[19:0]; // @[Voice.scala 90:26]
  assign Mem_io_Step = OpCounter; // @[Voice.scala 59:15]
  always @(posedge clock) begin
    if (SineGenerator_io_OutputValid) begin // @[Voice.scala 95:37]
      if (3'h0 == _T_9) begin // @[Voice.scala 96:36]
        WaveReg_0 <= _WaveReg_T_9; // @[Voice.scala 96:36]
      end
    end
    if (SineGenerator_io_OutputValid) begin // @[Voice.scala 95:37]
      if (3'h1 == _T_9) begin // @[Voice.scala 96:36]
        WaveReg_1 <= _WaveReg_T_9; // @[Voice.scala 96:36]
      end
    end
    if (SineGenerator_io_OutputValid) begin // @[Voice.scala 95:37]
      if (3'h2 == _T_9) begin // @[Voice.scala 96:36]
        WaveReg_2 <= _WaveReg_T_9; // @[Voice.scala 96:36]
      end
    end
    if (SineGenerator_io_OutputValid) begin // @[Voice.scala 95:37]
      if (3'h3 == _T_9) begin // @[Voice.scala 96:36]
        WaveReg_3 <= _WaveReg_T_9; // @[Voice.scala 96:36]
      end
    end
    if (SineGenerator_io_OutputValid) begin // @[Voice.scala 95:37]
      if (3'h4 == _T_9) begin // @[Voice.scala 96:36]
        WaveReg_4 <= _WaveReg_T_9; // @[Voice.scala 96:36]
      end
    end
    if (SineGenerator_io_OutputValid) begin // @[Voice.scala 95:37]
      if (3'h5 == _T_9) begin // @[Voice.scala 96:36]
        WaveReg_5 <= _WaveReg_T_9; // @[Voice.scala 96:36]
      end
    end
    if (reset) begin // @[Voice.scala 16:26]
      OpCounter <= 3'h0; // @[Voice.scala 16:26]
    end else if (ScaleReg == 2'h1) begin // @[Voice.scala 45:25]
      if (OpCounter != 3'h5) begin // @[Voice.scala 46:28]
        OpCounter <= _OpCounter_T_1; // @[Voice.scala 47:17]
      end else begin
        OpCounter <= 3'h0; // @[Voice.scala 49:17]
      end
    end
    if (reset) begin // @[Voice.scala 18:25]
      ScaleReg <= 2'h0; // @[Voice.scala 18:25]
    end else if (ScaleReg == 2'h1) begin // @[Voice.scala 45:25]
      ScaleReg <= 2'h0; // @[Voice.scala 51:14]
    end else begin
      ScaleReg <= _ScaleReg_T_1; // @[Voice.scala 43:12]
    end
    if (FreqReg_0 == 20'h1) begin // @[Voice.scala 35:36]
      FreqReg_0 <= 20'h0; // @[Voice.scala 36:18]
    end else begin
      FreqReg_0 <= _FreqReg_0_T_1; // @[Voice.scala 33:16]
    end
    if (FreqReg_1 == 20'h2) begin // @[Voice.scala 35:36]
      FreqReg_1 <= 20'h0; // @[Voice.scala 36:18]
    end else begin
      FreqReg_1 <= _FreqReg_1_T_1; // @[Voice.scala 33:16]
    end
    if (FreqReg_2 == 20'h3) begin // @[Voice.scala 35:36]
      FreqReg_2 <= 20'h0; // @[Voice.scala 36:18]
    end else begin
      FreqReg_2 <= _FreqReg_2_T_1; // @[Voice.scala 33:16]
    end
    if (FreqReg_3 == 20'h4) begin // @[Voice.scala 35:36]
      FreqReg_3 <= 20'h0; // @[Voice.scala 36:18]
    end else begin
      FreqReg_3 <= _FreqReg_3_T_1; // @[Voice.scala 33:16]
    end
    if (FreqReg_4 == 20'h5) begin // @[Voice.scala 35:36]
      FreqReg_4 <= 20'h0; // @[Voice.scala 36:18]
    end else begin
      FreqReg_4 <= _FreqReg_4_T_1; // @[Voice.scala 33:16]
    end
    if (FreqReg_5 == 20'h6) begin // @[Voice.scala 35:36]
      FreqReg_5 <= 20'h0; // @[Voice.scala 36:18]
    end else begin
      FreqReg_5 <= _FreqReg_5_T_1; // @[Voice.scala 33:16]
    end
    if (FreqReg_0 == 20'h1) begin // @[Voice.scala 35:36]
      IndexReg_0 <= _IndexReg_0_T_1; // @[Voice.scala 37:19]
    end
    if (FreqReg_1 == 20'h2) begin // @[Voice.scala 35:36]
      IndexReg_1 <= _IndexReg_1_T_1; // @[Voice.scala 37:19]
    end
    if (FreqReg_2 == 20'h3) begin // @[Voice.scala 35:36]
      IndexReg_2 <= _IndexReg_2_T_1; // @[Voice.scala 37:19]
    end
    if (FreqReg_3 == 20'h4) begin // @[Voice.scala 35:36]
      IndexReg_3 <= _IndexReg_3_T_1; // @[Voice.scala 37:19]
    end
    if (FreqReg_4 == 20'h5) begin // @[Voice.scala 35:36]
      IndexReg_4 <= _IndexReg_4_T_1; // @[Voice.scala 37:19]
    end
    if (FreqReg_5 == 20'h6) begin // @[Voice.scala 35:36]
      IndexReg_5 <= _IndexReg_5_T_1; // @[Voice.scala 37:19]
    end
    if (reset) begin // @[Voice.scala 23:30]
      OutputTempReg <= 23'sh0; // @[Voice.scala 23:30]
    end else if (SineGenerator_io_OutputValid) begin // @[Voice.scala 95:37]
      if (Mem_io_IsOutput) begin // @[Voice.scala 98:26]
        if (OpCounter == 3'h5 & _T_6) begin // @[Voice.scala 101:50]
          OutputTempReg <= 23'sh0; // @[Voice.scala 102:23]
        end else begin
          OutputTempReg <= _OutputTempReg_T_2; // @[Voice.scala 99:21]
        end
      end
    end
    if (reset) begin // @[Voice.scala 25:26]
      OutputReg <= 23'sh0; // @[Voice.scala 25:26]
    end else if (SineGenerator_io_OutputValid) begin // @[Voice.scala 95:37]
      if (Mem_io_IsOutput) begin // @[Voice.scala 98:26]
        if (OpCounter == 3'h5 & _T_6) begin // @[Voice.scala 101:50]
          OutputReg <= _OutputTempReg_T_2; // @[Voice.scala 103:19]
        end
      end
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
  WaveReg_0 = _RAND_0[19:0];
  _RAND_1 = {1{`RANDOM}};
  WaveReg_1 = _RAND_1[19:0];
  _RAND_2 = {1{`RANDOM}};
  WaveReg_2 = _RAND_2[19:0];
  _RAND_3 = {1{`RANDOM}};
  WaveReg_3 = _RAND_3[19:0];
  _RAND_4 = {1{`RANDOM}};
  WaveReg_4 = _RAND_4[19:0];
  _RAND_5 = {1{`RANDOM}};
  WaveReg_5 = _RAND_5[19:0];
  _RAND_6 = {1{`RANDOM}};
  OpCounter = _RAND_6[2:0];
  _RAND_7 = {1{`RANDOM}};
  ScaleReg = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  FreqReg_0 = _RAND_8[19:0];
  _RAND_9 = {1{`RANDOM}};
  FreqReg_1 = _RAND_9[19:0];
  _RAND_10 = {1{`RANDOM}};
  FreqReg_2 = _RAND_10[19:0];
  _RAND_11 = {1{`RANDOM}};
  FreqReg_3 = _RAND_11[19:0];
  _RAND_12 = {1{`RANDOM}};
  FreqReg_4 = _RAND_12[19:0];
  _RAND_13 = {1{`RANDOM}};
  FreqReg_5 = _RAND_13[19:0];
  _RAND_14 = {1{`RANDOM}};
  IndexReg_0 = _RAND_14[19:0];
  _RAND_15 = {1{`RANDOM}};
  IndexReg_1 = _RAND_15[19:0];
  _RAND_16 = {1{`RANDOM}};
  IndexReg_2 = _RAND_16[19:0];
  _RAND_17 = {1{`RANDOM}};
  IndexReg_3 = _RAND_17[19:0];
  _RAND_18 = {1{`RANDOM}};
  IndexReg_4 = _RAND_18[19:0];
  _RAND_19 = {1{`RANDOM}};
  IndexReg_5 = _RAND_19[19:0];
  _RAND_20 = {1{`RANDOM}};
  OutputTempReg = _RAND_20[22:0];
  _RAND_21 = {1{`RANDOM}};
  OutputReg = _RAND_21[22:0];
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
  output [19:0] io_Out
);
  wire  Voice0_clock; // @[Synth.scala 14:22]
  wire  Voice0_reset; // @[Synth.scala 14:22]
  wire [22:0] Voice0_io_WaveOut; // @[Synth.scala 14:22]
  wire [22:0] _io_Out_T = Voice0_io_WaveOut; // @[Synth.scala 17:31]
  Voice Voice0 ( // @[Synth.scala 14:22]
    .clock(Voice0_clock),
    .reset(Voice0_reset),
    .io_WaveOut(Voice0_io_WaveOut)
  );
  assign io_Out = _io_Out_T[19:0]; // @[Synth.scala 17:10]
  assign Voice0_clock = clock;
  assign Voice0_reset = reset;
endmodule
