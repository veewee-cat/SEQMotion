### `GetAnimationLength`

Метод возвращает длину анимации в количестве кадров, указанном в редакторе последовательностей

### Синтаксис

```c#
SEQMotion.GetAnimationLength( _seqmotion_sequence_id )
```

### Параметры метода

![GetAnimationLength_Parameters](.images/GetAnimationLength_Parameters.png)

### Возвращаемое значение

![GetAnimationLength_ReturnValue](.images/GetAnimationLength_ReturnValue.png)

<br>
<br>

### Пример

```c#
if ( SEQMotion.GetFrame( character ) >= SEQMotion.GetAnimationLength( character ) ) SEQMotion.SetSequence( character, Sequence_Character_Run );
```

Код выше вручную проверит, закончилась ли текущая анимация, и при успешной проверке изменит индекс последовательности экземпляра управляемой последовательности `character`
