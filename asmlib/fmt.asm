format ELF64

public printNumber
public printChar
public printLine

section '.data' writable
  char rb 1

section '.printNumber' executable
; input |
; rax: number to print
printNumber:
  push rax
  push rbx
  push rcx
  push rdx

  mov rcx, 0

  .iter:
    ; get digit by dividing by 10 and getting remainder
    mov rbx, 10
    mov rdx, 0
    div rbx
    ; convert digit to ascii symbol by adding it to 48 ('0')
    add rdx, '0'
    ; push to stack for inverted access
    push rdx

    inc rcx
    
    ; if iterated through all digits, go to printing
    cmp rax, 0
    je .printIter

    jmp .iter
  .printIter:
    cmp rcx, 0
    je .close

    pop rax
    call printChar

    dec rcx
    jmp .printIter
  .printZero:
    mov rax, '0'
    call printChar
  .close:
    pop rdx
    pop rcx
    pop rbx
    pop rax

    ret

; input |
; rax: chracter to print
section '.printChar' executable
printChar:
  push rax
  push rbx
  push rcx
  push rdx

  mov [char], al ; set al (last byte from rax) to char

  ; mov rax, 4
  ; mov rbx, 1
  ; mov rcx, char
  ; mov rdx, 1
  ; int 128

  mov rsi, char ; set value to print
  mov rax, 1 ; 4 - write
  mov rdi, 1 ; 1 - stdout
  mov rdx, 1 ; symbols count
  syscall

  pop rdx
  pop rcx
  pop rbx
  pop rax

  ret

section '.printLine' executable
printLine:
  push rax
  mov rax, 10
  call printChar
  pop rax

  ret