![banner](images/banner.png)

## Возможности

`SEQMotion.DrawSequence( seqmotion_sequence, frame, x, y, xscale, yscale, rotation )`

Отрисовка управляемой последовательности<br>
Расчет данных каналов последовательности происходит на основе указанного в параметрах функции кадра, аналогично работе со спрайтами: если указать `frame = -1` игра будет отрисовывать текущий кадр последовательности *как оно есть*

![banner](images/code_hint/DrawSequence.png)

<br><br>

`SEQMotion.SetSequence( seqmotion_sequence, sequence_index )`

Изменение индекса экземпляра последовательности управляемой SEQ-последовательности
Метод позволяет переключаться между ассетами, создавая более сложные системы анимаций. В качестве указателя на индекс последовательности можно указать значение `-1` — это очистит данные текущего экземпляра

![banner](images/code_hint/SetSequence.png)

























<br><br><br><br><br><br><br>

`SEQMotion.CreateSequence( sequence_index )`

`SEQMotion.DeleteSequence( seqmotion_sequence )`

`SEQMotion.GetSequence( seqmotion_sequence, frame, x, y, xscale, yscale, rotation )`
