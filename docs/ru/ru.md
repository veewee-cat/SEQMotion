## Методы

```c
SEQMotion.CreateSEQMotionSequence( sequence_index )
```

Создание экземпляра управляемой последовательности
Метод возвращает указатель на струтуру управляемой последовательности, который нужно передавать в других методах ниже

**Внимание!** После того, как вы закончили использование управляемой последовательности удалите ее из памяти методом `SEQMotion.DeleteSEQMotionSequence`, в противном случае экземпляр останется висеть в памяти

![CreateSEQMotionSequence](docs/ru/images/CreateSEQMotionSequence.png)

<br><br>

```c
SEQMotion.DeleteSEQMotionSequence( seqmotion_sequence )
```

Удаление экземпляра управляемой последовательности из памяти

![DeleteSEQMotionSequence](docs/ru/images/DeleteSEQMotionSequence.png)

<br><br>

```c
SEQMotion.DrawSEQMotionSequence( seqmotion_sequence, frame, x, y, xscale, yscale, rotation )
```

Отрисовка управляемой последовательности<br>
Расчет данных каналов последовательности происходит на основе указанного в параметрах функции кадра, аналогично работе со спрайтами: если указать `frame = -1` игра будет отрисовывать текущий кадр последовательности *как оно есть*

![DrawSEQMotionSequence](docs/ru/images/DrawSEQMotionSequence.png)

<br><br>

```c
SEQMotion.SetSequence( seqmotion_sequence, sequence_index )
```

Изменение индекса экземпляра последовательности управляемой SEQ-последовательности
Метод позволяет переключаться между ассетами, создавая более сложные системы анимаций. В качестве указателя на индекс последовательности можно указать значение `-1` — это очистит данные текущего экземпляра

![SetSequence](docs/ru/images/SetSequence.png)
