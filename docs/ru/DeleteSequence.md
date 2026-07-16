### `DeleteSequence`

Удаление конкретного экземпляра управляемой последовательности из памяти. После удаления указатель, сохраненный ранее будет недействительным и попытки использовать его в параметрах методов расширения приведут к вызову ошибки

### Синтаксис

```c#
SEQMotion.DeleteSequence( _seqmotion_sequence_id )
```

### Параметры метода

![DeleteSequence_Parameters](.images/DeleteSequence_Parameters.png)

### Возвращаемое значение

![DeleteSequence_ReturnValue](.images/DeleteSequence_ReturnValue.png)

### Пример

```c#
hands = SEQMotion.CreateSequence( Sequence_Character_Hands_Idle );
        SEQMotion.DeleteSequence( hands );
```

Код выше удалит из памяти ранее созданный экземпляр управляемой последовательности `hands`
