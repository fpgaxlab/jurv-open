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
wire reset = PB[0];
wire clk   = PB[1];

/************* The logic of this experiment *************/
logic [7:0]q;
always @ (posedge clk or posedge reset)
	if (reset)
		q <= 1;
	else
		q <= {q[6:0], q[7]};

/****** Internal signal assignment to output port *******/
assign L[7:0] = q[7:0];

endmodule
