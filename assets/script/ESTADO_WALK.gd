extends ESTADOS
class_name ESTADO_WALK

var walk_speed = 50.0
@export var idle_estado: ESTADOS
@export var estado_jump: ESTADOS
@export var estado_run: ESTADOS
@export var estado_crouch_idle: ESTADOS
@export var estado_crouch_walk: ESTADOS
@export var estado_dash: ESTADOS 
@export var estado_escalando: ESTADOS
@export var estado_fall: ESTADOS
@export var estado_hurt: ESTADOS

func on_enter():
	player.play_anim("walk",1.0)
	player.get_node("colicion_normal").disabled = false
	player.get_node("colicion_crouch").disabled = true
	print("entra ", self.name)
	
func estado_process(delta):
	# CONDICIONES
	var dir = Input.get_axis("izquierda","derecha")
	player.velocity.x = dir * walk_speed
	if dir != 0:
		player.facing_direccion = dir
		
	if dir < 0:
		animacion.flip_h = true
	elif dir > 0:
		animacion.flip_h = false
	
	# CAMBIOS DE ESTADOS	
	if player.is_hurt:
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
		player.is_running_jump = false
		player.count_jump = 1
		next_estado = estado_jump
		return
	
	if dir == 0:
		next_estado = idle_estado
		
	if Input.is_action_just_pressed("correr") or Input.is_action_pressed("correr") and player.is_on_floor():
		next_estado = estado_run
	
	if Input.is_action_pressed("abajo"):
		next_estado = estado_crouch_idle
		
	if dir != 0 and Input.is_action_pressed("abajo"):
		next_estado = estado_crouch_walk
		
	if dir == 0 and Input.is_action_pressed("abajo"):
		next_estado = estado_crouch_idle
		
	if Input.is_action_just_pressed("dash") and player.can_dash:
		next_estado = estado_dash
	
	if !player.is_on_floor():
		next_estado = estado_fall
		
	if player.is_hurt:
		print("quiero entrar a hurt")
		next_estado = estado_hurt
		return
