# Соколовский Вацлав, БПИ191
[В данной папке](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/HomeWork_2) представлено выполнение второй домашней работы по работе в NASM. Исходники лежат в [HomeWork_2/src/](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/HomeWork_2/src), а скриншоты в [HomeWork_2/pictures/](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/HomeWork_2/pictures)

## Условие
Разработать программу, которая вводит одномерный массив A[N], формирует из элементов массива A новый массив B из <b>сумм соседних элементов A ({A[0] + A[1], A[1] + A[2], ...}).</b>

## Код программы
[Исходный код](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/HomeWork_2/src/program.ASM)<br>

Рассмотрим основную часть кода, которая "вызывает" процедуры:<br>
- **Основная часть кода**<br>
1. Считываем в консоли размер массива, далее резервируем память под наш массив заданного размера. <br>
2. Вызываем процедуру ввода массива. <br>
3. Вызываем процедуру вывода нашего массива. <br>
4. Делаем ранний выход из программы в случае, если элементов меньше двух. <br>
5. Резервируем память под вспомогательный массив, вызываем процедуру копирования исходного массива в новый. <br>
6. Изменяем исходный массив по заданию с помощью вспомогательного. <br>
7. Вызываем процедуру вывода измененного массива. <br>

<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/MainCode1.png" alt="" width="700" /> <br><br>
<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/MainCode2.png" alt="" width="700" /> <br><br>
Рассмотрим часть кода, относящегося к процедурам:<br>
- **Процедура ввода массива**<br>
<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/InputArrCode.png" alt="" width="700" /> <br><br>
- **Процедура создания вспомогательного массива посредством копирования исходного**<br>
<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/CopyArrCode.png" alt="" width="550" /> <br><br>
- **Решение основной задачи (Создание массива из сумм двух соседних элементов исходного)**<br>
<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/TaskCode.png" alt="" width="550" /> <br><br>
- **Процедура вывода массива**<br>
<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/OutputArrCode.png" alt="" width="550" /> <br><br>

## Тестирование программы
- **Тест 1**<br>
Для начала проверим ввод размера массива на отрицательные числа и ноль:<br>
<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/Test1.png" alt="" width="350" /> <br>
Программа отработала успешно <br><br>
- **Тест 2**<br>
Введем массив из чередующихся чисел 1 и -1, тогда все элементы нового должны обнулиться:<br>
<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/Test2.png" alt="" width="350" /> <br>
Программа отработала успешно (также значит, что корректно обрабатываются отрицательные числа) <br><br>
- **Тест 3**<br>
Введем массив из случайно разбросанных чисел и проверим корректность выполнения задания:<br>
<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/Test3.png" alt="" width="300" /> <br>
Программа отработала успешно <br><br>
- **Тест 4**<br>
Введем массив, содержащий большие числа, и проверим корректность работы:<br>
<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/Test4.png" alt="" width="300" /> <br>
Программа отработала успешно <br><br>
- **Тест 5**<br>
Введем большой массив и проверим корректность выполнения программы:<br>
<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/Test5.png" alt="" width="300" /> <br>
Программа отработала успешно <br><br>
- **Тест 6**<br>
Последняя маленькая проверка на чередование по 2:<br>
<img src="https://github.com/RinokuS/HSE-FCS-SE-NASM/blob/master/HomeWork_2/pictures/%20Test6.png" alt="" width="750" /> <br>
Программа отработала должным образом
