// --------------------------------------------------------------------
//
// --------------------------------------------------------------------

`default_nettype none
module Interfaces
#(
    parameter DATAWIDTH = 32,
    parameter ADDRWIDTH = 32
)
(
    input     wire iClk,
    input     wire iReset,
    input     wire [ADDRWIDTH-1:0] iAddress,
    input     wire [DATAWIDTH-1:0] iWriteData,
    output    wire [DATAWIDTH-1:0] oReadData,
    input     wire iWR, iIOS,
    output    wire [7:0]  oSSLED7,
    output    wire [7:0]  oSSLED6,
    output    wire [7:0]  oSSLED5,
    output    wire [7:0]  oSSLED4,
    output    wire [7:0]  oSSLED3,
    output    wire [7:0]  oSSLED2,
    output    wire [7:0]  oSSLED1,
    output    wire [7:0]  oSSLED0,
    output    wire [31:0] oLED,
    input     wire [19:0] iPB,
    input     wire [31:0] iSW
);

// * -------- 外设接口地址 ---------
// * 拨动开关输入接口地址：FFFF_F800H
// * LED 输出寄存器地址:  FFFF_F810H
// * 数码管输出寄存器地址：FFFF_F820H
    `define SW_OFFSET   (11'h000)
    `define LED_OFFSET  (11'h010)
    `define SD_OFFSET   (11'h020)
   
    // 接口地址译码
    wire enSW_A  = iIOS & (iAddress[10:0]==`SW_OFFSET); 
    wire enLED_A = iIOS & (iAddress[10:0]==`LED_OFFSET); 

    // LED输出寄存器
    DataReg #(8) led_a(.oQ(oLED[7:0]), .iD(iWriteData[7:0]), .Clk(iClk), .Load(enLED_A & iWR), .Reset(iReset));
     
    // 输入接口
    assign oReadData = {DATAWIDTH{enSW_A}}  & {{(DATAWIDTH-8){1'b0}}, iSW[7:0]}
                     | {DATAWIDTH{enLED_A}} & {{(DATAWIDTH-8){1'b0}}, oLED[7:0]};

    // 若未使用数码管，将其消隐。若将数码管扩展为外设，需删除下面这些代码。
    assign oSSLED7 = 8'b11111111;
    assign oSSLED6 = 8'b11111111;
    assign oSSLED5 = 8'b11111111;
    assign oSSLED4 = 8'b11111111;
    assign oSSLED3 = 8'b11111111;
    assign oSSLED2 = 8'b11111111;
    assign oSSLED1 = 8'b11111111;
    assign oSSLED0 = 8'b11111111;	

endmodule
