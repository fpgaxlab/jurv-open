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
wire [2:0]data0  = S[2:0];
wire [2:0]data1  = S[5:3];
wire [2:0]data2  = S[8:6];
wire oe0    = S[9];
wire oe1    = S[10];
wire oe2    = S[11];

/************* The logic of this experiment *************/
wire [2:0]out;
// Logic description of three-state buffer
assign out = oe0 ? data0 : 3'bZZZ;
assign out = oe1 ? data1 : 3'bZZZ;
assign out = oe2 ? data2 : 3'bZZZ;

// 用与或门构成数据选择器
// assign out = data0 & {3{oe0}} | data1 & {3{oe1}} | data2 & {3{oe2}};

/****** Internal signal assignment to output port *******/
assign L[2:0]   = out;

endmodule
