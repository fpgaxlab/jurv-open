module RAM
#(  parameter ADDRWIDTH = 6,
	parameter DATAWIDTH = 32)
(
  input  wire iClk, iWR,
  input  wire [ADDRWIDTH-1:0] iAddress,
  input  wire [DATAWIDTH-1:0] iWriteData,
  output logic [DATAWIDTH-1:0] oReadData
);
  localparam MEMDEPTH = 1<<ADDRWIDTH; //存储器的字数 
  logic [DATAWIDTH-1:0] mem[0:MEMDEPTH-1];

  always_ff @(posedge iClk)
  begin
    if (iWR)
      mem[iAddress] <= iWriteData;
  end

  assign oReadData = mem[iAddress]; // 读地址未锁存，编译器使用FPGA的逻辑资源生成存储器

  /* initial 为了调试方便可给存储器赋初值，调试成功后将其删除。
      $readmemh("init_data.txt",mem);  // 存储器内容定义在文件中。 */

endmodule
