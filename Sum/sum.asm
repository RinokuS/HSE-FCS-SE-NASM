        global    _main
        extern    _scanf                   ; импорт команды из другого модуля
        extern    _printf

        section   .text
_main:  
        push    rbp

        mov     rdi, formatin ; arguments are right to left (first parameter)
        mov     rsi, integer1
        mov     al, 0
        call    _scanf

        mov     rdi, formatin ; arguments are right to left (first parameter)
        mov     rsi, integer2
        mov     al, 0
        call    _scanf

        xor     rax, rax

        mov     rax, [rel integer1]
        add     rax, [rel integer2]
        mov	rdi,fmt		; format for printf
        mov	rsi,[rel integer1]         ; first parameter for printf
	mov	rdx,rax         ; second parameter for printf
        mov	rax,0		; no xmm registers
        call    _printf	
        pop	rbp	

	mov	rax,0		; normal, no error, return value
	ret			; return

        section   .data

        ;X:        dq        2
        ;Y:        dq       3
        ;Z:        dq        0
        integer1: times 8 db 0 ; 32-bits integer = 4 bytes
        integer2: times 8 db 0 ;
        formatin: db "%d", 0
        fmt:    db "firstInt=%ld, Sum=%ld", 10, 0	; The printf format, "\n",'0'