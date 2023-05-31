`default_nettype none 
module CPU
#(
   parameter DATAWIDTH = 32,
   parameter ADDRWIDTH = 32
)
(
   input  wire iCPU_Reset,
   input  wire iCPU_Clk,
   // 指令存储器接口
   output wire [ADDRWIDTH-1:0] oIM_Addr,   //指令存储器地址
   input  wire [DATAWIDTH-1:0] iIM_Data,   //指令存储器数据
   // 数据存储器接口
   input  wire [DATAWIDTH-1:0] iReadData,  //数据存储器读数据
   output wire [DATAWIDTH-1:0] oWriteData, //数据存储器写数据
   output wire [ADDRWIDTH-1:0] oAB,        //数据存储器地址
   output wire oRD, oWR,                   //数据存储器读写使能
   // 连接调试器的信号
   output wire [ADDRWIDTH-1:0] oCurrent_PC,
   output wire oFetch,
   input  wire iScanClk,
   input  wire iScanIn,
   output wire oScanOut1,
   input  wire [1:0] iScanCtrl1,
   output wire oScanOut2,
   input  wire [1:0] iScanCtrl2
);

   /** The input port is replaced with an internal signal **/
   wire   clk   = iCPU_Clk;
   wire   reset = iCPU_Reset;

   // Instruction parts
   wire  [31:0] pc, nextPC;
   /*-TODO Next PC -*/
   /* 实例化PC寄存器 */ 
   //tag::PC[]
   DataReg #(32) pcreg(.iD(nextPC), .oQ(pc), .Clk(clk), .Reset(reset), .Load(1'b1));
   //end::PC[]
   /*-TODO 连接指令存储器的地址端口 -*/
   /*-TODO 连接指令存储器的数据端口 -*/

   // Instruction decode

   // Control unit
   /*-TODO 实例化控制器模块
   Controller controller(
      .iOpcode(opcode),
      .iFunct3(funct3),
      // 随着指令的增加，相应添加端口信号
      .oRegWrite(cRegWrite),
      .oImmType(cImmType)
   );
   -*/

   // Immediate data generation 
   /*-TODO 实例化立即数生成模块
   ImmGen  immGen(
      .iInstrImm(instruction[31:7]), 
      .iImmType(cImmType), 
      .oImmediate(immData));
   -*/

   // Register file
   /*-TODO 实例化寄存器堆模块
   RegisterFile regFile(.Clk(clk), 
      .iWE(cRegWrite), .iWA(wa), .iWD(regWriteData), 
      .iRA1(ra1), .oRD1(regReadData1),
      .iRA2(ra2), .oRD2(regReadData2));
   -*/

   // ALU
   /*-TODO 目前只需要实现加立即数运算，下一个实验需用自己设计的ALU模块代替。
   assign aluOut = regReadData1 + immData; 
   -*/

   // Data Memory
   /*-目前不使用数据存储器，实现访存指令时需连接数据存储器 -*/
  
//---------------------- 送给调试器的变量 ------------------------//

    //tag::watch[]
    //送给调试器的观察信号，需要与虚拟面板的信号框相对应
    struct packed{ 
        logic [4:0] WS1;  //ImmType
        logic       WS0;  //RegWrite
    }ws;

    //送给调试器的观察数据，需要与虚拟面板的数据框相对应
    struct packed{
        logic [31:0] WD4; //regWriteData
        logic [4:0]  WD3; //wa
        logic [31:0] WD2; //instruction        
        logic [31:0] WD1; //pc         
        logic [31:0] WD0; //nextPC 
    }wd;
    //end::watch[]

    /*-【注意】定义观察信号后须关联相应变量！
    always_comb begin
        ws.WS1[4:0] = cImmType;
        ws.WS0      = cRegWrite;
    end
    -*/

    /*-【注意】定义观察数据后须关联相应变量！        
    always_comb begin
        wd.WD4[31:0]  = regWriteData;
        wd.WD3[4:0]   = wa;
        wd.WD2[31:0]  = instruction; 
        wd.WD1[31:0]  = pc;          
        wd.WD0[31:0]  = nextPC; 
    end
    -*/
    
    // 以下调试器部分，请勿修改！
    WatchChain #(.DATAWIDTH($bits(wd))) wdChain_inst(
        .DataIn(wd), 
        .ScanIn(iScanIn), 
        .ScanOut(oScanOut1), 
        .ShiftDR(iScanCtrl1[1]), 
        .CaptureDR(iScanCtrl1[0]), 
        .TCK(iScanClk)
    );
    WatchChain #(.DATAWIDTH($bits(ws))) wsChain_inst(
        .DataIn(ws), 
        .ScanIn(iScanIn), 
        .ScanOut(oScanOut2), 
        .ShiftDR(iScanCtrl2[1]), 
        .CaptureDR(iScanCtrl2[0]), 
        .TCK(iScanClk)
    );
    assign oCurrent_PC = pc;
    assign oFetch = 1'b1;

endmodule
