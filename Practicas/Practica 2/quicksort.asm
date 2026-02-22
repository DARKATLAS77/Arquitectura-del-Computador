.data
	vec: .word 4, 2, 6, 4, 8, 1
	n: .word 5
	blanco: .asciiz " "
.text
	li $a1, 0
	lw $a2, n
	la $a3, vec
	li $s0, 0
	
	jal quicksort			#llamada a la funcion.
	
	li $t0, 0
	ciclo:				#ciclo para imprimir el vector.
	bgt $t0, $a2, finciclo
	sll $t1, $t0, 2
	add $t1, $t1, $a3
	
	lw $a0, 0($t1)
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, blanco
	syscall
	
	addi $t0, $t0, 1
	j ciclo
	
	finciclo:		
	
	li $v0, 10			#fin del programa.
	syscall
	
	quicksort:			#funcion quicksort.
	addi $sp, $sp, -16		#reservacion de pila.
	sw $a1, 0($sp)
	sw $a2, 4($sp)
	sw $s0, 8($sp)
	sw $ra, 12($sp)
	
	blt $a1, $a2, recursivo		#caso base.
	j finquicksort
	
	recursivo:			#caso recursivo.
	jal particion			#llamada a la funcion particion, p se guarda en $s0.
	sw $s0, 8($sp)			#se guarda en la pila para no perderlo.
	addi $a2, $s0, -1
	jal quicksort			#se llama recursivamente con final=p-1.
	lw $a1, 0($sp)			#se carga todo desde la pila.
	lw $a2, 4($sp)
	lw $s0, 8($sp)
	addi $a1, $s0, 1		
	jal quicksort			#se llama a la funcion con inicio=p+1.
	
	finquicksort:			#devolucion de la pila.
	lw $a1, 0($sp)
	lw $a2, 4($sp)
	lw $s0, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	jr $ra				#se devuelve a donde fue llamado.
	
	particion:			#funcion particion.
	move $t0, $a2
	sll $t0, $t0, 2
	add $t0, $t0, $a3		
	lw $t1, 0($t0)			#$t1 es el pivote.
	
	addi $t2, $a1, -1		#$t2 es i.
	move $t3, $a1			#$t3 es j.
	
	cicloparticion:
	bge $t3, $a2, fincicloparticion		#cilo desde inicio hasta final.
	sll $t4, $t3, 2
	add $t4, $t4, $a3			#$t5=vec[j].
	lw $t5, 0($t4)
	
	bgt $t5, $t1, sigue			#si el $t5 es mayor al pivote, salta asigue.
	addi $t2, $t2, 1			#sino, se incrementa el i.
	sll $t6, $t2, 2				
	add $t6, $t6, $a3			
	lw $t7, 0($t6)				#se hace swap entre vec[i] y vec[j].
	sw $t5, 0($t6)
	sw $t7, 0($t4)
	
	sigue:
	addi $t3, $t3, 1			#se incrementa 1 a j y vuelve al ciclo.
	j cicloparticion
	
	fincicloparticion:
	addi $t2, $t2, 1			
	sll $t6, $t2, 2
	add $t6, $t6, $a3
	lw $t7, 0($t6)
	sw $t1, 0($t6)				#se hace swap entre vec[i+1] y vec[final] que es donde estaba el pivote.
	sw $t7, 0($t0)
	move $s0, $t2				#p=i+1, $s0 es p.
	jr $ra					#se devuelve a donde fue llamado.
	
	
