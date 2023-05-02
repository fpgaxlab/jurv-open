	.text
    addi x3, x0, 0x100 
    slli x3, x3, 20    
    addi x18, x0, -0x556
    sw   x18, 8(x3)     
    xori x19, x18, -1   
    lw   x19, 8(x3)     
    addi x19, x19, 0    
