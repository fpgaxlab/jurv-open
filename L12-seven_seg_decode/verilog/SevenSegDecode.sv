module SevenSegDecode(
    input  wire  [3:0] iData,
    output logic [7:0] oSeg
);

always_comb
begin
   case(iData)
   /*-TODO：添加七段译码逻辑
   4'h0: oSeg = 8'...;
   ...  */
   default: oSeg = 8'bx;
   endcase
end
    
endmodule
