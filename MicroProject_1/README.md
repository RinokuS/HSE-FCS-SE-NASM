# Соколовский Вацлав, БПИ191
Основаня информация о работе представлена в [Пояснительной записке](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/MicroProject_1/PZ.pdf)

В [данной папке](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/MicroProject_1) представлено выполнение первого микропроекта в NASM. Исходники лежат в [MicroProject_1/src/](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/MicroProject_1/src), а скриншоты в [MicroProject_1/pictures/](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/MicroProject_1/pictures)

## Условие
Разработать программу умножения матриц порядка N=5 при условии размещения элементов матриц в линейном массиве по строкам.

## Код программы
[Исходный код](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/MicroProject_1/src/MatrixMultiplication.ASM)<br>

Рассмотрим основную часть кода, которая "вызывает" процедуры:<br>
- **Основная часть кода**<br>
1. Считываем в консоли порядок матриц, далее резервируем память под наши матрицы заданного размера (квадрат порядка). <br>
2. Вызываем процедуру ввода первой матрицы. <br>
3. Вызываем процедуру ввода первой матрицы. <br>
4. Резервируем память под матрицу-результат. <br>
5. Перемножаем две исходные матрицы. <br>
6. Вызываем процедуру вывода матрицы-результата. <br>
7. Освобождаем зарезервированную память. <br>

## Тестирование программы
Тесты программы осуществлялись только на матрицах порядка 5 и лежат [здесь](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/MicroProject_1/Tests).

В папке [MicroProject_1/input/](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/MicroProject_1/Tests/input) лежат входные данные для тестирования программы, в папке [MicroProject_1/output/](https://github.com/RinokuS/HSE-FCS-SE-NASM/tree/master/MicroProject_1/Tests/output) - вывод программы при соответствующих входных данных.