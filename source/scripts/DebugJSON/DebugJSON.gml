///	@function
///	@description				Создает .json файл с отладочной информацией в нем
///	@parameter {Any} _value		Данные для сохранения
function DebugJSON( _value )
{
	var _file = file_text_open_write( ".debug.json" );
	
	file_text_write_string( _file, json_stringify( _value, true ) );
	file_text_close( _file );
	
	game_end( );
};