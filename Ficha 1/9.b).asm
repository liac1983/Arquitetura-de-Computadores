# 9. Considerar os vetores A, B e R, com n números inteiros de 32 bits, em que A e B 
# são operandos e R é o vetor, ou escalar, resultante. Implementar e testar programas 
# que implementem as seguintes operações vetoriais:
# b) Adição de vetores (R ? A+B) – se ocorrer overow ao somar dois valores usar como
# resultado o maior ou o menor valor representável (saturação), conforme essa soma seja,
# respetivamente, positiva ou negativa

.data
# Exemplo sem overflow :
#A: .word -2 , 4 , 1 , -5 , 0
#B: .word 8 , 1 , -1 , -4 , 3
#R: .space 20 # Espaço para o resultado (6 , 5 , 0 , -9 , 3)
# Exemplo com saturação devido a overflow :
A: .word 4 , 0x7 ffffff0 , -2 , -3 , 0
B: .word -1 , 16 , 0x80000001 , 3 , 0x80000000
R: .space 20 # Espaço para resultado (3 , 0x7 fffffff , 0x80000000 ,
0 , 0x80000000)
.text
la a0 , A
la a1 , B
la a2 , R
li a3 , 5
jal ra , somaVet_ovf
li a7 , 10 # Verificar R em memória !
ecall # Termina
somaVet_ovf :
addi sp , sp , -32
sw ra , 20( sp)
iter :beq a3 , zero , fim
lw t0 , (a0)
lw t1 , (a1)
add t2 , t0 , t1 # Se sign (t0)= sign (t1) e
# sign (t2)!= sign (t0) há OVF
sw a0 , 16( sp)
sw a1 , 12( sp)
sw a2 , 8( sp)
sw a3 , 4( sp)
sw t2 , 0( sp) # t2= soma
mv a0 , t0
mv a1 , t1
mv a2 , t2
jal ra , detOVF_add
lw t2 , 0( sp) # Recupera soma calculada
beq a0 , zero , notOVF
# Ocorreu overflow ( positivo ou negativo )
bgt t2 , zero , OVFneg
li t2 , 0x7 fffffff # Satura no número " mais positivo "
j notOVF # Prossegue
OVFneg :
li t2 , 0x80000000 # Satura no número " mais negativo "
notOVF : # Não ocorreu overflow
lw a0 , 16( sp) # Recupera
lw a1 , 12( sp) # endereços
lw a2 , 8( sp) # dos vetores e
lw a3 , 4( sp) # número de iterações.
sw t2 , (a2) # Guarda soma em R.
addi a0 , a0 , 4 # Atualiza
addi a1 , a1 , 4 # endereços
addi a2 , a2 , 4 # e
addi a3 , a3 , -1 # número de iterações.
j iter
fim : lw ra , 20( sp)
addi sp , sp , 32
ret
detOVF_add :
# a0=op1 , a1=op2 e a2=op1+op2
# Só há overflow se operandos tiverem o mesmo sinal e a soma
# tiver sinal diferente de operando
srli a0 , a0 , 31 # sinal de op1
srli a1 , a1 , 31 # sinal de op2
srli a2 , a2 , 31 # sinal de op1+op2
xor a0 , a0 , a1
xor a1 , a1 , a2
xori a0 , a0 , 1 # not a0
and a0 , a0 , a1 # a0 =0: não ocorreu overflow
ret # a0 =1: ocorreu overflow