# Course:		ECEN 3350
# Assignment:	Project 3.1
# Name:			Calvin Ulsh

# r2 and r3			return values
# r4 - r7			register arguments
# r8 - r15			caller-saved general purpose registers
# r16 - r23			callee-saved general purpose registers


.text
.global sum_two             		# Part 1.1 Calling Convention ~SUM~
sum_two:
	add   r3, r4, r5
	ret

.global op_three            		# Part 1.2 Saving Registers ~THREE INPUT OPERATION~
op_three:
	subi	sp, sp, 8				# push return address to stack - allocate
	stw		ra, 4(sp)				# return address
	stw		fp, 0(sp)				# frame pointer
	call	op_two					# call two input function
	ldw		ra, 4(sp)				# pop return address from stack
	ldw		fp, 0(sp)				# pop frame pointer from stack
	addi 	sp, sp, 8				# deallocate
	mov		r4, r2					# set return value from op_two as new argument
	mov		r5, r6
	call	op_two					# call to compute the new argument
	ret

.global fibonacci               	# Part 1.3 Recursive Functions ~FIBONACCI~
fibonacci:                      	# fibonacci(N - 1) + fibonacci(N - 2)
  	subi	sp,	sp,	12		    	# stack frame pointer
	stw		ra,	8(sp)				# store return address
	stw		fp,	4(sp)				# store frame pointer
	addi	fp,	sp,	4				# end of entry code
	cmpeqi	r15,r4, 1          		# Compare n with 2. if r18 < 2 ...
	beq		r15,r0,	one        		# Skip To one If n = 1
	beq		r4, r0,	zero           	# Skip To zero If n = 0
	stw		r4,-4(fp)				# Store The Last Index Value
	subi	r4, r4, 1				# Decrease by 1
	call	fibonacci				# Recurse
	ldw		r4,-4(fp)				# Pop
	add		r2, r9, r10				# Set Up Next Fibonacci Number
	mov		r9, r10					#
	mov		r10,r2
	br		stop
one: 	  	                      	# n = 1
	movi	r9,	0					# First Fibonacci Sequence Number
	movi	r10,1					# Second Fibonacci Sequence Number
	movi	r2, 1					# Third Fibonacci Sequence Number
	br		stop					# Ready For Summation
zero:								# n = 0
	movi	r2, 0					# First Fibonacci Sequence Number
stop:
	ldw		fp,	4(sp)				# Restore fp
	ldw		ra,	8(sp)				# Restore ra
	addi	sp, sp, 12				# Deallocate Stack Space
	ret

.data
IN1:		.word 0x8
IN2:		.word 0x6
A:			.word 0x1
B:			.word 0x2
C:      	.word 0x3
N:      	.word 0x7
.end
