#region Приватные методы

	///	@method
	///	@description Получение данных локатора
	///	@return {Struct}
	///	@ignore
	__GetLocatorData = function( )
	{
		return
		{
			x,
			y,
			rotation: image_angle
		};
	};

#endregion
#region При создании

	//	Сохранение указателя на локатор в памяти экземпляра последовательности
	struct_set( sequence_instance.locators, array_shift( sequence_instance.raw_locators_indexes ), id );

#endregion