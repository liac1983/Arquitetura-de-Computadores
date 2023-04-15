.data 	# data section
P:	.half 10 20 30 40 50 60 70 80
K:	.half 2 
R: 	.float 11 22 33 44 55 66 77 88

.text

loop: beqz a3, END
lw t0, 0(a0)
lw t1, 0(a1)
mul16 t2, t0, t1
sw t2, 0(a2)	
addi a0, a0, 4
addi a1, a1, 4
addi a2, a2, 4
addi a3, a3, -2
j loop

END: 
ret