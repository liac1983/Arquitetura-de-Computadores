is_palindrome:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	addi t0, zero, 0
	addi t1, zero,0
	add t2, zero, a0
	
	lbu t3, 0(t2)
loop1:
	beqz t3, done
	addi t1, t1, 1
	addi t2, t2, 1
	lbu t3, 0(t2)
	j loop1
done:
	addi t1, t1, -1
	beq t0, t1, true
loop2:
	blt t0, t1, check
	j false
check:
	add a0, a0, t0
	add t1, a0, t1
	lb t3, 0(a0)
	lb t4, 0(t1)
	beq t3, t4, next
	j false
next:
	addi t0, t0, 1
	addi t1, t1, -1
	blt t0, t1, loop2
	j true
true:
	addi sp, sp, 4
	lw ra, 0(sp)
	addi a0, zero, 1
	ret
false:
	addi sp, sp, 4
	lw ra, 0(sp)
	addi a0, zero, 0
	ret