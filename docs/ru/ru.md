## Методы

```c
SEQMotion.CreateSEQMotionSequence( sequence_index )
```

Создание экземпляра управляемой последовательности
Метод возвращает указатель на струтуру управляемой последовательности, который нужно передавать в других методах ниже

**Внимание!** После того, как вы закончили использование управляемой последовательности удалите ее из памяти методом `SEQMotion.DeleteSEQMotionSequence`, в противном случае экземпляр останется висеть в памяти

### Возвращаемое значение

![CreateSEQMotionSequence-return](images/CreateSEQMotionSequence-return.png)

### Параметры метода

![CreateSEQMotionSequence](images/CreateSEQMotionSequence.png)

<br><br>

```c
SEQMotion.DeleteSEQMotionSequence( seqmotion_sequence )
```

Удаление экземпляра управляемой последовательности из памяти

### Возвращаемое значение

![DeleteSEQMotionSequence-return](images/DeleteSEQMotionSequence-return.png)

### Параметры метода

![DeleteSEQMotionSequence](images/DeleteSEQMotionSequence.png)

<br><br>

```c
SEQMotion.DrawSEQMotionSequence( seqmotion_sequence, frame, x, y, xscale, yscale, rotation )
```

Отрисовка управляемой последовательности<br>
Расчет данных каналов последовательности происходит на основе указанного в параметрах функции кадра, аналогично работе со спрайтами: если указать `frame = -1` игра будет отрисовывать текущий кадр последовательности *как оно есть*

### Возвращаемое значение

![DrawSEQMotionSequence-return](images/DrawSEQMotionSequence-return.png)

### Параметры метода

![DrawSEQMotionSequence](images/DrawSEQMotionSequence.png)

<br><br>

```c
SEQMotion.SetSequence( seqmotion_sequence, sequence_index )
```

Изменение индекса экземпляра последовательности управляемой SEQ-последовательности
Метод позволяет переключаться между ассетами, создавая более сложные системы анимаций. В качестве указателя на индекс последовательности можно указать значение `-1` — это очистит данные текущего экземпляра

### Возвращаемое значение

![SetSequence-return](images/SetSequence-return.png)

### Параметры метода

![SetSequence](images/SetSequence.png)
