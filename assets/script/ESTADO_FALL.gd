extends ESTADOS
class_name ESTADO_FALL

@export var estado_idle: ESTADOS
@export var estado_walk: ESTADOS
@export var estado_run: ESTADOS
var speed_in_fall = 50
var is_run = false

func on_enter():
	animacion.play("fall")
	
	
func estado_process(delta):
	var dir = Input.get_axis("izquierda","derecha")
	
	player.velocity.x = dir * get_SPEED()
	
	if Input.is_action_pressed("correr") and not player.is_on_floor():
		speed_in_fall = 100
		is_run = true
	
	if dir < 0:
		animacion.flip_h = true
	elif dir > 0:
		animacion.flip_h = false
		
	if player.is_on_floor():
		next_estado = estado_idle
		
	if dir != 0 and player.is_on_floor():
		next_estado = estado_walk
		
	if dir != 0 and player.is_on_floor() and is_run:
		next_estado = estado_run
		
	if player.is_on_floor():
		next_estado = estado_idle
		
func get_SPEED():
	return speed_in_fall
