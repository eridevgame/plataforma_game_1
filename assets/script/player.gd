extends CharacterBody2D

class_name PLAYER

@export var maquina_estados: MAQUINA_ESTADOS
@export var estado_idle: ESTADOS
@export var estado_fall: ESTADOS
@export var estado_walk: ESTADOS
@export var estado_run: ESTADOS

@onready var ANIMACION = $AnimatedSprite2D
@onready var ANIMACION_TREE = $AnimationPlayer
@onready var ANIMACION_PLAYBACK = ANIMACION_TREE["parameters/playback"]
@onready var parado = $colicion_normal
@onready var agachado = $colicion_crouch
@onready var doble_jump = $colicion_doble_jump
@onready var raycast = $RayCast2D
@onready var area_impulso_y = $area_impulso_y
@onready var area_hit = $hit_area/CollisionShape2D

var vida_max = 100
var vida_actual = 100

var is_hurt = false
var hurt_direccion 

var jump_buffer_time = 0.2
var jump_buffer = 0.0

var count_jump = 0
const max_jump = 2
var jump_velocity_walk = -200
var jump_velocity_run = -260
var speed_jump_walk = 50
var speed_jump_run = 80
var is_running_jump = false

var speed_crouch_walk = 30
var speed_crouch_run = 30

var RETROCESO = Vector2.ZERO
const FUERZA_RETROCESO = 200.0

@onready var dash_cooldown_timer = $dash_cooldown
@onready var dash_timer = $dash_timer
var dash_speed = 400
var dash_time = 0.15
var can_dash = true
var dash_cooldown = 5.0
var dash_direccion = 0

var facing_direccion = 1

var is_escalando = false
var can_escalar = false
var top_escalada = false

var ray_position_1 = Vector2(10,0)
var ray_position_2 = Vector2(-10,0)
var puede_girar = true

var esta_jalando = false

@onready var roll_timer = $roll_timer
@onready var roll_cooldown_timer = $roll_cooldown
var roll_speed = 200
var roll_time = 0.5
var can_roll = true
var roll_cooldown = 5.0
var roll_direccion = 0


func config_colicion(config: Dictionary):
	parado.disabled = config.get("parado",false)
	agachado.disabled = config.get("agachado", true)
	doble_jump.disabled = config.get("doble_jump", true)
	
func actualizar_raycast():
	if facing_direccion > 0:
		raycast.target_position = Vector2(7,0)
	else:
		raycast.target_position = Vector2(-7,0)

		# ANIMACIONES
var animaciones = {
	"idle" : 1.0,
	"walk" : 1.0,
	"run" : 1.0,
	"jump" : 1.0,
	"doble_jump" : 1.0,
	"fall" : 1.0,
	"crouch_idle" : 1.0,
	"crouch_walk" : 1.0,
	"dash" : 1.0,
	"climb_side" : 1.0,
	"pull" : 1.0,
	"push" : 1.0,
	"roll" : 1.0,
	"hurt_damange" : 1.0
}
func play_anim(nombre:String, velocidad: float):
	if animaciones.has(nombre):
		ANIMACION.speed_scale = velocidad
		ANIMACION.play(nombre)
		
var animaciones_tree = {
	"punch":1.0
}
func play_anima_tree(nombre:String, velocidad:float):
	if animaciones_tree.has(nombre):
		ANIMACION_TREE["parameters/%s/scale" % nombre] = velocidad
		ANIMACION_PLAYBACK.travel(nombre)
	
func config_ataque(tipo):
	match tipo:
		"punch":
			area_hit.position = Vector2(15,0)
		
func _on_dash_cooldown_timeout() -> void:
	can_dash = true

func _on_dash_timer_timeout() -> void:
	if is_on_floor():
		maquina_estados.cambiar_estado(estado_idle) 
	else:
		maquina_estados.cambiar_estado(estado_fall)
		
	dash_cooldown_timer.start(dash_cooldown)
	
func recibir_dano(cantidad, body):
	if is_hurt:
		return
		
	vida_actual -= cantidad
	
	var direccion = (global_position - body.global_position).normalized()
	RETROCESO = direccion * FUERZA_RETROCESO
	print(vida_actual)
	
	is_hurt = true
	
func _on_hurt_area_body_entered(body: Node2D) -> void:
	print(vida_actual)
	if body.is_in_group("enemigos"):
		recibir_dano(body.damange,body)
	
		
