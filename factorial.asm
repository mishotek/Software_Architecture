.data
	array: .space 800
	ask_to_enter_data: .asciiz "Enter number in ragne of (1 < n < 100): "
	
.text
	jal prompt_user
	
	jal init_array
	
	jal factorial
	
	jal exit
	
	
	prompt_user:
		# Ask user to enter data
		li $v0, 4
		la $a0, ask_to_enter_data
		syscall
		
		# Read user input
		li $v0, 5
		syscall
		
		# Save user's input in the t0 register
		move $t0, $v0 
		
		# Return
		jr $ra
		
	init_array:
		# Initial value of the last item in the array
		addi $t1, $zero, 1
		# Last Index address
		addi $t2, $zero, 796
		
		sw $t1, array($t2)
		
		# Return
		jr $ra
		
	print_array:
		# Init i = 0
		addi $t2, $zero, 0
		
		jal print_array_loop
		
		# Return
		jr $ra
		
	print_array_loop:
		bge $t2, 800, exit
		
		lw $t3, array($t2)
		
		# Print number
		li $v0, 1
		move $a0, $t3
		syscall
		
		addi $t2, $t2, 4
		
		j print_array_loop
		
		
	factorial:
		# Set initial value to check entered number against
		addi $t1, $zero, 1
		
		jal factorial_loop
		
		# Return
		jr $ra
		
	factorial_loop:
		bgt $t1, $t0, print_array
		addi $t3, $zero, 0
		jal multiply
		
		
	multiply:
		beq $t3, 800, calc_reminders
		
		lw $t4, array($t3)
		mul $t4, $t4, $t1
		sw $t4, array($t3)
		
		addi $t3, $t3, 4
		j multiply
		
	calc_reminders:
		# Increment curr multiplyer for factorial_loop
		addi $t1, $t1, 1
	
		# Prepare for loop
		addi $t3, $zero, 796
		jal calc_reminders_loop
			
	calc_reminders_loop:
		ble $t3, 0, factorial_loop
		
		lw $t4, array($t3)
		
		# Reminder
		rem $t5, $t4, 10
		# Setting updating array with reminder
		sw $t5, array($t3)
		
		# Move in loop
		addi $t3, $t3, -4
		
		# Full part
		div $t6, $t4, 10
		
		# From next index in array
		lw $t4, array($t3)
		add $t5, $t4, $t6
		
		sw $t5, array($t3)
		
		j calc_reminders_loop
		
		
		
		
	exit:
		li $v0, 10
		syscall
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
