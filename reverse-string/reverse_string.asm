bits 64

section .data
hello_world db "hello world"

section .bss
    string resb 0x1

section .text

global _start
_start:
    mov rsi, string
    xor rcx, rcx

    cld

    mov rdi, $ + 0xf
    call string_lenght

    xor rax, rax
    xor rdi, rdi

    jmp reverse_string


string_lenght:
    cmp 0x0, byte[rsi]
    je exit_from_rotine

    lodsb
    push rax
    inc rcx

    jmp string_lenght

exit_from_rotine:
    ret

print_result:
    mov rdx, rdi
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, string
    syscall

    jmp new_line

new_line:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, 0xa
    mov rdx, 0x1
    syscall

    jmp exit

exit:
    mov rax, 0x3c
    mov rsi, 0x1
    syscall
