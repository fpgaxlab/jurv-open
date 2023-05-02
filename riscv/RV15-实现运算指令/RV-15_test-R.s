    # R型运算指令测试
    .text
    addi x18, x0, 0x666  
    addi x17, x0, 0x555  
    and  x19, x18, x17   
    addi x19, x19, 0     
    or   x20, x18, x17   
    addi x20, x20, 0     
    xor  x21, x18, x17   
    addi x21, x21, 0     
    add  x22, x18, x17   
    addi x22, x22, 0     
    sub  x23, x18, x17   
    addi x23, x23, 0     
    addi x28, x0, 21    
    sll  x5, x18, x28    
    addi x5, x5, 0       
    addi x28, x0, 10
    sra  x6, x18, x28    
    addi x6, x6, 0       
    srl  x7, x18, x28    
    addi x7, x7, 0       
    addi x28, x0, 12
    sra  x6, x5, x28     
    addi x6, x6, 0       
    srl  x7, x5, x28     
    addi x7, x7, 0       
