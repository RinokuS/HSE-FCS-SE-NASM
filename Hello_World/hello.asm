        global    _main
        extern    _puts                   ; импорт команды из другого модуля

        section   .text
_main:  
        push      rbx                     ; Кидает регистр rbx на стек
        lea       rdi, [rel message]      ; Загружает в rdi адрес значения, лежащего по адресу rel message
                                          ; Без rel не дает передать, does not support 32-bit absolute addresses  
        call      _puts                   ; вызываем puts с параметром message
        pop       rbx                     ; Убираем отработавший регистр из стека
        ret                               ; Извлекает адрес с верхней части стека и переходит на него 

        section   .data
message:  
        db        "Hello, world", 0        ; для Сшных строк нужен нулевой символ в конце