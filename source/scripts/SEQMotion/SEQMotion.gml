//	Made by Veewee cat: https://t.me/veewee_cat

///	@class			
///	@description	Основной класс расширения - единая точка входа
function SEQMotion( ) constructor
{
	#region Публичные методы - API
	
		#region Get-методы
		
			///	@method
			///	@description													Получение индекса текущей последовательности управляемой последовательности
			///	@parameter {Struct.SEQMotionSequence} _seqmotion_sequence		Экземпляр управляемой последовательности
			///	@return {Id.SequenceElement OR Undefined}
			static GetSequence = function( _seqmotion_sequence )
			{
				return _seqmotion_sequence.__GetSequence( );
			};
		
		#endregion
		#region Set-методы
		
			///	@method
			///	@description													Изменение индекса текущей последовательности
			///	@parameter {Struct.SEQMotionSequence} _seqmotion_sequence		Экземпляр управляемой последовательности
			///	@parameter {Asset.GMSequence OR Real} _seqmotion_sequence		Индекс последовательности
			static SetSequence = function( _seqmotion_sequence, _sequence_index = -1 )
			{
					_seqmotion_sequence.__SetSequence( _sequence_index );
			};
		
		#endregion
		#region Создание / удаление управляемых последовательностей
		
			///	@method
			///	@description													Создание экземпляра управляемой последовательности
			///	@parameter {Asset.GMSequence OR Undefined} _sequence_index		Индекс последовательности
			///	@return {Struct.SEQMotionSequence}
			static CreateSEQMotionSequence = function( _sequence_index = -1 )
			{
				return new SEQMotionSequence( _sequence_index );
			};
		
			///	@method
			///	@description													Удаление экземпляра управляемой последовательности из памяти
			///	@parameter {Struct.SEQMotionSequence} _seqmotion_sequence		Экземпляр управляемой последовательности
			static DeleteSEQMotionSequence = function ( _seqmotion_sequence )
			{
					   _seqmotion_sequence.__CleanUp( );
				delete _seqmotion_sequence;
			};
		
		#endregion
	
		///	@method
		///	@description													Отрисовка управляемой последовательности
		///	@parameter {Struct.SEQMotionSequence} _seqmotion_sequence		Экземпляр управляемой последовательности
		///	@parameter {Real} _frame										Индекс конкретного кадра для отрисовки. Аналогично спрайтам, в качестве значения
		///																	этого параметра можно указать -1, чтобы отрисовка происходила на основе текущего кадра последовательности
		///	@parameter {Real} _x											Позиция для отрисовки последовательности по x
		///	@parameter {Real} _y											Позиция для отрисовки последовательности по y
		///	@parameter {Real} _xscale										Фактор растяжения последовательности по x
		///	@parameter {Real} _yscale										Фактор растяжения последовательности по y
		///	@parameter {Real} _rotation										Угол поворота
		static DrawSEQMotionSequence = function( _seqmotion_sequence, _frame, _x, _y, _xscale = 1, _yscale = 1, _rotation = 0 )
		{
				_seqmotion_sequence.__DrawSequence( _frame, _x, _y, _xscale, _yscale, _rotation );
		};

	#endregion
};