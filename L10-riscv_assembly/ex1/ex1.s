.data
    .word 1,3,5,7,9
.text
    add x9, x3, x0  
    add x10, x0, x0 
    add x11, x0, x0 
    addi x13,x0, 5  
Loop: 
    bge x11,x13,Done
    lw x12, 0(x9)   
    add x10,x10,x12 
    addi x9, x9,4   
    addi x11,x11,1  
    beq x0,x0,Loop  
Done:
    sw x10, 0(x9)   
    addi x17, x0, 10 
    ecall  # x17=10表示程序退出