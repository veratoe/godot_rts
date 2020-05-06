extends Node2D

export(Vector2) var map_size = Vector2(100, 100)

onready var terrain = get_node("terrain")
onready var buildings = get_node("buildings")

# moet dit zo dubbelop?

var Pathfinder = preload("res://scripts/pathfinder.gd")
var pathfinder

# LELIJK! Maar ik weet niet wat voor type de world node2d wordt, dus 
# maar even een dummy tilemap node

var map : TileMap = TileMap.new()


func world_to_map(point: Vector2):
	return map.world_to_map(point)
	
func map_to_world(point: Vector2):
	return map.map_to_world(point)
	
# ---- einde LELIJK -----


func _ready():
	map.cell_size = Vector2(16, 16)

	
	# dit mooier maken	

	pathfinder = Pathfinder.new()
	pathfinder.map = map
	pathfinder.map_size = map_size
	pathfinder.buildings = get_node("buildings")
	pathfinder.terrain = get_node("terrain")
	
	pathfinder.initialize_astar()
