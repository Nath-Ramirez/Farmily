extends CharacterBody3D

@export var speed:int = 300
var last_key_pressed

func _physics_process(delta: float) -> void:
	if Input.is_key_pressed(KEY_I):
		velocity.z = -speed * delta
		velocity.x = 0
		animate_player("run_back")

	elif Input.is_key_pressed(KEY_K):
		velocity.z = speed * delta
		velocity.x = 0
		animate_player("run_front")

	elif Input.is_key_pressed(KEY_J):
		velocity.x = -speed * delta
		velocity.z = 0
		$Sprite3D.flip_h = true
		animate_player("run_side")

	elif Input.is_key_pressed(KEY_L):
		velocity.x = speed * delta
		velocity.z = 0
		$Sprite3D.flip_h = false
		animate_player("run_side")
	
	if not Input.is_anything_pressed():
		$Sprite3D.flip_h = false
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		animate_player("stop")

	move_and_slide()

func animate_player(animation:String):
	match animation:
		"stop":
			$Sprite3D/AnimationPlayer.play("idle_front")
		"run_front":
			$Sprite3D/AnimationPlayer.play("run_front")
		"run_back":
			$Sprite3D/AnimationPlayer.play("run_back")
		"run_side":
			$Sprite3D/AnimationPlayer.play("run_side")
	
