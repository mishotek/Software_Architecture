.data
	ask_to_enter_data: .asciiz "Enter number in ragne of (0 < n < 10000): "
	is_prime_text: .asciiz "It's prime"
	not_prime_text: .asciiz "It's not a prime!"

.text
	jal prompt_user
	
	# Set initial value to check entered number against
	addi $t1, $zero, 2
	
	jal while
	
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
	
	while:
		bge $t1, $t0, is_prime        # Exit if i >= n
		rem $t2, $t0, $t1             # Calc n % i
		beq $t2, $zero, not_prime     # When n % i == 0
		
		addi $t1, $t1, 1              # Increment the loop
		j while
		
	is_prime:
		# Print is prime message
		li $v0, 4
		la $a0, is_prime_text
		syscall
		
		jal exit
		
	not_prime:
		# Print is not prime message
		li $v0, 4
		la $a0, not_prime_text
		syscall
		
		jal exit
		
	exit:
		li $v0, 10
		syscall