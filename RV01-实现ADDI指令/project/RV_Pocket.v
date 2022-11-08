// --------------------------------------------------------------------
// 远程实验板和口袋实验板的顶层模块
//
// 修订历史 :
// --------------------------------------------------------------------
//   版本  | 作者                      | 修改日期   | 所做改变
//   V1.0  | 肖铁军                    | 2017.08.29| 初始版本
//   V1.1  |                           | 2020.06.06| 存储器模块的地址对齐
//   V2.0  |                           | 2022.08   | 增加SoC层次
// --------------------------------------------------------------------

`default_nettype none
module RV_Pocket(

    //////////// CLOCK //////////
    input  wire         CLOCK_50,
    
    //////////// LED //////////
    output wire  [7:0]  LEDG,
    output wire [15:0]  LEDR,
     
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
    // wire [7:0] vSSLED [0:7];  // Virtual seven-segment display          
    wire [7:0]  vSSLED0;    //虚拟七段数码管0          
    wire [7:0]  vSSLED1;    //虚拟七段数码管1
    wire [7:0]  vSSLED2;    //虚拟七段数码管2
    wire [7:0]  vSSLED3;    //虚拟七段数码管3
    wire [7:0]  vSSLED4;    //虚拟七段数码管4
    wire [7:0]  vSSLED5;    //虚拟七段数码管5
    wire [7:0]  vSSLED6;    //虚拟七段数码管6
    wire [7:0]  vSSLED7;    //虚拟七段数码管7

    // Logic level settings of actual component
    // The logic level when the actual button is loosened
    localparam ButtonReleaseLevel = {1'b0}; 
    // The logical level of the lit segment of actual component
    localparam LightLevelOfSevenSeg = {1'b0}; 
    // The logical level when the actual LED is not lit   
    localparam DarkLevelOfLED = {1'b0};       

    // Actual components connected to virtual components
    assign LEDR[15:0] = vLED[15:0] ^ {16{DarkLevelOfLED}};
    assign LEDG[7:0] = vLED[25:18] ^ {8{DarkLevelOfLED}};
    // 未与实际元件连接的虚拟按键、开关默认值
    assign vSWITCH[N_SW-1:0] = {N_SW{1'b0}};
    assign vBUTTON[N_BTN-1:0] = {N_BTN{1'h0}}; 

//---------------------------------------------------------------------------//
    wire TCK;
    GlobalCLK global_TCK(
        .ena (1'b1),
        .inclk (JTCK),
        .outclk (TCK)
    );

    wire CLK_50,CLK_10,CLK_lag,clk_locked;
    pll clock_PLL(
        .inclk0 (CLOCK_50),
        .c0 (CLK_50), //50MHz
        .c1 (CLK_10), //10MHz
        .c2 (CLK_lag),//10MHz,30度相位滞后
        .locked (clk_locked)
    );
    wire CLK = CLK_10;
    wire RESET = ~clk_locked;

    SoC rv_soc(
        .RESET(RESET),
        .CLOCK(CLK_50),
        .CLK(CLK),
        .vSWITCH(vSWITCH),
        .vBUTTON(vBUTTON),
        .vLED(vLED),
        .vSSLED0(vSSLED0),
        .vSSLED1(vSSLED1),
        .vSSLED2(vSSLED2),
        .vSSLED3(vSSLED3),
        .vSSLED4(vSSLED4),
        .vSSLED5(vSSLED5),
        .vSSLED6(vSSLED6),
        .vSSLED7(vSSLED7),

        .TCK(TCK),
        .JTMS(JTMS),
        .JTDI(JTDI),
        .JTDO(JTDO)
    );

//---------------------------------------------------------------------------//

endmodule
