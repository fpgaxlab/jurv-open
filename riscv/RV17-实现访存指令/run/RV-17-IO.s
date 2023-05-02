	.text
    addi s0, x0, -2048 
    addi s1, x0, 0x100 
    slli s1, s1, 20    
    addi s3, x0, -1    
    sw   s3, 0x20(s0)  
    lw   s2, 0x00(s0)  
    sw   s2, 8(s1)     
    xori s2, s2, -1
    sw   s2, 0x10(s0)  
    lw   s4, 8(s1)     
    sw   s4, 0x20(s0)  
    lw   s3, 0x10(s0)  
    addi s3, s3, 0     
    lw   s5, 0x20(s0)  
    addi s5, s5, 0     