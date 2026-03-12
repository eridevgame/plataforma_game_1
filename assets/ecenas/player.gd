extends CharacterBody2D


@export var SPEED = 50.0
const JUMP_VELOCITY = -200.0
@onready var animacion = $AnimatedSprite2D
var is_jump = false
var is_run = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	salto()
	movimiento()
	animaciones()

	

func salto():
	if Input.is_action_just_pressed("arriba") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jump = true
	
func movimiento():
	var direction := Input.get_axis("izquierda", "derecha")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func animaciones():
	if velocity.x == 0:
		animacion.play("idle")
		
	if velocity.x < 0:
		if Input.is_action_pressed("correr"):
			animacion.play("run")
			animacion.flip_h = true
			is_run = true
			SPEED = 80.0
		else:
			animacion.play("walk")
			animacion.flip_h = true
			SPEED = 50.0
			
	if velocity.x > 0:
		if Input.is_action_pressed("correr"):
			animacion.play("run")
			animacion.flip_h = false
			is_run = true
			SPEED = 80.0
		else:
			animacion.play("walk")
			animacion.flip_h = false
			SPEED = 50.0
			
	if is_jump == true and not is_on_floor():### ARREGLAR ANIMACION DE SALTO CORRIENDO
		if is_run == false:
			animacion.play("jump")
		if is_run == true:
			animacion.play("air_spin")
	
		
		
