.data
	prompt: .asciiz "Enter string:"
	str: .space 20
	
.text
	jal read_str
	
read_str:
	li $v0, 4			# Tell user to
	la $a0, prompt			# enter string
	syscall				# to check
	
	li $v0, 8			# Get string
	la $a0, str			# from the
	li $a1, 64			# user
	syscall				#
	
	addi $t9, $zero, 0             # Calculate string
	jal set_str_length		# length
	
set_str_length:
	lb $t0, str($t9)
	beq $t0, $zero, set_registers	# Set other registers
	addi $t9, $t9, 1		# length++
	j set_str_length
	
set_registers:
	subi $t9, $t9, 1		# Remove str end from the length
	addi $t8, $zero, 1		# Iteration index
	addi $t1, $zero, 0		# Number of desc sequences
	addi $t2, $zero, 0		# Length of sequence
	
	jal loop
	
loop:
	beq $t9, $t8, add_last_if_needed
	
	lb $t7, str($t8)		# Load current char
	
	subi $t8, $t8, 1		
	lb $t6, str($t8)		# Load previous char 
	addi $t8, $t8, 2
	
	bge $t7, $t6, increment_if_needed
	addi $t2, $t2, 1
	
	j loop
	
increment_if_needed:
	bge $t2, 1, increment
	addi $t2, $zero, 0
	
	j loop
	
add_last_if_needed:
	bge $t2, 1, increment
	jal print_result
	
increment:
	addi $t1, $t1, 1
	addi $t2, $zero, 0
	j loop
	
print_result:
	li $v0, 1			
	move $a0, $t1			
	syscall	
	
	jal exit
	
exit:
	li $v0, 10
	syscall
	
	
	
	
	
	
