extends TileMap

onready var astar = AStar2D.new()

var size: Vector2 = Vector2(100, 100)

var walkable_cells : Array = [
	0, # dirt road
	2, # gras
	
]

var weights: Dictionary = {
	0: 1,
	2: 1,
}

func get_weight(point: Vector2):
	var cell = get_cellv(world_to_map(point))
	return weights[cell]

export(Vector2) var map_size = Vector2(100, 100)
# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_astar()

func calculate_index(point: Vector2) -> int:
	return point.y * map_size.x + point.x

func initialize_astar():
	var points = []
		
	for y in range(map_size.y):
		for x in range(map_size.x):
			var cell = get_cell(x, y)
			if walkable_cells.has(cell):
				var point = Vector2(x, y)
				points.append(point)
				astar.add_point(calculate_index(point), point, weights[cell])
	
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
						print('diagonaal past niet')
						continue
					if not astar.has_point(calculate_index(Vector2(point.x, point.y + y - 1))):
						print('diagonaal past niet')
						continue

				astar.connect_points( calculate_index(point),  calculate_index(neighbor), true)

func find_path(start: Vector2, end: Vector2):
	var world_path: Array
	var path = astar.get_point_path(calculate_index(world_to_map(start)), calculate_index(world_to_map(end)))
	for point in path:
		world_path.append(map_to_world(point))
	
	return world_path

func _process(delta):
	update()


			
		
