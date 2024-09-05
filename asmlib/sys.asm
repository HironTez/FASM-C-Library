format ELF64

public exit

section '.exit' executable
exit:
	mov	rax, 60 ; exit
  mov	rdi, 0	; exit code
  syscall
