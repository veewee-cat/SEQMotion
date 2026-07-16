//	Made by Veewee cat
//	@veewee_cat

///	@class												
///	@description Управляемая последовательность
///	@parameter {Asset.GMSequence OR Undefined} _sequence_index Индекс последовательности
///	@ignore
function SEQMotionSequence( _sequence_index ) constructor
{
	#region Переменные
	
		__layer = undefined;	//	Слой для управления последовательностью
		
		__sequence = { };	//	Структура последовательности
		
		__sequence_instance_id = undefined;		//	Экземпляр последовательности
		__sequence_instance = { };				//	Структура экземпляра последовательности
		
		__ready = false;			//	Готова ли управляемая последовательность для обновления
		__can_be_updated = false;	//	Может ли последовательность быть обновлена
		__has_been_ready = false;	//	Была ли готова управляемая последовательность ранее
		
		__x = 0;	//	Позиция управляемой последовательности в мире; По x
		__y = 0;	//	По y
		
		__xscale = 1;	//	Фактор растяжения последовательности; По x
		__yscale = 1;	//	По y
		
		__rotation = 0;		//	Угол поворота управляемой последовательности

		__depth = 0;	//	Глубина слоя экземпляров последовательностей
		
		__sprites = { };				//	Структура спрайтов последовательности
		__raw_locators_indexes = [ ];	//	Список имен локаторов
		__locators = { };				//	Структура экземпляров локаторов

		__frame = 0;	//	Кадр анимации текущего экземпляра последовательности
		
		__animation_length = 0;		//	Длина анимации текущей последовательности в количестве кадров
		
		__animation_speed = 1;			//	Множитель скорости анимации
		__should_be_paused = false;		//	Должна ли анимация остановиться 

	#endregion
	#region Приватные методы
	
		//	Не рекомендуется использовать их напрямую
		//	Вместо этого лучше обращаться к публичным API-методам класса SEQMotion
		
		#region Get-методы
		
			///	@method
			///	@description Получение индекса спрайта указанного канала последовательности
			///	@parameter {String} _track_name Имя канала
			///	@return {Asset.GMSprite OR Undefined}
			///	@ignore
			static __GetTrackSprite = function( _track_name )
			{
				return struct_get( __sprites, _track_name ).spriteIndex;
			};
				
			///	@method
			///	@description Получение данных локатора по его имени
			///	@parameter {String} _locator_name Имя локатора
			///	@return {Struct OR Undefined}
			///	@ignore
			static __GetLocatorData = function( _locator_name )
			{
				//	Текущей последовательности не существует
				//	Возвращение неизвестного указателя
				if ( not __ready ) return undefined;
				
				//	Попытка обращение к экземпляру локатора
				//	Получение данных локатора
				with ( struct_get( __locators, _locator_name ) ) return __GetLocatorData( );
				
				//	Возвращение неизвестного указателя
				return undefined;
			};
		
			///	@method
			///	@description Структура текущей последовательности
			///	@return {Id.SequenceElment}
			///	@ignore
			static __GetSequenceInstanceId = function( )
			{
				return __sequence_instance_id;
			};
		
			///	@method
			///	@description Фактор растяжения последовательности по x
			///	@return {Real}
			///	@ignore
			static __GetXscale = function( )
			{
				return __xscale;
			};
			
			///	@method
			///	@description Фактор растяжения последовательности по y
			///	@return {Real}
			///	@ignore
			static __GetYscale = function( )
			{
				return __yscale;
			};
			
			///	@method
			///	@description Получение скорости проигрывания анимации экземпляра управляемой последовательности
			///	@return {Real}
			///	@ignore
			static __GetAnimationSpeed = function( )
			{
				return __animation_speed;
			};
			
			///	@method
			///	@description Получение индекса текущего кадра анимации последовательности
			///	@return {Real} 
			///	@ignore
			static __GetFrame = function( )
			{
				return __frame;
			};
		
		#endregion
		#region Set-методы

			///	@method
			///	@description Изменение спрайта указанного канала последовательности
			///	@parameter {String} _track_name Имя канала
			///	@parameter {Asset.GMSprite} _sprite_index Индекс спрайта для изменения
			///	@ignore
			static __SetTrackSprite = function( _track_name, _sprite_index )
			{
				//	В последовательности нет канала с указанным именем
				//	Вывод ошибки
				if ( not struct_exists( __sprites, _track_name ) ) 
				{
					show_error( $"В последовательности '{ __sequence.name }' нет канала с именем '{ _track_name }'", true );
					exit;
				};
					
				//	Сброс последовательности
				__ResetSequence( );
					
				//	Изменение параметров ассета последовательности
				struct_get( __sprites, _track_name ).spriteIndex = _sprite_index;
					
				//	Парсинг новых данных последовательности
				__ParseSequenceData( );
					
				//	Предыдущий экземпляр последовательности был обновлен ранее
				//	Обновление последовательности
				if ( __has_been_ready ) __UpdateSequence( );
			};

			///	@method
			///	@description Изменение индекса последовательности
			///	@parameter {Asset.GMSequence} _sequence_index Индекс последовательности
			///	@ignore
			static __SetSequence = function( _sequence_index )
			{
				//	Сброс последовательности
				__ResetSequence( );
				
				//	Индекс на последовательность невалидный
				//	Отмена описания новой последовательности
				if ( not sequence_exists( _sequence_index ) ) 
				{
					__can_be_updated = false;
					exit;
				};
				
				//
				//	Расчет параметров последовательности
				
					__sequence = sequence_get( _sequence_index );
					__can_be_updated = true;
				
					__frame = 0;
					__animation_length = __sequence.length;
					__playback_speed = __sequence.playbackSpeed;
					
				//	Парсинг данных последовательности
				__ParseSequenceData( );
					
				//	Предыдущий экземпляр последовательности был обновлен ранее
				//	Обновление нового экземпляра последовательности
				if ( __has_been_ready ) __UpdateSequence( );
			};
			
			///	@method
			///	@description Изменение фактора растяжения по x
			///	@parameter {Real} _xscale Фактор растяжения по x
			///	@ignore
			static __SetXscale = function( _xscale )
			{
				__xscale = _xscale;
				
				//	Текущий экземпляр последовательности существует
				//	Обновление его фактора растяжения по x
				if ( __ready ) layer_sequence_xscale( __sequence_instance_id, _xscale );
			};
			
			///	@method
			///	@description Изменение фактора растяжения по y
			///	@parameter {Real} _yscale Фактор растяжения по y
			///	@ignore
			static __SetYscale = function( _yscale )
			{
				__yscale = _yscale;
				
				//	Текущий экземпляр последовательности существует
				//	Обновление его фактора растяжения по y
				if ( __ready ) layer_sequence_yscale( __sequence_instance_id, _yscale );
			};
			
			///	@method
			///	@description Изменение угла наклона последовательности
			///	@parameter {Real} _rotation Угол наклона в градусах
			///	@ignore
			static __SetRotation = function( _rotation )
			{
				__rotation = _rotation;
				
				//	Текущий экземпляр последовательности существует
				//	Обновление его угла наклона
				if ( __ready ) layer_sequence_angle( __sequence_instance_id, _rotation );
			};
			
			///	@method
			///	@description Изменение множителя скорости анимации
			///	@parameter {Real} _animation_speed Скорость анимации
			///	@ignore
			static __SetAnimationSpeed = function( _animation_speed )
			{
				__animation_speed = _animation_speed;
				__should_be_paused = _animation_speed == 0;
				
				//	Текущий экземпляр последовательности существует
				//	Обновление его свойств
				if ( __ready ) 
				{
					layer_sequence_speedscale( __sequence_instance_id, _animation_speed );
					
					//	Должна ли анимация остановиться
					//	Остановка нативной анимации
					if ( __should_be_paused ) 
					{
						layer_sequence_pause( __sequence_instance_id );
						exit;
					};
					
					//	Продолжение анимации
					layer_sequence_play( __sequence_instance_id );
				};
			};
			
			///	@method
			///	@description Изменение текущего кадра анимации
			///	@parameter {Real} _frame Индекс кадра анимации
			///	@ignore
			static __SetFrame = function( _frame )
			{
				__frame = _frame mod __animation_length;
				
				//	Текущий экземпляр последовательности существует
				//	Обновление его свойств
				if ( __ready ) layer_sequence_headpos( __sequence_instance_id, __frame );
			};

		#endregion
		#region Сброс данных текущего экземпляра последовательности
		
			///	@method
			///	@description Сброс последовательности
			///	@ignore
			static __ResetSequence = function( )
			{
				//	Сброс состояния готовности текущего экземпляра последовательности
				__has_been_ready = false;
				
				//	Управляемая последовательность была ранее обновлена
				//	Очистка памяти
				if ( __ready ) 
				{
					//
					//	Удаление локаторов
					
						struct_foreach( __locators, __DeleteLocatorInstance );
										__locators = { };
					
					//	Удаление слоя
					layer_destroy( __layer );

					__ready = false;
					__has_been_ready = true;
				};
			};
		
			///	@method
			///	@description Удаление экземпляра локатора
			///	@parameter {String} _ Имя локатора
			///	@parameter {Id.Instance} _instance Экземпляр локатора
			///	@ignore
			static __DeleteLocatorInstance = function( _, _instance )
			{
				instance_destroy( _instance );
			};
		
		#endregion
		#region Парсинг данных последовательности
		
			///	@method
			///	@description Парсинг данных последовательности
			///	@ignore
			static __ParseSequenceData = function( )
			{
				//
				//	Сброс данные последовательности
					
					__sprites = { };
					__raw_locators_indexes = [ ];
					
				//	Парсинг каналов
				array_foreach( __sequence.tracks, __ParseTrack );
			};
			
			///	@method
			///	@description Парсинг данных канала
			///	@parameter {Struct.Track} _track Структура канала последовательности
			///	@ignore
			static __ParseTrack = function( _track )
			{
				//	Проверка типа канала
				switch ( _track.type )
				{
					case seqtracktype_graphic:
						//
						//	Спрайт
					
							//	Сохранение ссылки на исходную структуру канала
							struct_set( __sprites, _track.name, _track.keyframes[ 0 ].channels[ 0 ] );
					break;
				
					case seqtracktype_instance:
						//
						//	Экземпляр объекта
					
							//	Экземпляр объекта является локатором
							//	Сохранение имени локатора в памяти
							if ( _track.keyframes[ 0 ].channels[ 0 ].objectIndex == SEQMotion_Pointer_Locator ) array_push( __raw_locators_indexes, _track.name );
					break;
				};
			
				//	Рекурсивный обход дочерних каналов последовательности
				array_foreach( _track.tracks, __ParseTrack );
			};
		
		#endregion
		
		///	@method
		///	@description Обновление текущего экземпляра последовательности
		///	@parameter {Real} _x Позиция, где будет стоять экземпляр последовательности по x
		///	@parameter {Real} _y Позиция, где будет стоять экземпляр последовательности по y
		///	@parameter {Real} _depth Глубина сортировки экземпляра последовательности
		///	@ignore
		static __UpdateSequence = function( _x = __x, _y = __y, _depth = __depth )
		{
			//	Последовательность не может быть обновлена
			//	Отмена обновления
			if ( not __can_be_updated ) exit;
			
			//
			//	Обновление последовательности
			
				//	Последовательность не готова к обновлению
				//	Создание экземпляра текущей последовательности
				if ( not __ready )
				{
					__layer = layer_create( 0 );
							  layer_depth( __layer, _depth );
				
					//	Создание экземпляра текущей последовательности
					//	Получение структуры экземпляра последовательности
					__sequence_instance_id = layer_sequence_create( __layer, _x, _y, __sequence );
					__sequence_instance = layer_sequence_get_instance( __sequence_instance_id );

					//	Переключение состояния всей структуры
					__ready = true;
				
					//
					//	Изменение свойств экземпляра текущей последовательности
					
						//
						//	Подготовка данных локаторов
						
							__sequence_instance.locators = __locators;
							__sequence_instance.raw_locators_indexes = __raw_locators_indexes;

						layer_sequence_xscale( __sequence_instance_id, __xscale );
						layer_sequence_yscale( __sequence_instance_id, __yscale );

						layer_sequence_speedscale( __sequence_instance_id, __animation_speed );
						layer_sequence_headpos( __sequence_instance_id, __frame mod __animation_length );
						
						layer_sequence_angle( __sequence_instance_id, __rotation );
						
						//	Должна ли анимация остановиться
						//	Остановка нативной анимации
						if ( __should_be_paused ) layer_sequence_pause( __sequence_instance_id );
				
					exit;
				};
			
				//
				//	Обновление последовательности
			
					//	Позиция была изменена
					//	Обновление позиции
					if ( _x != __x or _y != __y )
					{
						__x = _x;
						__y = _y;
					
						layer_sequence_x( __sequence_instance_id, _x );
						layer_sequence_y( __sequence_instance_id, _y );
					};
				
					//	Глубина была изменена
					//	Обновление глубины
					if ( _depth != __depth )
					{
						__depth = _depth;
					
						layer_depth( __layer, _depth );
					};
					
					//	Обновление значения текущего кадра анимации текущего экземпляра последовательности
					__frame = layer_sequence_get_headpos( __sequence_instance_id );
		};
		
		///	@method
		///	@description Очистка динамичных данных управляемой последовательности
		///	@ignore
		static __CleanUp = function( )
		{
			//	Удалание текущего экземпляра последовательности
			__ResetSequence( );
		};
		
	#endregion
	#region При создании
	
		//	Изменение индекса последовательности
		__SetSequence( _sequence_index );
	
	#endregion
};