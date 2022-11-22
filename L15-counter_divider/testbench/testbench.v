`timescale 1ns/100ps
module testbench;
   reg reset, clock;
   wire [19:0]pb;
   assign pb[0] = reset;
   
   VirtualBoard UUT (.CLOCK(clock), .PB(pb));
   
   initial begin
      reset=1'b1;
      clock=1'b0; 
   end
   initial #150 reset = 1'b0;
   always #50 clock = ~clock;
   initial #1000000 $stop; //$finish
   
endmodule
