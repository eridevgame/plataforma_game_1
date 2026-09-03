extends ESTADOS

class_name ESTADO_ESCALAR

@export var estado_idle: ESTADOS
@export var estado_salir_de_escalera: ESTADOS
@export var estado_jump: ESTADOS

var climb_speed = 50

func on_enter():
	animacion.play("climb_side")
	player.is_escalando = true
	player.puede_girar = false
	player.config_colicion({
		"parado": false,
		"agachado":true,
		"doble_jump":true
	})
	
func estado_process(delta):
	# CONDICIONES
	var dir_y = Input.get_axis("arriba", "abajo")
	player.velocity.y = dir_y * climb_speed
	
	if player.is_escalando:
		player.raycast.target_position = player.raycast.target_position
	player.velocity.x = 0
	
	if dir_y == 0:
		animacion.pause()
	else:
		player.play_anim("climb_side",1.0)
		
	if dir_y < 0:
		player.play_anim("climb_side",1.0)
	elif dir_y > 0:
		player.play_anim("climb_side",-1.0)
		
	# CAMBIO DE ESTADOS
	if player.top_escalada:
		next_estado = estado_salir_de_escalera
		return
		
	if not player.can_escalar:
		next_estado = estado_idle
		return
		
	if player.raycast.is_colliding() == false:
		next_estado = estado_salir_de_escalera
		player.can_escalar = false
		
	if player.is_on_floor() and dir_y > 0:
		next_estado = estado_idle
		player.is_escalando = false
		
	


func _on_area_impulso_y_area_entered(area: Area2D) -> void:
	player.top_escalada = true
	print("senal detectada")
	
