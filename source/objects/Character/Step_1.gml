//	Простая сортировка по глубине
depth = -y;

//
//	Обновление управляемой последовательности

	//	Последовательность персонажа существует
	//	Обновление анимации
	if ( SEQMotion.SequenceExists( character ) )
	{
		var _depth = depth;
		var _hands = hands;
		
		//	Обновление тела персонажа
		SEQMotion.UpdateSequence( character, x, y, _depth );

		//	Обращение к данным локатора
		//	Обновление рук персонажа в позиции локатора
		with ( SEQMotion.GetLocatorData( character, "Hands" ) ) 
		{
			SEQMotion.UpdateSequence( _hands, x, y, _depth - 1 );
			SEQMotion.SetRotation( _hands, rotation );
		};
	};