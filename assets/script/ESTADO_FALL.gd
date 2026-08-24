extends ESTADOS
class_name ESTADO_FALL

@export var estado_idle: ESTADOS
@export var estado_walk: ESTADOS
@export var estado_run: ESTADOS
@export var estado_doble_jump: ESTADOS
@export var estado_dash: ESTADOS 

var speed_in_fall = 50
var is_run = false

func on_enter():
	player.play_anim("fall",1.0)
	print("entra: ",self.name)
	
func estado_process(delta):
	# CONDICIONES
	var dir = Input.get_axis("izquierda","derecha")
	player.velocity.x = dir * speed_in_fall
	
	if dir != 0:
		player.facing_direccion = dir
	
	if dir < 0:
		animacion.flip_h = true
	elif dir > 0:
		animacion.flip_h = false
	
	if Input.is_action_pressed("correr") and not player.is_on_floor():
		speed_in_fall = 100
		is_run = true
	else:
		speed_in_fall = 50
		is_run = false
	
	# CAMBIO DE ESTADOS
	if player.velocity.y > 0 and Input.is_action_just_pressed("arriba"):
		player.count_jump += 1
		next_estado = estado_doble_jump
	
	if player.is_on_floor():
		next_estado = estado_idle
		
	if dir != 0 and player.is_on_floor():
		next_estado = estado_walk
		
	if dir != 0 and player.is_on_floor() and Input.is_action_pressed("correr"):
		next_estado = estado_run
		
	if player.is_on_floor() and dir == 0:
		next_estado = estado_idle
		
	if Input.is_action_just_pressed("dash") and player.can_dash:
		next_estado = estado_dash
		
func get_SPEED():
	return speed_in_fall
