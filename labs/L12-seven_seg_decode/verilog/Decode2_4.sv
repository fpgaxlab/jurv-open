module Decode2_4 (
   input  wire  iEn,
   input  wire  [1:0] iA,
   output logic [3:0] oY
);

always_comb
begin
   if (iEn)
      case (iA)
         2'b00 : oY=4'h1;
         2'b01 : oY=4'h2;
         2'b10 : oY=4'h4;
         2'b11 : oY=4'h8;	
         default:oY=4'bx;	
      endcase
   else
      oY=4'b0;
end

endmodule
