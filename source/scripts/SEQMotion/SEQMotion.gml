//	Made by Veewee cat
//	@veewee_cat

///	@class			
///	@description Основной класс расширения - единая точка входа
function SEQMotion( ) constructor
{
	#region Публичные методы - API
	
		#region Get-методы
		
			///	@method
			///	@description Получение фактора растяжения по x управляемой последовательности
			///	@parameter {Struct.SEQMotionSequence} _seqmotion_sequence Экземпляр управляемой последовательности 
			///	@return {Real}
			static GetXscale = function( _seqmotion_sequence )
			{
				return _seqmotion_sequence.__GetXscale( );
			};
			
			///	@method
			///	@description Получение фактора растяжения по y управляемой последовательности
			///	@parameter {Struct.SEQMotionSequence} _seqmotion_sequence Экземпляр управляемой последовательности 
			///	@return {Real}
			static GetYscale = function( _seqmotion_sequence )
			{
				return _seqmotion_sequence.__GetYscale( );
			};
		
		#endregion
		#region Set-методы
		
			#region Данные каналов последовательностей
			
				///	@method
				///	@description Изменение спрайта указанного канала последовательности
				///	@parameter {Struct.SEQMotionSequence} _seqmotion_sequence Экземпляр управляемой последовательности 
				///	@parameter {String} _track_name Имя канала
				///	@parameter {Asset.GMSprite} _sprite_index Индекс спрайта для изменения
				static SetTrackSprite = function( _seqmotion_sequence, _track_name, _sprite_index )
				{
						_seqmotion_sequence.__SetTrackSprite( _track_name, _sprite_index );
				};
			
			#endregion
		
			///	@method
			///	@description Изменение фактора растяжения по x
			///	@parameter {Struct.SEQMotionSequence} _seqmotion_sequence Экземпляр управляемой последовательности 
			///	@parameter {Real} _xscale Фактор растяжения по x
			///	@ignore
			static SetXscale = function( _seqmotion_sequence, _xscale )
			{
					_seqmotion_sequence.__SetXscale( _xscale );
			};
			
			///	@method
			///	@description Изменение фактора растяжения по y
			///	@parameter {Struct.SEQMotionSequence} _seqmotion_sequence Экземпляр управляемой последовательности 
			///	@parameter {Real} _xscale Фактор растяжения по y
			///	@ignore
			static SetYscale = function( _seqmotion_sequence, _yscale )
			{
					_seqmotion_sequence.__SetYscale( _yscale );
			};
		
		#endregion

		///	@method
		///	@description Создание экземпляра управляемой последовательности
		///	@parameter {Asset.GMSequence OR Undefined} _sequence_index Индекс последовательности
		///	@return {Struct.SEQMotionSequence}
		static CreateSEQMotionSequence = function( _sequence_index = -1 )
		{
			return new SEQMotionSequence( _sequence_index );
		};

		///	@method
		///	@description Отрисовка управляемой последовательности
		///	@parameter {Struct.SEQMotionSequence} _seqmotion_sequence Экземпляр управляемой последовательности
		///	@parameter {Real} _x Позиция, где будет стоять экземпляр последовательности по x
		///	@parameter {Real} _y Позиция, где будет стоять экземпляр последовательности по y
		///	@parameter {Real} _depth Глубина сортировки экземпляра последовательности
		static UpdateSEQSequence = function( _seqmotion_sequence, _x = undefined, _y = undefined, _depth = undefined )
		{
				_seqmotion_sequence.__UpdateSequence( _x, _y, _depth );
		};

	#endregion
};