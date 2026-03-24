extends ESTADOS
class_name  ESTADO_IDLE

@export var estado_walk: ESTADOS
@export var estado_jump: ESTADOS

func on_enter():
	animacion.play("idle")
	print("entra ", self.name)

func estado_process(delta):
	player.velocity.x = move_toward(player.velocity.x,0,300)
	
	if not player.is_on_floor():
		return
	
	if Input.is_action_just_pressed("arriba") and player.is_on_floor():
		next_estado = estado_jump
		return
		
	if Input.get_axis("izquierda","derecha") != 0:
		next_estado = estado_walk
		
