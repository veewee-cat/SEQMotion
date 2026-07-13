## CreateSEQMotionSequence

Создание экземпляра управляемой последовательности
Метод возвращает указатель на струтуру управляемой последовательности, который нужно передавать в других методах ниже

**Внимание!** После того, как вы закончили использование управляемой последовательности удалите ее из памяти методом `DeleteSEQMotionSequence`, в противном случае экземпляр останется висеть в памяти

<br>

### Синтаксис
```c
SEQMotion.CreateSEQMotionSequence( _sequence_index )
```

### Параметры метода
![CreateSEQMotionSequence](images/CreateSEQMotionSequence.png)

### Возвращаемое значение
![CreateSEQMotionSequence-return](images/CreateSEQMotionSequence-return.png)

<br>
<br>
<br>

## DeleteSEQMotionSequence

Удаление из памяти экземпляра управляемой последовательности, созданного ранее, с помощью метода `CreateSEQMotionSequence`<br>
Внимание! После удаления к экзепляру управляемой последовательности все еще можно обращаться — его указатель будет актуальным, но методы отрисовки и изменения параметров / состояний не будут работать ( речь про `SetSequence` и ему подобные )

<br>

### Синтаксис
```c
SEQMotion.DeleteSEQMotionSequence( _seqmotion_sequence )
```

### Параметры метода
![DeleteSEQMotionSequence](images/DeleteSEQMotionSequence.png)

### Возвращаемое значение
![DeleteSEQMotionSequence-return](images/DeleteSEQMotionSequence-return.png)

<br>
<br>
<br>

## DrawSEQMotionSequence

Отрисовка управляемой последовательности<br>
Расчет данных каналов последовательности происходит на основе указанного в параметрах функции кадра, аналогично работе со спрайтами: если указать `frame = -1` игра будет отрисовывать текущий кадр последовательности *как оно есть*

При отрисовке можно менять общие параметры трансформации изображения ( самой последовательности ), а именно: размер ( `xscale` / `yscale` ) и поворот ( `rotation` ), относительно центральной точки

### Синтаксис
```c
SEQMotion.DrawSEQMotionSequence( _seqmotion_sequence, _frame, _x, _y, _xscale, _yscale, _rotation )
```

### Параметры метода
![DrawSEQMotionSequence](images/DrawSEQMotionSequence.png)

### Возвращаемое значение
![DrawSEQMotionSequence-return](images/DrawSEQMotionSequence-return.png)

<br>
<br>
<br>

## SetSequence

Изменение индекса экземпляра последовательности управляемой последовательности
Метод позволяет переключаться между ассетами, создавая более сложные системы анимаций. В качестве указателя на индекс последовательности можно указать значение `-1` — это очистит данные текущего экземпляра

### Синтаксис
```c
SEQMotion.SetSequence( _seqmotion_sequence, _sequence_index )
```

### Параметры метода
![SetSequence](images/SetSequence.png)

### Возвращаемое значение
![SetSequence-return](images/SetSequence-return.png)
