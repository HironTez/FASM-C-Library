format ELF64

include './sys.inc'

public printNumber
public printChar
public printLine
public input
public print
public charToNumber

section '.data'
  charToNumberErrorMessage db 'Invalid character', 0
  charToNumberErrorMessageLength = $ - charToNumberErrorMessage

section '.bss' writable
  char rb 1

section '.printNumber' executable
; input |
; rax: number to print
printNumber:
  push rbx
  mov rcx, 0

  .iter:
    ; get digit by dividing by 10 and getting remainder
    mov rbx, 10
    mov rdx, 0
    div rbx
    ; convert the remainder digit to ascii symbol by adding it to 48 ('0')
    add rdx, '0'
    ; push to stack for inverted access
    push rdx

    inc rcx
    
    ; if iterated through all digits, go to printing
    cmp rax, 0
    je .printIter

    jmp .iter

  .printIter:
    dec rcx

    pop rax ; get digit character from stack
    push rcx
    call printChar
    pop rcx

    ; exit if printed all digits
    cmp rcx, 0
    je .close

    jmp .printIter

  .close:
    pop rbx
    ret

section '.print' executable
; print buffer string
; input |
; rax: buffer address
; rdx: buffer size
print:
  mov rsi, rax ; buffer address
  ; mov rdx, 1 ; buffer size
  mov rax, 1 ; 1 - write
  mov rdi, 1 ; 1 - stdout
  syscall
  ret

section '.printChar' executable
; print a character
; input |
; rax: chracter to print
printChar:
  mov [char], al ; set al (last byte from rax) to char
  mov rax, char ; set buffer address
  mov rdx, 1 ; buffer size 1

  call print
  ret

section '.printLine' executable
; print a newline symbol
printLine:
  mov rax, 10 ; new line ASCII
  call printChar
  ret

section '.input' executable
; get input from the console
; input |
; rax: buffer address
; rdx: buffer size
input:
  dec rdx ; decrement the buffer size to reserve the latest byte for a null-terminator
  mov rsi, rax ; buffer address
  ; mov rdx, 1 ; buffer size
  mov rax, 0 ; 0 - read
  mov rdi, 0 ; 0 - stdin
  syscall
  mov byte [rsi + rdx], 0 ; set a null-terminator to the latest byte
  ret

section '.charToNumber' executable
; convert a character to a number
; input |
; rax: character to convert
; return |
; rax: converted number
charToNumber:
  ; exit if the value is not in the ASCII numeric range 
  cmp rax, 48
  jl .error
  cmp rax, 57
  jg .error

  ; subtract '0' from the ASCII value to get the number
  mov r8, 48
  sub rax, r8

  ret

  .error:
    mov rax, charToNumberErrorMessage
    mov rdx, charToNumberErrorMessageLength
    call exception
