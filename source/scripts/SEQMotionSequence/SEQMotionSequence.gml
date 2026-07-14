//	Made by Veewee cat: https://t.me/veewee_cat

///	@class												
///	@description													Управляемая последовательность
///	@parameter {Asset.GMSequence OR Undefined} _sequence_index		Индекс последовательности
///	@ignore
function SEQMotionSequence( _sequence_index ) constructor
{
	#region Макросы и enumы
	
		enum ARGB	//	Индексы матрицы ARGB цвета
		{
			ALPHA,		//	Значение альфа-канала
			RED,		//	Красный канал
			GREEN,		//	Зеленый
			BLUE		//	Синий
		};
	
	#endregion
	#region Переменные
	
		__layer = undefined;	//	Слой для хранения и обработки экземпляров последовательностей		
		
		__current_sequence = undefined;		//	Указатель на текущую последовательность, которая должна отрисовываться
		
		__playback_speed = 1;	//	Скорость проигрывания анимации текущего и последующих экземпляров последовательностей
		__frame_length = 0;		//	Индекс последнего кадра текущей последовательности
		
		__sprites = { };	//	Структура спрайтов текущей последовательности
							//	Хранит указатели на спрайты по ключу
	
		__active_tracks = [ ];		//	Список каналов экземпляра последовательности
									//	Используется как заглушка в случаях, когда индекс последовательности был изменен, но обработка
									//	самого экземпляра не успела вызваться
	
	#endregion
	#region Приватные методы
	
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
			///	@description		Получение скорости проигрывания анимации
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
		#region Отрисовка
		
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
				//
				//	Описание временных переменных
				
					static current_headpos = 0;		//	Текущая позиция проигрывателя последовательности
					static world_matrix = [ ];		//	Данные текущей мировой матрицы
													//	При отрисовки последовательности матрица изменяется, поэтому необходимо где-то хранить
													//	временный массив-значений матричной таблицы

				//	Указатель на текущую последовательность невалидный
				//	Отмена отрисовки
				if ( is_undefined( __current_sequence ) ) exit;
			
				//
				//	Отрисовка
			
					//
					//	Определение конкретного кадра последовательности для отрисовки

						//	Указан конкретный кадр последовательности
						//	Изменение позиции обработчика экземпляра последовательности
						if ( _frame != -1 ) layer_sequence_headpos( __current_sequence, _frame mod __frame_length );
				
					//
					//	Отрисовка последовательности
				
						//
						//	Изменение текущей мировой матрицы
						//	Самый быстрый из всех варинтов для изменения параметров отрисовки: позиции, растяжения, поворота
					
							world_matrix = matrix_get( matrix_world );
										   matrix_set( matrix_world, matrix_build( _x, _y, 0, 0, 0, _rotation * sign( _xscale ) * sign( _yscale ), _xscale, _yscale, 1 ) );
									   
						//
						//	Обход всех активных каналов последовательности
						
							var _active_tracks = layer_sequence_get_instance( __current_sequence ).activeTracks;
							
							//	Список валиден ( экземпляр последовательности успел обработаться )
							//	Обновление актуального списка активных каналов
							if ( array_length( _active_tracks ) != 0 ) __active_tracks = _active_tracks;

							array_foreach( __active_tracks, __DrawBasedActiveTrack );
									   
						//	Сброс мировой матрицы 
						matrix_set( matrix_world, world_matrix );
			};
			
			///	@method
			///	@description							Отрисовка основного канала экземпляра последовательности
			///											Является методом переадресации - его использование в паре с array_foreach быстрее рукописных циклов 
			///	@parameter {Struct} _active_track		Структура данных активного канала
			///	@ignore
			static __DrawBasedActiveTrack = function( _active_track )
			{
				__DrawActiveTrack( _active_track );
			};
		
			///	@method
			///	@description							Отрисовка активного канала с применением смещения и поворота
			///	@parameter {Struct} _active_track		Структура данных активного канала
			///	@parameter {Real} _x					Значение смещения отрисовки по x
			///	@parameter {Real} _y					Значение смещения отрисовки по y
			///	@parameter {Real} _rotation				Смещение наклона в градусах
			///	@ignore
			static __DrawActiveTrack = function( _active_track, _x = 0, _y = 0, _rotation = 0 )
			{
				//
				//	Описание временных переменных
				
					static active_track_index = 0;		//	Индекс активного канала в списке
														//	Используется при рекурсивном обходе списка активных каналов
				
					static color = c_white;								//	Цвет спрайта
					static singular_color_matrix = [ 1, 1, 1, 1 ];		//	Единичная матрица цвета спрайта
					
					static alpha = 1;	//	Значение альфа-канала
					
					static sprite_position = [ ];	//	Позиция спрайта для отрисовки

				//	
				//	Канал-группа
				
					//	Канал является группой элементов
					//	Рекурсивный обход его дочерних элементов
					if ( _active_track.track.type == seqtracktype_group )
					{
						//	Группу элементов можно передвигать
						//	Это значит, что нужно дополнительно расчитывать значение смещения позиции отрисовки
						var _position = matrix_transform_vertex( matrix_build( _x, _y, 0, 0, 0, _rotation, 1, 1, 1 ), _active_track.posx, _active_track.posy, 0 );
						
						active_track_index = 0;
						
						//	Рекурсивный обход дочерних элементов группы
						//	с передачей позиции смещения и значения поворота
						repeat ( array_length( _active_track.activeTracks ) ) __DrawActiveTrack
						(
								_active_track.activeTracks[ active_track_index ++ ],	//	Структура канала
							
								_position[ 0 ],											//	Позиция смещения; По x
								_position[ 1 ],											//	По y
							
								_rotation + _active_track.rotation						//	Значение смещения поворота
						);
						
						exit;
					};
					
				//
				//	Канал с графическими данными спрайта
				
					//	Канал содержит спрайт для отрисовки
					//	Отрисовка спрайта
					if ( _active_track.track.type == seqtracktype_graphic )
					{
						//	У канала не указан валидный спрайт
						//	Отмена отрисовки спрайта
						if ( _active_track.spriteIndex == -1 ) exit;
						
						//
						//	Отрисовка
						
							//
							//	Определение цвета и значения альфа-канала
							
								color = c_white;
								alpha = 1;
								
								//	Значение цвета не является единичным массивом
								//	Это значит, что спрайт должен менять свой цвет
								if ( not array_equals( _active_track.colourmultiply, singular_color_matrix ) )
								{
									color = ( _active_track.colourmultiply[ ARGB.BLUE ]		* 255 ) * 65_536 
										  + ( _active_track.colourmultiply[ ARGB.GREEN ]	* 255 ) * 255 
										  + ( _active_track.colourmultiply[ ARGB.RED ]		* 255 );
										  
									alpha = _active_track.colourmultiply[ ARGB.ALPHA ];
								};

							//	Расчет конечной позиции спрайта в мировых координата
							//	Отрисовка спрайта
							sprite_position = matrix_transform_vertex( matrix_build( _x, _y, 0, 0, 0, _rotation, 1, 1, 1 ), _active_track.posx, _active_track.posy, 0 );
							draw_sprite_ext
							(
								struct_get( __sprites, _active_track.track.name ),		//	Индекс спрайта
													   _active_track.imageindex,		//	Номер кадра спрайта
								
								sprite_position[ 0 ],									//	Позиция отрисовки, относительно мира игры; По x
								sprite_position[ 1 ],									//	По y
								
									_active_track.scalex,								//	Растяжение спрайта; По горизонтали
									_active_track.scaley,								//	По вертикали
									
									_active_track.rotation + _rotation,					//	Поворот спрайта
									
								color,													//	Конечный цвет
								alpha													//	Значение альфа-канала
							);
					};
			};
		
		#endregion
		
		///	@method
		///	@description	Очистка экземпляра управляемой последовательности
		///	@ignore
		static __CleanUp = function( )
		{
			//	Слой существует ( управляемая последовательность еще жива )
			//	Очистка памяти
			if ( layer_exists( __layer ) )
			{
				//	Удаление слоя, на котором должны лежать экземпляры последовательностей
				//	Сброс указателя на текущий экземпляр последовательности
				layer_destroy( __layer );
							   __current_sequence = undefined;
			};
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
			
			__layer = layer_create( 0 );
					  layer_set_visible( __layer, false );
		};
	
	#endregion
	#region При создании
	
		//	Создание слоя последовательности
		__CreateLayer( );
	
		//	В качестве параметра указан валидный индекс последовательности
		//	Установка последовательности
		if ( sequence_exists( _sequence_index ) ) __SetSequence( _sequence_index );
	
	#endregion
};