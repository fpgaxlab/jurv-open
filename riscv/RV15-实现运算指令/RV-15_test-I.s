    # I型运算指令测试
	.text
    addi x0, x0, -1      
    addi x18, x0, 0x666  
    addi x18, x18, 0     
    andi x19, x18, 0x555 
    addi x19, x19, 0     
    ori  x20, x18, 0x333 
    addi x20, x20, 0     
    xori x21, x18, -1    
    addi x21, x21, 0     
    slli x5, x18, 21     
    addi x5, x5, 0       
    srai x6, x18, 10     
    addi x6, x6, 0       
    srli x7, x18, 10     
    addi x7, x7, 0       
    srai x6, x5, 12      
    addi x6, x6, 0       
    srli x7, x5, 12      
    addi x7, x7, 0       
    slli x5, x18, 1      
