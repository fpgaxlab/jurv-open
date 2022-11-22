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
wire [2:0] num  = S[12:10];   //移位的位数

/************* The logic of this experiment *************/
logic [7:0] q, shiftOut;
always_comb
    case (num)
        3'b000: shiftOut = q[7:0];
        3'b001: shiftOut = {q[6:0],q[7]};
        3'b010: shiftOut = {q[5:0],q[7:6]};
        3'b011: shiftOut = {q[4:0],q[7:5]};
        3'b100: shiftOut = {q[3:0],q[7:4]};
        3'b101: shiftOut = {q[2:0],q[7:3]};
        3'b110: shiftOut = {q[1:0],q[7:2]};
        3'b111: shiftOut = {q[0],q[7:1]};
        default:shiftOut = 8'hxx;
	endcase
/*  
    也可用下面的语句实现一次移动多位的循环左移
    logic [7:0] temp;
    assign {shiftOut, temp} = {q,q}<<num;
*/
always @ (posedge clk or posedge reset)
	if (reset)
		q <= 1;
	else
		q <= shiftOut;

/****** Internal signal assignment to output port *******/
assign L[7:0] = q[7:0];
assign L[15:8] = shiftOut[7:0];

endmodule
