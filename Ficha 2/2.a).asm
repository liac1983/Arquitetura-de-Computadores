# 2. Escrever e testar programas, envolvendo dados em vírgula 
# flutuante com precisão simples, para calcular: a) o valor da 
# expressão (A?B)×C D+A?3.

.data
A: .float 2.0
B: .float 1.0
C: .float 6.0
D: .float 3.0
.text
la t0 , A
la t1 , B
la t2 , C
la t3 , D
flw fa0 , 0( t0)
flw fa1 , 0( t1)
flw fa2 , 0( t2)
flw fa3 , 0( t3)
fsub.s ft0 , fa0 , fa1 # A-B
fmul.s ft0 , ft0 , fa2 # (A-B)C
fadd.s ft1 , fa3 , fa0 # D+A
li t0 , 3
fcvt.s.w ft2 , t0 # 3.0
fsub.s ft2 , ft1 , ft2 # D+A -3
fdiv.s fa0 , ft0 , ft2 # Resultado em fa0
li a7 , 10
ecall
