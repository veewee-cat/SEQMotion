//
//	Изменение анимации рук

	var _sprite = SEQMotion.GetTrackSprite( hands, "Gun" );

	SEQMotion.SetSequence( hands, Sequence_Character_Hands_PlayWith );
	SEQMotion.SetTrackSprite( hands, "Gun", _sprite );