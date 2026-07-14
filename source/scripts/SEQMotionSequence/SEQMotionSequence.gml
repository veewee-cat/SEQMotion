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
		
		__sequence = { };					//	Структура последовательности
		__sequence_instance = undefined;	//	Экземпляр последовательности
		
		__ready = false;			//	Готова ли управляемая последовательность для обновления
		__can_be_updated = false;	//	Может ли последовательность быть обновлена
		
		__x = 0;	//	Позиция управляемой последовательности в мире; По x
		__y = 0;	//	По y
		
		__xscale = 1;	//	Фактор растяжения последовательности; По x
		__yscale = 1;	//	По y

		__depth = 0;	//	Глубина слоя экземпляров последовательностей
		
		__animation_length = 0;		//	Длина анимации текущей последовательности в количестве кадров
		__playback_speed = 60;		//	Множитель скорости анимации

	#endregion
	#region Приватные методы
	
		//	Не рекомендуется использовать их напрямую
		//	Вместо этого лучше обращаться к публичным API-методам класса SEQMotion
		
		#region Get-методы
		
			///	@method
			///	@description Структура текущей последовательности
			///	@return {Id.SequenceElment}
			///	@ignore
			static __GetSequenceInstance = function( )
			{
				return __sequence_instance;
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
		
		#endregion
		#region Set-методы
		
			#region Данные каналов
			
				///	@method
				///	@description Изменение спрайта указанного канала последовательности
				///	@parameter {String} _track_name Имя канала
				///	@parameter {Asset.GMSprite} _sprite_index Индекс спрайта для изменения
				///	@ignore
				static __SetTrackSprite = function( _track_name, _sprite_index )
				{
					//	Сброс последовательности
					__ResetSequence( );
					
					//	Изменение параметров ассета последовательности
					//	Обновление последовательности
					struct_get( __sprites, _track_name ).spriteIndex = _sprite_index;
					__UpdateSequence( );
				};
			
			#endregion

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
				
					__animation_length = __sequence.length;
					__playback_speed = __sequence.playbackSpeed;
					
				//	
				//	Парсинг данных последовательности
				
					//	Сброс структуры спрайтов последовательности
					//	Парсинг каналов
					__sprites = { };
					array_foreach( __sequence.tracks, __ParseTrack );
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
				if ( __ready ) layer_sequence_xscale( __sequence_instance, _xscale );
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
				if ( __ready ) layer_sequence_yscale( __sequence_instance, _yscale );
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
				if ( __ready ) layer_sequence_angle( __sequence_instance, __rotation );
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
					//	Переключение состояния всей структуры
					__sequence_instance = layer_sequence_create( __layer, _x, _y, __sequence );
					__ready = true;
				
					//
					//	Изменение свойств экземпляра текущей последовательности

						layer_sequence_xscale( __sequence_instance, __xscale );
						layer_sequence_yscale( __sequence_instance, __yscale );
					
						layer_sequence_headpos( __sequence_instance, layer_sequence_get_headpos( __sequence_instance ) mod __animation_length );
						
						layer_sequence_angle( __sequence_instance, __rotation );
				
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
					
						layer_sequence_x( __sequence_instance, _x );
						layer_sequence_y( __sequence_instance, _y );
					};
				
					//	Глубина была изменена
					//	Обновление глубины
					if ( _depth != __depth )
					{
						__depth = _depth;
					
						layer_depth( __layer, _depth );
					};
		};
		
		///	@method
		///	@description Сброс последовательности
		///	@ignore
		static __ResetSequence = function( )
		{
			//	Управляемая последовательность была ранее обновлена
			//	Очистка памяти
			if ( __ready ) 
			{
				layer_destroy( __layer );
							   __ready = false;
			};
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
			};
			
			//	Рекурсивный обход дочерних каналов последовательности
			array_foreach( _track.tracks, __ParseTrack );
		};
	
	#endregion
	#region При создании
	
		//	Изменение индекса последовательности
		__SetSequence( _sequence_index );
	
	#endregion
};