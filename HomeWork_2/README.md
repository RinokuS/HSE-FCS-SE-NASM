# Соколовский Вацлав, БПИ191
[В данной папке](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/HomeWork_2) представлено выполнение второй домашней работы по работе в NASM. Исходники лежат в [HomeWork_2/src/](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/HomeWork_2/src), а скриншоты в [HomeWork_2/pictures/](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/HomeWork_2/pictures)

## Условие
Разработать программу, которая вводит одномерный массив A[N], формирует из элементов массива A новый массив B из <b>сумм соседних элементов A ({A[0] + A[1], A[1] + A[2], ...}).</b>

## Код программы
[Исходный код](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/HomeWork_2/src/program.ASM)<br>

Рассмотрим основную часть кода, которая "вызывает" процедуры:<br>
- **Основная часть кода**<br>
1. Сначала считываем в консоли размер массива, далее резервируем память под наш массив заданного размера. <br>
2. Вызываем процедуру ввода массива. <br>
3. Вызываем процедуру вывода нашего массива. <br>
4. Делаем ранний выход из программы в случае, если элементов меньше двух. <br>
5. Резервируем память под вспомогательный массив вызываем процедуру копирования исходного массива в новый. <br>
6. Изменяем исходный массив по заданию с помощью вспомогательного. <br>
7. Вызываем процедуру вывода измененного массива. <br>

<img src="https://raw.githubusercontent.com/TopYar/HSE_FCS_SE-ASM/master/HW2/img/proc4.png?v=1.01" alt="" width="700" /> <br><br>
Рассмотрим часть кода, относящегося к процедурам:<br>
- **Процедура ввода массива**<br>
<img src="https://raw.githubusercontent.com/TopYar/HSE_FCS_SE-ASM/master/HW2/img/proc1.png?v=1.01" alt="" width="700" /> <br><br>
- **Решение основной задачи (замена отрицательных чисел на максимум из массива)**<br>
<img src="https://raw.githubusercontent.com/TopYar/HSE_FCS_SE-ASM/master/HW2/img/proc3.png?v=1.01" alt="" width="550" /> <br><br>
- **Процедура вывода массива**<br>
<img src="https://raw.githubusercontent.com/TopYar/HSE_FCS_SE-ASM/master/HW2/img/proc2.png?v=1.01" alt="" width="550" /> <br><br>

## Тестирование программы
- **Тест 1**<br>
Для начала проверим проверку ввода на натуральное число:<br>
<img src="https://raw.githubusercontent.com/TopYar/HSE_FCS_SE-ASM/master/HW2/img/arr6.png" alt="" width="350" /> <br>
Программа отработала успешно <br><br>
- **Тест 2**<br>
Введем простенький массив, в котором максимальный элемент окажется -1, тогда все остальные элементы заменятся на -1:<br>
<img src="https://raw.githubusercontent.com/TopYar/HSE_FCS_SE-ASM/master/HW2/img/arr1.png" alt="" width="350" /> <br>
Программа отработала успешно <br><br>
- **Тест 3**<br>
Введем другой массив, в котором максимальный элемент окажется положительным, тогда все остальные <b> отрицательные элементы </b> заменятся на этот максимум:<br>
<img src="https://raw.githubusercontent.com/TopYar/HSE_FCS_SE-ASM/master/HW2/img/arr2.png" alt="" width="300" /> <br>
Программа отработала успешно <br><br>
- **Тест 4**<br>
Введем другой массив, в котором проверим работу вблизи нижней границы:<br>
<img src="https://raw.githubusercontent.com/TopYar/HSE_FCS_SE-ASM/master/HW2/img/arr3.png" alt="" width="300" /> <br>
Программа отработала успешно <br><br>
- **Тест 5**<br>
Введем массив посложнее и проверим правильность выполнения программы:<br>
<img src="https://raw.githubusercontent.com/TopYar/HSE_FCS_SE-ASM/master/HW2/img/arr4.png" alt="" width="300" /> <br>
Программа отработала должным образом
- **Тест 6**<br>
Введем большой массив и проверим правильность выполнения программы:<br>
<img src="https://raw.githubusercontent.com/TopYar/HSE_FCS_SE-ASM/master/HW2/img/arr5.png" alt="" width="750" /> <br>
Все отрицательные числа заменили на максимум (то есть 100), а неотрицательные числа остались нетронутыми<br>
Программа отработала должным образом
