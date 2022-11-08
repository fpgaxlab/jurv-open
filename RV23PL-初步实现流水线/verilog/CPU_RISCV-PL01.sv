// --------------------------------------------------------------------
// 流水线 RISC-V CPU 模块
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

/*-------------- IF: Instruction Fetch --------------*/
   // Instruction parts
   wire [31:0] pc_if, nextPC;
   wire [31:0] instr_if;  // instruction code
   assign nextPC = pc_if + 4;   /*-TODO 目前仅支持PC+4，增加分支指令时需修改 -*/
   DataReg #(32) pcreg(.iD(nextPC), .oQ(pc_if), .Clk(clk), .Reset(reset), .Load(1'b1));
   assign oIM_Addr = pc_if;         // 连接指令存储器的地址端口
   assign instr_if = iIM_Data;      // 连接指令存储器的数据端口

  // IF-ID pipeline regisetr
   wire [31:0] instr_id, pc_id;
   DataReg #(32) pr_instr_id(.iD(instr_if), .oQ(instr_id), .Clk(clk), .Load(1'b1), .Reset(reset));
/*====================================================*/

/*-------------- ID: Instruction Decode -------------*/
   wire [6:0] opcode;
   wire [2:0] funct3;
   wire [6:0] funct7;
   wire [4:0] ra1,ra2,wa_id;
   assign funct7 = instr_id[31:25];
   assign ra2    = instr_id[24:20];
   assign ra1    = instr_id[19:15]; 
   assign funct3 = instr_id[14:12];
   assign wa_id  = instr_id[11:7];
   assign opcode = instr_id[6:0];

   // Control unit
   wire cRegWrite_id;
   wire [4:0] cImm_type;  //{J,U,B,S,I}
   Controller controller(
      .iOpcode(opcode),
      .iFunct3(funct3),
      /*-TODO 随着指令的增加，相应添加端口信号 -*/
      .oRegWrite(cRegWrite_id),
      .oImm_type(cImm_type)
   );

   // Immediate data generation 
   wire [31:0] immData_id;
   ImmGen  immGen(
      .iInstrImm(instr_id[31:7]), 
      .iImm_type(cImm_type), 
      .oImmediate(immData_id));

   // Register file
   wire [31:0] regWriteData_wb, regReadData1_id, regReadData2_id;
   wire [4:0] wa_wb;
   RegisterFile regFile(.Clk(clk), 
      .iWE(cRegWrite_wb), .iWA(wa_wb), .iWD(regWriteData_wb), 
      .iRA1(ra1), .oRD1(regReadData1_id),
      .iRA2(ra2), .oRD2(regReadData2_id));

   // ID-EX pipeline regisetr
   wire [4:0]  wa_ex;
   wire [31:0] regReadData2_ex;
   wire [31:0] pc_ex;
   wire [31:0] immData_ex, regReadData1_ex;
   DataReg #(5)  pr_wa_ex(.iD(wa_id), .oQ(wa_ex), .Clk(clk), .Load(1'b1), .Reset(reset));
   DataReg #(32) pr_rd1_ex(.iD(regReadData1_id), .oQ(regReadData1_ex), .Clk(clk), .Load(1'b1), .Reset(reset));
   DataReg #(32) pr_rd2_ex(.iD(regReadData2_id), .oQ(regReadData2_ex), .Clk(clk), .Load(1'b1), .Reset(reset));
   DataReg #(32) pr_imm_ex(.iD(immData_id), .oQ(immData_ex), .Clk(clk), .Load(1'b1), .Reset(reset));
   wire cMemWrite_ex, cPCjump_ex, cMemToReg_ex, cRegWrite_ex;
   DataReg #(1) pr_ctrl_ex( .Clk(clk), .Reset(reset), .Load(1'b1), 
            .iD({cRegWrite_id}),
            .oQ({cRegWrite_ex}));
/*====================================================*/

/*=========== EX: Execution / calculation ============*/
   // ALU
   wire [31:0] aluOut_ex;
   assign aluOut_ex = regReadData1_ex + immData_ex; /*-目前仅支持加立即数运算，
                                             TODO：需用自己设计的ALU模块代替 -*/

   // EX-MEM pipeline regisetr
   wire [4:0] wa_mem;
   wire [31:0] aluOut_mem;
   DataReg #(5)  pr_wa_mem (.iD(wa_ex), .oQ(wa_mem), .Clk(clk), .Load(1'b1), .Reset(reset));
   DataReg #(32) pr_aluout_mem (.iD(aluOut_ex), .oQ(aluOut_mem), .Clk(clk), .Load(1'b1), .Reset(reset));
   wire cMemToReg_mem, cRegWrite_mem;
   DataReg #(1) pr_ctrl_mem( .Clk(clk), .Reset(reset), .Load(1'b1), 
            .iD({cRegWrite_ex}),
            .oQ({cRegWrite_mem}));
/*====================================================*/

/*=============== Data memory access =================*/
   /*-TODO 连接数据存储器 -*/

   // MEM-WB pipeline regisetr
   wire [31:0] aluOut_wb;
   wire cRegWrite_wb;
   DataReg #(5)  pr_wa_wb (.iD(wa_mem), .oQ(wa_wb), .Clk(clk), .Load(1'b1), .Reset(reset));
   DataReg #(32) pr_aluout_wb (.iD(aluOut_mem), .oQ(aluOut_wb), .Clk(clk), .Load(1'b1), .Reset(reset));
   DataReg #(1)  pr_ctrl_wb( .Clk(clk), .Reset(reset), .Load(1'b1), 
                     .iD(cRegWrite_mem), .oQ(cRegWrite_wb));
/*====================================================*/

/*============= Register write back ==================*/
   // Writeback 
   assign regWriteData_wb = aluOut_wb; /*- 仅支持将ALU运算结果写入寄存器堆，TODO：需修改 -*/
/*====================================================*/

//---------------------- 送给调试器的变量 ------------------------//

    //送给调试器的观察信号，需要与虚拟面板的信号框相对应
    struct packed{
        /*-TODO 在这里添加观察信号的类型 -*/
        logic [4:0] WS4;
        logic       WS3;
        logic       WS2;
        logic       WS1;
        logic       WS0;
    }ws;
    always_comb begin
        /*-【注意】添加观察信号类型后须关联相应变量！-*/
        ws.WS4 = cImm_type[4:0];
        ws.WS3 = cRegWrite_mem;
        ws.WS2 = cRegWrite_ex;
        ws.WS1 = cRegWrite_id;
        ws.WS0 = cRegWrite_wb;
    end
    
    //送给调试器的观察变量，需要与虚拟面板的数据框相对应
    struct packed{
        /*-TODO 在这里添加观察数据的类型 -*/        
        logic [4:0]  WD16;
        logic [4:0]  WD15;
        logic [4:0]  WD14;
        logic [31:0] WD13;
        logic [31:0] WD12;
        logic [31:0] WD11;
        logic [31:0] WD10;
        logic [31:0] WD9;
        logic [31:0] WD8;
        logic [31:0] WD7;
        logic [31:0] WD6;
        logic [4:0]  WD5;
        logic [4:0]  WD4;
        logic [4:0]  WD3;
        logic [31:0] WD2;
        logic [31:0] WD1;
        logic [31:0] WD0;
    }wd;
    always_comb begin
        /*-【注意】添加观察数据类型后须关联相应变量！-*/        
        wd.WD16 = wa_mem;
        wd.WD15 = wa_ex;
        wd.WD14 = wa_id;
        wd.WD13 = aluOut_ex;
        wd.WD12 = immData_id;
        wd.WD11 = regReadData1_id;
        wd.WD10 = instr_if;
        wd.WD9  = nextPC;          
        wd.WD8  = aluOut_mem;      
        wd.WD7  = immData_ex;      
        wd.WD6  = regReadData1_ex; 
        wd.WD5  = ra2;             
        wd.WD4  = ra1;             
        wd.WD3  = wa_wb;           
        wd.WD2  = instr_id;        
        wd.WD1  = pc_if;           
        wd.WD0  = regWriteData_wb;
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
    assign oCurrent_PC = pc_if;
    assign oFetch = 1'b1;

endmodule

