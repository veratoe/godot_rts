var astar = AStar2D.new()

var buildings : TileMap
var terrain : TileMap
var map : TileMap

var map_size : Vector2

var walkable_terrain : Array = [
	2, # grass	,
	23, # blue_flowers
]

var walkable_buildings : Array = [	
	"dirt_road",
	"farm",
	"farm_grown",
	"farm_sown"
]

var weights: Dictionary = {	
	0: 1.0,
	2: 1.6,
}

var initialized : bool = false

func get_weight(point: Vector2):
	var cell = buildings.get_cellv(map.world_to_map(point))
	if weights.has(cell):
		return weights[cell]
	cell = terrain.get_cellv(map.world_to_map(point))
	if weights.has(cell):
		return weights[cell]
	
	return 1


# Called when the node enters the scene tree for the first time.

func is_walkable(point : Vector2):
	return astar.has_point(calculate_index(point))

func calculate_index(point: Vector2): 	
	return point.y * map_size.x + point.x

func initialize_astar():
	var points = []
		
	for y in range(map_size.y):
		for x in range(map_size.x):
			var point = Vector2(x, y)
			
			var building_cell = buildings.get_cellv(point)
			if building_cell != -1 and !walkable_buildings.has(_World.buildings_tile_name(point)):				
				continue
			
				
			var terrain_cell = terrain.get_cellv(point)
			if !walkable_terrain.has(terrain_cell):
				#print("cell not walkable: ", cell)
				continue
			
			points.append(point)		
			astar.add_point(calculate_index(point), point, get_weight(map.map_to_world(point)))
	
	var dx 
	var dy
	
	for point in points:
		for y in range(3):
			dy = point.y + y - 1
			for x in range(3):
				dx = point.x + x - 1
				if dy < 0 or dy > map_size.y:
					continue

				if dx < 0 or dx > map_size.x:
					continue

				if y == 1 and x == 1:
					continue

				var neighbor = Vector2(dx, dy)

				if not astar.has_point(calculate_index(neighbor)):
					continue

				# aanvullende check voor diagonale verbindingen
				if (x == 0 or x == 2) and (y == 0 or y == 2):
					if not astar.has_point(calculate_index(Vector2(point.x + x - 1, point.y))):						
						continue
					if not astar.has_point(calculate_index(Vector2(point.x, point.y + y - 1))):						
						continue

				astar.connect_points( calculate_index(point),  calculate_index(neighbor), true)

	self.initialized = true

func find_path(start: Vector2, end: Vector2):
	if !self.initialized:
		return 
		
	if !astar.has_point(calculate_index(map.world_to_map(start))):
		return
		
	if !astar.has_point(calculate_index(map.world_to_map(end))):
		return
		
	var world_path: Array
	var path = astar.get_point_path(calculate_index(map.world_to_map(start)), calculate_index(map.world_to_map(end)))
	for point in path:
		world_path.append(map.map_to_world(point))
	
	return world_path

func _process(delta):
	update()


func update():
	pass
			
		
