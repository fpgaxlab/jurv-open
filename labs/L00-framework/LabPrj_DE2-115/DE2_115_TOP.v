`default_nettype none
module DE2_115_TOP(
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
    localparam ButtonReleaseLevel = {N_BTN{1'b1}}; 
    // Logic level of the lit segment of actual component
    localparam LightLevelOfSevenSeg = {8{1'b0}}; 
    // Logic level when the actual LED is not lit   
    localparam DarkLevelOfLED = {N_LED{1'b0}};       
    // Logic level when the switch is turned down
    localparam DownLevelOfSwitch = {N_SW{1'b0}};

    // Actual components connected to virtual components
    assign LEDR[17:0] = vLED[17:0] ^ DarkLevelOfLED[17:0];
    assign LEDG[8:0] = vLED[25:18] ^ DarkLevelOfLED[25:18];
    assign vSWITCH[17:0] = SW[17:0] ^ DownLevelOfSwitch[17:0];
    assign vSWITCH[N_SW-1:18] = {(N_SW-18){1'h0}};
    assign vBUTTON[3:0] = KEY[3:0] ^ ButtonReleaseLevel[3:0];
    assign vBUTTON[N_BTN-1:4] = {(N_BTN-4){1'h0}}; 
    assign HEX0 = vSSLED[0] ^ LightLevelOfSevenSeg;          
    assign HEX1 = vSSLED[1] ^ LightLevelOfSevenSeg;
    assign HEX2 = vSSLED[2] ^ LightLevelOfSevenSeg;
    assign HEX3 = vSSLED[3] ^ LightLevelOfSevenSeg;
    assign HEX4 = vSSLED[4] ^ LightLevelOfSevenSeg;
    assign HEX5 = vSSLED[5] ^ LightLevelOfSevenSeg;
    assign HEX6 = vSSLED[6] ^ LightLevelOfSevenSeg;
    assign HEX7 = vSSLED[7] ^ LightLevelOfSevenSeg;

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