extends ESTADOS
class_name ESTADO_JUMP

@export var estado_walk: ESTADOS
@export var idle_estado: ESTADOS
@export var estado_fall: ESTADOS
@export var estado_doble_jump: ESTADOS
@export var estado_dash: ESTADOS 
@export var estado_escalando: ESTADOS


var jump_velocity = -200
var speed_in_jump = 50

func on_enter():
	player.play_anim("jump",1.0)
	if player.is_running_jump:
		player.velocity.y = player.jump_velocity_run
	else:
		player.velocity.y = player.jump_velocity_walk
	print("entra ", self.name)
	
	
@warning_ignore("unused_parameter")
func estado_process(delta):
	# CONDICIONES
	var dir = Input.get_axis("izquierda", "derecha")
	
	if dir != 0:
		player.facing_direccion = dir
		
	if player.is_running_jump:
		player.velocity.x = dir * player.speed_jump_run
	else:
		player.velocity.x = dir * player.speed_jump_walk
	
	if dir < 0:
		animacion.flip_h = true
	elif dir > 0:
		animacion.flip_h = false
		
	# CAMBIOIS DE ESTADOS
	if Input.is_action_just_pressed("arriba") and player.count_jump == 1:
		player.count_jump += 1
		next_estado = estado_doble_jump
		print(player.count_jump)
		return
		
	if player.raycast.is_colliding() and Input.is_action_just_pressed("arriba"):
		var tile = player.raycast.get_collider()
		if tile.is_in_group("wall_escalar"):
			player.can_escalar = true
			next_estado = estado_escalando
			print(player.raycast.get_collider())
			return
		
	if player.velocity.y > 0:
		next_estado = estado_fall
		
	if Input.is_action_just_pressed("dash") and player.can_dash:
		next_estado = estado_dash
		
func get_SPEED():
	return speed_in_jump
