format ELF64

public exit

section '.exit' executable
exit:
	mov	rax,60 ; exit(2)
  mov	rdi,0	 ; result
  syscall
