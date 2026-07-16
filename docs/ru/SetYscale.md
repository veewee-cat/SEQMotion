### `SetYscale`

Метод изменяет значение растяжения экземпляра управляемой последовательности по вертикали, аналогично переменной `image_yscale` у объектов

### Синтаксис

```c#
SEQMotion.SetYscale( _seqmotion_sequence_id, _yscale )
```

### Параметры метода

![SetYscale_Parameters](.images/SetYscale_Parameters.png)

### Возвращаемое значение

![SetYscale_ReturnValue](.images/SetYscale_ReturnValue.png)

<br>
<br>

### Пример

```c#
SEQMotion.SetXscale( character, image_xscale );
SEQMotion.SetYscale( character, image_yscale );
```

Код выше будет синхронизировать растяжения экземпляра управляемой последовательности по горизонтали и вертикали на основе значений переменных `image_xscale` и `image_yscale` экземпляра объекта
