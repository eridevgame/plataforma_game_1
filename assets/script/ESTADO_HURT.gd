extends ESTADOS

class_name ESTADO_HURT

@export var estado_idle: ESTADOS
@export var estado_walk: ESTADOS
@export var estado_run: ESTADOS

const fuerza_retroceso = 500.0
const desaceleracion = 1500.0

func on_enter():
	player.play_anim("hurt_damange",0.005)
	player.is_hurt = false
	
	 
	
func estado_process(delta):
	# CONDICIONES
	player.velocity = player.RETROCESO
	player.RETROCESO = player.RETROCESO.move_toward(Vector2.ZERO,desaceleracion * delta)
	# CAMBIOS DE ESTADO
	if player.RETROCESO.length() < 10 and !player.is_hurt:
		next_estado = estado_idle
		
	if player.RETROCESO.length() < 10 and !player.is_hurt and player.velocity.x > 0:
		next_estado = estado_walk
		
	
func on_exit():
	pass
