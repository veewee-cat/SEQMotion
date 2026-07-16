### `GetFrame`

Метод возвращает текущую позицию кадра анимации текущей последовательности экземпляра управляемой последовательности

### Синтаксис

```c#
SEQMotion.GetFrame( _seqmotion_sequence_id )
```

### Параметры метода

![GetFrame_Parameters](.images/GetFrame_Parameters.png)

### Возвращаемое значение

![GetFrame_ReturnValue](.images/GetFrame_ReturnValue.png)

<br>
<br>

### Пример

```c#
if ( SEQMotion.GetFrame( character ) >= SEQMotion.GetAnimationLength( character ) ) SEQMotion.SetSequence( character, Sequence_Character_Run );
```

Код выше вручную проверит, закончилась ли текущая анимация, и при успешной проверке изменит индекс последовательности экземпляра управляемой последовательности `character`
