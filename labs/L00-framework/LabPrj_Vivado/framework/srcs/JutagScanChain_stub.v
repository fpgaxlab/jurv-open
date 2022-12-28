module JutagScanChain
(
    //////////// LED Lamp ////////////
    input wire [35:0] iLED,        //虚拟LED指示灯
    
    //////////// SWITCH /////////////
    input  wire  [35:0]  iSWITCH,   //虚拟拨动开关
    output wire  [35:0]  oSW_BSC,  

    //////////// BUTTON /////////////
    input  wire  [19:0] iBUTTON,	//虚拟按键    
    output wire  [19:0] oKEY_BSC,  
    
    /////// Seven Segment LED  ////////
    input  wire [7:0]  iSSLED0,	//虚拟七段数码管0      	
    input  wire [7:0]  iSSLED1,	//虚拟七段数码管1
    input  wire [7:0]  iSSLED2,	//虚拟七段数码管2
    input  wire [7:0]  iSSLED3,	//虚拟七段数码管3
    input  wire [7:0]  iSSLED4,	//虚拟七段数码管4
    input  wire [7:0]  iSSLED5,	//虚拟七段数码管5
    input  wire [7:0]  iSSLED6,	//虚拟七段数码管6
    input  wire [7:0]  iSSLED7,	//虚拟七段数码管7

    ///////// DEBUG IO ///////////
    input  wire         TCK,
    input  wire         TMS,
    input  wire         TDI,
    output wire         TDO
);

endmodule
