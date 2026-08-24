extends ESTADOS
class_name ESTADO_CROUCH_WALK

@export var estado_crouch_idle: ESTADOS
@export var estado_walk: ESTADOS

var speed_crouch = 30

func on_enter():
	player.play_anim("crouch_walk",1.0)
	player.config_colicion({
		"parado": true,
		"agachado":false,
		"doble_jump":true
	})
	print("entra: ",self.name)

func estado_process(delta):
	# CONDICIONES
	var dir = Input.get_axis("izquierda","derecha")
	player.velocity.x = dir * speed_crouch
	
	if dir < 0:
		animacion.flip_h = true
	elif dir > 0:
		animacion.flip_h = false
	
	# CAMBIOS DE ESTADOS
	if dir == 0:
		next_estado = estado_crouch_idle
		
	if dir != 0 and Input.is_action_just_released("abajo"):
		next_estado = estado_walk

func get_SPEED():
	return speed_crouch
