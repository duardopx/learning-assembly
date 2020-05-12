section .data
error_mesage db "> Insufficient argument offered"
line_breaker db 0xa

section .text

global _start
_start:

; Get argc
pop rcx

; Check if the parameters quantity is enought
cmp rcx, 0x3
jne inssuficient_parameters

add rsp, 0x8

pop rsi
call convert_to_int
mov r10, rax

pop rsi
call convert_to_int
mov r11, rax

add r10, r11

mov rax, r10
xor r12, r12

jmp convert_to_string


inssuficient_parameters:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, error_mesage
    mov rdx, 0x3f
    syscall

    jmp exit


convert_to_string:
    mov rdx, 0x0
    mov rbx, 0xa
    div rbx
    add rdx, 0x30
    push rdx
    inc r12
    cmp rax, 0x0
    jne convert_to_string
    jmp print


convert_to_int:
    xor rax, rax
    mov rcx, 0xa

next:
        cmp [rsi], byte 0x0
        je return
        mov bl, [rsi]
        sub bl, 0x30
        mul rcx
        add rax, rbx
        inc rsi
        jmp next

return:
        ret


print:
    mov rax, 0x1
    mul r12
    mov r12, 0x8
    mul r12
    mov rdx, rax

    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    syscall

jmp print_line_breaker

print_line_breaker:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, line_breaker
    mov rdx, 0x1
    syscall

    jmp exit


exit:
    mov rax, 0x3c
    mov rdi, 0x0
    syscall
