### `SequenceExists`

Так как экземпляры управляемой последовательности являются динамичными данными, с помощью этого метода можно проверить существование конкретного экземпляра по его уникальному идентификатору, что возвращает метод [**CreateSequence**](/docs/ru/CreateSequence.md) при создании

### Синтаксис

```c#
SEQMotion.SequenceExists( _seqmotion_sequence_id )
```

### Параметры метода

![DeleteSequence_Parameters](.images/SequenceExists_Parameters.png)

### Возвращаемое значение

![DeleteSequence_ReturnValue](.images/SequenceExists_ReturnValue.png)

### Пример

```c#
if ( SEQMotion.SequenceExists( character ) ) SEQMotion.UpdateSequence( character, x, y, depth );
```

Код выше проверит существование экземпляра управляемой последовательности character, и если он существует — обновит его позицию и глубину отрисовки
