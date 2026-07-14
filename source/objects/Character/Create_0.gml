#region Переменные

	character = SEQMotion.CreateSEQMotionSequence( Sequence_Character );	//	Персонаж
	hands = SEQMotion.CreateSEQMotionSequence( Sequence_CharacterHands );	//	Руки персонажа

#endregion

sequence_layer = layer_create( 0 );
				 layer_sequence_create( sequence_layer, 512, 512, Sequence_Character );
				 
layer_script_begin( sequence_layer,
	function( )
	{
		surface_set_target( global.surface );
	} );
	
layer_script_end( sequence_layer,
	function( )
	{
		surface_reset_target( );
	} );