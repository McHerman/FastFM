module BindsTo_0_IntructionMemory(
  input        clock,
  input  [2:0] io_Step,
  output [5:0] io_ReadReg,
  output [2:0] io_WriteReg,
  output       io_IsOutput
);

initial begin
  $readmemh("Algorithm.txt", IntructionMemory.Mem);
end
                      endmodule

bind IntructionMemory BindsTo_0_IntructionMemory BindsTo_0_IntructionMemory_Inst(.*);