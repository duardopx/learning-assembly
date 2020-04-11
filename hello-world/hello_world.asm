section .data
hello_world db 'Hello World'

section .text

    global _start
    _start:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, hello_world
    mov rdx, 11
    syscall

    mov rax, 0x3c
    mov rsi, 0x1
    syscall
