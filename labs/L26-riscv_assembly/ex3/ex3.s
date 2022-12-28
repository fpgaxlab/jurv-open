.equ IO_BASE -2048
.equ SW0_OFFSET 0
.equ SW1_OFFSET 4
.data
str_origin: .string "\nOrigin = "
str_result: .string "\nResult = "
str_get:    .string "\nGet bit "
str_set:    .string "\nSet bit "
str_clr:    .string "\nClear bit "
str_flip:   .string "\nFlip bit "
.text
start:
    li   s0, IO_BASE
    lw   s1, SW0_OFFSET(s0)
    lw   s2, SW1_OFFSET(s0)
    mv   a0, s1
    andi a1, s2, 0x007
    srli s2, s2, 6
    slli s2, s2, 3
    lui  s5, %hi(jmplist)
    addi s5, s5, %lo(jmplist) 
    add  s2, s2, s5
    jr   s2

jmplist:
    jal  get_bit
    j    print  
    jal  set_bit
    j    print  
    jal  clr_bit
    j    print  
    jal  flip_bit
    j    print  
print:
    mv   s3, a0
    la   a0 str_origin
    jal  print_str
    mv   a0, s1
    jal  print_bin
    la   a0 str_result
    jal  print_str
    mv   a0, s3
    jal  print_bin
    li   a7, 10  #Exit
    ecall  

print_str:
    li a7, 4
    ecall
    ret

print_int:
    li a7, 1
    ecall
    ret

print_bin:
    li a7, 35
    ecall
    ret

get_bit:
    addi sp, sp, -8
    sw   ra, 4(sp)
    sw   s1, 0(sp)
    li   s1, 1
    sll  s1, s1, a1
    and  s1, a0, s1
    la   a0 str_get
    jal  print_str
    mv   a0, a1
    jal  print_int
    mv   a0, s1
    lw   s1, 0(sp)
    lw   ra, 4(sp) 
    addi sp, sp, 8
    ret

set_bit:
    // 在这里编写你的程序

clr_bit:
    // 在这里编写你的程序

flip_bit: 
    // 在这里编写你的程序

