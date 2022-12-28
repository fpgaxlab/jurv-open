//立即数生成模块
module ImmGen( 
   input  riscv_defs::t_imm  iImm_type,
   input  wire  [31:7] iInstrImm,
   output logic [31:0] oImmediate
);
wire [31:7]/*注意起始下标*/ instr = iInstrImm;

/*- 符号扩展为32位立即数。 -*/
assign oImmediate =  
    {32{iImm_type.I}} & {{20{instr[31]}}, instr[30:20]};

endmodule
