extends TileMap

onready var astar = AStar2D.new()

var walkable_cells : Array = [
	0, # dirt road
	2, # gras
	
]

var weights: Dictionary = {
	0: 1,
	2: 1.5
}


func get_weight(point: Vector2):
	var cell = get_cellv(world_to_map(point))
	return weights[cell]

export(Vector2) var map_size = Vector2(100, 100)
# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_astar()
	pass # Replace with function body.

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
		#print("examining point (%s, %s), with index %s" % [point.x, point.y, calculate_index(point)])
		for y in range(3):
			dy = point.y + y - 1
			for x in range(3):
				dx = point.x + x - 1
				#print("neighbor: (%s, %s)" % [dx, dy])
				if dy < 0 or dy > map_size.y:
				#print("skipping: (", dx, ", " , dy, ")")
					continue
			
				
				if dx < 0 or dx > map_size.x:
					#print("skipping: (", dx, ", " , dy, ")")
					continue
					
				if y == 1 and x == 1:
					#print(dx, " = ", point.x , ", ", dy, " = ", point.y)
					continue
					
				var neighbor = Vector2(dx, dy)
				
				if not astar.has_point( calculate_index(neighbor)):
					#print("( %s, %s) met index %s not walkable" % [neighbor.x, neighbor.y, calculate_index(neighbor)])
					continue
					
				astar.connect_points( calculate_index(point),  calculate_index(neighbor), true)
				#print(point.x, ", " , point.y, " => " , dx, ", ", dy , " connect!")

func find_path(start: Vector2, end: Vector2):
	var world_path: Array
	var path = astar.get_point_path(calculate_index(world_to_map(start)), calculate_index(world_to_map(end)))
	for point in path:
		world_path.append(map_to_world(point))
	
	return world_path
