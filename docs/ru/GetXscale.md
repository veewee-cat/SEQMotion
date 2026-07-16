### `GetXscale`

Метод возвращает множитель растяжения по горизонтали экземпляра управляемой последовательности, аналогично значению `image_xscale` у объектов

### Синтаксис

```c#
SEQMotion.GetXscale( _seqmotion_sequence_id )
```

### Параметры метода

![GetXscale_Parameters](.images/GetXscale_Parameters.png)

### Возвращаемое значение

![GetXscale_ReturnValue](.images/GetXscale_ReturnValue.png)

<br>
<br>

### Пример

```c#
Object_Eyes.image_xscale = SEQMotion.GetXscale( character );
Object_Eyes.image_yscale = SEQMotion.GetYscale( character );
```

Приведенный выше код получит значения множителей растяжения экземпляра управляемой последовательности и на их основе изменит значения переменных `image_xscale` и `image_yscale` у объекта `Object_Eyes`
