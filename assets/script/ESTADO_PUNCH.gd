extends ESTADOS
class_name ESTADO_PUNCH

@export var estado_idle: ESTADOS

func on_enter():
	
	player.play_anim("punch", 2.0)

	
func estado_process(delta):
	
	
	if !player.ANIMACION.is_playing():
		next_estado = estado_idle

	
	
