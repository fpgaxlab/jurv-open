module DataReg
#(parameter N = 4)
(   output reg [N-1:0] oQ,
    input wire [N-1:0] iD,
    input wire Clk,
    input wire Load,
    input wire Reset
);
always @(posedge Clk or posedge Reset)
begin
  if (Reset)
		oQ <= 0;	
  else if (Load)
		oQ <= iD;
end
endmodule
