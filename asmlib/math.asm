format ELF64

public fibonacci

section '.data' writable
  char rb 1

section '.fibonacci' executable
; input |
; rax: number
; return |
; rax: fibonacci number
fibonacci:
  push rbx
  push rcx
  mov rcx, rax
  mov rax, 0
  mov rbx, 1

  .iter:
    cmp rcx, 1
    je .close

    push rbx
    add rbx, rax
    pop rax

    dec rcx
    jmp .iter
  .close:
    mov rax, rbx
    pop rcx
    pop rbx
    ret
