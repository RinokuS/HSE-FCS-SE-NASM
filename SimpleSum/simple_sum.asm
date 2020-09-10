global    _main
        extern    _scanf                   ; импорт команды из другого модуля
        extern    _printf

        section   .text
_main:  
        push    rbp

        mov     rax, [rel X]
        add     rax, [rel Y]
        mov	rdi,fmt		; format for printf
        mov	rsi,[rel X]         ; first parameter for printf
	mov	rdx,rax         ; second parameter for printf
        mov	rax,0		; no xmm registers
        call    _printf		; Call C function
        pop	rbp		; restore stack

	mov	rax,0		; normal, no error, return value
	ret			; return

        section   .data

        X:        dq        2
        Y:        dq        3
        Z:        dq        0
        fmt:    db "a=%ld, rax=%ld", 10, 0	; The printf format, "\n",'0'