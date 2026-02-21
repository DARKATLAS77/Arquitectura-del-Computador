.data
	msg: .asciiz "ingrese el numero (el programa mostrara 0 si es par, 1 si es impar): "
.text

	li $v0, 4		#mensaje para el usuario.
	la $a0, msg
	syscall
	
	li $v0, 5		#recibe el numero por pantalla.
	syscall
	move $s0, $v0
	
	li $t0, 1
	ciclo:			#ciclo hasta que el numero sea 1 o 0.
	ble $s0, $t0 finciclo
	addi $s0, $s0, -2
	j ciclo
	
	finciclo:
	li $v0, 1
	move $a0, $s0		#se mueve el valor resultante a $a0 para imprimirlo.
	syscall
	
	
	li $v0, 10		#fin del programa.
	syscall
	
	