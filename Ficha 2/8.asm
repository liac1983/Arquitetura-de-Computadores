.data 	# data section
X1:	.float 0.0034
X2:	.float -0.0077
a: 	.float 1, 0.278393, 0.230389, 0.000972, 0.078108
# expected final result of ERFPOS is 0.003787805
# expected final result of ERF is 0.008582808
.text
#--------------------------------------------------------------
# test ERFPOS
la t0, X1
flw	fa0, 0(t0)	# load X1
jal ra, ERFPOS	# call ERFPOS with X1 in fa0
fmv.s fs7, fa0	# store result in fs7 (we are going to overwrite fa0 ahead)

# test ERF
la t0, X2
flw	fa0, 0(t0)	# load X2
jal ra, ERF		# call ERF with X2 in fa0

# see result of ERFPOS in fs7 and result of ERF on fa0
li   a7, 10
ecall
#--------------------------------------------------------------
ERFPOS:					# ERFPOS only works for positive numbers
la t0, a				# load address of vector of constants
flw ft1, 0(t0)			# constant 1
flw ft2, 4(t0)			# a1
flw ft3, 8(t0)			# a2
flw ft4, 12(t0)			# a3
flw ft5, 16(t0)			# a4
# we will accumulate the result in ft0
fmv.s ft0, ft1			# 1
fmul.s ft2, ft2, fa0	# a1x
fadd.s fa6, ft0,ft2	# a1x+1
fmul.s fa0, fa0, fa0 	# x^2
fmul.s ft3,ft3, fa0	# a2x^2
fadd.s fa6, fa6,ft3	# 1 + a1x + a2x^2
fmul.s fa0, fa0, fa0	# x^3
fmul.s ft4, ft4, fa0	# a3x^3
fadd.s fa6, fa6, ft4	# 1 + a1x + a2x^2 + a3x^3
fmul.s fa0, fa0, fa0 	# x^4
fmul.s ft5, ft5, fa0	# a4x^4
fadd.s fa6, fa6, ft5	# 1 + a1x + a2x^2 + a3x^3 + a4x^4
fmul.s fa6, fa6, fa6 	# (1 + a1x + a2x^2 + a3x^3 + a4x^4)^2
fmul.s fa6, fa6, fa6 	# (1 + a1x + a2x^2 + a3x^3 + a4x^4)^3
fmul.s fa6, fa6, fa6 	# (1 + a1x + a2x^2 + a3x^3 + a4x^4)^4
fdiv.s ft7, ft0, fa6	# 1 / (1 + a1x + a2x^2 + a3x^3 + a4x^4)^4
fsub.s ft0, ft0, ft7 	# 1 - (1 / (1 + a1x + a2x^2 + a3x^3 + a4x^4)^4)
ret						
#--------------------------------------------------------------
ERF:					# ERF needs to work for both positive and negative numbers
addi sp, sp, -16		# allocate space on the stack
sw ra, 12(sp)			# save ra to the stack
# how do we check if fa0 is positive or negative?
# we compare it to 0: if it is greater, it is positive; otherwise, it is negative
li t0, 0				# load immediate 0
fcvt.s.w ft0, t0		# convert integer to float
# ...
# complete it
# ...
END:
lw ra, 12(sp)			# reinstate ra
addi sp, sp, 16			# reinstate stack pointer
ret