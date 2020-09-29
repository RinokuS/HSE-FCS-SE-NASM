        ; nasm -fmacho64 program.asm && gcc program.o && ./a.out
        
        ; Вариант: 3
        ; Массив B из сумм соседних элементов A ({A[0] + A[1], A[1] + A[2], ...}).
        global    _main
        extern    _scanf                   ; импорт команд из другого модуля
        extern    _printf
        extern    _malloc
        extern    _free

section .data

        formatStr db '%s', 0
        formatInt db '%d', 0
        formatIntWithSpace db '%d ', 0
        okMessage db 'Everything is OK.', 10, 13, 0 ; сообщение для дебага :)
        typeSize db 'Please, type size of an array: ', 10, 13, 0
        typeArr db 'Please, type your (int) array: ', 10, 13, 0
        individualLengthError db 'Your array length is less than 2! Can`t perform task.', 10, 13, 10, 13, 0
        firstArr db 'Typed array:', 10, 13, 0
        yourArr db 'Your new array:', 10, 13, 0
        wrongInput db 'Incorrect input. Please try again', 10, 13, 10, 13, 0
        newLine db 10, 13, 0

        N: times 8 db 0                ; размер массива
        number: times 8 db 0           ; введенное число
        temp: times 8 db 0
        i: times 8 db 0                ; счетчик в цикле

        arr : times 8 db 0             ; массив
        taskArr : times 8 db 0

        one dd 1                       ; переменная для сравнения

 section .text
        _main:
                push    rbp

                mov rdi, typeSize
                call _printf
                mov rdi, formatInt
                mov rsi, N
                call _scanf            ; считываем размер массива

                mov eax, [rel N]
                cmp eax, [rel one]     ; проверяем, положителен ли размер
                jl _WrongInput

                mov rdi, typeArr
                call _printf           ; просим ввести массив

                mov rdi, N
                imul rdi, 4
                call _malloc           ; ищем участок памяти на N чисел размером 8 байт
                mov [rel arr], rax     ; записываем в arr адрес первой ячейки найденного участка

                call InputArray        ; идем в процедуру ввода массива

                mov rdi, newLine
                call _printf

                xor r11, r11
                mov [rel i], r11       ; обнуляем счетчик цикла

                mov rdi, firstArr
                call _printf

                call OutputArray       ; выводим весь массив

                mov rdi, newLine
                call _printf

                mov rax, [rel N]
                cmp rax, [rel one]     ; выходим из программы, если длина массива равна единице
                je PreExitProgram      ; ибо для нового массива нужно хотя бы 2 элемента

                xor r11, r11
                mov [rel i], r11       ; обнуляем счетчик цикла

                mov rdi, N
                imul rdi, 4
                call _malloc           ; ищем участок памяти на N чисел размером 8 байт
                mov [rel taskArr], rax ; записываем в taskArr адрес первой ячейки найденного участка

                call CopyFirstArray    ; создаем второй вспомогательный массив

                xor r11, r11
                mov [rel i], r11       ; обнуляем счетчик цикла

                call IndividualTask    ; изменяем начальный массив, чтобы не переписывать функцию вывода

                xor r11, r11
                add r11, 1
                mov [rel i], r11       ; обнуляем счетчик цикла

                mov rdi, yourArr
                call _printf

                call OutputArray       ; выводим массив

                mov rdi, newLine
                call _printf

                mov rdi, [rel arr]
                call _free
                                       ; освобождаем зарезервированную память
                mov rdi, [rel taskArr]
                call _free

                jmp ExitProgram

        ; --ПРОЦЕДУРЫ--
        InputArray:
                push rcx

                mov rdi, formatInt
                mov rsi, number
                call _scanf 

                mov r10, [rel i]
                imul r10, dword 8      ; вычисляем сдвиг указателя

                mov rax, [rel arr]
                add rax, r10           ; смещаем указатель на только что посчитанный сдвиг
                mov r10, [rel number]  ; запишем введенное число в ecx
                mov [rel rax], r10     ; записали введенное число в ячейку массива

                mov r11, [rel i]
                add r11, 1             ; инкременируем счетчик
                mov [rel i], r11

                mov r11, [rel i]

                cmp r11, [rel N]       ; сравнение с размером массива
                jne _InputLooper

                mov rax, 1
                pop rcx
                ret

        _InputLooper:
                pop rcx
                jmp InputArray

        OutputArray:
                push rcx

                mov r10, [rel i]
                imul r10, dword 8       ; вычисляем сдвиг указателя
                mov rax, [rel arr]
                add rax, r10


                mov rdi, formatIntWithSpace
                mov rsi, [rel rax]
                call _printf            ; вывод числа

                mov r11, [rel i]
                add r11, 1
                mov [rel i], r11
                mov r11, [rel i]

                cmp r11, [rel N] 
                jne _OutputLooper

                xor rax, rax
                pop rcx
                ret

        _OutputLooper:
                pop rcx
                jmp OutputArray

        CopyFirstArray:
                push rcx

                mov r10, [rel i]
                imul r10, dword 8       ; вычисляем сдвиг указателя
                mov rax, [rel taskArr]
                add rax, r10

                mov r11, [rel arr]
                add r11, r10
                mov r12, [rel rax]
                add r12, [rel r11]
                mov [rel rax], r12      ; копируем элемент массива arr в элемент массива taskArr

                mov r11, [rel i]
                add r11, 1              ; инкременируем i
                mov [rel i], r11

                cmp r11, [rel N]
                jne _CopyLooper

                xor rax, rax
                pop rcx
                ret
        
        _CopyLooper:
                pop rcx
                jmp CopyFirstArray

        IndividualTask:
                push rcx

                mov r10, [rel i]
                imul r10, dword 8      ; вычисляем сдвиг указателя
                mov r13, [rel taskArr]
                add r13, r10

                mov r11, [rel i]
                add r11, 1             ; инкременируем i
                mov [rel i], r11

                mov r10, [rel i]
                imul r10, dword 8      ; вычисляем сдвиг указателя
                mov rax, [rel arr]
                add rax, r10

                mov r12, [rel r13]
                add r12, [rel rax]
                mov [rel rax], r12

                cmp r11, [rel N]
                jne _IndividualTaskLooper

                xor rax, rax
                pop rcx
                ret

        _IndividualTaskLooper:
                pop rcx
                jmp IndividualTask

        _WrongInput:
                mov rdi, wrongInput
                call _printf

                pop rbp
                jmp _main

        ExitProgram:
                mov	rax, 0		; normal, no error, return value
                pop     rbp
	        ret

        PreExitProgram:
                mov rdi, individualLengthError
                call _printf

                mov     rax, 0
                pop     rbp
                ret