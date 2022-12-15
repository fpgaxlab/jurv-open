module DataLatch
#(parameter N = 4)
(   output reg [N-1:0] oQ,
    input wire [N-1:0] iD,
    input wire iEn
);
always_latch
begin
  if (iEn)
		oQ <= iD;
end
endmodule
