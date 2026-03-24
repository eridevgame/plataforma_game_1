extends ESTADOS
class_name MAQUINA_ESTADOS

@export var estado_actual : ESTADOS

var array_estados: Array[ESTADOS]

func _ready():
	animacion.play("idle")
	for child in self.get_children():
		if child is ESTADOS:
			child.player = player
			child.animacion = animacion
			array_estados.append(child)
			
func _physics_process(delta):
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	
	if estado_actual.next_estado != null:
		cambiar_estado(estado_actual.next_estado)
	estado_actual.estado_process(delta)	
	player.move_and_slide()
	
func cambiar_estado(new_estado: ESTADOS):
	estado_actual.on_exit()
	estado_actual.next_estado = null
	estado_actual = new_estado
	estado_actual.on_enter()

func _input(event):
	estado_actual.estado_input(event)

func _on_animated_sprite_2d_animation_finished() -> void:
	estado_actual.fin_animacion(animacion.animation)
