# Course:		ECEN 3350
# Assignment:	Project 3.1
# Name:		Calvin Ulsh

.text
.global _start            # Main ~TEST ALL~
_start:
    movia	sp, 0x03ffffff
    movia	r2, IN1
    movia	r3, IN2
    ldw	r4, 0(r2)
    ldw	r5, 0(r3)
    call	sum_two
    movia	r18, N
    call	fibonacci

.global op_two            # Test Function ~TWO INPUT TEST OPERATION~
op_two:
    ldw		r4, 0(r2)
    ldw		r5, 0(r3)
    mul		r6, r4, r5
    ret
.data
IN1:		.word 0x8
IN2:		.word 0x6
A:			.word 0x1
B:			.word 0x2
C:			.word 0x3
N:			.word 0x7
