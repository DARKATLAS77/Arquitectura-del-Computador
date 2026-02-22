.data
	vec: .word 4, 2, 6, 4, 8, 1
	n: .word 5
	blanco: .asciiz " "
.text
	la $a1, vec
	lw $s0, n
	
	
	li $t0, 0
	ciclo1:
	bge $t0, $s0, finciclo1
	li $t1, 0
	ciclo2:
	sub $t2, $s0, $t0
	bge $t1, $t2, finciclo2
	sll $t3, $t1, 2
	add $t3, $t3, $a1
	lw $t4, 0($t3)
	lw $t5, 4($t3)
	ble $t4, $t5, sigue
	sw $t4, 4($t3)
	sw $t5, 0($t3)
	sigue:
	addi $t1, $t1, 1
	j ciclo2
	finciclo2:
	addi $t0, $t0, 1
	j ciclo1
	finciclo1:
	
	li $t0, 0
	imprimir:
	bgt $t0, $s0, finimprimir
	sll $t1, $t0, 2
	add $t1, $t1, $a1
	lw $a0, 0($t1)
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, blanco
	syscall
	
	addi $t0, $t0, 1
	j imprimir
	finimprimir:
	
	li $v0, 10
	syscall
	
	
	
