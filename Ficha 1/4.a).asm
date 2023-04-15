# Nas alíneas seguintes pretende-se escrever e testar sub-rotinas que 
# envolvem vetores com um ou mais elementos. Assumir que o endereço base
# do vetor e o número de elementos são passados à sub-rotina
# por esta ordem (caso existam mais argumentos devem ser passados 
# a seguir aos anteriores)
# Determinar o valor máximo de um vetor com dados do tipo byte.

.data
V1: .byte 4 , 18 , -5 , 0 , 3
#V2: .byte 3
.text
la a0 , V1
li a1 , 5
jal ra , maxVbyte
li a7 , 10 # Ver resultado em a0 !
ecall # Termina
maxVbyte :
lb t0 , 0( a0) # Max inicial = 1º elemento do vetor
prox : addi a1 , a1 , -1
beq a1 , zero , fim
addi a0 , a0 , 1
lb t1 , 0( a0)
ble t1 , t0 , prox
mv t0 , t1 # Novo max
j prox
fim : mv a0 , t0
ret

