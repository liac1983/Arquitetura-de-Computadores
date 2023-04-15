# 8. Escrever e testar as seguintes sub-rotinas em que é processado um argumento 
# do tipo word.
# a) Determinar a posição do bit 1 mais signicativo da representação binária
# de um número inteiro

.data
# Assume -se que o número é não nulo
num1 : .word 1 # Res =0
# num2 : .word 38 # Res =5
# num3 : .word 0x80000000 # Res =31
.text
lw a0 , num1
jal ra , pos1MSB
li a7 , 10 # Resultado em a0
ecall
pos1MSB :
li t0 , 31 # Índice do MSB
li t1 , 1
slli t1 , t1 , 31 # 0x80000000
L1: and t2 , a0 , t1
bne t2 , zero , fim
addi t0 , t0 , -1
slli a0 , a0 , 1
bne a0 , zero , L1
fim: mv a0 , t0
ret