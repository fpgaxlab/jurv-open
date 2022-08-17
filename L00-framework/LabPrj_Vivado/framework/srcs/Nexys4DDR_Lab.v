`default_nettype none 
module Nexys4DDR_Lab(
    //////////// CLOCK //////////
    input wire  CLK100MHZ,       //Clock 100MHz
       
    //////////// LED //////////
    output wire [15:0]LED, 
    
	 /////////// Tri-color LED  ////////////////
//    output wire LED16_R,
//    output wire LED16_G,
//    output wire LED16_B,
//    output wire LED17_R,
//    output wire LED17_G,
//    output wire LED17_B,

    //////////// KEY //////////
    input wire   BTNU,        //button in the "up"    position
    input wire   BTNL,        //button in the "left"  position
    input wire   BTND,        //button in the "down"  position
    input wire   BTNR,        //button in the "right" position
    input wire   BTNC,        //button in the "center" position
    
    //////////// Switch //////////
    input wire  [15:0] sw,
    
    //////////// SEG7 //////////
    output wire DP, CG, CF, CE, CD, CC, CB, CA,
    output wire [7:0]AN,
    
    ///////// DEBUG IO //////////////////
    //位于板子右侧中部的JA插座的下排插孔
    input  wire JTCK,
    input  wire JTMS,
    input  wire JTDI,
    output wire JTDO
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
    // The logical level of the lit segment of actual component
    localparam LightLevelOfSevenSeg = {8{1'b0}}; 
    // The logical level when the actual LED is not lit   
    localparam DarkLevelOfLED = {N_LED{1'b0}};       
    // Logic level when the switch is turned down
    localparam DownLevelOfSwitch = {N_SW{1'b0}};

    // Actual components connected to virtual components
    assign LED[15:0] = vLED[15:0] ^ DarkLevelOfLED[15:0];
    assign vSWITCH[15:0] = sw[15:0] ^ DownLevelOfSwitch[15:0]; 
    assign vBUTTON[4:0] = {BTNC,BTNR,BTND,BTNL,BTNU} ^ ButtonReleaseLevel[4:0]; 
    
    // 未与实际元件连接的虚拟按键、开关默认值
    assign vSWITCH[N_SW-1:16] = {(N_SW-16){1'h0}};
    assign vBUTTON[N_BTN-1:5] = {(N_BTN-5){1'h0}}; 

    //动态扫描式七段数码管的连接
    wire [7:0] SSLED_SEL;   //动态扫描七段数码管的位选择（共阳极）
    wire [7:0] SSLED_SEG;   //动态扫描七段数码管的8个段 （含小数点）
    assign AN = SSLED_SEL;
    assign {DP, CG, CF, CE, CD, CC, CB, CA} = SSLED_SEG ^ LightLevelOfSevenSeg;
     
    // Connection of clock signal
    wire CLK_10M;
    wire CLOCK = CLK_10M;  

//------------ Virtual Top-level module instantiation ----------------------// 

    wire [N_BTN-1:0] bsc_btn;
    wire [N_SW-1:0]  bsc_sw;    
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

//------------------ JuTAG Scan Chain ---------------------------------------//
    wire TCK, JTCK_BUF1;
    IBUFG IBUFG_inst( .I(JTCK), .O(JTCK_BUF1));    
    BUFG  BUFG_inst ( .I(JTCK_BUF1), .O(TCK));
     
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

    // 七段数码管静态显示转动态显示
    SEG7_DISPLAY SEG7_DISPLAY_inst(   
        .iClk(CLK100MHZ),     
        .iSEG0(vSSLED[0]),      
        .iSEG1(vSSLED[1]),         
        .iSEG2(vSSLED[2]),      
        .iSEG3(vSSLED[3]),      
        .iSEG4(vSSLED[4]),      
        .iSEG5(vSSLED[5]),         
        .iSEG6(vSSLED[6]),      
        .iSEG7(vSSLED[7]),      
        .oSEL(SSLED_SEL),       
        .oSEG(SSLED_SEG)      
    );
    
    pll clock_pll (
        .clk_in1(CLK100MHZ),
        .clk_out1(CLK_10M)   //10MHz
    ); 

endmodule