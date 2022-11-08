// --------------------------------------------------------------------
//
// --------------------------------------------------------------------

`default_nettype none
module SoC
#(
     parameter N_LED = 36,
     parameter N_SW  = 36,
     parameter N_BTN = 20,
     parameter DATAWIDTH = 32,
     parameter ADDRWIDTH = 32
)
(
    ///////////// CLOCK and RESET ///////////
    input  wire RESET,  // 板载复位按钮
    input  wire CLOCK,  // 板载时钟
    input  wire CLK,    // 系统主时钟
    
    //////////// 与IO连接的虚拟元件 //////////
    input  wire [N_SW-1:0]  vSWITCH, // Virtual Switch
    input  wire [N_BTN-1:0] vBUTTON, // Virtual Button
    output wire [N_LED-1:0] vLED,    // Virtual LED    
    output wire [7:0]  vSSLED0,      //虚拟七段数码管0          
    output wire [7:0]  vSSLED1,      //虚拟七段数码管1
    output wire [7:0]  vSSLED2,      //虚拟七段数码管2
    output wire [7:0]  vSSLED3,      //虚拟七段数码管3
    output wire [7:0]  vSSLED4,      //虚拟七段数码管4
    output wire [7:0]  vSSLED5,      //虚拟七段数码管5
    output wire [7:0]  vSSLED6,      //虚拟七段数码管6
    output wire [7:0]  vSSLED7,      //虚拟七段数码管7
     
    ///////// DEBUG IO ///////////
    input  wire TCK,
    input  wire JTMS,
    input  wire JTDI,
    output wire JTDO
);


//---------------------------------------------------------------------------//

    wire [N_BTN-1:0] bsc_btn;
    wire [N_SW-1:0]  bsc_sw;

//---------------------------------------------------------------------------//

    wire cpuReset, cpuClk;
    wire [ADDRWIDTH-1:0] cpuAB, memAB;
    wire cpuWR, memWR, cpuRD;

    wire scan_clk, scan_in, scan_out1, scan_out2;
    wire [1:0] scan_ctrl1, scan_ctrl2; 
    
    wire [DATAWIDTH-1:0] cpuWriteData, readData, memWriteData, instruction_code; 
    wire [DATAWIDTH-1:0] dmReadData, ioReadData;
    wire [ADDRWIDTH - 1: 0] current_pc, instruction_addr;
    wire fetching;
    
    // CPU模块实例化
    CPU #(.ADDRWIDTH(ADDRWIDTH), .DATAWIDTH(DATAWIDTH)) CPU_RISC (
        // 连接调试器的信号
        .oCurrent_PC(current_pc),
        .oFetch(fetching),
        .iScanClk(scan_clk),
        .iScanIn(scan_in),
        .oScanOut1(scan_out1),
        .iScanCtrl1(scan_ctrl1),
        .oScanOut2(scan_out2),
        .iScanCtrl2(scan_ctrl2),
        // 指令存储器接口
        .oIM_Addr(instruction_addr),
        .iIM_Data(instruction_code),
        // 数据存储器接口
        .iReadData(readData),
        .oWriteData(cpuWriteData),
        .oAB (cpuAB),
        .oWR (cpuWR),
        // 时钟和复位
        .iCPU_Reset(cpuReset),
        .iCPU_Clk(cpuClk)
    );

    // 总线的地址译码以及数据切换
    wire ios;
    assign ios = &memAB[31:11];    //高21位全为1，IO起始地址：FFFF_F800H
    assign readData = ios ? ioReadData : dmReadData;

    // 数据存储器模块实例化 
    RAM #(.ADDRWIDTH(6), .DATAWIDTH(DATAWIDTH)) MM
    (   
        .iClk(CLK), //连续的更快的时钟，不是cpuClk
        .iWR(~ios & memWR),
        .iAddress(memAB[7:2]), //存储器只能按字访问
        .iWriteData(memWriteData), 
        .oReadData(dmReadData)
    );
    
    // 输入输出接口模块实例化
    Interfaces #(.ADDRWIDTH(ADDRWIDTH), .DATAWIDTH(DATAWIDTH)) Peripheral
    (
        .iClk (cpuClk),
        .iReset (cpuReset),
        .iAddress (memAB),
        .iWriteData(memWriteData),
        .oReadData(ioReadData),
        .iWR (memWR),
        .iIOS (ios),
        .oSSLED7(vSSLED7),
        .oSSLED6(vSSLED6),
        .oSSLED5(vSSLED5),
        .oSSLED4(vSSLED4),
        .oSSLED3(vSSLED3),
        .oSSLED2(vSSLED2),
        .oSSLED1(vSSLED1),
        .oSSLED0(vSSLED0),
        .oLED(vLED[31:0]),
        .iPB(bsc_btn),
        .iSW(bsc_sw[31:0])
    );

    // 指令存储器模块实例化
    wire imWR;
    wire [DATAWIDTH-1:0] imWriteData;
    wire [8:0] imAddr;
    RAM_asIM #(.ADDRWIDTH(9), .DATAWIDTH(DATAWIDTH)) IM 
    (
      .iClk(CLK), 
      .iWR(imWR),
      .iAddress(imAddr),
      .iWriteData(imWriteData),
      .oReadData(instruction_code)
    );

//----------------- On-chip Debug -------------------------------------------//

    JuTAG_CPU  jutag
    (              
        .TCK(TCK),
        .TMS(JTMS),
        .TDI(JTDI),
        .TDO(JTDO),
        // 与IO连接的虚拟元件
        .iLED(vLED),   
        .iSWITCH(vSWITCH),
        .oSW_BSC(bsc_sw),
        .iBUTTON(vBUTTON),
        .oKEY_BSC(bsc_btn),
        .iSSLED0(vSSLED0),          
        .iSSLED1(vSSLED1),          
        .iSSLED2(vSSLED2),          
        .iSSLED3(vSSLED3),          
        .iSSLED4(vSSLED4),          
        .iSSLED5(vSSLED5),          
        .iSSLED6(vSSLED6),          
        .iSSLED7(vSSLED7), 
        // 系统总线
        .iWR(cpuWR),
        .oWR(memWR),
        .iRD(cpuRD),
        .oRD(),
        .iCpuAB(cpuAB),
        .oSysAB(memAB),
        .iCPUWriteData(cpuWriteData),
        .iMemReadData(readData),
        .oMemWriteData(memWriteData),
        // 指令存储器接口
        .iROM_Addr(instruction_addr[17:2]),
        .oROM_Addr(imAddr),
        .iROM_ReadData(instruction_code),
        .oROM_WriteData(imWriteData),
        .oROM_WriteEnable(imWR),
        // 调试与运行控制
        .iClock(CLK),
        .oCPU_Reset(cpuReset),
        .oCPU_Clk(cpuClk),
        .iCurrent_PC(current_pc),
        .iFetch(fetching),
        .oScanClk(scan_clk),
        .oScanIn(scan_in),
        .iScanOut2(scan_out2),
        .oScanCtrl2(scan_ctrl2),
        .iScanOut1(scan_out1),
        .oScanCtrl1(scan_ctrl1)
    );

endmodule
