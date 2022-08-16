`default_nettype none 
`include "definitions.sv"
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

/************* The logic of this experiment *************/
// 程序计数器PC
logic [3:0] pc;
always@(posedge clk or posedge reset)
begin

end

// 指令存储器
logic [15:0] instruction;  // instruction code
ROM_IM instrMem(.iAddr(pc), .oData(instruction));  
wire [3:0] opcode       = ; //
wire [1:0] read_addr1 = ; //
wire [1:0] read_addr2 = ; //
wire [1:0] write_addr  = ; //
wire [3:0] imm_data   = ; //

// 控制器
defs::t_cmp cmp;
wire write_enable, y_sel, load_pc;
wire [3:0] alu_op;
Controller Controller_inst(
   .iOpcode(opcode), .iCmp(cmp), 
   .oALUop(alu_op), .oYsel(y_sel), 
   .oRegWr(write_enable), .oPCld(load_pc) );

// 数据通路部分
wire [3:0] alu_result, alu_y, read_data1, read_data2;
RegFile #(4) RF_inst(.Clk(clk), 
      .iWE(write_enable), .iWA(write_addr), .iWD(alu_result), 
      .iRA1(read_addr1), .oRD1(read_data1),
      .iRA2(read_addr2), .oRD2(read_data2));
assign alu_y = y_sel ? imm_data : read_data2;
ALU #(.N(4)) alu(
    .iX(read_data1), 
    .iY(alu_y), 
    .iALUop(alu_op), 
    .oF(alu_result), 
    .oCmp(cmp));

/****** Internal signal assignment to output port *******/
assign HD[0] = alu_y;
assign HD[1] = read_data1;
assign HD[2] = read_data2;
assign HD[3] = alu_result;
assign HD[4] = imm_data;
assign HD[5] = pc;
assign L[25:22] = opcode;
assign L[21:18] = cmp;
assign L[12:11] = read_addr1;
assign L[10:9] = read_addr2;
assign L[8:7] = write_addr;
assign L[6] = load_pc;
assign L[5] = write_enable;
assign L[4] = y_sel;
assign L[3:0] = alu_op;

endmodule
