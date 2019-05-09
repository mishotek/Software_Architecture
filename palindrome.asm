.data
	prompt: .asciiz "Enter string to check (max length 64)"
	yes: .asciiz "Yes"
	no: .asciiz "No"
	str: .space 64

.text
	jal read_str
	jal is_palindrome
	jal exit
	
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
	add $t8, $zero, $t9		# Iteration index
	
	jal is_palindrome_loop
	
is_palindrome_loop:
	beq $t8, 0, print_no		# We didn't find palindrome
	
	addi $t7, $zero, 2		# Pairs
	div $t9, $t7			# to
	mflo $t3			# check
	
	sub $t0, $t9, $t8		# Staring index of the string
	
	add $t1, $t0, $t9		# Last index
	subi $t1, $t1, 1		# of the
	rem $t1, $t1, $t9		# string
	
	subi $t8, $t8, 1		# i--
	
	jal is_palindrome
	
is_palindrome:
	beq $t3, $zero, print_yes	# Check that we have reached the middle
	subi $t3, $t3, 1               # i--
	
	lb $t4, str($t0)
	lb $t5, str($t1)
	
	bne $t4, $t5, is_palindrome_loop
	
	addi $t0, $t0, 1		# Update starting
	rem $t0, $t0, $t9		# index
	
	subi $t1, $t1, 1               # Update
	add $t1, $t1, $t9		# end
	rem $t1, $t1, $t9		# index
		
	j is_palindrome

print_yes:
	li $v0, 4
	la $a0, yes
	syscall
	jal exit

print_no:
	li $v0, 4
	la $a0, no
	syscall
	jal exit

exit:
	li $v0, 10
	syscall
	
