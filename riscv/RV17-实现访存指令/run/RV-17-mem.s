	.text
    addi x3, x0, 0x100 #<1>
    slli x3, x3, 20    #<2>
    lw   x18, 8(x3)    #<3>
    xori x19, x18, -1  #<4>
    sw   x19, 12(x3)   #<5>