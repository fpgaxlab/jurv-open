`include "definitions.sv"
`default_nettype none 
module VirtualBoard (
    input  wire   CLOCK,      // 10 MHz Input Clock 
    input  wire  [19:0] PB,   // 20 Push Buttons, logical 1 when pressed
    input  wire  [35:0] S,    // 36 Switches
    output logic [35:0] L,    // 36 LEDs, drive logical 1 to light up
    output logic  [7:0] SD7,  // 8 common anode Seven-segment Display
    output logic  [7:0] SD6,
    output logic  [7:0] SD5,
    output logic  [7:0] SD4,
    output logic  [7:0] SD3,
    output logic  [7:0] SD2,
    output logic  [7:0] SD1,
    output logic  [7:0] SD0
); 

/** The input port is replaced with an internal signal **/
wire [3:0] ALUop = S[12:9];
wire [3:0] X = S[7:4];
wire [3:0] Y = S[3:0];

/************* The logic of this experiment *************/
wire [3:0] F;
alu_defs::t_flag flag;
ALU #(.N(4)) alu(
    .iX(X), 
    .iY(Y), 
    .iALUop(ALUop), 
    .oF(F), 
    .oFlag(flag));

/****** Internal signal assignment to output port *******/
assign L[12:9] = F;
assign L[21:18] = flag; //<=>{flag.sign, flag.zero, flag.overflow, flag.carryOut}

endmodule

