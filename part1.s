.text
.global sum_two             # Part 1.1 ~SUM~
sum_two:
  add   r6, r4, r5
  ret


.global op_three            # Part 1.2 ~THREE INPUT OPERATION~
op_three:
  movia r2, A
  movia r3, B
  call  op_two
  movia r2, C
  mov   r3, r6
  call  op_two
  ret


.global fibonacci           # Part 1.3 ~FIBONACCI~
fibonacci:                  # fibonacci(N - 1) + fibonacci(N - 2)
  	addi	sp, sp, -8		    # Entry code
		stw   ra, 0(sp)
		stw		fp, 4(sp)
		add		fp, sp,   zero		# End of entry code
		ldw   r4, 8(fp)			    # r4 holds the argument n
		slli	r3, r4,   2       # Compare n with 2. if r4 < 2 ...
		beq		r3, zero, over    # ... skip the next two instructions
		addi	r2, zero, 1       # n < 2. We're done with the recursion
		call	exit				      # Jump to exit code
over: 	                    # n >= 2
    # Calculate fibonacci(n - 1)
		addi	r4, r4,   -1		  # Calculate n - 1
		addi	sp, sp,   -4		  # Allocate space for arguments
		stw   r4, 0(sp)			    # n - 1 is our argument
		call	fibonacci					# Call the fib procedure
		addi	sp, sp,   4       # Pop off the argument
		add		r3, r2,   zero		# r2 holds the result of fibonacci(n - 1). Put the result into r3
    # Calculate fibonacci(n - 2)
		ldw		r4, 8(fp)         # $r4 holds the argument n
		addi	r4, r4,   -2      # Calculate n - 2
		addi	sp, sp,   -4      # Allocate space for saved register
		stw   r3, 0(sp)         # Save r3 (the result of fibonacci(n - 1))
		addi	sp, sp,   -4      # Allocate space for arguments
		stw   r4, 0(sp)         # n - 2 is our argument
		call	fibonacci					# Call the fibonacci procedure
		addi	sp, sp,   4       # Pop off the argument
		ldw   r3, 0(sp)         # Restore r3 (the result of fibonacci(n - 1))
		addi	sp, sp,   4       # Deallocate space for saved register
		add		r2, r3,   r2      # r2 holds the result of fibonacci(n - 2). Result is fibonacci(n - 1) + fibonacci(n - 2)
exit:
		ldw		ra, 0(sp)         # Exit code
		ldw		fp, 4(sp)
		addi	sp, sp,   8
		ret                     # End of exit code

.data
INPUT1:
  .word 0x8
INPUT2:
  .word 0x6
A:
  .word 0x1
B:
  .word 0x2
C:
  .word 0x3
N:
  .word 0x7

.end
