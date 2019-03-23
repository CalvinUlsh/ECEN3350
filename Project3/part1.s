#*******************************************************************************************
# Course:		ECEN 3350
# Assignment:		Project 3.1
# Name:			Calvin Ulsh
#*******************************************************************************************

.text
.global sum_two             		# Part 1.1 Calling Convention ~SUM~
sum_two:							# two input sum (r4, r5)
	add   r3, r4, r5				# store the sum of r4 and r5 in r3
	ret								# return. value(r3)

.global op_three            		# Part 1.2 Saving Registers ~THREE INPUT OPERATION~
op_three:							# three input operation (r4, r5, r6)
	subi	sp, sp, 8				# push return address to stack - allocate
	stw		ra, 4(sp)				# return address
	stw		fp, 0(sp)				# frame pointer
	call	op_two					# call two input function
	ldw		ra, 4(sp)				# pop return address from stack
	ldw		fp, 0(sp)				# pop frame pointer from stack
	addi 	sp, sp, 8				# deallocate
	mov		r4, r3					# result of (r4 op r5) = (r3) stored in r4 for next operation
	mov		r5, r6					# the third term (r6) is moved to r5 for next operation
	subi	sp, sp, 8				# push return address to stack - allocate
	stw		ra, 4(sp)				# return address
	stw		fp, 0(sp)				# frame pointer
	call	op_two					# call to compute full three input operation
	ldw		ra, 4(sp)				# pop return address from stack
	ldw		fp, 0(sp)				# pop frame pointer from stack
	addi 	sp, sp, 8				# deallocate
	ret								# return. value(r3)

									# fibonacci[n - 1] + fibonacci[n - 2]
.global fibonacci               	# Part 1.3 Recursive Functions ~FIBONACCI~
fibonacci:                      	# one input for index (r4)
  	subi	sp,	sp,	12		    	# stack frame pointer
	stw		ra,	8(sp)				# store return address
	stw		fp,	4(sp)				# store frame pointer
	addi	fp,	sp,	4				# end of entry code
	cmpnei	r15,r4, 1          		# compare n with 1
	beq		r4, r0,	zero           	# if n = 0 (r4 = 0), break to zero
	beq		r15,r0,	one        		# if the cmpeqi is false, break to one
	stw		r4,	-4(fp)				# store the last index (r4) value
	subi	r4, r4, 1				# decrease index by 1
	call	fibonacci				# recurse to top fibonacci and start again with n-1 value
	ldw		r4,	-4(fp)				# pop off r4 value
	add		r2, r8, r9				# add r8 and r9, store in r2. r2 is the sum
	mov		r8, r9					# move r9 (n - 1) to r8 (n - 2)
	mov		r9,	r2					# and move r2 (sum) to r9 (n - 1)
	br		stop					# r2 is our new (n - 1), r9 is our new (n - 2). break to stop and repeat.
zero:								# n = 0
	movi	r2, 0					# first fibonacci sequence number
	br		stop					# ready for next term...
one: 	  	                      	# n = 1
	movi	r8,	0					# first fibonacci sequence number
	movi	r9,	1					# second fibonacci sequence number
	movi	r2, 1					# third fibonacci sequence number (first sum)
	br		stop					# ready for next term...
stop:								# tree branch is over
	ldw		fp,	4(sp)				# restore fp
	ldw		ra,	8(sp)				# restore ra
	addi	sp, sp, 12				# deallocate stack space
	ret								# return result (r2)

.end


# ***************************** MAIN.S *********************************************
#.text
#.global _start            # Main ~TEST ALL~
#_start:
#	movia	sp, 0x03ffffff
#	movi	r4, 3
#	movi	r5, 5
#	call	sum_two
#	movi	r4,	2
#	movi	r5, 3
#	movi	r6, 1
#	call	op_three
#	movi	r4, 7
#	call	fibonacci
#.end
#
# ***************************** OP_TWO.s ********************************************
#.global op_two
#op_two:					# test op_three with op_two = sum_two
#	call sum_two
#	ret
#.end