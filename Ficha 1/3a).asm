.data 
num: .word 7

.text
la t0, num
lw a0, 0(t0)
jal ra, poli
li a7, 10
ecall #termina

POLI:
	mv t0, a0
	jal ra, QUAD
	mv, s0, a0
	li a0, 3
	mul t0, t0, a0
	add a0, s0, t0
	addi a0, a0, 1
	ret

QUAD:
	mul a0, a0, a0
	ret
	
