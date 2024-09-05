format ELF64

public fibonacci
public factorial

section '.fibonacci' executable
; calculate fibonacci number on the given position
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

section '.factorial' executable
; calculate factorial of the given number
; input |
; rax: number
; return |
; rax: factorial number
factorial:
  push rbx

  mov rbx, rax

  .iter:
    cmp rbx, 2
    jle .close

    dec rbx
    mul rbx
    jmp .iter

  .close:
    pop rbx
    ret
    

