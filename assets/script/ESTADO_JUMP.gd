extends ESTADOS
class_name ESTADO_JUMP

@export var estado_walk: ESTADOS
@export var idle_estado: ESTADOS
@export var estado_fall: ESTADOS
var jump_velocity = -200
var speed_in_jump = 50

func on_enter():
	animacion.play("jump")
	player.velocity.y = jump_velocity
	print("entra ", self.name)
	
func estado_process(delta):
	var dir = Input.get_axis("izquierda", "derecha")
	player.velocity.x = dir * get_SPEED()
	
	if player.velocity.y == jump_velocity:
		next_estado = estado_fall
		
	if dir < 0:
		animacion.flip_h = true
	elif dir > 0:
		animacion.flip_h = false
	
	if Input.is_action_pressed("correr") and not player.is_on_floor():
		jump_velocity = 100
		
func get_SPEED():
	return speed_in_jump
