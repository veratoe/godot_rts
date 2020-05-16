extends Node2D

enum types {
	ARCHER, BISHOP, BLACKSMITH, BUTCHER, DUKE, ELF, EXECUTIONER,
	HERALD, KING, KNIGHT_ELITE, KNIGHT_HEAVY, KNIGHT_STANDARD,
	MAGE, MAGIC_SHOPKEEPER, MERCHANT, MOUNTAIN_KING, NUN_FAT, NUN_NORMAL,
	NUN_TALL, PRINCESS, QUEEN, THIEF, TOWNSFOLK_MALE, TOWNSFOLK_FEMALE
}

var sprite_frames = [
	preload("res://animations/archer.tres"),
	preload("res://animations/bishop.tres"),
	preload("res://animations/blacksmith.tres"),
	preload("res://animations/butcher.tres"),
	preload("res://animations/duke.tres"),
	preload("res://animations/elf.tres"),
	preload("res://animations/executioner.tres"),
	preload("res://animations/herald.tres"),
	preload("res://animations/knight_elite.tres"),
	preload("res://animations/knight_heavy.tres"),
	preload("res://animations/knight_standard.tres"),
	preload("res://animations/mage.tres"),
	preload("res://animations/magic_shopkeeper.tres"),
	preload("res://animations/merchant.tres"),
	preload("res://animations/mountain_king.tres"),
	preload("res://animations/nun_fat.tres"),
	preload("res://animations/nun_normal.tres"),
	preload("res://animations/nun_tall.tres"),
	preload("res://animations/princess.tres"),
	preload("res://animations/queen.tres"),
	preload("res://animations/thief.tres"),
	preload("res://animations/townsfolk_male.tres"),
	preload("res://animations/townsfolk_female.tres")
]

var Actor = preload("res://scenes/actor.tscn")

func _ready():
	pass # Replace with function body.

func remove_all_actors():
	for actor in get_tree().get_nodes_in_group("actors"):
		actor.queue_free()

func create_actor(position = null) -> bool:
	
	if position == null:
		position = Vector2(randi() % 800, randi() % 500)
	if !_World.is_walkable(position):
		return false
	# lelijk dat dit dubbel moet
	var actor = Actor.instance()
	actor.initialize(
		randi() % (types.size() - 1),
		position		#Vector2(randi() % 1600, randi() % 500)
	)
		
	_World.get_node("actors").add_child(actor)
	
#	actor = Actor.instance()
#	actor.initialize(
#		randi() % (types.size() - 1),
#		_World.map_to_world(Vector2(60, 20))
#	)
#
#	_World.get_node("actors").add_child(actor)
	
	return true

func get_totals_actors():
	return get_tree().get_nodes_in_group("actors").size()

func _input(event):
	if event is InputEventMouseButton and event.pressed == true and event.button_index == BUTTON_LEFT:
		SignalsManager.emit_signal("actor_deselected")
