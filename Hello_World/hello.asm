        global    _main
        extern    _puts                   ; импорт команды из другого модуля

        section   .text
_main:  
        push      rbx                     ; Кидает регистр rbx на стек
        lea       rdi, [rel message]      ; Загружает в rdi адрес значения, лежащего по адресу rel message
        call      _puts                   ; вызываем puts с параметром message
        pop       rbx                     ; Fix up stack before returning
        ret                               ; Извлекает адрес с верхней части стека и переходит на него 

        section   .data
message:  
        db        "Hello, world", 0        ; C strings need a zero byte at the end