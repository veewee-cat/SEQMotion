//	Made by Veewee cat
//	@veewee_cat

///	@class			
///	@description SEQMotion API
function SEQMotion( ) constructor
{
	#region Переменные
	
		///	@ignore
		static __sequences_map = ds_map_create( );		//	Карта всех активных экземпляров управляемых последовательностей
														//	Используется как единое хранилище данных и указателей
	
	#endregion
	#region Публичные методы - API
	
		#region Get-методы
		
			///	@method
			///	@description
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@return {Real}
			static GetAnimationLength = function( _seqmotion_sequence_id )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetAnimationLength( );
			};
		
			///	@method
			///	@description Метод возвращает множитель скорости анимации управляемой последовательности, аналогичный возвращаемому значению функции layer_sequence_get_speedscale
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@return {Real}
			static GetAnimationSpeed = function( _seqmotion_sequence_id )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetAnimationSpeed( );
			};
			
			///	@method
			///	@description Метод возвращает текущую позицию кадра анимации текущей последовательности экземпляра управляемой последовательности
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@return {Real}
			static GetFrame = function( _seqmotion_sequence_id )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetFrame( );
			};
		
			///	@method
			///	@description Метод возвращает структуру данных локатора в текущем кадре анимации по имени его канала в редакторе последовательностей. Если локатора с указанным именем не существует, метод вернет значение undefined
			///	В структуре описана позиция относительно комнаты: x и y, — а также угол наклона локатора rotation
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {String} _locator_name Имя локатора локатора
			///	@return {Struct OR Undefined}
			static GetLocatorData = function( _seqmotion_sequence_id, _locator_name )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetLocatorData( _locator_name );
			};
			
			///	@method
			///	@description Метод возвращает указатель на текущий спрайт канала управляемой последовательности. Если канала с указанным именем не существует, метод вернет значение undefined
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {String} _track_name Имя канала спрайта
			///	@return {Asset.GMSprite OR Undefined}
			static GetTrackSprite = function( _seqmotion_sequence_id, _track_name )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetTrackSprite( _track_name );
			};
		
			///	@method
			///	@description Метод возвращает множитель растяжения по горизонтали экземпляра управляемой последовательности, аналогично значению image_xscale у объектов
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@return {Real}
			static GetXscale = function( _seqmotion_sequence_id )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetXscale( );
			};
		
			///	@method
			///	@description Метод возвращает множитель растяжения по вертикали экземпляра управляемой последовательности, аналогично значению image_yscale у объектов
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@return {Real}
			static GetYscale = function( _seqmotion_sequence_id )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetYscale( );
			};
			
		#endregion
		#region Set-методы
		
			///	@method
			///	@description Метод позволяет изменить множитель скорости проигрывания анимации
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Real} _rotation Скорость проигрывания анимации
			static SetAnimationSpeed = function( _seqmotion_sequence_id, _animation_speed )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetAnimationSpeed( _animation_speed );
			};
			
			///	@method
			///	@description С помощью этого метода вы можете изменить позицию текущего кадра анимации, аналогично с image_index у объектов
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Real} _frame Позиция кадра анимации
			static SetFrame = function( _seqmotion_sequence_id, _frame )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetFrame( _frame );
			};
		
			///	@method
			///	@description С помощью этого метода вы можете изменить угол наклона экземпляра управляемой последовательности, аналогично image_angle у объектов. Изменение наклона также влияет на положение локаторов
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Real} _rotation Значение наклона
			static SetRotation = function( _seqmotion_sequence_id, _rotation )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetRotation( _rotation );
			};
		
			///	@method
			///	@description Этот метод позволяет на ходу изменять индекс текущей последовательности экземпляра управляемой последовательности, позволяя вам переключаться между несколькими анимациями, описанными как отдельные ассеты
			///	Параметр _reset отвечает за то, нужно ли сбрасывать позицию кадра при смене индекса последовательности. Если этот параметр равен true, позиция кадра будет сдвинута в начало — на нулевой индекс ( По умолчанию этот параметр имеет значение true )
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Asset.GMSequence} _sequence_index Индекс последовательности
			///	@parameter {Bool} _reset * Нужно ли сбрасывать позицию текущего кадра анимации
			static SetSequence = function( _seqmotion_sequence_id, _sequence_index, _reset = true )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetSequence( _sequence_index, _reset );
			};
		
			///	@method
			///	@description С помощью этого метода можно на ходу изменить индекс спрайта указанного канала экземпляра управляемой последовательности. Если канала с указанным именем не существует, игра НЕ вызовет ошибку, позволяя избежать непредвиденных ситуаций
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {String} _track_name Имя канала спрайта
			///	@parameter {Asset.GMSprite} _sprite_index Индекс нового спрайта
			static SetTrackSprite = function( _seqmotion_sequence_id, _track_name, _sprite_index )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetTrackSprite( _track_name, _sprite_index );
			};
		
			///	@method
			///	@description Метод изменяет значение растяжения экземпляра управляемой последовательности по горизонтали, аналогично переменной image_xscale у объектов
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Real} _xscale Множитель растяжения экземпляра последовательности по горизонтали
			static SetXscale = function( _seqmotion_sequence_id, _xscale )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetXscale( _xscale );
			};

			///	@method
			///	@description Метод изменяет значение растяжения экземпляра управляемой последовательности по вертикали, аналогично переменной image_yscale у объектов
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Real} _xscale Множитель растяжения экземпляра последовательности по вертикали
			static SetYscale = function( _seqmotion_sequence_id, _yscale )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetYscale( _yscale );
			};
		
		#endregion
	
		///	@method
		///	@description Создание экземпляра управляемой последовательности. При указании индекса существующей последовательности она становится текущей при первом вызове UpdateSequence. Параметр _sequence_index является необязательным, его можно будет установить позже, используя метод SetSequence
		///	@parameter {Asset.GMSequence OR Undefined} _sequence_index * Индекс последовательности
		///	@return {Id.SEQMotionSequence}
		static CreateSequence = function( _sequence_index = undefined )
		{
			static seqmotion_sequence_id = 0;	//	Уникальный идентификатор управляемой последовательности
												//	Обновляется при создании нового экземпляра
									
			//
			//	Обновление уникального номера идентификатора экземпляра
			
				var _seqmotion_sequence_id = seqmotion_sequence_id;
											 seqmotion_sequence_id ++;
			
			//	Создание нового экземпляра
			//	Сохранение его указателя в памяти
			var _seqmotion_sequence = new SEQMotionSequence( _sequence_index );
									  ds_map_set( __sequences_map, _seqmotion_sequence_id, _seqmotion_sequence );
			
			return _seqmotion_sequence_id;
		};
		
		///	@method
		///	@description Удаление конкретного экземпляра управляемой последовательности из памяти. После удаления указатель, сохраненный ранее будет недействительным и попытки использовать его в параметрах методов расширения приведут к вызову ошибки
		///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
		static DeleteSequence = function( _seqmotion_sequence_id )
		{
			var _seqmotion_sequence = ds_map_find_value( __sequences_map, _seqmotion_sequence_id );
			
			//	Указатель на структуру последовательности валидный
			//	Удаление данных управляемой последовательности
			if ( is_instanceof( _seqmotion_sequence, SEQMotionSequence ) )
			{
				//	Очистка данных управляемой последовательности
				//	Удаление управляемой последовательности из памяти
					   _seqmotion_sequence.__CleanUp( );
				delete _seqmotion_sequence;
				
				//	Удаление указателя из карты активных экземпляров
				ds_map_delete( __sequences_map, _seqmotion_sequence_id );
			};
		};
		
		///	@method
		///	@description Так как экземпляры управляемых последовательностей являются динамичными данными, с помощью этого метода можно проверить существование конкретного экземпляра по его уникальному идентификатору, что возвращает метод CreateSequence при создании
		///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
		///	@return {Bool}
		static SequenceExists = function( _seqmotion_sequence_id )
		{
			return ds_map_exists( __sequences_map, _seqmotion_sequence_id );
		};
		
		///	@method
		///	@description Обновление экземпляра управляемой последовательности. Метод изменяет позицию и глубину отрисовки указанного экземпляра. Если параметры _x, _y и _depth не заданы или в качестве значения указана константа undefined, игра будет использовать данные экземпляра предыдущего кадра, когда был вызван метод
		///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
		///	@parameter {Real} _x * Позиция по x
		///	@parameter {Real} _y * Позиция по y
		///	@parameter {Real} _depth * Глубина отрисовки последовательности
		static UpdateSequence = function( _seqmotion_sequence_id, _x = undefined, _y = undefined, _depth = undefined )
		{
			__GetSequence( _seqmotion_sequence_id ).__UpdateSequence( _x, _y, _depth );
		};
	
	#endregion
	#region Приватные методы
	
		///	@method
		///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id
		///	@return {Struct.SEQMotionSequence}
		///	@ignore
		static __GetSequence = function( _seqmotion_sequence_id )
		{
			return ds_map_find_value( __sequences_map, _seqmotion_sequence_id ) ?? __Error( $"Недействительный указатель на экземпляр управляемой последовательности: { _seqmotion_sequence_id }" );
		};
		
		///	@method
		///	@parameter {String} _message
		///	@ignore
		static __Error = function( _message )
		{
			//	Изменение стандартной обработки сообщения
			exception_unhandled_handler( 
				///	@method
				///	@description Обработка ошибки
				///	@parameter {Struct} _message
				function( _message )
				{
					show_message( string_join
					( 
						"\n",
						"SEQMotion Error!",						//	Заголовок
						" ", 
						_message.message,						//	Основное сообщение ошибки
																//	Указывается в методе __Error
						" ",
						array_last( _message.stacktrace ) )		//	Первое звено вызовов, где была ошибка
					);
				} );
			
			//	Вывод сообщения ошибки
			show_error( _message, true );
		};
	
	#endregion
};