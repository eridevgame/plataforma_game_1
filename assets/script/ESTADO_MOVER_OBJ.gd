extends ESTADOS

class_name ESTADO_MOVER_OBJ

@export var estado_idle: ESTADOS

var caja_actual: OBJ_MOVIBLE = null
var is_jalando = false

func on_enter():
	animacion.play("pull")
	player.esta_jalando = true
	is_jalando = true
	
	if player.raycast.is_colliding():
		var collider = player.raycast.get_collider()
		if collider is OBJ_MOVIBLE:
			caja_actual = collider
	
func estado_process(delta):
	# CONDICIONES
	var dir = Input.get_axis("izquierda","derecha")
	
	if caja_actual:
		caja_actual.mover(dir)
		player.velocity.x = caja_actual.velocity.x
	
	var speed_anim = 1.0 / caja_actual.peso
	var caja_derecha = caja_actual.global_position.x > player.global_position.x
	if dir == 0:
		animacion.pause()
	elif dir < 0:
		if caja_derecha:
			player.play_anim("pull",speed_anim)
		else:
			player.play_anim("push",speed_anim)
	elif dir > 0:
		if caja_derecha:
			player.play_anim("push",speed_anim)
		else:
			player.play_anim("pull",speed_anim)
	
	# CAMBIOS DE ESTADOS
	if !Input.is_action_pressed("accion"):
		next_estado = estado_idle

func on_exit():
	caja_actual = null
	is_jalando = false
