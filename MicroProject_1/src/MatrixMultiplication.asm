        ; nasm -fmacho64 MatrixMultiplication.asm && gcc MatrixMultiplication.o && ./a.out
        

        ; Разработать программу умножения матриц порядка N=5 
        ; при условии размещения элементов матриц в линейном
        ; массиве по строкам.
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
        typeSize db 'Please, type size of an matrix`s row: ', 10, 13, 0
        typeMatrix db 'Please, type your (int) matrix: ', 10, 13, 0
        yourMatrix db 'Your new matrix:', 10, 13, 0
        wrongInput db 'Incorrect input. Please try again', 10, 13, 10, 13, 0
        newLine db 10, 13, 0

        N: times 8 db 0                ; порядок матрицы
        sqr_N: times 8 db 0            ; размер матрицы
        number: times 8 db 0           ; введенное число
        temp: times 8 db 0
        iterator: times 8 db 0         ; вспомогательная переменная для циклов loop
        i: times 8 db 0                ; счетчик в цикле
        j: times 8 db 0                ; счетчик в цикле уровня 2
        k: times 8 db 0                ; счетчик в цикле уровня 3

        matrix  times 8 db 0           ; первая матрица
        matrix2: times 8 db 0          ; вторая матрица
        answer_matrix: times 8 db 0    ; матрица для результата

        one dd 1                       ; константа для сравнения
        zero dd 0

 section .text
        _main:
                push    rbp

                mov rdi, typeSize
                call _printf
                mov rdi, formatInt
                mov rsi, N
                call _scanf            ; считываем порядок квадратной матрицы

                mov eax, [rel N]
                cmp eax, [rel one]     ; проверяем, положителен ли порядок
                jl _WrongInput

                mov rax, [rel N]
                mov rbx, [rel N]
                mul rbx
                mov [rel sqr_N], rax

                mov rdi, typeMatrix
                call _printf           ; просим ввести матрицу построчно

                mov rdi, [rel sqr_N]            
                imul rdi, 8
                call _malloc           ; ищем участок памяти на N^2 чисел размером 8 байт
                mov [rel matrix], rax  ; записываем в matrix адрес первой ячейки найденного участка

                call InputMatrix       ; идем в процедуру ввода матрицы

                mov rdi, newLine
                call _printf

                xor r11, r11
                mov [rel i], r11       ; обнуляем счетчик цикла

                mov rdi, typeMatrix
                call _printf           ; просим ввести вторую матрицу построчно

                mov rdi, [rel sqr_N]            
                imul rdi, 8
                call _malloc           ; ищем участок памяти на N^2 чисел размером 8 байт
                mov [rel matrix2], rax ; записываем в matrix2 адрес первой ячейки найденного участка

                call InputSecondMatrix ; идем в процедуру ввода второй матрицы

                mov rdi, newLine
                call _printf

                mov rdi, [rel sqr_N]            
                imul rdi, 8
                call _malloc           ; ищем участок памяти на N^2 чисел размером 8 байт
                mov [rel answer_matrix], rax ; записываем в matrix2 адрес первой ячейки найденного участка

                call MultiplyMatrixes

                mov rdi, [rel matrix]
                call _free
                                       ; освобождаем зарезервированную память
                mov rdi, [rel matrix2] ; под промежуточные матрицы после создания результирующей
                call _free

                xor r11, r11
                mov [rel i], r11       ; обнуляем счетчик цикла 

                call OutputMatrix

                mov rdi, [rel answer_matrix] ; освобождаем память матрицы-результата после ее вывода
                call _free

                jmp ExitProgram

        ; --ПРОЦЕДУРЫ--
        InputMatrix:
                push rbx

                mov rcx, [rel sqr_N]
                ReadMatrix:
                        mov [rel iterator], rcx; махинации с сохранением в переменную, ибо rcx может меняться в цикле
                                               ; подобную магию мы будем делать в каждом цикле, ибо все они крупные
                                               ; и мы не можем быть уверены в сохранности регистра
                        mov rdi, formatInt
                        mov rsi, number
                        call _scanf 

                        mov r10, [rel i]
                        imul r10, dword 8      ; вычисляем сдвиг указателя

                        mov rax, [rel matrix]
                        add rax, r10           ; смещаем указатель на только что посчитанный сдвиг
                        mov r10, [rel number]  ; запишем введенное число в ecx
                        mov [rel rax], r10     ; записали введенное число в ячейку массива

                        mov r11, [rel i]
                        add r11, 1             ; инкременируем счетчик
                        mov [rel i], r11

                        mov rcx, [rel iterator]
                        loop ReadMatrix

                mov rax, 1
                pop rbx
                ret

        InputSecondMatrix:
                push rbx

                mov rcx, [rel sqr_N]
                ReadSecondMatrix:
                        mov [rel iterator], rcx; махинации с сохранением в переменную, ибо rcx может меняться в цикле

                        mov rdi, formatInt
                        mov rsi, number
                        call _scanf 

                        mov r10, [rel i]
                        imul r10, dword 8      ; вычисляем сдвиг указателя

                        mov rax, [rel matrix2]
                        add rax, r10           ; смещаем указатель на только что посчитанный сдвиг
                        mov r10, [rel number]  ; запишем введенное число в r10
                        mov [rel rax], r10     ; записали введенное число в ячейку массива

                        mov r11, [rel i]
                        add r11, 1             ; инкременируем счетчик
                        mov [rel i], r11

                        mov rcx, [rel iterator]
                        loop ReadSecondMatrix

                mov rax, 1
                pop rbx
                ret


        OutputMatrix:
                push rbx

                mov rdi, yourMatrix ; выводим сообщение о том, что дальше последует вывод матрицы-результата
                call _printf

                mov rcx, [rel N]
                ColumnOutputIterator: ; итерация по колонке (перебираем строки)
                        mov [rel i], rcx
                        
                        mov rcx, [rel N]
                        RowOutputIterator: ; итерация по строкам (перебираем элементы)
                                mov [rel j], rcx

                                mov r10, [rel N]   ; вычитаем текущий индекс из длины для получения индекса элемента
                                sub r10, [rel i]   ; i и j принадлежат диапазону [1;N]
                                imul r10, [rel N]
                                add r10, [rel N]
                                sub r10, [rel j]
                                imul r10, dword 8  ; просчитываем сдвиг указателя
                                mov rax, [rel answer_matrix]
                                add  rax, r10      ; сдвигаем указатель к нужному элементу

                                mov rdi, formatIntWithSpace
                                mov rsi, [rel rax] ; выводим нужный элемент
                                call _printf

                                mov rcx, [rel j]
                                loop RowOutputIterator

                        mov rdi, newLine
                        call _printf

                        mov rcx, [rel i]
                        loop ColumnOutputIterator
                                
                mov rdi, newLine
                call _printf
                
                xor rax, rax
                pop rbx
                ret

        MultiplyMatrixes:
                push rbx

                mov rcx, [rel N]
                RowsIteration:
                        mov [rel i], rcx

                        mov rcx, [rel N]
                        ColumnIteration:
                                mov [rel j], rcx

                                xor r12, r12            ; будем использовать для хранения суммы произведений
                                mov rcx, [rel N]

                                ElemIteration:
                                        mov [rel k], rcx

                                        mov r10, [rel i]
                                        dec r10
                                        imul r10, [rel N]
                                        add r10, [rel k]
                                        dec r10
                                        imul r10, dword 8       ; вычисляем сдвиг указателя
                                        mov rax, [rel matrix]
                                        add rax, r10

                                        mov r10, [rel k]
                                        dec r10
                                        imul r10, [rel N]
                                        add r10, [rel j]
                                        dec r10
                                        imul r10, dword 8       ; вычисляем сдвиг указателя
                                        mov rcx, [rel matrix2]
                                        add rcx, r10

                                        mov r11, [rel rax]      ; умножаем значение элемента строки первой матрицы 
                                        imul r11, [rel rcx]     ; на значение элемента столбца второй матрицы

                                        add r12, r11            ; суммируем так все произведения

                                        mov rcx, [rel k]
                                        loop ElemIteration

                                mov r10, [rel i]
                                dec r10
                                imul r10, [rel N]
                                add r10, [rel j]
                                dec r10
                                imul r10, dword 8       ; вычисляем сдвиг указателя
                                mov rax, [rel answer_matrix]
                                add rax, r10

                                mov [rel rax], r12      ; записываем сумму произведений элементов
                                                        ; i-ой строки первой матрицы на j-й столбец второй

                                mov rcx, [rel j]
                                dec rcx 
                                cmp rcx, [rel zero]
                                jnz ColumnIteration

                        mov rcx, [rel i]
                        dec rcx
                        cmp rcx, [rel zero]
                        jnz RowsIteration

                ; N * num_of_column + num_of_row
                ; N * num_of_row + num_of_column

                xor rax, rax
                pop rbx
                ret

        _WrongInput:
                mov rdi, wrongInput
                call _printf

                pop rbp
                jmp _main

        ExitProgram:
                mov	rax, 0		; normal, no error, return value
                pop     rbp
	        ret