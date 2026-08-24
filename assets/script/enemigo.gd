extends CharacterBody2D

class_name  ENEMIGO_SLIME

const SPEED = 30
const JUMP_VELOCITY = -400.0

const gravedad = 900
var enemigo_persigue : bool = false
var patrullando : bool = true

var vida = 80
var max_vida = 80
var min_vida = 0
var dir : Vector2 
var muerto: bool = false
var recibe_dano: bool = false
var damange = 10

func _ready() -> void:
	add_to_group("enemigos")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravedad * delta
		velocity.x = 0
		
	move(delta)
	move_and_slide()

func move(delta):
	if !muerto:
		if !enemigo_persigue:
			velocity.x += dir.x * SPEED * delta
		patrullando = true
	elif muerto:
		velocity.x = 0

func _on_timer_dir_timeout() -> void:
	$timer_dir.wait_time = chose([1.5,2.0,2.5])
	if !enemigo_persigue:
		dir = chose([Vector2.RIGHT,Vector2.LEFT])
		velocity.x = 0
	
func chose(array):
	array.shuffle()
	return array.front()
	
