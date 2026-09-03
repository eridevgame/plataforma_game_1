extends CharacterBody2D
class_name OBJ_MOVIBLE

@export var datos: objeto_movible_data

func mover(dir: float):
	if not datos.se_empuja:
		return 
		
	velocity.x = dir * datos.speed_empuje / datos.peso
	move_and_slide()
	print("caja: ", velocity.x)
	
	
func detener():
	velocity.x = 0
	move_and_slide()
