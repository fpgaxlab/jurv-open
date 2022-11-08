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
  logic [ADDRWIDTH-1:0] read_addr;

  always_ff @(posedge iClk)
  begin
    read_addr <= iAddress;   //读地址锁存，编译器使用FPGA的RAM块生成存储器
    if (iWR)
      mem[iAddress] <= iWriteData;
  end

  assign oReadData = mem[read_addr]; 

endmodule
