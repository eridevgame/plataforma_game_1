extends ESTADOS

class_name ESTADO_CROUCH_IDLE

@export var estado_idle: ESTADOS
@export var estado_walk: ESTADOS
@export var estado_crouch_walk: ESTADOS

func on_enter():
	player.play_anim("crouch_idle",1.0)
	player.config_colicion({
		"parado": true,
		"agachado":false,
		"doble_jump":true
	})
	print("entra: ",self.name)
	
func estado_process(delta):
	# CONDICIONES
	var dir = Input.get_axis("izquierda","derecha")
	
	# CAMBIOS DE ESTADOS
	if Input.is_action_pressed("abajo") and dir != 0:
		next_estado = estado_crouch_walk
	
	if not Input.is_action_pressed("abajo"):
		if dir != 0:
			next_estado = estado_walk 
		else:
			next_estado = estado_idle

	
