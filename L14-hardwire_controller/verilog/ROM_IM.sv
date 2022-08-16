module ROM_IM(
    input  wire  [3:0] iAddr,
    output logic [15:0] oData
);
logic [15:0] mem[0:15];
initial begin
         // 13  10 9 8 7 6 54 3 0
         // OPCODE Rs1 Rs2 Rd Imm
   mem[0] = 14'b0110_00_00_01_0101;  // addi r1, r0, #5
   mem[1] = 14'b1000_00_00_10_1010;  // ori  r2, r0, #10
   mem[2] = 14'b0010_01_10_11_0000;  // sub  r3, r1, r2  
   mem[3] = 14'b1011_10_11_00_0000;  // bne  r2, r3, #0
end

assign oData = mem[iAddr];

endmodule
