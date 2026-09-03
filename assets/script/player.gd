extends CharacterBody2D

class_name PLAYER
#region var exports
@export var maquina_estados: MAQUINA_ESTADOS
@export var estado_idle: ESTADOS
@export var estado_fall: ESTADOS
@export var estado_walk: ESTADOS
@export var estado_run: ESTADOS

#endregion

#region var onready
@onready var ANIMACION = $animaciones
@onready var parado = $colicion_normal
@onready var agachado = $colicion_crouch
@onready var doble_jump = $colicion_doble_jump
@onready var raycast = $RayCast2D
@onready var area_impulso_y = $area_impulso_y
@onready var area_hit = $hit_area/CollisionShape2D
@onready var dash_cooldown_timer = $dash_cooldown
@onready var dash_timer = $dash_timer
@onready var roll_timer = $roll_timer
@onready var roll_cooldown_timer = $roll_cooldown
@onready var area_ataque = $hit_area/CollisionShape2D
#endregion

#region var stats
var vida_max: int:
	get:
		return GlobalStats.stats["vida_max"]
var vida_actual: int:
	get:
		return GlobalStats.stats["vida_actual"]

#endregion

#region var habilidades
var is_punsh: bool = false
var can_escalar: bool:
	get:
		return GlobalStats.habilidades["escalar"]
var can_dash: bool:
	get:
		return GlobalStats.habilidades["dash"]
var can_roll: bool:
	get:
		return GlobalStats.habilidades["roll"]
var can_doble_jump: bool:
	get:
		return GlobalStats.habilidades["doble_jump"]
var puede_girar = true
#endregion

#region var conunt
var count_jump = 0
const max_jump = 2
var jump_buffer_time = 0.2
var jump_buffer = 0.0

#endregion

#region var mix
var is_hurt = false
var hurt_direccion 
var jump_velocity_walk = -200
var jump_velocity_run = -260
var speed_jump_walk = 50
var speed_jump_run = 80
var is_running_jump = false
var speed_crouch_walk = 30
var speed_crouch_run = 30
var RETROCESO = Vector2.ZERO
const FUERZA_RETROCESO = 200.0
# DASH
var dash_speed = 400
var dash_time = 0.15
@export var dash_cooldown = 5.0
var dash_direccion = 0

var facing_direccion = 1
var is_escalando = false
var top_escalada = false
var ray_position_1 = Vector2(4 ,0)
var ray_position_2 = Vector2(-4 ,0)
var esta_jalando = false
var roll_speed = 200
var roll_time = 0.5
var roll_cooldown = 5.0
var roll_direccion = 0
#endregion

func config_colicion(config: Dictionary):
	parado.disabled = config.get("parado",false)
	agachado.disabled = config.get("agachado", true)
	doble_jump.disabled = config.get("doble_jump", true)
	
func actualizar_raycast():
	if facing_direccion > 0:
		raycast.target_position = Vector2(3,0)
	else:
		raycast.target_position = Vector2(-3,0)
	raycast.force_raycast_update()
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
	"hurt_damange" : 1.0,
	"punch" : 1.0
}
func play_anim(nombre:String, velocidad: float):
	if animaciones.has(nombre):
		ANIMACION.speed_scale = velocidad
		ANIMACION.play(nombre)
		
	
func config_ataque(tipo):
	match tipo:
		"punch":
			if facing_direccion > 0:
				area_hit.position = Vector2(15, 0)
				area_ataque.position = Vector2(10.5, -1.0)
			else:
				area_hit.position = Vector2(-15, 0)
				area_ataque.position = Vector2(-10.5, -1.0)
				
		
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
		
	GlobalStats.stats["vida_actual"] -= cantidad
	
	var direccion = (global_position - body.global_position).normalized()
	RETROCESO = direccion * FUERZA_RETROCESO
	print(vida_actual)
	
	is_hurt = true
	
func _on_hurt_area_body_entered(body: Node2D) -> void:
	print(vida_actual)
	if body.is_in_group("enemigos"):
		recibir_dano(body.damange,body)
	
		
func _on_animated_sprite_2d_frame_changed() -> void:
	if ANIMACION.animation == "punch":
		if ANIMACION.frame == 5:
			activar_hitbox()

		elif ANIMACION.frame == 6:
			desactivar_hitbox()

func activar_hitbox():
	area_ataque.disabled = false
	
func desactivar_hitbox():
	area_ataque.disabled = true
