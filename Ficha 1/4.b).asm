# Determinar o valor máximo de um vetor com dados do tipo unsigned word.

 .data
#V1: .word 4 , 18 , 26 , 0 , 3
V2: .word 9 , 0xffffffff , 5
.text
la a0 , V2
li a1 , 3
jal ra , maxVuword
li a7 , 10 # Ver resultado em a0 !
ecall # Termina
maxVuword :
lw t0 , 0( a0) # Max inicial = 1º elemento do vetor
prox : addi a1 , a1 , -1
beq a1 , zero , fim
addi a0 , a0 , 4
lw t1 , 0( a0)
bltu t1 , t0 , prox
mv t0 , t1 # Novo max
j prox
fim : mv a0 , t0
ret
