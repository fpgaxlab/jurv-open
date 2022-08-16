module ROM
#(  parameter ADDRWIDTH = 4,
	parameter DATAWIDTH = 8)
(
    input  wire  [ADDRWIDTH-1:0] iAddress,
    output logic [DATAWIDTH-1:0] oData
);
    localparam MEMDEPTH = 1<<ADDRWIDTH;
    logic [DATAWIDTH-1:0] mem[0:MEMDEPTH-1];
    assign oData = mem[iAddress];

    initial begin
        $readmemb("init_mem.txt",mem); // 如果文件中的数据是十六进制，用 $readmemh 
        /* 云编译无法上传txt文件，可采用如下代码代替上面的readmemh
        mem[n'h00] = n'...;
        ......                   */
    end

endmodule



