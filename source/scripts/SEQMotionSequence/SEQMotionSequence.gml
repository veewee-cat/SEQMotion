//	Made by Veewee cat: https://t.me/veewee_cat

///	@class												
///	@description													Родительский класс управляемой последовательности
///	@parameter {Asset.GMSequence OR Undefined} _sequence_index		Индекс последовательности
///	@ignore
function SEQMotionSequence( _sequence_index ) constructor
{
	#region Переменные
	
		__layer = undefined;	//	Слой для хранения и обработки экземпляров последовательностей		
		
		__on_create_sequence = _sequence_index;		//	Индекс начальной последовательности
		
		__current_sequence = undefined;		//	Указатель на текущую последовательность, которая должна отрисовываться
		
		__playback_speed = 1;	//	Скорость проигрывания анимации текущего и последующих экземпляров последовательностей
		__frame_length = 0;		//	Индекс последнего кадра текущей последовательности
		
		__sprites = { };	//	Структура спрайтов текущей последовательности
							//	Хранит указатели на спрайты по ключу

	#endregion
	#region Приватные методы
	
		//	Не рекомендуется их использовать напрямую
		//	Для манипуляции с данными экземпляров управляемых последовательностей используйте методы API
		
		#region Get-методы
		
			///	@method
			///	@description								Получение индекса текущей последовательности
			///	@return {Id.SequenceElement OR Undefined}
			///	@ignore
			static __GetSequence = function( )
			{
				return __current_sequence;
			};
			
			///	@method
			///	@description								Получение скорости проигрывания анимации
			///	@return {Real}
			///	@ignore
			static __GetPlaybackSpeed = function( )
			{
				return __playback_speed;
			};
		
		#endregion
		#region Set-методы
			
			///	@method
			///	@description												Создание экземпляра последовательности
			///	@parameter {Asset.GMSequence OR Real} _sequence_index		Индекс последовательности, на которую будет изменен текущий экземпляр
			///	@ignore
			static __SetSequence = function( _sequence_index )
			{
				//	Слоя не существует
				//	Пересоздание слоя
				if ( not layer_exists( __layer ) ) __CreateLayer( );
				
				//	Указатель на текущую последовательность валидный
				//	Удаление текущей последовательности
				if ( not is_undefined( __current_sequence ) ) layer_sequence_destroy( __current_sequence );
			
				//	Индекс на последовательность невалидный
				//	Отмена создания нового экземпляра последовательности
				if ( _sequence_index == -1 )
				{
					__current_sequence = undefined;
					__frame_length = 0;
					
					exit;
				};
				
				//
				//	Создание экземпляра последовательности
				
					//	Создание экземпляра последовательности
					//	Сохранение его индекса
					__current_sequence = layer_sequence_create( __layer, 0, 0, _sequence_index );
										 layer_sequence_speedscale( __current_sequence, __playback_speed );
										 
					var _sequence_struct = layer_sequence_get_sequence( __current_sequence );
				
					//	Получение длины анимации последовательности
					__frame_length = _sequence_struct.length;
				
					//
					//	Подготовка структуры спрайтов
				
						__sprites = { };
					
						array_foreach( _sequence_struct.tracks, function( _track )
						{
							if ( _track.type == seqtracktype_graphic )
							{
								struct_set( __sprites, _track.name, _track.keyframes[ 0 ].channels[ 0 ].spriteIndex );
							};
						} );
			};
			
			///	@method
			///	@description						Изменение скорости проигрывания анимации
			///	@parameter {Real} _playback_speed	Новая скорость анимации
			///	@ignore
			static __SetPlaybackSpeed = function( _playback_speed )
			{
				//	Текущий экземпляр существует
				//	Изменение скорости проигрывания анимации
				if ( not is_undefined( __current_sequence ) ) layer_sequence_speedscale( __current_sequence, _playback_speed );
				
				//	Сохранение скорости для последующих экземпляров
				__playback_speed = _playback_speed;
			};
			
			///	@method
			///	@description									Изменение спрайта конкретного канала последовательности
			///	@parameter {String} _track_name					Имя канала, указанное в редакторе последовательности
			///	@parameter {Asset.GMSprite} _sprite_index		Индекс нового спрайта
			///	@ignore
			static __SetTrackSprite = function( _track_name, _sprite_index )
			{
				struct_set( __sprites, _track_name, _sprite_index );
			};
		
		#endregion
		
		///	@method
		///	@description	Обработка события создания нового экземпляра последовательности
		///	@ignore
		static __OnCreate = function( )
		{
			//	Создание слоя последовательности
			__CreateLayer( );
	
			//	В качестве параметра указан валидный индекс последовательности
			//	Установка последовательности
			if ( sequence_exists( __on_create_sequence ) ) __SetSequence( __on_create_sequence );
		};
		
		/*
			Методы ниже не описаны по умолчанию
			Они переопределяются дочерними классами, что наследуют логику текущего
		*/
		
		///	@method
		///	@description					Отрисовка экземпляра последовательности
		///	@parameter {Real} _frame		Индекс кадра
		///	@parameter {Real} _x			Позиция отрисовки по x
		///	@parameter {Real} _y			Позиция отрисовки по y
		///	@parameter {Real} _xscale		Фактор растяжения последовательности по x
		///	@parameter {Real} _yscale		Фактор растяжения последовательности по y
		///	@parameter {Real} _rotation		Угол поворота
		///	@ignore
		static __DrawSequence = function( _frame, _x, _y, _xscale, _yscale, _rotation )
		{
			//	Изначально пустой
			//	Переопределяется дочерними экземплярами
		};
		
		///	@method
		///	@description	Очистка экземпляра управляемой последовательности
		///	@ignore
		static __CleanUp = function( )
		{
			//	Изначально пустой
			//	Переопределяется дочерними экземплярами
		};

		///	@method
		///	@description	Создание слоя для последовательности
		///					Помимо прямого содержания экземпляров последовательностей, слой будет передвигаться вместе с последовательностью
		///					Это нужно, чтобы различные звуковые и не только эффекты работали с корректной позицией
		///	@ignore
		static __CreateLayer = function( )
		{
			//	Изначально пустой
			//	Переопределяется дочерними экземплярами
		};
		
	#endregion
};