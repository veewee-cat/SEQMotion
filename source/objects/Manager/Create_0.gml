#region При создании

	//	Синхронизация частоты обновления игры с частотой обновления монитора
	game_set_speed( display_get_frequency( ), gamespeed_fps );
	
	//	Включение режима отладки
	show_debug_overlay( true );

#endregion