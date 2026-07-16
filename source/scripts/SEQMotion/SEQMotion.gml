//	Made by Veewee cat
//	@veewee_cat

///	@class			
///	@description Основной класс расширения - единая точка входа
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
			///	@description Получение данных локатора по его имени
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {String} _locator_name Имя локатора
			///	@return {Struct OR Undefined}
			static GetTrackLocatorData = function( _seqmotion_sequence_id, _locator_name )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetTrackLocatorData( _locator_name );
			};
		
			///	@method
			///	@description Получение индекса спрайта указанного канала последовательности
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {String} _track_name Имя канала
			///	@return {Asset.GMSprite OR Undefined}
			static GetTrackSprite = function( _seqmotion_sequence_id, _track_name )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetTrackSprite( _track_name );
			};
		
			///	@method
			///	@description Получение фактора растяжения по x управляемой последовательности
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@return {Real}
			static GetXscale = function( _seqmotion_sequence_id )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetXscale( );
			};
			
			///	@method
			///	@description Получение фактора растяжения по y управляемой последовательности
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@return {Real}
			static GetYscale = function( _seqmotion_sequence_id )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetYscale( );
			};
			
			///	@method
			///	@description Получение скорости проигрывания анимации экземпляра управляемой последовательности
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@return {Real}
			static GetAnimationSpeed = function( _seqmotion_sequence_id )
			{
				return __GetSequence( _seqmotion_sequence_id ).__GetAnimationSpeed( );
			};

		#endregion
		#region Set-методы
		
			///	@method
			///	@description Изменение спрайта указанного канала последовательности
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {String} _track_name Имя канала
			///	@parameter {Asset.GMSprite} _sprite_index Индекс спрайта для изменения
			static SetTrackSprite = function( _seqmotion_sequence_id, _track_name, _sprite_index )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetTrackSprite( _track_name, _sprite_index );
			};
		
			///	@method
			///	@description Изменение угла наклона последовательности
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Real} _rotation Угол наклона в градусах
			static SetRotation = function( _seqmotion_sequence_id, _rotation )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetRotation( _rotation );
			};
			
			///	@method
			///	@description Изменение индекса последовательности
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Asset.GMSequence} _sequence_index Индекс последовательности
			static SetSequence = function( _seqmotion_sequence_id, _sequence_index )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetSequence( _sequence_index );
			};
			
			///	@method
			///	@description Изменение фактора растяжения по x
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Real} _xscale Фактор растяжения по x
			static SetXscale = function( _seqmotion_sequence_id, _xscale )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetXscale( _xscale );
			};
			
			///	@method
			///	@description Изменение фактора растяжения по y
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Real} _xscale Фактор растяжения по y
			static SetYscale = function( _seqmotion_sequence_id, _yscale )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetYscale( _yscale );
			};
			
			///	@method
			///	@description Изменение множителя скорости анимации
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Real} _rotation Скорость анимации
			static SetAnimationSpeed = function( _seqmotion_sequence_id, _animation_speed )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetAnimationSpeed( _animation_speed );
			};
			
			///	@method
			///	@description Изменение текущего кадра анимации
			///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
			///	@parameter {Real} _frame Индекс кадра анимации
			static SetFrame = function( _seqmotion_sequence_id, _frame )
			{
				__GetSequence( _seqmotion_sequence_id ).__SetFrame( _frame );
			};
		
		#endregion
	
		///	@method
		///	@description Создание экземпляра управляемой последовательности
		///	@parameter {Asset.GMSequence OR Undefined} _sequence_index Индекс последовательности. Можно оставить пустым и задать позже методом SetSequence
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
		///	@description Проверка существования экземпляра управляемой последовательности
		///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
		///	@return {Bool}
		static SequenceExists = function( _seqmotion_sequence_id )
		{
			return ds_map_exists( __sequences_map, _seqmotion_sequence_id );
		};
		
		///	@method
		///	@description Очистка памяти после использования экземпляра управляемой последовательности
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
		///	@description Отрисовка управляемой последовательности
		///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id Уникальный идентификатор управляемой последовательности
		///	@parameter {Real} _x Позиция по x
		///	@parameter {Real} _y Позиция по y
		///	@parameter {Real} _depth Глубина отрисовки последовательности
		static UpdateSequence = function( _seqmotion_sequence_id, _x = undefined, _y = undefined, _depth = undefined )
		{
			__GetSequence( _seqmotion_sequence_id ).__UpdateSequence( _x, _y, _depth );
		};
	
	#endregion
	#region Приватные методы
	
		///	@method
		///	@description Получение указателя на структуру управляемой последовательности по ее уникальному числовому индексу
		///	@parameter {Id.SEQMotionSequence} _seqmotion_sequence_id
		///	@return {Struct.SEQMotionSequence}
		///	@ignore
		static __GetSequence = function( _seqmotion_sequence_id )
		{
			return ds_map_find_value( __sequences_map, _seqmotion_sequence_id ) ?? __Error( $"Недействительный указатель на экземпляр управляемой последовательности: { _seqmotion_sequence_id }" );
		};
		
		///	@method
		///	@description Вывод сообщения об ошибке с последующим закрытием игры
		///	@parameter {String} _message Сообщение ошибки
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