.text 
.global maskadd
maskadd:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw s1, 4(sp)
    sw s0, 8(sp)

    li s0, 0   #// initialize sum to 0
    li s1, 1

    loop:
        beqz a1, end_loop  #// if mask is zero, end the loop

        and t0, a1, s1     #// check if the least significant bit of mask is 1
        bnez t0, add_elem  #// if bit is 1, add the element to sum

        srl a1, a1, 1      #// shift mask right by 1 bit
        addi a2, a2, 4     #// move to next element in array
        j loop

    add_elem:
        flw fa0, 0(a2)     #// load element from array to fa0
        jal ra, subrotina  #// call subrotina to calculate G(fa0)
        fadd.s fa1, fa0, fa2  #// add result of subrotina to sum

        srl a1, a1, 1      #// shift mask right by 1 bit
        addi a2, a2, 4     #// move to next element in array
        j loop

    end_loop:
        beqz a3, return_sum #// if flag is zero, return sum directly

        jal ra, subrotina   #// call subrotina to calculate G(sum)
        fmv.s fa1, f0       #// move sum to fa1 for use in subrotina
        jal ra, subrotina   #// call subrotina to calculate G(sum)

        j return_sum

    return_sum:
        fmv.s fa0, f0       #// move sum to fa0 for returning
        lw ra, 0(sp)
        lw s1, 4(sp)
        lw s0, 8(sp)
        addi sp, sp, 16     #// return sum in fa0
        jr ra
