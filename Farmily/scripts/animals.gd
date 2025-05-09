extends Node3D

var animal_list: Array[Node]
var MOVEMENT_PROBABILITY: float = 0.1
var SPEED: int = 10
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var initial_time: float = Time.get_unix_time_from_system()
var timer

func _ready() -> void:
	animal_list = get_children()
	timer = $CowBody/Timer

func _physics_process(delta: float) -> void:
	var random_number: float = rng.randf()
	if random_number <= MOVEMENT_PROBABILITY:
		var animal_to_move: CharacterBody3D = get_random_animal()
		move_animal_randomly(animal_to_move, delta)

func get_random_animal() -> CharacterBody3D:
	var random_choice: int = round((len(animal_list) * rng.randf())) - 1 
	return animal_list[random_choice]

func move_animal_randomly(animal: CharacterBody3D, delta) -> void:
	var directions = [Vector3(1, 0, 0), Vector3(-1, 0, 0)]
	var current_direction: Vector3 = directions[round((len(directions) * rng.randf())) - 1]
	
	#animal.velocity = lerp(current_direction, 100 * delta)
	
	
	
