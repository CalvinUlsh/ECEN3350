# Name: Calvin Ulsh
# Project 3 Part 1

.text
.equ input1       # part 1.1
.equ input2       # part 1.1
.equ A            # part 1.2
.equ B            # part 1.2
.equ C            # part 1.2
.equ N            # part 1.3


.global _start            # Part 1 ~TEST ALL~
_start:
  movia r2, INPUT1
  movia r3, INPUT2
  call  sum_two
  movia r2, VAR_N

  call  fibonacci



.global op_two            # Part 1.2 ~TWO INPUT TEST OPERATION~
op_two:
  ldw   r4, 0(r2)
  ldw   r5, 0(r3)
  multi r6, r4, r5
  ret

.data
INPUT1:
  .byte 8
INPUT2:
  .byte 6
VAR_A:
  .word 0x00000000
VAR_B:
  .word 0x00000000
VAR_C:
  .word 0x00000000
VAR_N:
  .byte 1
