.text
.global nperto

nperto:
    li t2, 0        
    beqz a2, end_nperto  
loop:
    lw t4, 0(a0)   
    lw t5, 0(a1)    
    sub t6, t4, t5  
    bgez t6, positive 
    neg t6, t6      
positive:
    bltz t6, continue  
    bgt t6, a3, continue  
    addi t2, t2, 1  
continue:
    addi a0, a0, 4 
    addi a1, a1, 4  
    addi a2, a2, -1 
    bnez a2, loop   
end_nperto:
    mv a0, t2    # move result to return register
    ret

