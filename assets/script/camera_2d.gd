extends Camera2D
@export var speed := 500.0
@export var zoom_speed := 0.1
@export var min_zoom := 1.0
@export var max_zoom := 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _input(event):
	if event is InputEventMouseButton:
		
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom -= Vector2(zoom_speed, zoom_speed)
			
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom += Vector2(zoom_speed, zoom_speed)
			
		zoom.x = clamp(zoom.x, min_zoom, max_zoom)
		zoom.y = clamp(zoom.y, min_zoom, max_zoom)	
	
