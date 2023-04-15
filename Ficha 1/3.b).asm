POLI :
addi sp, sp, -16
sw ra, 12(sp)
sw s0, 8(sp)
mv s0 , a0 # <1>
jal ra , QUAD
mv t0 , a0
li a0 , 3
mul s0 , s0 , a0
add a0 , t0 , s0
addi a0 , a0 , 1
lw ra, 12(sp)
lw s0, 8(sp)
addi sp,sp, 16
ret # <2>
QUAD : mul a0 , a0 , a0
ret