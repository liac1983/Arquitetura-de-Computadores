# 5. Sejam X = [x1, x2, ..., xn] e Y = [y1, y2, ..., yn] dois vetores de n números 
# reais (n > 0).O seu produto interno é dado por:
# X · Y = x1 × y1 + x2 × y2 + ... + xn × yn
# Escrever e testar a sub-rotina prodint_VF que calcula o produto interno de X e Y 
# assumindo que não ocorre overow. Considerar o seguinte protótipo da função a chamar
# em C para executar a subrotina: double prodint_VF(float *X, float *Y, int n)

.data
X: .float -2.0 , 4.0 , -3.0026 , -5.0 , 0.0
Y: .float 8.0 , 1.5 , -1.0 , -4.0 , 3.0
n: .word 5
.text
la a0 , X
la a1 , Y
lw a2 , n
jal ra , prodInt # Resultado em fa0 ( será 13 .00259971... )
li a7 , 10
ecall
prodInt :
fcvt.s.w ft7 , zero # Acumulador
iter :beq a2 , zero , fim
flw ft0 , (a0)
flw ft1 , (a1)
fmadd.s ft7 , ft0 , ft1 , ft7 # Atualiza acumulador com Xi*Yi
addi a0 , a0 , 4
addi a1 , a1 , 4
addi a2 , a2 , -1
j iter
fim : fcvt.d.s fa0 , ft7
ret
