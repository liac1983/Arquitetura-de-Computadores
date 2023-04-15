.text
.global count_range

count_range:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw s1, 4(sp)

    lw a1, 0(a0)     #// a1 aponta para o início do vetor
    mv a2, a1        #// a2 aponta para o fim do vetor
    slli a3, a2, 2   #// tamanho do vetor em bytes
    add a3, a3, a1   #// a3 aponta para a posição seguinte do último elemento do vetor
    flw f2, 0(a2)    #// carrega a para f2
    flw f3, 4(a2)    #// carrega b para f3

    #// contador de elementos no intervalo [a, b]
    li s1, 0

    loop:
        bgeu a1, a3, end_loop #// se o vetor acabou, terminar o loop

        flw f0, 0(a1)         #// carrega um elemento do vetor
        fle.s t4, f0, f2      #// compara com a
        blt t4, x0, continue_loop     #// se for menor que a, pula para a próxima iteração

        fle.s t5, f3, f0      #// compara com b
        bgt t5, x0, continue_loop     #// se for maior que b, pula para a próxima iteração

        addi s1, s1, 1        #// incrementa o contador

        continue_loop:
            addi a1, a1, 4    #// incrementa o ponteiro para o próximo elemento do vetor
            j loop

    end_loop:
        mv a0, s1
        lw ra, 0(sp)
        lw s1, 4(sp)
        addi sp, sp, 16            #// retorna o contador
