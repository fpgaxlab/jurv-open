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
wire reset  = PB[0];
wire clk    = PB[1];
wire [3:0] data  = S[3:0];
wire load   = S[6];

/************* The logic of this experiment *************/
localparam N = 4;   // 字长

// flip-flop instantiation
wire [N-1:0] Q_ff;
DataReg #(N) flip_flop(.oQ(Q_ff), .iD(data), .iClk(clk), .iLoad(load), .iReset(reset));

// latch instantiation
wire [N-1:0] Q_latch;
DataLatch #(N) latch(.oQ(Q_latch), .iD(data), .iEn(load));

/****** Internal signal assignment to output port *******/
SevenSegDecode ssdecoder0(.iData(Q_ff), .oSeg(SD0));
SevenSegDecode ssdecoder1(.iData(Q_latch), .oSeg(SD1));
assign L[0] = load;
assign L[1] = load;

endmodule

