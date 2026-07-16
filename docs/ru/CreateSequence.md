### `CreateSequence`

Создание экземпляра управляемой последовательности. При указании индекса существующей последовательности она становится текущей при первом вызове [**UpdateSequence**](UpdateSequence.md). Параметр `_sequence_index` является необязательным, его можно будет установить позже, используя метод [**SetSequence**](SetSequence.md)

`Внимание!` Не забудьте удалить экземпляр управляемой последовательности из памяти после того, как закончите им пользоваться. В противном случае возможна утечка памяти. Используйте для этого метод [**DeleteSequence**](DeleteSequence.md)
### Синтаксис

```c#
SEQMotion.CreateSequence( _sequence_index )
```

### Параметры метода

![CreateSequence_Parameters](.images/CreateSequence_Parameters.png)

### Возвращаемое значение

![CreateSequence_Parameters](.images/CreateSequence_ReturnValue.png)

<br>
<br>

### Пример

```c#
character = SEQMotion.CreateSequence( Sequence_Character_Idle );
```

Код выше создаст новый экземпляр управляемой последовательности и сохранит его уникальный идентификатор в переменную `character`
