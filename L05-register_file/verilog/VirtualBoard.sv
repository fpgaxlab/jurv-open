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
wire clk    = PB[1];
wire [3:0] Data  = S[3:0];
wire [1:0] Index = S[5:4];
wire Load = S[6];

/************* The logic of this experiment *************/
localparam N = 4;
// 2-4 decode
logic load3, load2, load1, load0;
always_comb begin
    if (Load)
        case (Index)
            2'b00: {load3, load2, load1, load0} = 4'b0001;
            /*- TODO
                这里将译码器补充完整
                                                       -*/
            default: {load3, load2, load1, load0} = 4'bx;
        endcase
    else
        {load3, load2, load1, load0} = 4'b0000;
end

// register instantiation
logic [N-1:0] R0_Q, R1_Q, R2_Q, R3_Q;
DataReg #(N) R0(.oQ(R0_Q), .iD(Data), .Clk(clk), .Load(load0), .Reset(1'b0));
/*- TODO
    这里实例化其余的寄存器
                                                                          -*/

// 4-1 MUX
logic  [N-1:0] GRS_Q;
/*- TODO



    这里编写4选1多路器




 -*/

/****** Internal signal assignment to output port *******/
assign HD[0] = R0_Q;
assign HD[1] = R1_Q;
assign HD[2] = R2_Q;
assign HD[3] = R3_Q;
assign HD[4] = GRS_Q;
assign L[0] = load0;
assign L[1] = load1;
assign L[2] = load2;
assign L[3] = load3;

endmodule

