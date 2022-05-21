global _start
section .data
    message: db "Hello, world!", 0ah, "João Alem", 3

section .text
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, 24
    syscall
    mov rax, 60
    xor rdi, rdi
    syscall
