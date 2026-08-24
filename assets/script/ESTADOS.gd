extends Node

class_name ESTADOS

@export var player: CharacterBody2D
@export var animacion: AnimatedSprite2D


const  SPEED = 200.0
const  JUMP_VELOCITY = -400.0
var in_duble_jump = false

@export var can_move = true
var next_estado: ESTADOS = null

func on_enter():
	pass
	
func on_exit():
	pass
	
func get_SPEED():
	return SPEED 
	
func get_JUMP_VELOCITY():
	return JUMP_VELOCITY
	
func get_DIRECCION():
	return Input.get_axis("izquierda", "derecha")
	
func estado_process(delta):
	pass
	
func estado_input(event: InputEvent):
	pass
	
func fin_animacion(anim_name):
	pass
	
