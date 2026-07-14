//	Made by Veewee cat: https://t.me/veewee_cat

///	@class
///	@description													Динамическа управляемая последовательность
///																	Позволяет использовать ВЕСЬ доступный функционал нативных последовательностей,
///																	но является более требовательной к ресурсам устройства
///	@parameter {Asset.GMSequence OR Undefined} _sequence_index		Индекс последовательности
///	@ignore
function SEQMotionSequence_Dynamic( _sequence_index ): SEQMotionSequence( _sequence_index ) constructor
{
	#region Макросы и enumы
	
		#macro RENDER_LAYER_DEPTH 2_147_483_647		//	Глубина слоя рендера
													//	Специально выбрано самое минимальное значение ( относительно порядка отрисовки GameMaker )
	
	#endregion
	#region Переменные
	
		__render_surface = -1;		//	Поверхность для рендера последовательности
		
		__current_world_matrix = [ ];	//	Таблица значений матрицы, что была до отрисовки последовательности	
		__render_matrix = [ ];			//	Текущая матрица для рендера
		
		__canvas_offset_x = -1;		//	Отступ для отрисовки холста рендера последовательности; По горизонтали
		__canvas_offset_y = -1;		//	По вертикали
		
		__previous_canvas_offset_x = -1;	//	Предыдущие значения отсутпа для отрисовки холста рендера последовательности; По горизонтали
		__previous_canvas_offset_y = -1;	//	По вертикали
	
	#endregion
	#region Приватные методы
	
		#region Рендер
		
			///	@method
			///	@description	Начало рендера слоя
			///	@ignore
			static __RenderBegin = function( )
			{
				//
				//	Описание временных переменных
				
					static width = -1;		//	Размер холста для рендера последовательности; Ширина
					static height = -1;		//	Высота
				
				//	Указатель на текущую последовательность невалидный
				//	Отмена рендера последовательности
				if ( is_undefined( __current_sequence ) ) 
				{
					//	Поверхность рендера существует
					//	Удаление поверхности для рендера из памяти
					if ( surface_exists( __render_surface ) ) surface_free( __render_surface );
					
					exit;
				};
				
				//	
				//	Рендер последовательности
				
				//	Поверхность для рендера не существует
				//	Пересоздание поверхности
				if ( not surface_exists( __render_surface ) ) 
				{
					width =		surface_get_width( application_surface );
					height =	surface_get_height( application_surface );
					
					__render_surface = surface_create( width, height );
					
					//
					//	Сохранение значения позиции центра, относительно поверхности
					
						__canvas_offset_x = width / 2;
						__canvas_offset_y = height / 2;
				};
				
				//
				//	Подготовка матрицы для рендера экземпляра текущей последовательности
				
					__current_world_matrix = matrix_get( matrix_world );
				
					//	Позиция отступа от угла была изменена
					//	Пересоздание матрицы
					if ( __previous_canvas_offset_x != __canvas_offset_x and __previous_canvas_offset_y != __canvas_offset_y )
					{
						__render_matrix = matrix_build( __canvas_offset_x, __canvas_offset_y, 0, 0, 0, 0, 1, 1, 1 );
						
						__previous_canvas_offset_x = __canvas_offset_x;
						__previous_canvas_offset_y = __canvas_offset_y;
					};
				
					//	Применение матрицы
					matrix_set( matrix_world, __render_matrix );
					
				//
				//	Подготовка поверхности перед рендером
				
					//	Установка указателя на поверхность
					//	Очистка предыдущих данных поверхности
					surface_set_target( __render_surface );
					draw_clear_alpha( c_white, 0 );
			};
			
			///	@method
			///	@description	Конец рендера слоя
			///	@ignore
			static __RenderEnd = function( )
			{
				matrix_set( matrix_world, __current_world_matrix );
				surface_reset_target( );
			};
		
		#endregion
		
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
			//	Указатель на текущую последовательность невалидный
			//	Отмена отрисовки
			if ( is_undefined( __current_sequence ) ) exit;
				
			//
			//	Отрисовка экземпляра последовательности
			
				//
				//	Определение конкретного кадра последовательности для отрисовки

					//	Указан конкретный кадр последовательности
					//	Изменение позиции обработчика экземпляра последовательности
					if ( _frame != -1 ) layer_sequence_headpos( __current_sequence, _frame mod __frame_length );
				
				//	Поверхность рендера существует
				//	Отрисовка поверхности
				if ( surface_exists( __render_surface ) ) draw_surface( __render_surface, _x - __canvas_offset_x, _y - __canvas_offset_y );
		};
	
		///	@method
		///	@description	Очистка экземпляра динамичной управляемой последовательности
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
							   
				//	Поверхность для рендера существует
				//	Удаление поверхности рендера из памяти
				if ( surface_exists( __render_surface ) ) surface_free( __render_surface );
			};
		};
	
		///	@method
		///	@description	Создание слоя для последовательности
		///					Помимо прямого содержания экземпляров последовательностей, слой будет передвигаться вместе с последовательностью
		///					Это нужно, чтобы различные звуковые и не только эффекты работали с корректной позицией
		///	@ignore
		static __CreateLayer = function( )
		{
			__layer = layer_create( RENDER_LAYER_DEPTH );
			
			//
			//	Изменение работы слоя
			
				layer_script_begin( __layer, method( self, __RenderBegin ) );
				layer_script_end( __layer, method( self, __RenderEnd ) );
		};
	
	#endregion
	#region При создании
	
		//	Обработка события создания нового экземпляра последовательности
		__OnCreate( );
	
	#endregion
};