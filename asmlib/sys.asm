format ELF64

include './fmt.inc'

public exit
public exception

section '.data'
  messagePrefix db 'An error occurred: ', 0
  messagePrefixLength = $ - messagePrefix

section '.exit' executable
exit:
	mov	rax, 60 ; exit
  mov	rdi, 0	; exit code
  syscall

section '.exception' executable
; exit with an error code
; input |
; rax: message buffer (optional)
; rdx: message buffer size (optional)
exception:
  push rax
  push rdx
  mov rax, messagePrefix
  mov rdx, messagePrefixLength
  call print

  pop rdx
  pop rax
  call print

  call printLine
  
	mov	rax, 60 ; exit
  mov	rdi, 1	; exit code
  syscall
