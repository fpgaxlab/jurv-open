`timescale 1ns / 100ps
module tb_soc();

reg rst;
reg fpga_clk;
reg sys_clk;

SoC uut(
    .RESET(rst),
    .CLOCK(fpga_clk),
    .CLK(sys_clk)
);

initial begin 
	fpga_clk = 0;
    sys_clk = 0;
    rst = 1;
    #10 rst = 0;
end

initial begin
	forever #10 fpga_clk = ~fpga_clk;	//50Mhz
end

initial begin
	forever #50 sys_clk = ~sys_clk;	//10Mhz
end

endmodule