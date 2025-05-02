extends WorldEnvironment

var enabled: bool = true
var ambient

func _ready() -> void:
	ambient = environment.ambient_light_source

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_down"):
		if enabled:
			environment.ambient_light_source = Environment.AMBIENT_SOURCE_DISABLED
		else:
			environment.ambient_light_source = ambient
		
		enabled = !enabled
