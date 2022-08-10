`default_nettype none
module LabBoard_TOP(
    //////////// CLOCK //////////
    input  wire         CLOCK_50,
    
    //////////// LED //////////
    output wire [15:0]  LEDR,
    output wire  [7:0]  LEDG,
    
    ///////// DEBUG IO ///////////
    input  wire         JTCK,
    input  wire         JTMS,
    input  wire         JTDI,
    output wire         JTDO
);
     
    // Virtual Component Declaration
    localparam N_LED = 36;
    localparam N_SW  = 36;
    localparam N_BTN = 20;
    wire [N_LED-1:0] vLED;    // Virtual LED    
    wire [N_SW-1:0]  vSWITCH; // Virtual Switch
    wire [N_BTN-1:0] vBUTTON; // Virtual Button
    wire [7:0] vSSLED [0:7];  // Virtual seven-segment display          

    // Logic level settings of actual component
    // The logic level when the actual button is loosened
    localparam ButtonReleaseLevel = {N_BTN{1'b0}}; 
    // Logic level of the lit segment of actual component
    localparam LightLevelOfSevenSeg = {8{1'b0}}; 
    // Logic level when the actual LED is not lit   
    localparam DarkLevelOfLED = {N_LED{1'b0}};       
    // Logic level when the switch is turned down
    localparam DownLevelOfSwitch = {N_SW{1'b0}};

    // Actual components connected to virtual components
    assign LEDR[15:0] = vLED[15:0] ^ DarkLevelOfLED[15:0];
    assign LEDG[7:0] = vLED[25:18] ^ DarkLevelOfLED[25:18];
    assign vSWITCH[N_SW-1:0] = {N_SW{1'b0}};
    assign vBUTTON[N_BTN-1:0] = {N_BTN{1'h0}}; 

    // Connection of clock signal
    wire CLK_50M, CLK_10M, CLK_1M;
    pll clock_pll(
        .inclk0 (CLOCK_50),
        .c0 (CLK_10M)  //10MHz
    );
    wire CLOCK = CLK_10M; 

//------------------ JuTAG Scan Chain ---------------------------------------//
    wire TCK;
    GlobalCLK globalTCK_inst(
        .ena(1'b1),
        .inclk (JTCK),
        .outclk (TCK)
    );
     
    wire [N_BTN-1:0] bsc_btn;
    wire [N_SW-1:0]  bsc_sw;
    JutagScanChain   jutagScanChain
    (              
        .iLED(vLED),   
        .iSWITCH(vSWITCH),
        .oSW_BSC(bsc_sw),
        .iBUTTON(vBUTTON),
        .oKEY_BSC(bsc_btn),
        .iSSLED0(vSSLED[0]),          
        .iSSLED1(vSSLED[1]),          
        .iSSLED2(vSSLED[2]),          
        .iSSLED3(vSSLED[3]),          
        .iSSLED4(vSSLED[4]),          
        .iSSLED5(vSSLED[5]),          
        .iSSLED6(vSSLED[6]),          
        .iSSLED7(vSSLED[7]), 
        .TCK(TCK),
        .TMS(JTMS),
        .TDI(JTDI),
        .TDO(JTDO)
    );

//------------ Virtual Top-level module instantiation ----------------------// 

    VirtualBoard Lab_inst
    (
        .CLOCK(CLOCK),
        .PB(bsc_btn),
        .S(bsc_sw),
        .L(vLED),
        .SD7(vSSLED[7]),
        .SD6(vSSLED[6]),
        .SD5(vSSLED[5]),
        .SD4(vSSLED[4]),
        .SD3(vSSLED[3]),
        .SD2(vSSLED[2]),
        .SD1(vSSLED[1]),
        .SD0(vSSLED[0])
    );

endmodule