// --------------------------------------------------------------------
// 单周期 RISC-V CPU 模块
// 修订历史 :
// --------------------------------------------------------------------
//   版本 | 作者                      | 修改日期    | 所做改变
//   V1.0 |                          | 2019.02.16  | 初始版本
//   V1.1 |                          | 2019.12.16  | 整理代码
//   V1.2 |                          | 2020.06.06  | 修改扫描链
//   V1.3 |                          | 2021.07.16  | 修改控制器的组织
//   V2.0 |                          | 2022.08.11  | 更新调试器接口
// --------------------------------------------------------------------
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
   wire [31:0] pc, nextPC;
   wire [31:0] instruction; // instruction code
   assign nextPC = pc + 4;   /*-TODO 目前仅支持PC+4，增加分支指令时需修改 -*/
   // PC
   DataReg #(32) pcreg(.iD(nextPC), .oQ(pc), .Clk(clk), .Reset(reset), .Load(1'b1));
   assign oIM_Addr = pc;         // 连接指令存储器的地址端口
   assign instruction = iIM_Data;// 连接指令存储器的数据端口

   // Instruction decode
   wire [6:0] opcode;
   wire [2:0] funct3;
   wire [6:0] funct7;
   wire [4:0] ra1,ra2,wa;
   assign funct7 = instruction[31:25];
   assign ra2    = instruction[24:20];
   assign ra1    = instruction[19:15]; 
   assign funct3 = instruction[14:12];
   assign wa     = instruction[11:7];
   assign opcode = instruction[6:0];

   // Control unit
   wire cRegWrite;
   riscv_defs::t_imm cImm_type;
   Controller controller(
      .iOpcode(opcode),
      .iFunct3(funct3),
      /*-TODO 随着指令的增加，相应添加端口信号 -*/
      .oRegWrite(cRegWrite),
      .oImm_type(cImm_type)
   );

   // Immediate data generation 
   wire [31:0] immData;
   ImmGen  immGen(
      .iInstrImm(instruction[31:7]), 
      .iImm_type(cImm_type), 
      .oImmediate(immData));

   // Register file
   wire [31:0] regWriteData, regReadData1, regReadData2;
   wire [31:0] aluOut;
   RegisterFile regFile(.Clk(clk), 
      .iWE(cRegWrite), .iWA(wa), .iWD(regWriteData), 
      .iRA1(ra1), .oRD1(regReadData1),
      .iRA2(ra2), .oRD2(regReadData2));
   assign regWriteData = aluOut; /*-目前仅支持将ALU运算结果写入寄存器堆，
                                    TODO：增加Load类指令时需修改 -*/

   // ALU
   assign aluOut = regReadData1 + immData; /*-目前仅支持加立即数运算，
                                    TODO：需用自己设计的ALU模块代替 -*/

   /*-TODO 连接数据存储器 -*/
  
//---------------------- 送给调试器的变量 ------------------------//

    //送给调试器的观察信号
    struct packed{ 
    //【注意】 成员定义顺序需要与虚拟面板信号框的序号对应
        logic WS0;        //RegWrite
    }ws;

    //送给调试器的观察数据
    struct packed{
    //【注意】 成员定义顺序需要与虚拟面板数据框的序号对应
        logic [31:0] WD4; //regWriteData
        logic [4:0]  WD3; //wa; 5位
        logic [31:0] WD2; //instruction        
        logic [31:0] WD1; //pc         
        logic [31:0] WD0; //nextPC 
    }wd;

    always_comb begin
        /*-【注意】定义观察信号后须关联相应变量！-*/
        ws.WS0 = cRegWrite;
    end

    always_comb begin
        /*-【注意】定义观察数据后须关联相应变量！-*/        
        wd.WD4[31:0]  = regWriteData;
        wd.WD3[4:0]   = wa;
        wd.WD2[31:0]  = instruction; 
        wd.WD1[31:0]  = pc;          
        wd.WD0[31:0]  = nextPC; 
    end
    
    // 调试器部分，请勿修改！
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
