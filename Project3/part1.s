# Course:		ECEN 3350
# Assignment:	Project 3.1
# Name:			Calvin Ulsh

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
	cmpeqi	r15,r4, 1          		# compare n with 1
	beq		r15,r0,	one        		# skip to one if true
	beq		r4, r0,	zero           	# skip to zero if r4 = 0 (n = 0)
	stw		r4,-4(fp)				# store the last index value
	subi	r4, r4, 1				# decrease n by 1
	call	fibonacci				# recurse to top fibonacci and start again with n-1 value
	ldw		r4,-4(fp)				# pop off r4 value
	add		r2, r9, r10				# add r9 and r10, store in r2. r2 is the sum
	mov		r9, r10					# move r10 (n - 1) to r9 (n - 2)			
	mov		r10,r2					# and move r2 (sum) to r10 (n - 1)
	br		stop					# r2 is our new (n - 1), r10 is our new (n - 2). break to stop and repeat.
one: 	  	                      	# n = 1
	movi	r9,	0					# first fibonacci sequence number
	movi	r10,1					# second fibonacci sequence number
	movi	r2, 1					# third fibonacci sequence number (first sum)
	br		stop					# ready for next term...
zero:								# n = 0
	movi	r2, 0					# first fibonacci sequence number
stop:
	ldw		fp,	4(sp)				# restore fp
	ldw		ra,	8(sp)				# restore ra
	addi	sp, sp, 12				# deallocate stack space
	ret

#.data
#IN1:		.word 0x8
#IN2:		.word 0x6
#A:			.word 0x1
#C:      	.word 0x3
#N:      	.word 0x7
#.end

# r2 and r3			return values
# r4 - r7			register arguments
# r8 - r15			caller-saved general purpose registers
# r16 - r23			callee-saved general purpose registers