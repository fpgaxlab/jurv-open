// --------------------------------------------------------------------
// DE2-115教育开发板的顶层模块 
// --------------------------------------------------------------------
//
// --------------------------------------------------------------------

`default_nettype none
module RV_DE2_115(
    //////////// CLOCK //////////
    input  wire         CLOCK_50,
    input  wire         CLOCK2_50,
    input  wire         CLOCK3_50,
    input  wire         ENETCLK_25,
    
    //////////// Sma //////////
    input  wire         SMA_CLKIN,
    output wire         SMA_CLKOUT,
    
    //////////// LED //////////
    output wire  [8:0]  LEDG,
    output wire [17:0]  LEDR,
    
    //////////// KEY //////////
    input  wire  [3:0]  KEY,
    
    //////////// SW //////////
    input  wire [17:0]  SW,
    
    //////////// SEG7 //////////
    output wire  [6:0]  HEX0,
    output wire  [6:0]  HEX1,
    output wire  [6:0]  HEX2,
    output wire  [6:0]  HEX3,
    output wire  [6:0]  HEX4,
    output wire  [6:0]  HEX5,
    output wire  [6:0]  HEX6,
    output wire  [6:0]  HEX7,
    
    //////////// LCD //////////
    output wire         LCD_BLON,
    inout  wire  [7:0]  LCD_DATA,
    output wire         LCD_EN,
    output wire         LCD_ON,
    output wire         LCD_RS,
    output wire         LCD_RW,
    
    //////////// RS232 //////////
    output wire         UART_CTS,
    input  wire         UART_RTS,
    input  wire         UART_RXD,
    output wire         UART_TXD,
    
    //////////// PS2 //////////
    inout  wire         PS2_CLK,
    inout  wire         PS2_DAT,
    inout  wire         PS2_CLK2,
    inout  wire         PS2_DAT2,
    
    //////////// SDCARD //////////
    output wire         SD_CLK,
    inout  wire         SD_CMD,
    inout  wire  [3:0]  SD_DAT,
    input  wire         SD_WP_N,
    
    //////////// VGA //////////
    output wire  [7:0]  VGA_B,
    output wire         VGA_BLANK_N,
    output wire         VGA_CLK,
    output wire  [7:0]  VGA_G,
    output wire         VGA_HS,
    output wire  [7:0]  VGA_R,
    output wire         VGA_SYNC_N,
    output wire         VGA_VS,
    
    //////////// Audio //////////
    input  wire         AUD_ADCDAT,
    inout  wire         AUD_ADCLRCK,
    inout  wire         AUD_BCLK,
    output wire         AUD_DACDAT,
    inout  wire         AUD_DACLRCK,
    output wire         AUD_XCK,
    
    //////////// I2C for EEPROM //////////
    output wire         EEP_I2C_SCLK,
    inout  wire         EEP_I2C_SDAT,
    
    //////////// I2C for Audio and Tv-Decode //////////
    output wire         I2C_SCLK,
    inout  wire         I2C_SDAT,
    
    //////////// Ethernet 0 //////////
    output wire         ENET0_GTX_CLK,
    input  wire         ENET0_INT_N,
    output wire         ENET0_MDC,
    inout  wire         ENET0_MDIO,
    output wire         ENET0_RST_N,
    input  wire         ENET0_RX_CLK,
    input  wire         ENET0_RX_COL,
    input  wire         ENET0_RX_CRS,
    input  wire  [3:0]  ENET0_RX_DATA,
    input  wire         ENET0_RX_DV,
    input  wire         ENET0_RX_ER,
    input  wire         ENET0_TX_CLK,
    output wire  [3:0]  ENET0_TX_DATA,
    output wire         ENET0_TX_EN,
    output wire         ENET0_TX_ER,
    input  wire         ENET0_LINK100,
    
    //////////// Ethernet 1 //////////
    output wire         ENET1_GTX_CLK,
    input  wire         ENET1_INT_N,
    output wire         ENET1_MDC,
    inout  wire         ENET1_MDIO,
    output wire         ENET1_RST_N,
    input  wire         ENET1_RX_CLK,
    input  wire         ENET1_RX_COL,
    input  wire         ENET1_RX_CRS,
    input  wire  [3:0]  ENET1_RX_DATA,
    input  wire         ENET1_RX_DV,
    input  wire         ENET1_RX_ER,
    input  wire         ENET1_TX_CLK,
    output wire  [3:0]  ENET1_TX_DATA,
    output wire         ENET1_TX_EN,
    output wire         ENET1_TX_ER,
    input  wire         ENET1_LINK100,
    
    //////////// TV Decoder 1 //////////
    input  wire         TD_CLK27,
    input  wire  [7:0]  TD_DATA,
    input  wire         TD_HS,
    output wire         TD_RESET_N,
    input  wire         TD_VS,
    
    
    //////////// USB OTG controller //////////
    inout  wire [15:0]  OTG_DATA,
    output wire  [1:0]  OTG_ADDR,
    output wire         OTG_CS_N,
    output wire         OTG_WR_N,
    output wire         OTG_RD_N,
    input  wire         OTG_INT,
    output wire         OTG_RST_N,
    
    //////////// IR Receiver //////////
    input  wire         IRDA_RXD,
    
    //////////// SDRAM //////////
    output wire [12:0]  DRAM_ADDR,
    output wire  [1:0]  DRAM_BA,
    output wire         DRAM_CAS_N,
    output wire         DRAM_CKE,
    output wire         DRAM_CLK,
    output wire         DRAM_CS_N,
    inout  wire [31:0]  DRAM_DQ,
    output wire  [3:0]  DRAM_DQM,
    output wire         DRAM_RAS_N,
    output wire         DRAM_WE_N,
    
    //////////// SRAM //////////
    output wire [19:0]  SRAM_ADDR,
    inout  wire [15:0]  SRAM_DQ,
    output wire         SRAM_CE_N,
    output wire         SRAM_LB_N,
    output wire         SRAM_OE_N,
    output wire         SRAM_UB_N,
    output wire         SRAM_WE_N,
    
    //////////// Flash //////////
    output wire [22:0]  FL_ADDR,
    output wire         FL_CE_N,
    inout  wire  [7:0]  FL_DQ,
    output wire         FL_OE_N,
    output wire         FL_RST_N,
    input  wire         FL_RY,
    output wire         FL_WE_N,
    output wire         FL_WP_N,
    
    //////////// GPIO //////////
    inout  wire [35:0]  GPIO,
    
    //////////// HSMC (LVDS) //////////
    
    //input  wire        HSMC_CLKIN_N1;
    //input  wire        HSMC_CLKIN_N2;
    input  wire         HSMC_CLKIN_P1,
    input  wire         HSMC_CLKIN_P2,
    input  wire         HSMC_CLKIN0,
    //output wire         HSMC_CLKOUT_N1;
    //output wire         HSMC_CLKOUT_N2;
    output wire         HSMC_CLKOUT_P1,
    output wire         HSMC_CLKOUT_P2,
    output wire         HSMC_CLKOUT0,
    inout  wire  [3:0]  HSMC_D,
    //input  wire[16:0]  HSMC_RX_D_N;
    input  wire [16:0]  HSMC_RX_D_P,
    //output wire [16:0]  HSMC_TX_D_N;
    output wire [16:0]  HSMC_TX_D_P,
    
    ///////// DEBUG IO ///////////
    input  wire         JTCK,
    input  wire         JTMS,
    input  wire         JTDI,
    output wire         JTDO
);

//---------------------------------------------------------------------------//

    // 虚拟元件声明
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
    localparam ButtonReleaseLevel = {1'b1}; 
    // The logical level of the lit segment of actual component
    localparam LightLevelOfSevenSeg = {1'b0}; 
    // The logical level when the actual LED is not lit   
    localparam DarkLevelOfLED = {1'b0};       

    // 实际元件与虚拟元件连接
    assign LEDR[15:0]  = vLED[23:8]  ^ {16{DarkLevelOfLED}};
    assign LEDG[7:0]   = vLED[7:0]   ^ {8{DarkLevelOfLED}};
    assign LEDR[17:16] = vLED[25:24] ^ {2{DarkLevelOfLED}};
    assign LEDG[8]     = vLED[35]    ^ {1{DarkLevelOfLED}};
    assign vSWITCH[17:0] = SW[17:0];
    assign vBUTTON[3:0] = KEY[3:0] ^ {4{ButtonReleaseLevel}};
    assign HEX0 = vSSLED0[6:0] ^ {7{LightLevelOfSevenSeg}};          
    assign HEX1 = vSSLED1[6:0] ^ {7{LightLevelOfSevenSeg}};
    assign HEX2 = vSSLED2[6:0] ^ {7{LightLevelOfSevenSeg}};
    assign HEX3 = vSSLED3[6:0] ^ {7{LightLevelOfSevenSeg}};
    assign HEX4 = vSSLED4[6:0] ^ {7{LightLevelOfSevenSeg}};
    assign HEX5 = vSSLED5[6:0] ^ {7{LightLevelOfSevenSeg}};
    assign HEX6 = vSSLED6[6:0] ^ {7{LightLevelOfSevenSeg}};
    assign HEX7 = vSSLED7[6:0] ^ {7{LightLevelOfSevenSeg}};

    // 未与实际元件连接的虚拟按键、开关默认值
    assign vSWITCH[N_SW-1:18] = {(N_SW-18){1'h0}};
    assign vBUTTON[N_BTN-1:4] = {(N_BTN-4){1'h0}}; 

//---------------------------------------------------------------------------//
    wire TCK;
    GlobalCLK global_TCK(
        .ena (1'b1),
        .inclk (JTCK),
        .outclk (TCK)
    );

    // DE2-115没有专用的复位按钮，临时用 SW17 做复位
    wire rst_btn = SW[17];

    wire CLK_50,CLK_10,CLK_lag,clk_locked;
    pll clock_PLL(
        .inclk0 (CLOCK_50),
        .c0 (CLK_50), //50MHz
        .c1 (CLK_10), //10MHz
        .c2 (CLK_lag),//10MHz,30度相位滞后
        .locked (clk_locked) 
    );
    wire CLK = CLK_10;
    wire RESET = rst_btn | ~clk_locked;

//---------------------------------------------------------------------------//

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

    //  All inout port turn to tri-state
    assign  LCD_DATA        =   8'hzz;
    assign  DRAM_DQ         =   32'hzzzz;
    assign  FL_DQ           =   8'hzz;
    assign  SRAM_DQ         =   16'hzzzz;
    assign  PS2_CLK         =   1'bz;
    assign  PS2_DAT         =   1'bz;
    assign  PS2_CLK2        =   1'bz;
    assign  PS2_DAT2        =   1'bz;
    assign  SD_CMD          =   1'bz;    
    assign  SD_DAT          =   4'bz;
    assign  I2C_SDAT        =   1'bz;
    assign  AUD_ADCLRCK     =   1'bz;
    assign  AUD_BCLK        =   1'bz;
    assign  AUD_DACLRCK     =   1'bz;
    assign  EEP_I2C_SDAT    =   1'bz;
    assign  ENET0_MDIO      =   1'bz;
    assign  ENET1_MDIO      =   1'bz;
    assign  OTG_DATA        =   16'hzzzz;   
    assign  GPIO            =   36'hzzzzzzzzz;

    // All unused output port turn to x
    assign SMA_CLKOUT = 1'bz;
    assign LCD_BLON =  1'bz;
    assign LCD_EN =  1'bz;
    assign LCD_ON =  1'bz;
    assign LCD_RS =  1'bz;
    assign LCD_RW =  1'bz;    
    assign UART_CTS =  1'bz;
    assign UART_TXD =  1'bz;
    assign SD_CLK =  1'bz;
    assign VGA_B =  8'bz;    
    assign VGA_BLANK_N =  1'bz;
    assign VGA_CLK =  1'bz;
    assign VGA_G =  8'bz;
    assign VGA_HS =  1'bz;    
    assign VGA_R =  8'bz;
    assign VGA_SYNC_N =  1'bz;
    assign VGA_VS =  1'bz;
    assign AUD_DACDAT =  1'bz;    
    assign AUD_XCK =  1'bz;
    assign EEP_I2C_SCLK =  1'bz;
    assign I2C_SCLK =  1'bz;
    assign ENET0_GTX_CLK =  1'bz;    
    assign ENET0_MDC =  1'bz;
    assign ENET0_RST_N =  1'bz;
    assign ENET0_TX_DATA =  4'bz;
    assign ENET0_TX_EN =  1'bz;    
    assign ENET0_TX_ER =  1'bz;
    assign ENET1_GTX_CLK =  1'bz;
    assign ENET1_MDC =  1'bz;
    assign ENET1_RST_N =  1'bz;    
    assign ENET1_TX_DATA =  4'bz;
    assign ENET1_TX_EN =  1'bz;
    assign ENET1_TX_ER =  1'bz;
    assign TD_RESET_N =  1'bz;    
    assign OTG_ADDR =  2'bz;
    assign OTG_CS_N =  1'bz;
    assign OTG_WR_N =  1'bz;
    assign OTG_RD_N =  1'bz;    
    assign OTG_RST_N =  1'bz;
    assign DRAM_ADDR =  13'bz;
    assign DRAM_BA =  2'bz;    
    assign DRAM_CAS_N =  1'bz;    
    assign DRAM_CKE =  1'bz;
    assign DRAM_CLK =  1'bz;
    assign DRAM_CS_N =  1'bz;
    assign DRAM_DQM =  1'bz;    
    assign DRAM_RAS_N =  1'bz;
    assign DRAM_WE_N =  1'bz;
    assign SRAM_ADDR =  20'bz;
    assign SRAM_CE_N =  1'bz;    
    assign SRAM_LB_N =  1'bz;    
    assign SRAM_OE_N =  1'bz;
    assign SRAM_UB_N =  1'bz;
    assign SRAM_WE_N =  1'bz;
    assign FL_ADDR =  23'bz;    
    assign FL_CE_N =  1'bz;    
    assign FL_OE_N =  1'bz;    
    assign FL_RST_N =  1'bz;
    assign FL_WE_N =  1'bz;
    assign FL_WP_N =  1'bz;
    assign HSMC_CLKOUT_P1 =  1'bx;    
    assign HSMC_CLKOUT_P2 =  1'bx;    
    assign HSMC_CLKOUT0 =  1'bx;    
    assign HSMC_TX_D_P =  17'bx;


endmodule
