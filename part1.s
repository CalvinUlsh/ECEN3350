; Name: Calvin Ulsh
; Project 3 Part 1

.text
.global sum_two       ; Part 1.1 ~SUM~
sum_two:
  ldw   r4, 0(r2)
  ldw   r5, 0(r3)
  add   r6, r4, r5
  ret

.global op_three      ; Part 1.2 ~THREE INPUT OPERATION~
op_three:
  movia r2, VAR_A
  movia r3, VAR_B
  call  op_two
  movia r2, VAR_C
  mov   r3, r6
  call  op_two
  ret

.global fibonacci     ; Part 1.3 ~FIBONACCI~
fibonacci:            ; Fibonacci(N - 1) + Fibonacci(N - 2)
  ;Set Up Stack Memory
  br LOOP
LOOP:
  ; Recall The New N Value From Stack Memory
  ldb   r3, 0(r2)
  subi  r4, r3, 1
  subi  r5, r4, 1
Minus1:                 ; Set Up Fibonacci(N - 1)
  dec   r4
  ; Save r4 Value To Stack Memory
  bne   r4, r0, LOOP    ; Break To Fibonacci(N - 1)
Minus2:                 ; Set Up Fibonacci(N - 2) After Fibonacci(N - 1) Branch Sequence
  dec   r5
  ; Save r5 Value To Stack Memory
  bne   r5, r0, LOOP    ; Break To Fibonacci(N - 2)
DONE:
  ; Add Minus1 and Minus2 Value
call Done
