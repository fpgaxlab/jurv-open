//ALU模块中的符号定义

`ifndef DEFINITIONS_SVH
`define DEFINITIONS_SVH

package defs;

   typedef struct packed{
      logic sign; 
      logic zero; 
      logic overflow; 
      logic carryOut;
   } t_flag;
    
   typedef struct packed{
      logic ge;
      logic lt; 
      logic ne; 
      logic eq; 
   } t_cmp;

   enum logic [3:0] {
      ADD = 4'b0001,
      SUB = 4'b0010,
      AND = 4'b0011,
      OR  = 4'b0100,
      XOR = 4'b0101,
      SRA = 4'b0110,
      SLL = 4'b0111,
      SRL = 4'b1000
   } aluop;

endpackage

`endif