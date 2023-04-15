.text
.global nbits1
nbits1:
mv a1, a0 #// copy input number to a1 register
li a2, 0 #// initialize bit count to 0
loop:
beqz a1, end #// if input number is 0, exit loop
andi a3, a1, 1 #// check if the lowest bit is set
add a2, a2, a3 #// if bit is set, increment bit count
srli a1, a1, 1 #// shift input number one bit to the right
j loop #// repeat loop
end:
mv a0, a2 #// move bit count to return register
ret #// return to calling function