### `GetRotation`

Метод возвращает угол наклона экземпляра управляемой последовательности, аналогично `image_angle` у объектов

### Синтаксис

```c#
SEQMotion.GetRotation( _seqmotion_sequence_id )
```

### Параметры метода

![GetRotation_Parameters](.images/GetRotation_Parameters.png)

### Возвращаемое значение

![GetRotation_ReturnValue](.images/GetRotation_ReturnValue.png)

<br>
<br>

### Пример

```c#
var _rotation = SEQMotion.GetRotation( hands );
                SEQMotion.SetRotation( _rotation + 45 );
```

Приведенный выше код изменит угол наклона экземпляра управляемой последовательности `hands` на 45 градус против часовой стрелки
