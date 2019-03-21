# Course:		ECEN 3350
# Assignment:	Project 3.1
# Name:			Calvin Ulsh

.text
.global sum_two             		# Part 1.1 Calling Convention ~SUM~
sum_two:
	add   r6, r4, r5
	ret

.global op_three            		# Part 1.2 Saving Registers ~THREE INPUT OPERATION~
op_three:
	movia	r2,	A
	movia	r3,	B
	call	op_two
	movia	r2,	C
	mov 	r3,	r6
	call	op_two
	ret

.global fibonacci               	# Part 1.3 Recursive Functions ~FIBONACCI~
fibonacci:                      	# fibonacci(N - 1) + fibonacci(N - 2)
  	addi	sp,	sp,	-8		    	# Entry code
	stw		ra,	0(sp)
	stw		fp,	4(sp)
	add		fp,	sp,	r0				# End of entry code
	ldw		r18,8(fp)			    # r18 holds the argument n
	cmpeqi	r3,	r18,2          		# Compare n with 2. if r18 < 2 ...
	beq		r3, r0,	skip        	# ... skip the next two instructions
	addi	r2, r0,	1           	# n < 2. We're done with the recursion
  	call	stop				    # Jump to exit code
skip: 	                        	# n >= 2
	addi	r18,r18,-1		    	# Calculate n - 1
	addi	sp,	sp,	-4		    	# Allocate space for arguments
	stw		r18,0(sp)			    # n - 1 is our argument
	call	fibonacci				# Call the fibonacci procedure
	addi	sp,	sp,	4           	# Pop off the argument
	add		r3,	r2,	r0				# r2 holds the result of fibonacci(n - 1). Put the result into r3
	ldw		r18,8(fp)            	# r18 holds the argument n
	addi	r18,r18,-2        		# Calculate n - 2
	addi	sp, sp,	-4          	# Allocate space for saved register
	stw		r3, 0(sp)             	# Save r3 (the result of fibonacci(n - 1))
	addi	sp, sp,	-4          	# Allocate space for arguments
	stw		r18,0(sp)            	# n - 2 is our argument
	call	fibonacci				# Call the fibonacci procedure
	addi	sp, sp,	4           	# Pop off the argument
	ldw		r3, 0(sp)             	# Restore r3 (the result of fibonacci(n - 1))
	addi	sp, sp,	4           	# Deallocate space for saved register
	add		r2, r3,	r2          	# r2 holds the result of fibonacci(n - 2).
stop:
	ldw		ra, 0(sp)             	# Exit code
	ldw		fp, 4(sp)
	addi	sp, sp,		8
	ret                      		# End of exit code
.data
IN1:		.word 0x8
IN2:		.word 0x6
A:			.word 0x1
B:			.word 0x2
C:        .word 0x3
N:        .word 0x7
.end
