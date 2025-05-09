extends Node3D

var animal_list: Array[Node]
var MOVEMENT_PROBABILITY: float = 0.1
var SPEED: int = 1
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var initial_time: float = Time.get_unix_time_from_system()
@onready var timer: Timer = $Timer

func _ready() -> void:
	update_children()
	timer.connect("timeout", move_animal_randomly)

# Devuelve algun animal de los nodos hijos de la instancia actual
func get_random_animal() -> CharacterBody3D:
	var random_choice: int = round((len(animal_list) * rng.randf())) - 1
	return animal_list[random_choice]

# Mueve algun animal de manera aleatoria
func move_animal_randomly() -> void:
	update_children()
	var animal_to_move: CharacterBody3D = get_random_animal()
	
	# Vector de direcciones en X (derecha o izquierda)
	var directions = [Vector3(0.2, 0, 0), Vector3(-0.2, 0, 0)]
	
	var direction_number = int((len(directions) * rng.randf()))
	
	# Obtiene aleatoriamente la direccion a la cual apuntara el animal
	var current_direction: Vector3 = directions[direction_number]
	
	# Obtiene los nodos hijos del animal actual
	var animal_node_children: Array[Node] = animal_to_move.get_children()
	print(animal_node_children)
	
	# Obtiene el nodo de Sprite3D para
	var target = animal_node_children[animal_node_children.find_custom(
		func (child): return child is Sprite3D
	)]
	
	match direction_number:
		0:
			if target:
				target.flip_h = true # Cambia de orientacion en el eje X
		1:
			if target:
				target.flip_h = false
				
	# Obtenemos el AnimationPlayer del animal actual
	var animal_animation: AnimationPlayer = target.get_child(0) 
	
	# Ejecutamos la animacion que se encuentra en la ultima posicion de la lista de animaciones
	# (la primera siempre es la DEFAULT)
	animal_animation.play(animal_animation.get_animation_list()[-1])
	
	# Creamos un tween (InBetween) para interpolar o suavizar el movimiento de los animales
	var tween = get_tree().create_tween()
	
	# Movemos el animal
	tween.tween_property(animal_to_move, "position", animal_to_move.position + current_direction, 1)
	
	# Detectar cuando el tween acaba para detener la animacion
	tween.connect("finished", func(): animal_animation.stop())

func update_children():
	animal_list = get_children()
	animal_list.pop_back()
