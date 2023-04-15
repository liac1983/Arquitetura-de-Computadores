# 2. Implemente a sub-rotina sumSquare que recebe um inteiro n e,
# se positivo, retorna o valor da expressão seguinte e se não for
# positivo retorna 0.
# n2 + (n ? 1)2 + (n ? 2)2 + · · · + 12

sumSquare :
	addi sp , sp , -16 # Reserva espaço para 4 words na pilha
	sw ra , 12( sp) # Guarda endereço de retorno
	sw s0 , 8( sp) # Guarda registos
	sw s1 , 4( sp) # saved (s0 e s1)
	add s0 , a0 , x0 # Copia valor de n para s0
	add s1 , x0 , x0 # Inicializa s1 (irá acumular a soma )
loop :
	bge x0 , s0 , end # Salta if s0 não é positivo
	add a0 , s0 , x0 # Copia s0 para a0 para invocar 'square '
	jal ra , square # Chama a sub - rotina 'square '
	add s1 , s1 , a0 # Atualiza s1 com o valor retornado em a0
	addi s0 , s0 , -1 # Decrementa s0 de 1
	jal x0 , loop # Salta para o início do ciclo
end: 
	add a0 , s1 , x0 # Copia para a0 a soma acumulada em s1
	lw ra , 12( sp) # Recupera ra
	lw s0 , 8( sp) # Recupera s0
	lw s1 , 4( sp) # Recupera s1
	addi sp , sp , 16 # Liberta o espaço reservado na pilha
	jr ra # Retorna à sub - rotina que a invocou
square :
	mul a0 , a0 , a0
	ret
