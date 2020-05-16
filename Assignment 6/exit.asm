global _start

section .text

_start:

        xor ebx, ebx    ; zeroed out ebx instead of eax
        mul ebx         ; used a mul instruction to zero out eax/edx saving us a byte
        inc eax         ; saving us another byte by incrementing eax.
        int 0x80


#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xdb\xf7\xe3\x40\xcd\x80";


int main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

