# Contar o número de bits a 1 na representação binária de um valor do tipo word.

.data
num : .word 38 # Res =3
#num : .word 32 # Res =1
#num : .word 0 # Res =0
#num : .word 1 # Res =1
#num : .word 0x80000000 # Res =1
.text
la t0 , num
lw a0 , 0( t0)
jal ra , nbits1
li a7 , 10
ecall
nbits1 :
mv t0 , zero
ciclo :beq a0 , zero , fim
andi t1 , a0 , 1
add t0 , t0 , t1
srli a0 , a0 , 1
j ciclo
fim : mv a0 , t0
ret