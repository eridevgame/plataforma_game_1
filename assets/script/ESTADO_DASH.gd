extends ESTADOS
class_name ESTADO_DASH

@export var estado_idle: ESTADOS
@export var estado_fall: ESTADOS

func on_enter():
	player.play_anim("dash",1.0)
	player.can_dash = false
	
	var dir = Input.get_axis("izquierda","derecha")
	
	if dir == 0:
		dir = player.facing_direccion
	player.dash_direccion = dir 
	
	player.dash_timer.start(player.dash_time)
	
func estado_process(delta):
	# CONDICIONES
	
	player.velocity.x = player.dash_direccion * player.dash_speed
	player.velocity.y = 0
	
	# CAMBIOS DE ESTADOS
		
		 
			
	
