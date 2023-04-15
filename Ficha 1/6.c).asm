# Determinar o número de vogais de uma cadeia de carateres utilizando a sub-rotina
# da alínea anterior.

.data
str: .asciz "Nao foi gerado por chatGPT !"
vogais : .asciz " aeiouAEIOU "
.text
la a0 , str
la a1 , vogais
jal ra , nVogais
li a7 , 10 # Ver resultado em a0
ecall # Termina
nVogais :
# a0 = end. string onde é feita a pesquisa
# a1 = end. string de carateres a pesquisar
addi sp , sp , -16
sw ra , 12( sp) # End. retorno a caller
sw a0 , 8( sp) # nOcorr ( callee ) pode alterar registos 'a'
sw a1 , 4( sp)
li s0 , 0 # Contador de ocorrencias de vogais
next :lw a0 , 8( sp)
lw a1 , 4( sp) # a1 = end. string chars a pesquisar
lbu s1 , 0( a1) # s1 contém char a pesquisar
beq s1 , zero , termina
addi a1 , a1 , 1 # Atualiza end. da string de vogais
sw a1 , 4( sp)
mv a1 , s1
jal ra , nOcorr # Invoca nOcorr
add s0 , s0 , a0 # Atualiza contador de ocorrencias de char
j next
termina :
mv a0 , s0
lw ra , 12( sp) # Recupera end retorno a caller
addi sp , sp , 16
ret
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