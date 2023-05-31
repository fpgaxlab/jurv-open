module ImmGen( 
   input  riscv_defs::t_imm  iImmType,
   input  wire  [31:7]/*注意起始下标*/ iInstrImm,
   output logic [31:0] oImmediate
);

endmodule
