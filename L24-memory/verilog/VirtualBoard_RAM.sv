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
/********* Seven-segment decoder instantiation **********/
logic [3:0] HD[7:0];  // 8 hexadecimal display 
SevenSegDecode ssdecode_inst7(.iData(HD[7]), .oSeg(SD7));
SevenSegDecode ssdecode_inst6(.iData(HD[6]), .oSeg(SD6));
SevenSegDecode ssdecode_inst5(.iData(HD[5]), .oSeg(SD5));
SevenSegDecode ssdecode_inst4(.iData(HD[4]), .oSeg(SD4));
SevenSegDecode ssdecode_inst3(.iData(HD[3]), .oSeg(SD3));
SevenSegDecode ssdecode_inst2(.iData(HD[2]), .oSeg(SD2));
SevenSegDecode ssdecode_inst1(.iData(HD[1]), .oSeg(SD1));
SevenSegDecode ssdecode_inst0(.iData(HD[0]), .oSeg(SD0));

/** The input port is replaced with an internal signal **/
wire reset  = PB[0];
wire clk    = PB[1];
wire [15:0] write_data  = S[15:0];
wire [15:0] address = S[31:16];
wire write_enable = S[32];
logic [15:0] read_data;

/************* The logic of this experiment *************/
RAM #(.ADDRWIDTH(8), .DATAWIDTH(16)) mem(.iClk(clk), .iWR(write_enable), 
    .iAddress(address), .iWriteData(write_data), .oReadData(read_data));

/****** Internal signal assignment to output port *******/
assign HD[0] = read_data[3:0];
assign HD[1] = read_data[7:4];
assign HD[2] = read_data[11:8];
assign HD[3] = read_data[15:12];
assign HD[4] = address[3:0];
assign HD[5] = address[6:4];
// assign HD[6] = address[:];
// assign HD[7] = address[:];
assign L[0] = write_enable;

endmodule

