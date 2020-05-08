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

func _process(delta : float):
	var farm_tiles = buildings.get_used_cells_by_id(26)
	for tile in farm_tiles:
		if randi() % 1000 == 0:
			print("growing")
			buildings.set_cellv(tile, 25)
			
	farm_tiles = buildings.get_used_cells_by_id(25)
	for tile in farm_tiles:
		if randi() % 500 == 0:
			print("growing again")
			buildings.set_cellv(tile, 27)


func _ready():	
	map.cell_size = Vector2(16, 16)

	# dit mooier maken	

	pathfinder = Pathfinder.new()
	pathfinder.map = map
	pathfinder.map_size = map_size
	pathfinder.buildings = get_node("buildings")
	pathfinder.terrain = get_node("terrain")
	
	pathfinder.initialize_astar()

func is_walkable(point : Vector2) -> bool:
	return pathfinder.is_walkable(map.world_to_map(point))

func tile_has_building(tile: Vector2, building : String) -> bool:
	if tile.x > map_size.x or tile.x < 0 or tile.y > map_size.y or tile.y < 0:
		return false
	var i = pathfinder.buildings.get_cellv(tile)
	var name = pathfinder.buildings.tile_set.tile_get_name(i)
	return name == building
	
