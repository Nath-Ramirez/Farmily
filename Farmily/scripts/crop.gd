extends Node3D

@onready var bushes = get_children()
var current_crop = 1

func _ready() -> void:
	bushes = bushes.filter(func (elem): return elem.name.begins_with("Bush"))
	for i in bushes:
		print(i.name)

func get_interacted():
	if current_crop >= len(bushes):
		return
		
	var previous_bush: Node3D = bushes[current_crop - 1]
	var current_bush: Node3D = bushes[current_crop]
	
	previous_bush.visible = false
	current_bush.visible = true
	current_crop += 1
	
	$Sprite3D.modulate.a = 1
	
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite3D, "modulate:a", 0, 1)
	
