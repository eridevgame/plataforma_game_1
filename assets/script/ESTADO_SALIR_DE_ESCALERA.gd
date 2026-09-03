extends ESTADOS
class_name ESTADO_SALIDA_ESCALERA

@export var estado_idle: ESTADOS

var tiempo := 0.1
var timer := 0.0

func on_enter():
	player.play_anim("jump",1.0)
	player.puede_girar = true
	player.config_colicion({
		"parado": true,
		"agachado":true,
		"doble_jump":true
	})
	timer = 0.0
	player.velocity.y = -150
	player.velocity.x = 100 * player.facing_direccion
	player.top_escalada = false
	player.is_escalando = false
func estado_process(delta):
	# CONDICIONES
	timer += delta
	
	# CAMBIOS DE ESTADOS
	if timer >= tiempo:
		next_estado = estado_idle
