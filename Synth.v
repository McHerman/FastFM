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
  input  [19:0] io_Index
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire [17:0] DSP_io_Input1; // @[SineGenerator.scala 11:19]
  wire [17:0] DSP_io_Input2; // @[SineGenerator.scala 11:19]
  wire [35:0] DSP_io_Out; // @[SineGenerator.scala 11:19]
  reg  OpCounter; // @[SineGenerator.scala 13:26]
  reg [17:0] WaveReg; // @[SineGenerator.scala 21:24]
  reg [19:0] WaveReg2; // @[SineGenerator.scala 22:25]
  wire [17:0] _IndexAr_T_3 = 18'h3ffff - io_Index[17:0]; // @[SineGenerator.scala 34:27]
  wire [17:0] IndexAr = io_Index[18] ? io_Index[17:0] : _IndexAr_T_3; // @[SineGenerator.scala 31:28 32:13 34:13]
  wire [35:0] DSPOut = DSP_io_Out; // @[SineGenerator.scala 27:20 29:10]
  wire [19:0] _WaveReg2_T_1 = {1'b0,$signed(DSPOut[35:17])}; // @[SineGenerator.scala 44:34]
  wire [19:0] _WaveReg2_T_4 = 20'sh0 - $signed(_WaveReg2_T_1); // @[SineGenerator.scala 44:19]
  wire [17:0] _WaveReg_T_2 = 18'h3ffff - DSPOut[35:18]; // @[SineGenerator.scala 49:25]
  DSP DSP ( // @[SineGenerator.scala 11:19]
    .io_Input1(DSP_io_Input1),
    .io_Input2(DSP_io_Input2),
    .io_Out(DSP_io_Out)
  );
  assign io_WaveOut = WaveReg2; // @[SineGenerator.scala 25:14]
  assign DSP_io_Input1 = OpCounter ? WaveReg : IndexAr; // @[SineGenerator.scala 37:23]
  assign DSP_io_Input2 = OpCounter ? 18'h3ffff : IndexAr; // @[SineGenerator.scala 38:23]
  always @(posedge clock) begin
    if (reset) begin // @[SineGenerator.scala 13:26]
      OpCounter <= 1'h0; // @[SineGenerator.scala 13:26]
    end else if (OpCounter) begin // @[SineGenerator.scala 17:26]
      OpCounter <= 1'h0; // @[SineGenerator.scala 18:15]
    end else begin
      OpCounter <= OpCounter + 1'h1; // @[SineGenerator.scala 15:13]
    end
    if (reset) begin // @[SineGenerator.scala 21:24]
      WaveReg <= 18'h0; // @[SineGenerator.scala 21:24]
    end else if (!(OpCounter)) begin // @[SineGenerator.scala 42:25]
      WaveReg <= _WaveReg_T_2; // @[SineGenerator.scala 49:13]
    end
    if (reset) begin // @[SineGenerator.scala 22:25]
      WaveReg2 <= 20'sh0; // @[SineGenerator.scala 22:25]
    end else if (OpCounter) begin // @[SineGenerator.scala 42:25]
      if (io_Index[19]) begin // @[SineGenerator.scala 43:30]
        WaveReg2 <= _WaveReg2_T_4; // @[SineGenerator.scala 44:16]
      end else begin
        WaveReg2 <= _WaveReg2_T_1; // @[SineGenerator.scala 46:16]
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
  input        clock,
  input  [2:0] io_Step,
  output [5:0] io_ReadReg,
  output [2:0] io_WriteReg,
  output       io_IsOutput
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] Mem [0:255]; // @[IntructionMemory.scala 15:24]
  wire  Mem_Data_MPORT_en; // @[IntructionMemory.scala 15:24]
  wire [7:0] Mem_Data_MPORT_addr; // @[IntructionMemory.scala 15:24]
  wire [9:0] Mem_Data_MPORT_data; // @[IntructionMemory.scala 15:24]
  reg  Mem_Data_MPORT_en_pipe_0;
  reg [7:0] Mem_Data_MPORT_addr_pipe_0;
  wire [7:0] _GEN_0 = {{5'd0}, io_Step}; // @[IntructionMemory.scala 22:42]
  wire [8:0] _Data_T_1 = {{1'd0}, _GEN_0}; // @[IntructionMemory.scala 22:42]
  wire [9:0] Data = Mem_Data_MPORT_data; // @[IntructionMemory.scala 19:18 22:8]
  assign Mem_Data_MPORT_en = Mem_Data_MPORT_en_pipe_0;
  assign Mem_Data_MPORT_addr = Mem_Data_MPORT_addr_pipe_0;
  assign Mem_Data_MPORT_data = Mem[Mem_Data_MPORT_addr]; // @[IntructionMemory.scala 15:24]
  assign io_ReadReg = Data[5:0]; // @[IntructionMemory.scala 23:21]
  assign io_WriteReg = Data[8:6]; // @[IntructionMemory.scala 24:22]
  assign io_IsOutput = Data[9]; // @[IntructionMemory.scala 25:22]
  always @(posedge clock) begin
    Mem_Data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      Mem_Data_MPORT_addr_pipe_0 <= _Data_T_1[7:0];
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    Mem[initvar] = _RAND_0[9:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  Mem_Data_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  Mem_Data_MPORT_addr_pipe_0 = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
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
`endif // RANDOMIZE_REG_INIT
  wire  SineGenerator_clock; // @[Voice.scala 19:29]
  wire  SineGenerator_reset; // @[Voice.scala 19:29]
  wire [19:0] SineGenerator_io_WaveOut; // @[Voice.scala 19:29]
  wire [19:0] SineGenerator_io_Index; // @[Voice.scala 19:29]
  wire  Mem_clock; // @[Voice.scala 45:19]
  wire [2:0] Mem_io_Step; // @[Voice.scala 45:19]
  wire [5:0] Mem_io_ReadReg; // @[Voice.scala 45:19]
  wire [2:0] Mem_io_WriteReg; // @[Voice.scala 45:19]
  wire  Mem_io_IsOutput; // @[Voice.scala 45:19]
  reg [19:0] WaveReg_0; // @[Voice.scala 12:20]
  reg [19:0] WaveReg_1; // @[Voice.scala 12:20]
  reg [19:0] WaveReg_2; // @[Voice.scala 12:20]
  reg [19:0] WaveReg_3; // @[Voice.scala 12:20]
  reg [19:0] WaveReg_4; // @[Voice.scala 12:20]
  reg [19:0] WaveReg_5; // @[Voice.scala 12:20]
  reg [2:0] OpCounter; // @[Voice.scala 16:26]
  reg [1:0] ScaleReg; // @[Voice.scala 17:25]
  reg [22:0] OutputReg; // @[Voice.scala 24:26]
  wire [1:0] _ScaleReg_T_1 = ScaleReg + 2'h1; // @[Voice.scala 35:24]
  wire  _T_6 = ScaleReg == 2'h2; // @[Voice.scala 37:17]
  wire [2:0] _OpCounter_T_1 = OpCounter + 3'h1; // @[Voice.scala 38:28]
  reg [22:0] OutputTempReg; // @[Voice.scala 52:30]
  wire [19:0] _GEN_14 = Mem_io_ReadReg[0] ? $signed(WaveReg_0) : $signed(20'sh0); // @[Voice.scala 59:28 61:22 67:22]
  wire [22:0] IndexTemp_0 = {{3{_GEN_14[19]}},_GEN_14}; // @[Voice.scala 56:23]
  wire [22:0] _GEN_44 = {{3{WaveReg_1[19]}},WaveReg_1}; // @[Voice.scala 63:40]
  wire [22:0] _IndexTemp_1_T_2 = $signed(IndexTemp_0) + $signed(_GEN_44); // @[Voice.scala 63:40]
  wire [22:0] IndexTemp_1 = Mem_io_ReadReg[1] ? $signed(_IndexTemp_1_T_2) : $signed(IndexTemp_0); // @[Voice.scala 59:28 63:22 69:22]
  wire [22:0] _GEN_45 = {{3{WaveReg_2[19]}},WaveReg_2}; // @[Voice.scala 63:40]
  wire [22:0] _IndexTemp_2_T_2 = $signed(IndexTemp_1) + $signed(_GEN_45); // @[Voice.scala 63:40]
  wire [22:0] IndexTemp_2 = Mem_io_ReadReg[2] ? $signed(_IndexTemp_2_T_2) : $signed(IndexTemp_1); // @[Voice.scala 59:28 63:22 69:22]
  wire [22:0] _GEN_46 = {{3{WaveReg_3[19]}},WaveReg_3}; // @[Voice.scala 63:40]
  wire [22:0] _IndexTemp_3_T_2 = $signed(IndexTemp_2) + $signed(_GEN_46); // @[Voice.scala 63:40]
  wire [22:0] IndexTemp_3 = Mem_io_ReadReg[3] ? $signed(_IndexTemp_3_T_2) : $signed(IndexTemp_2); // @[Voice.scala 59:28 63:22 69:22]
  wire [22:0] _GEN_47 = {{3{WaveReg_4[19]}},WaveReg_4}; // @[Voice.scala 63:40]
  wire [22:0] _IndexTemp_4_T_2 = $signed(IndexTemp_3) + $signed(_GEN_47); // @[Voice.scala 63:40]
  wire [22:0] IndexTemp_4 = Mem_io_ReadReg[4] ? $signed(_IndexTemp_4_T_2) : $signed(IndexTemp_3); // @[Voice.scala 59:28 63:22 69:22]
  wire [22:0] _GEN_48 = {{3{WaveReg_5[19]}},WaveReg_5}; // @[Voice.scala 63:40]
  wire [22:0] _IndexTemp_5_T_2 = $signed(IndexTemp_4) + $signed(_GEN_48); // @[Voice.scala 63:40]
  wire [22:0] _SineGenerator_io_Index_T = Mem_io_ReadReg[5] ? $signed(_IndexTemp_5_T_2) : $signed(IndexTemp_4); // @[Voice.scala 74:42]
  wire [2:0] _T_16 = Mem_io_WriteReg - 3'h1; // @[Voice.scala 78:29]
  wire [19:0] _WaveReg_T_16 = SineGenerator_io_WaveOut; // @[Voice.scala 78:{36,36}]
  wire [22:0] _GEN_49 = {{3{SineGenerator_io_WaveOut[19]}},SineGenerator_io_WaveOut}; // @[Voice.scala 81:35]
  wire [22:0] _OutputTemp_T_2 = $signed(OutputTempReg) + $signed(_GEN_49); // @[Voice.scala 81:35]
  wire [22:0] _GEN_32 = Mem_io_IsOutput ? $signed(_OutputTemp_T_2) : $signed(23'sh0); // @[Voice.scala 54:14 80:26 81:18]
  wire [22:0] OutputTemp = _T_6 ? $signed(_GEN_32) : $signed(23'sh0); // @[Voice.scala 54:14 77:25]
  SineGenerator SineGenerator ( // @[Voice.scala 19:29]
    .clock(SineGenerator_clock),
    .reset(SineGenerator_reset),
    .io_WaveOut(SineGenerator_io_WaveOut),
    .io_Index(SineGenerator_io_Index)
  );
  IntructionMemory Mem ( // @[Voice.scala 45:19]
    .clock(Mem_clock),
    .io_Step(Mem_io_Step),
    .io_ReadReg(Mem_io_ReadReg),
    .io_WriteReg(Mem_io_WriteReg),
    .io_IsOutput(Mem_io_IsOutput)
  );
  assign io_WaveOut = OutputReg; // @[Voice.scala 94:14]
  assign SineGenerator_clock = clock;
  assign SineGenerator_reset = reset;
  assign SineGenerator_io_Index = _SineGenerator_io_Index_T[19:0]; // @[Voice.scala 74:26]
  assign Mem_clock = clock;
  assign Mem_io_Step = OpCounter; // @[Voice.scala 47:15]
  always @(posedge clock) begin
    if (_T_6) begin // @[Voice.scala 77:25]
      if (3'h0 == _T_16) begin // @[Voice.scala 78:36]
        WaveReg_0 <= _WaveReg_T_16; // @[Voice.scala 78:36]
      end
    end
    if (_T_6) begin // @[Voice.scala 77:25]
      if (3'h1 == _T_16) begin // @[Voice.scala 78:36]
        WaveReg_1 <= _WaveReg_T_16; // @[Voice.scala 78:36]
      end
    end
    if (_T_6) begin // @[Voice.scala 77:25]
      if (3'h2 == _T_16) begin // @[Voice.scala 78:36]
        WaveReg_2 <= _WaveReg_T_16; // @[Voice.scala 78:36]
      end
    end
    if (_T_6) begin // @[Voice.scala 77:25]
      if (3'h3 == _T_16) begin // @[Voice.scala 78:36]
        WaveReg_3 <= _WaveReg_T_16; // @[Voice.scala 78:36]
      end
    end
    if (_T_6) begin // @[Voice.scala 77:25]
      if (3'h4 == _T_16) begin // @[Voice.scala 78:36]
        WaveReg_4 <= _WaveReg_T_16; // @[Voice.scala 78:36]
      end
    end
    if (_T_6) begin // @[Voice.scala 77:25]
      if (3'h5 == _T_16) begin // @[Voice.scala 78:36]
        WaveReg_5 <= _WaveReg_T_16; // @[Voice.scala 78:36]
      end
    end
    if (reset) begin // @[Voice.scala 16:26]
      OpCounter <= 3'h0; // @[Voice.scala 16:26]
    end else if (OpCounter == 3'h6) begin // @[Voice.scala 41:26]
      OpCounter <= 3'h0; // @[Voice.scala 42:15]
    end else if (ScaleReg == 2'h2) begin // @[Voice.scala 37:25]
      OpCounter <= _OpCounter_T_1; // @[Voice.scala 38:15]
    end
    if (reset) begin // @[Voice.scala 17:25]
      ScaleReg <= 2'h0; // @[Voice.scala 17:25]
    end else begin
      ScaleReg <= _ScaleReg_T_1; // @[Voice.scala 35:12]
    end
    if (reset) begin // @[Voice.scala 24:26]
      OutputReg <= 23'sh0; // @[Voice.scala 24:26]
    end else if (OpCounter == 3'h5) begin // @[Voice.scala 88:26]
      if (_T_6) begin // @[Voice.scala 77:25]
        if (Mem_io_IsOutput) begin // @[Voice.scala 80:26]
          OutputReg <= _OutputTemp_T_2; // @[Voice.scala 81:18]
        end else begin
          OutputReg <= 23'sh0; // @[Voice.scala 54:14]
        end
      end else begin
        OutputReg <= 23'sh0; // @[Voice.scala 54:14]
      end
    end
    if (reset) begin // @[Voice.scala 52:30]
      OutputTempReg <= 23'sh0; // @[Voice.scala 52:30]
    end else if (OpCounter == 3'h5) begin // @[Voice.scala 88:26]
      OutputTempReg <= 23'sh0; // @[Voice.scala 90:19]
    end else if (_T_6) begin // @[Voice.scala 77:25]
      if (Mem_io_IsOutput) begin // @[Voice.scala 80:26]
        OutputTempReg <= OutputTemp; // @[Voice.scala 82:21]
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
  OutputReg = _RAND_8[22:0];
  _RAND_9 = {1{`RANDOM}};
  OutputTempReg = _RAND_9[22:0];
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
  wire [22:0] Voice0_io_WaveOut; // @[Synth.scala 14:22]
  wire [22:0] _io_Out_T_4 = $signed(Voice0_io_WaveOut) - 23'sh1; // @[Synth.scala 17:54]
  Voice Voice0 ( // @[Synth.scala 14:22]
    .clock(Voice0_clock),
    .reset(Voice0_reset),
    .io_WaveOut(Voice0_io_WaveOut)
  );
  assign io_Out = _io_Out_T_4[19:0]; // @[Synth.scala 17:10]
  assign Voice0_clock = clock;
  assign Voice0_reset = reset;
endmodule
