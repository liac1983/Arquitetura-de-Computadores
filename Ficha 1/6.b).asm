# 6. Pretende-se escrever sub-rotinas que executam tarefas envolvendo uma cadeia 
# de carateres terminada por zero (’\0’).
# a) Determinar o comprimento de uma cadeia de carateres.
# b) Determinar o número de ocorrências de um caráter numa cadeia de carateres.

 .data
str1 : .asciz "Nao foi gerado por chatGPT !"
str2 : .asciz "123 "
.text
la a0 , str1
li a1 , 'o'
jal ra , nOcorr
li a7 , 10 # Ver resultado em a0
ecall # Termina
nOcorr :
# a0 = end. string onde é feita a pesquisa
# a1 = carater a pesquisar
addi sp , sp , -16
sw s0 , 12( sp)
sw s1 , 8( sp)
mv s0 , zero # Número de ocorrências
prox :lbu s1 , 0( a0)
beq s1 , zero , fim
bne s1 , a1 , dif
addi s0 , s0 , 1 # Inc. contador
dif : addi a0 , a0 , 1
j prox
fim : mv a0 , s0
lw s0 , 12( sp)
lw s1 , 8( sp)
addi sp , sp , 16
ret