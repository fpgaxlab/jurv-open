`include "definitions.sv"
module ALU
#(parameter N=32)
(
   input  wire  [N-1:0] iX, iY,
   input  wire  [3:0] iALUop,
   output logic [N-1:0]oF,
   output alu_defs::t_flag oFlag
);

import alu_defs::*;

wire [N-1:0] X = iX;
wire [N-1:0] Y = iY;

logic M0, S1, S0;
logic [N-1:0] A,B;
logic C0;
logic [N:0] result; // Bit width is N+1 bits

assign A = X;
assign B = Y ^ {N{M0}};
assign C0 = M0;

always_comb 
begin
   case ({S1,S0})
      2'b00: result = A + B + C0;        
      2'b01: result = X & Y;
      2'b10: result = X | Y;
      2'b11: result = X ^ Y;
      default: result = {(N+1){1'bx}};
   endcase
end

always_comb
begin
	case (iALUop)
		ADD:	{S1,S0,M0} = 3'b000;
		SUB:	{S1,S0,M0} = 3'b001;
		AND:	{S1,S0,M0} = 3'b010;
		OR: 	{S1,S0,M0} = 3'b100;
		XOR:	{S1,S0,M0} = 3'b110;
		default: {S1,S0,M0} = 3'b000;
	endcase
end

assign oF = result[N-1:0];
assign oFlag.sign = oF[N-1];
assign oFlag.zero = ~(|oF);
assign oFlag.overflow = ~A[N-1] & ~B[N-1] & oF[N-1] | A[N-1] & B[N-1] & ~oF[N-1] ;
assign oFlag.carryOut = (M0==1'b0) ? result[N] : ~result[N];
  
endmodule