//
//	Переключение скорости анимации

	animation_speed = not animation_speed;

	SEQMotion.SetAnimationSpeed( character, animation_speed );
	SEQMotion.SetAnimationSpeed( hands, animation_speed );