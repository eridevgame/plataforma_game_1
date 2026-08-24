extends CharacterBody2D
class_name OBJ_MOVIBLE

@export var textura: Sprite2D
@export var nombre: String
@export var speed_empuje = 80.0
@export var peso = 5.0

func mover(dir: float):
	velocity.x = dir * speed_empuje / peso
	move_and_slide()
	print("caja: ", velocity.x)
	
	
func detener():
	velocity.x = 0
	move_and_slide()
