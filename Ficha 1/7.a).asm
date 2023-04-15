.data 
v1: .byte 1, 5, 98, 120, 7, 45, 240
v2: .word 0, 0, 0, 0, 0, 0, 0

.text
la a0, v1
la a1, v2
addi a2, zero, 7
jal ra, bytetoword

ecall

bytetoword:
beq a2, zero, fim
lbu t0, 0(a0)
sw t0, 0(a1)
addi a0, a0, 1
addi a1, a1, 4
addi a2, a2, -1

fim:
ret