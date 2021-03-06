## Task
Имеется массив числовых значений, например, [4, 5, 8, 9, 1, 7, 2]. В распоряжении есть функция array_swap(&$arr, $num) { … } которая меняет местами элемент на позиции $num и элемент на 0 позиции. Т.е. при выполнении array_swap([3, 6, 2], 2) на выходе получим [2, 6, 3].
Написать код, сортирующий произвольный массив по возрастанию, используя только функцию array_swap.

## Solution details
Задание слабо завязано на возможности отдельного языка программирования, реализации на разных языках будут отличаться лишь синтаксимом. Здесь я написал решения на JavaScript, но они будут идентичны на любом другом ЯП.

GitHub не рендерит LaTeX(
### 1. Solution with n-1 iterations through array. File - algorithm.js
Достаточно прямое решение, итерируем по массиву n - 1 раз, каждый раз проходим с 0 до arr.length - i элемента, где i меняется от 0 до n-2, сравниная элемент в позиции с индеском 0 с каждым элементом подмассива на определенном шаге. Поставив максимальный элемент в первую позицию после n - i сравнений, меняем его местами с последним элементом подмассива на текущей итерации и запускаем процесс снова для подмассива с 0 до n - i индекса при i += 1, повторяем n - 1 раз и получаем отсортированный массив.

Оценим сложность алгоритма в Big O нотации = (n - 1)(1 + 2 + ... + (n-1)).\
n - 1 итерация, в каждой производим n - i сравнений. Собрав слагаемые во второй скобке по формуле арифметической прогрессии получим (n-1)(n-2)(1 + (n-1)) / 2. Итого: n *\* 2 * (n / 2) = n ** 3 / 2 => O(n ** 3)

### 2. Symmetric solution using binary search (in theory)
**2.1** Начнем с решения, похожего на предыдущее, можно сказать симметричного. Начнем итерировать по массиву с правого его конца вместо левого, и вместо того чтобы сокращать количество элементов в подмассиве будет увеличивать их число. То есть сначала мы берем подмассив из двух последних элементов, отсортировав его, берем подмассив из 3 последних элементов, сортируем и т.д. до полного массива из n элементов. В данном случае для того, чтобы можно было применять swap функцию для нулевого элемента относительно подмассива, необходимо копировать этот подмассив, первый элемент подмассива в данном случае будет в позиции 0, затем сортировать его, и потом заменять изначальный подмассив по индексам с n - i до n новым отсортированным подмасссивом. В данном случае сложность алгоритма будет также n ** 3 + накладные расходы ресурсов на копирование подмассива. Затраты на копирование будут составлять (n-1)(2 + 3 + 4 + ... + n - 1), что в нотации Big O будут те же n ** 3. В итоге сложность O(2n ** 3) = O(n ** 3)

**2.2** Теперь оптимизируем этот алгоритм при помощи бинарного поиска. Отсортировав подмассив из последних 2 элементов, на следующей итерации с 3 элементами нам не нужно сравнивать добавленный элемент с каждым из элементов расположенных правее, эти элементы упорядочены и мы можем найти подоходящее место в этом упорядоченном ряду для нового элемента при помощи бинарного поиска за время log(n). log обозначает log по основанию 2\*. Отсюда получим сложность алгоритма равную (n-1)(log(1) + log(2) + log(3) + ... + log(n)) = (n-1)log(n!), что, очевидно, значительно быстрее первого решения с полным перебором всех элементов находящихся правее за время n ** 3. В Big O нотации получим O(nlog(n!)).\
В то же время постоянное копирование подмассивов будет оцениваться сверху функцией n ** 3, что сводит нас к скорости предыдущего решения.\
Сложно оценить как будет расти функция log(n!), но можно уверенно сказать, что данный алгоритм без учета расходов на копирования подмассивов будет значительное эффективнее. Для 10 ** 6 элементов предыдущий алгоритм потребует 10 ** (6*3) = 10 ** 18, в то время как новый всего 10 ** 6 * log((10 ** 6)!) ≈ 18488885 * 10 ** 6, что значительно меньше(В грубом округлении не больше 2 * 10 ** 13). Получившая функция растет намного медленнее квадратичной, при увеличении порядка аргумента с 10 ** 5 до 10 ** 6 ее значение увеличивается примерно в 20 раз. Если бы мы не тратили столько ресурсов на копирования и могли сортировать подмассивы в самом массиве на месте, не копируя их, считая за нулевой индекс n - i позицию и имея возможность менять местами этот относительный нулевой элемент с остальными в подмасссиве, алгоритм работал бы значительно быстрее.

## Run solution
Запускаем команду ```node algorithm.js```, далее вводим элементы массива в формате: 1 0 2 3

