# 14. Uma sequ�ncia de n pontos (xi, yi) do plano est� guardada em mem�ria como 
# um vetor de 2n n�meros inteiros com 8 bits {x1, y1, x2, y2, . . . , xn, yn}. 
# Escrever a sub-rotina mirrorSeq que troca as coordenadas horizontal e vertical 
# de cada ponto. O prot�tipo desta sub-rotina em C �:
# void mirrorSeq(char *pt, int n)

.data
pontos : .byte 5 , -3 , 32 , 0 , 1 , 127 , -1 , -3
n: .word 4
.text
la a0 , pontos
lw a1 , n
jal mirrorSeq # N�o retorna nada
li a7 , 10
ecall
mirrorSeq :
srli a1 , a1 , 1 # N. iter. = n/2 ( processa 2 pontos / iter. )
prox :lw t0 , 0( a0)
mv t0 , t0 # troca coordenadas de cada ponto
sw t0 , 0( a0)
addi a0 , a0 , 4
addi a1 , a1 , -1
bne a1 , zero , prox
ret