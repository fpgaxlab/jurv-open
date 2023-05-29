	.text
    addi s0, x0, -2048 #<1>
    lw   s2, 0x00(s0)  #<2>
	sw   s2, 0x10(s0)  #<3>
	lw   s3, 0x10(s0)  #<4>
  