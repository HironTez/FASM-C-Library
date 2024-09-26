format ELF64
public _start

include './asmlib/fmt.inc'
include './asmlib/sys.inc'
include './asmlib/math.inc'

section '.data'
  stringLength equ 128
  prompt db 'Enter something: ', 0
  promptLength = $ - prompt

section '.bss' writable
  string rb stringLength

section '.code' executable
_start:
  ; mov rax, 101
  ; call printNumber
  ; call printLine

  ; mov rax, 15
  ; call fibonacci
  ; call printNumber
  ; call printLine

  ; mov rax, 5
  ; call factorial
  ; call printNumber
  ; call printLine

  ; ; print the prompting message
  ; mov rax, prompt
  ; mov rdx, promptLength
  ; call print

  ; get user's input
  mov rax, string
  mov rdx, stringLength
  call input

  ; print the user's input
  mov rax, string
  mov rdx, stringLength
  call print

  ; mov rax, 50
  ; call charToNumber
  ; call printNumber
  ; call printLine

  call exit
