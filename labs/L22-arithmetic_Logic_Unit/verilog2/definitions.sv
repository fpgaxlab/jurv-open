`ifndef ALU_DEFS_SVH
`define ALU_DEFS_SVH
//tag::body[]
package alu_defs;

   typedef struct packed{
      logic sign; 
      logic zero; 
      logic overflow; 
      logic carryOut;
   } t_flag;
   
   enum logic [3:0] {
      ADD = 4'b0001,
      SUB = 4'b0010,
      AND = 4'b0011,
      OR  = 4'b0100,
      XOR = 4'b0101
   } aluop;

endpackage
//end::body[]
`endif