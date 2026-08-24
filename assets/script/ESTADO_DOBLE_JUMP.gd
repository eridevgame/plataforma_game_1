extends ESTADOS
class_name ESTADO_DOBLE_JUMP

@export var estado_fall: ESTADOS
@export var estado_dash: ESTADOS 
@export var estado_escalando: ESTADOS

var jump_velocity = -200


func on_enter():
	player.play_anim("doble_jump",1.0)
	player.config_colicion({
		"parado": true,
		"agachado":true,
		"doble_jump":false
	})
	player.velocity.y = get_JUMP_VELOCITY()
	
	print("entra: ",self.name)
	
	
func estado_process(delta):
	# CONDIONES
	var dir = Input.get_axis("izquierda","derecha")
	
	if player.is_running_jump:
		player.velocity.x = dir * player.speed_jump_run
	else:
		player.velocity.x = dir * player.speed_jump_walk
	
	if dir != 0:
		player.facing_direccion = dir
		
	if dir < 0:
		animacion.flip_h = true
	elif dir > 0:
		animacion.flip_h = false
	
	# CAMBIOS DE ESTADOS
	if player.is_on_floor():
		player.count_jump = 0
		next_estado = estado_fall
		
	if Input.is_action_just_pressed("dash") and player.can_dash:
		next_estado = estado_dash
		
	if player.raycast.is_colliding() and Input.is_action_just_pressed("arriba"):
		var tile = player.raycast.get_collider()
		if tile.is_in_group("wall_escalar"):
			player.can_escalar = true
			next_estado = estado_escalando
			print(player.raycast.get_collider())
			return
	
func get_JUMP_VELOCITY():
	return jump_velocity
