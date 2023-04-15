.data 
X:	.word 20
size:	.word 12
seq:	.word 4, -6, 23, -2, -56, -25, 20, 39, 7, 11, 19, -22

.text
	la t0, X
	lw a0, 0(t0)
	la t0, size
	lw a1, 0(t0)
	la a2, seq
	jal ra, CheckABS
	li a7, 10
	ecall
	
CheckABS:
	mv t1, zero
loop:
	beqz a1, end
	lw t0, 0(a2)
	bgtz t0, cont1
	sub t0, zero, t0
cont1:
	ble t0, a0, cont2
	sw zero, 0(a2)
	addi t1, t1, 1
cont2:
	addi a2, a2, 4
	addi a1, a1, -1
	j loop
end:
	mv a0, t1
	ret