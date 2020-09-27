        global    _main
        extern    _printf
        extern    _scanf                   ; импорт команды из другого модуля

        section   .text
_main:  
        push    rbp

        mov     rdi, formatin ; arguments are right to left (first parameter)
        mov     rsi, integer1
        mov     al, 0
        call    _scanf

        mov	rdi,fmt		; format for printf
        mov	rsi,[rel integer1]         ; first parameter for printf
        call    _printf	

        pop	rbp	

        mov rax, 0 ;simulates return 0
        ret

        section .data

integer1: times 8 db 0 ; 32-bits integer = 4 bytes
formatin: db "%d", 0
fmt:    db "Your Int=%ld", 10, 0	; The printf format, "\n",'0'