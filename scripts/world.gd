extends Node2D

export(Vector2) var map_size = Vector2(100, 100)

onready var terrain = get_node("terrain")
onready var buildings = get_node("buildings")

# moet dit zo dubbelop?

var Pathfinder = preload("res://scripts/pathfinder.gd")
var pathfinder

#var FlashIcon = preload("res://scenes/flash_icon.tscn")

# LELIJK! Maar ik weet niet wat voor type de world node2d wordt, dus 
# maar even een dummy tilemap node

var map : TileMap = TileMap.new()

func world_to_map(point: Vector2):
	return map.world_to_map(point)
	
func map_to_world(point: Vector2):
	return map.map_to_world(point)
	
# ---- einde LELIJK -----

func _process(delta : float):
	var farm_tiles = buildings.get_used_cells_by_id(28)
	for tile in farm_tiles:
		if randi() % 1500 == 0:
			#print("growing")
			buildings.set_cellv(tile, 29)
			
	farm_tiles = buildings.get_used_cells_by_id(29)
	for tile in farm_tiles:
		if randi() % 1500 == 0:
			#print(tile, "wordt een farm grown")
			buildings.set_cellv(tile, 30)

	update()
	
func _ready():	
	SignalsManager.connect("actor_work_farm_completed", self, "_on_actor_work_farm_completed")
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

func buildings_tile_name(tile: Vector2) -> String:
	if tile.x > map_size.x or tile.x < 0 or tile.y > map_size.y or tile.y < 0:
		return "empty"
	var i = buildings.get_cellv(tile)
	if buildings.tile_set.get_tiles_ids().has(i):
		return buildings.tile_set.tile_get_name(i)	
		
	return "empty space"

func tile_has_building(tile: Vector2, building : String) -> bool:
	var name = buildings_tile_name(tile)
	if (name == building):
		return true
	return false
	
func _on_actor_work_farm_completed(farm: Vector2):
	
	buildings.set_cellv(farm, 28)
	var flash_icon = FlashIcon.new(FlashIcon.types.APPLE, map_to_world(farm))
	add_child(flash_icon)

func _draw():
	pass
#
#	for tile in buildings.get_used_cells_by_id(28):
#		draw_rect(Rect2(map_to_world(tile), Vector2(16, 16)), Color(0, 255, 0, 0.2), true)
#
#	for tile in buildings.get_used_cells_by_id(29):
#		draw_rect(Rect2(map_to_world(tile), Vector2(16, 16)), Color(255, 0 , 0, 0.2), true)
#
#	for tile in buildings.get_used_cells_by_id(30):
#		draw_rect(Rect2(map_to_world(tile), Vector2(16, 16)), Color(0, 0, 255, 0.2), true)
