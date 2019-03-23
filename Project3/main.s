# Course:		ECEN 3350
# Assignment:	Project 3.1
# Name:			Calvin Ulsh

.text
.global _start            # Main ~TEST ALL~
_start:
	movia	sp, 0x03ffffff
	movi	r4, 3
	movi	r5, 5
	call	sum_two
	movi	r4,	2
	movi	r5, 3
	movi	r6, 1
	call	op_three
	movi	r4, 7
	call	fibonacci
.end