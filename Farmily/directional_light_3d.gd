extends DirectionalLight3D


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_up"):
		visible = !visible
	

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_W):
		rotate_z(2 * delta)
