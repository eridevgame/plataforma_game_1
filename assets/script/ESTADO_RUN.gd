extends ESTADOS
class_name ESTADO_RUN

@export var estado_idle: ESTADOS
@export var estado_walk: ESTADOS
@export var estado_jump: ESTADOS
@export var estado_fall: ESTADOS
@export var estado_crouch_idle: ESTADOS
@export var estado_dash: ESTADOS 
@export var estado_escalando: ESTADOS
@export var estado_roll: ESTADOS
@export var estado_hurt: ESTADOS
var speed: float:
	get:
		return GlobalStats.stats["velocidad_movimiento"]
var speed_run = speed * 1.5

func on_enter():
	player.play_anim("run",1.0)
	print("entra: ",self.name)
	

	
func estado_process(delta):
	# CONDICIONES
	var dir = Input.get_axis("izquierda","derecha")
	
	player.velocity.x = dir * get_SPEED()
	
	if dir != 0:
		player.facing_direccion = dir
		
	if dir < 0:
		animacion.flip_h = true
	elif dir > 0:
		animacion.flip_h = false
	
	# CAMBIOS DE ESTADOS
	if player.raycast.is_colliding() and Input.is_action_just_pressed("arriba"):
		var tile = player.raycast.get_collider()
		if tile.is_in_group("wall_escalar"):
			player.can_escalar = true
			next_estado = estado_escalando
			print(player.raycast.get_collider())
			return
		
	if Input.is_action_just_pressed("arriba") and player.is_on_floor():
		player.is_running_jump = true
		player.count_jump = 1
		next_estado = estado_jump
		return
		
		
	if dir == 0:
		next_estado = estado_idle
		
	if Input.is_action_just_released("correr"):
		next_estado = estado_walk

	if Input.is_action_pressed("abajo"):
		next_estado = estado_crouch_idle
		
	if Input.is_action_just_pressed("dash") and player.can_dash:
		next_estado = estado_dash
		
	if !player.is_on_floor():
		next_estado = estado_fall
		
	if Input.is_action_just_pressed("roll") and player.can_roll:
		next_estado = estado_roll
		
	if player.is_hurt:
		print("quiero entrar a hurt")
		next_estado = estado_hurt
		return
func get_SPEED(): 
	return speed_run
	
