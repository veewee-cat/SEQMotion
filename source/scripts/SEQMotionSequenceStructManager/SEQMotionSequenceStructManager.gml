//	Made by Veewee cat
//	@veewee_cat

///	@class
///	@ignore
function SEQMotionSequenceStructManager( ) constructor
{
	#region Переменные
	
		__sprites_in_sequences = ds_map_create( );		//	Карта, что содержит структуры спрайтов последовательности
														//	Является внутренним кэшем для "сброса" спрайтов новой последовательности
														
		__on_cache = { };		//	Структура кэшированных начальных спрайтов последовательности
		__has_cached = false;	//	Текущая загружаемая последовательность уже есть в кэше
	
	#endregion
	#region Приватные методы

		///	@method
		///	@parameter {Asset.GMSequence} _sequence_index
		///	@return {Struct.Sequence}
		///	@ignore
		static __GetStructByAsset = function( _sequence_index )
		{
			var _sequence = sequence_get( _sequence_index );
			
			//
			//	Подготовка данных для парсера
			
				__on_cache = ds_map_find_value( __sprites_in_sequences, _sequence_index ) ?? { };
				__has_cached = ds_map_exists( __sprites_in_sequences, _sequence_index );
			
			//	Цикличный обход основных каналов
			array_foreach( _sequence.tracks, __ParseTrack )
			
			//	Проверка того, что структура проходит этап парсинга впервые
			//	Сохранение ее кэша в памяти
			if ( not __has_cached ) ds_map_set( __sprites_in_sequences, _sequence_index, __on_cache );
			
			return _sequence;
		};
		
		///	@method
		///	@parameter {Struct.Track} _track
		///	@ignore
		static __ParseTrack = function( _track )
		{
			//	Канал последовательности является графическим ( содержит спрайт )
			//	Обработка канала
			if ( _track.type == seqtracktype_graphic )
			{
				//	Проверка того, что последовательность уже есть в кэше
				//	Изменение спрайта канала
				if ( __has_cached )
				{
					_track.keyframes[ 0 ].channels[ 0 ].spriteIndex = struct_get( __on_cache, _track.name );
				}
				//	Сохранение указателя на спрайт ( подготовка кэша )
				else
				{
					struct_set( __on_cache, _track.name, _track.keyframes[ 0 ].channels[ 0 ].spriteIndex );
				};
			};
			
			//	Рекурсивный обход дочерних каналов последовательности
			array_foreach( _track.tracks, __ParseTrack );
		};
	
	#endregion
};