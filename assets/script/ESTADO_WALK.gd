extends ESTADOS
class_name ESTADO_WALK

var walk_speed = 50.0
@export var idle_estado: ESTADOS
@export var estado_jump: ESTADOS
@export var estado_run: ESTADOS

func on_enter():
	animacion.play("walk")
	print("entra ", self.name)
	
func estado_process(delta):
	var dir = Input.get_axis("izquierda","derecha")
	player.velocity.x = dir * walk_speed
	
	if Input.is_action_just_pressed("arriba") and player.is_on_floor():
		next_estado = estado_jump
		return
	
	if dir < 0:
		animacion.flip_h = true
	elif dir > 0:
		animacion.flip_h = false
	
	if dir == 0:
		next_estado = idle_estado
		
	if Input.is_action_just_pressed("correr") or Input.is_action_pressed("correr") and player.is_on_floor():
		next_estado = estado_run
	
	
	
