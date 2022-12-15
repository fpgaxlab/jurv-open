module DataReg
#(parameter N = 4)
(   output reg [N-1:0] oQ,
    input wire [N-1:0] iD,
    input wire iClk,
    input wire iLoad,
    input wire iReset
);
always_ff @(posedge iClk or posedge iReset)
begin
  if (iReset)
		oQ <= 0;	
  else if (iLoad)
		oQ <= iD;
end
endmodule
