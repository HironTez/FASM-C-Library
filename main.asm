format ELF64
public _start

include './asmlib/fmt.inc'
include './asmlib/sys.inc'



section '.code' executable
_start:
  mov rax, 101
  call printNumber
  call printLine

  call exit

