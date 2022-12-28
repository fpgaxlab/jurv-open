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
SevenSegDecode ssdecoder7(.iData(HD[7]), .oSeg(SD7));
SevenSegDecode ssdecoder6(.iData(HD[6]), .oSeg(SD6));
SevenSegDecode ssdecoder5(.iData(HD[5]), .oSeg(SD5));
SevenSegDecode ssdecoder4(.iData(HD[4]), .oSeg(SD4));
SevenSegDecode ssdecoder3(.iData(HD[3]), .oSeg(SD3));
SevenSegDecode ssdecoder2(.iData(HD[2]), .oSeg(SD2));
SevenSegDecode ssdecoder1(.iData(HD[1]), .oSeg(SD1));
SevenSegDecode ssdecoder0(.iData(HD[0]), .oSeg(SD0));

/** The input port is replaced with an internal signal **/
wire reset  = PB[0];
wire clk    = PB[1];
wire [1:0] read_addr1 = S[1:0];
wire [1:0] read_addr2 = S[3:2];
wire [1:0] write_addr = S[5:4];
wire write_enable = S[6];
wire y_sel = S[7];
wire [3:0] input_data = S[11:8];
wire [3:0] op = S[15:12];

/************* The logic of this experiment *************/

//各模块间连线信号
wire [3:0] alu_result, alu_y, read_data1, read_data2;
defs::t_cmp cmp;

assign alu_y = y_sel ? input_data : read_data2;
ALU #(.N(4)) alu(
    .iX(read_data1), 
    .iY(alu_y), 
    .iALUop(op), 
    .oF(alu_result), 
    .oCmp(cmp));

RegisterFile #(.DATAWIDTH(4), .ADDRWIDTH(2)) rf (.iClk(clk), 
    .iWE(write_enable), .iWA(write_addr), .iWD(alu_result), 
    .iRA1(read_addr1), .oRD1(read_data1),
    .iRA2(read_addr2), .oRD2(read_data2));

/****** Internal signal assignment to output port *******/
assign HD[0] = alu_y;
assign HD[1] = read_data1;
assign HD[2] = read_data2;
assign HD[3] = alu_result;
assign L[21:18] = cmp;

endmodule

