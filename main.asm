format ELF64
public _start

include './asmlib/fmt.inc'
include './asmlib/sys.inc'
include './asmlib/math.inc'

section '.code' executable
_start:
  ; mov rax, 101
  ; call printNumber
  ; call printLine

  ; mov rax, 15
  ; call fibonacci
  ; call printNumber
  ; call printLine

  mov rax, 5
  call factorial
  call printNumber
  call printLine

  call exit
