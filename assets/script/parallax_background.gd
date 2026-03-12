extends ParallaxBackground


func _process(delta):
	var velocidad = 10
	
	if Input.is_action_pressed("derecha"):
		scroll_offset.x -= velocidad * delta
		
	if Input.is_action_pressed("izquierda"):
		scroll_offset.x += velocidad * delta
