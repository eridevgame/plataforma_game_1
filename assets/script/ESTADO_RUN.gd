extends ESTADOS
class_name ESTADO_RUN

@export var estado_idle: ESTADOS
@export var estado_walk: ESTADOS
@export var estado_jump: ESTADOS
@export var estado_fall: ESTADOS

var speed_run = 100

func on_enter():
	animacion.play("run")
	
func estado_process(delta):
	var dir = Input.get_axis("izquierda","derecha")
	player.velocity.x = dir * get_SPEED()
	
	if Input.is_action_just_pressed("arriba") and player.is_on_floor():
		next_estado = estado_jump
		return
		
	if dir == 0:
		next_estado = estado_idle
		
	if Input.is_action_just_released("correr"):
		next_estado = estado_walk

func get_SPEED(): 
	return speed_run
