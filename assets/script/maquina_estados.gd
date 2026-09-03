extends ESTADOS
class_name MAQUINA_ESTADOS

@export var estado_actual : ESTADOS

var array_estados: Array[ESTADOS]
@onready var area_hit = $"../hit_area"

func _ready():
	area_hit.add_to_group("hit")
	animacion.play("idle")
	for child in self.get_children():
		if child is ESTADOS:
			child.player = player
			child.animacion = animacion
			array_estados.append(child)
			
func _physics_process(delta):
	var dir = Input.get_axis("izquierda","derecha")
	if player.puede_girar:
		if dir > 0:
			player.raycast.target_position = player.ray_position_1
		elif dir < 0:
			player.raycast.target_position = player.ray_position_2
	
	if not player.is_escalando:
		if not player.is_on_floor():
			player.velocity += player.get_gravity() * delta
	
		
	
	if estado_actual.next_estado != null:
		var siguiente = estado_actual.next_estado
		estado_actual.next_estado = null
		cambiar_estado(siguiente)
	player.move_and_slide()
	estado_actual.estado_process(delta)	
	
	player.config_ataque("punch")
	
func cambiar_estado(new_estado: ESTADOS):
	if new_estado == null:
		return
		
	estado_actual.on_exit()
	estado_actual.next_estado = null
	estado_actual = new_estado
	estado_actual.on_enter()

func _input(event):
	estado_actual.estado_input(event)

func _on_animated_sprite_2d_animation_finished() -> void:
	estado_actual.fin_animacion(animacion.animation)
