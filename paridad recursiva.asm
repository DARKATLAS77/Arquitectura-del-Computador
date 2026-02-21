.data
	msg: .asciiz "ingrese el numero (el programa mostrara 0 si es par, 1 si es impar): "
.text
	li $v0, 4		#mensaje para el usuario.
	la $a0, msg		
	syscall
	
	li $v0, 5		#recibe el numero por pantalla.
	syscall			
	move $s0, $v0
	
	jal paridad		#llamada a la funcion.
	
	move $a0, $v0		#mueve el valor retornado a $a0 para imprimirlo.
	li $v0, 1	
	syscall
	
	li $v0, 10		#fin del programa.
	syscall
	
	paridad:			#funcion para calcular la paridad.
	addi $sp, $sp, -8		#reservacion de la pila.
	sw $s0, 0($sp)
	sw $ra, 4($sp)
	
	bgt $s0, $zero, recursivo	#caso base, retorna 0.
	li $v0, 0
	j finparidad
	
	recursivo:			#caso recursivo.
	addi $s0, $s0, -1		#se llama a la funcion con n-1.
	jal paridad
	li $t0, 1
	sub $v0, $t0, $v0		#retorna 1-paridad(n-1).
	
	finparidad:			#devolucion de la pila.
	lw $s0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra				