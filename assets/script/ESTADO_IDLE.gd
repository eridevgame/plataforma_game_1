extends ESTADOS
class_name  ESTADO_IDLE

@export var estado_walk: ESTADOS
@export var estado_jump: ESTADOS
@export var estado_crouch_idle: ESTADOS
@export var estado_dash: ESTADOS 
@export var estado_escalando: ESTADOS
@export var estado_mover_obj: ESTADOS
@export var estado_hurt: ESTADOS

var salto = 1

func on_enter():
	player.play_anim("idle",1.0)
	player.config_colicion({
		"parado": false,
		"agachado":true,
		"doble_jump":true
	})
	print("entra ", self.name)

func estado_process(delta):
	# CONDICIONES
	player.velocity.x = move_toward(player.velocity.x,0,300)
	var dir = Input.get_axis("izquierda","derecha")
	if dir != 0:
		player.facing_direccion = dir
	
	if not player.is_on_floor():
		return
		
	# CAMBIOS DE ESTADOS
	
	if player.is_hurt:
		print("quiero entrar a hurt")
		next_estado = estado_hurt
		return
		
	if player.raycast.is_colliding() and Input.is_action_just_pressed("arriba"):
		var tile = player.raycast.get_collider()
		if tile.is_in_group("wall_escalar"):
			player.can_escalar = true
			next_estado = estado_escalando
			print(player.raycast.get_collider())
			return
		
	if Input.is_action_just_pressed("arriba") and player.is_on_floor():
		next_estado = estado_jump
		player.count_jump = 1
		return
		
	if Input.get_axis("izquierda","derecha") != 0:
		next_estado = estado_walk
	
	if Input.is_action_pressed("abajo"):
		next_estado = estado_crouch_idle
		
	if Input.is_action_just_pressed("dash") and player.can_dash:
		next_estado = estado_dash
		
	if player.raycast.is_colliding() and Input.is_action_pressed("accion"):
		next_estado = estado_mover_obj
		
	
