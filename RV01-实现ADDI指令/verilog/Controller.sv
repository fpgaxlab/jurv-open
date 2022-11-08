
module Controller(
   input  wire  [6:0] iOpcode,
   input  wire  [2:0] iFunct3,
   /*- TODO：扩充指令时在这里增加端口 -*/
   output logic oRegWrite,   
   output riscv_defs::t_imm oImm_type
);

always_comb
   case(iOpcode)
   /*- TODO：在这里补充其他类型的指令译码 ...... -*/
   7'b0010011: begin   //I型格式的运算类指令
      /* 注：尚未根据Funct3区分具体指令，
      相当于把所有I型运算指令视为addi指令 */
      oImm_type = 5'b00001; //{J,U,B,S,I}
      oRegWrite = 1'b1;
   end
   default: begin  //非法opcode
      oImm_type = 5'b00000;
      oRegWrite = 1'b0;
   end
   endcase

endmodule

