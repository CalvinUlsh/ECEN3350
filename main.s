.text
.global _start            # Part 1 ~TEST ALL~
_start:
    movia sp, 0x03ffffff
    movia r2, INPUT1
    movia r3, INPUT2
    ldw   r4, 0(r2)
    ldw   r5, 0(r3)
    call  sum_two
    movia r4, N
    call  fib
.global op_two            # Part 1.2 ~TWO INPUT TEST OPERATION~
op_two:
    ldw   r4, 0(r2)
    ldw   r5, 0(r3)
    mul   r6, r4, r5
    ret
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
