extends CharacterBody2D

class_name ENEMIGO_SLIME

const SPEED = 30
const JUMP_VELOCITY = -400.0
const gravedad = 900

var enemigo_persigue: bool = false
var patrullando: bool = true

var vida = 80
var max_vida = 80
var min_vida = 0

var dir: Vector2
var muerto: bool = false
var recibe_dano: bool = false
var damange = 10

# RETROCESO
var retroceso := Vector2.ZERO
@export var retroceso_fuerza := 300.0
@export var retroceso_frenado := 1000.0


func _ready() -> void:
	add_to_group("enemigos")


func _physics_process(delta):

	# GRAVEDAD
	if not is_on_floor():
		velocity.y += gravedad * delta

	# RETROCESO
	if retroceso.length() > 0:
		velocity.x = retroceso.x
		retroceso = retroceso.move_toward(
			Vector2.ZERO,
			retroceso_frenado * delta
		)
	else:
		move(delta)

	move_and_slide()


func move(delta):

	if not muerto:

		if not enemigo_persigue:
			velocity.x += dir.x * SPEED * delta

		patrullando = true

	else:
		velocity.x = 0


func _on_timer_dir_timeout() -> void:

	$timer_dir.wait_time = chose([1.5, 2.0, 2.5])

	if not enemigo_persigue:
		dir = chose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0


func chose(array):
	array.shuffle()
	return array.front()


func recibir_dano(posicion_atacante: Vector2):

	# DAÑO
	vida -= damange

	print("Vida del enemigo: ", vida)

	# DIRECCIÓN DEL RETROCESO
	var direccion = (global_position - posicion_atacante).normalized()

	# APLICAR RETROCESO
	retroceso = direccion * retroceso_fuerza

	# MUERTE
	if vida <= min_vida:
		muerto = true


func _on_area_2d_area_entered(area: Area2D) -> void:

	# POSICIÓN DEL ATAQUE
	var posicion_atacante
	if area.is_in_group("hit"):
		posicion_atacante = area.global_position
		recibir_dano(posicion_atacante)

	print("recibio dano el enemigo")
