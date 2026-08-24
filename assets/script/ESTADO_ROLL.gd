extends ESTADOS

class_name ESTADO_ROLL

@export var maquina: ESTADOS
@export var estado_idle: ESTADOS
@export var estado_walk: ESTADOS
@export var estado_run: ESTADOS

func on_enter():
	print("entrando a roll")
	player.can_roll = false
	player.play_anim("roll", 1.0)
	
	var dir = Input.get_axis("izquierda","derecha")
	
	if dir == 0:
		dir = player.facing_direccion
	player.roll_direccion = dir
	
	player.roll_timer.start(player.roll_time)
	
func estado_process(delta):
	# CONDICIONES
	
	player.velocity.x = player.roll_direccion * player.roll_speed
	player.velocity.y = 0
	
	# CAMBIOS DE ESTADOS

func _on_roll_timer_timeout() -> void:
	if maquina.estado_actual != self:
		return
	var dir = Input.get_axis("izquierda","derecha")
	if dir == 0:
		next_estado = estado_idle
	elif dir != 0 and Input.is_action_pressed("correr"):
		next_estado = estado_run
	elif dir != 0:
		next_estado =  estado_walk 
		
	player.roll_cooldown_timer.start(player.roll_cooldown)
	print("timer out")


func _on_roll_cooldown_timeout() -> void:
	player.can_roll = true
	
func on_exit():
	if!player.roll_timer.is_stopped():
		player.roll_timer.stop()
