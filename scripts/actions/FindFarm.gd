class_name FindFarmAction 
extends Action
	
signal farm_found(tile)
	
var closest : int = -1
var tile : Vector2

var position : Vector2
var radius : int

var time : float  = 0

func _init(position: Vector2, radius: int):	
	self.position = position
	self.radius = radius

func _process(delta : float):
	time += delta
	if time < 5:
		return
		
	time = 0
	if self.status == Status.COMPLETE:
		return
		
	for x in range(radius):
		for y in range(radius):
			var dx = x - round(0.5 * radius)	
			var dy = y - round(0.5 * radius)
			
			var d = dx * dx + dy * dy
			
			if d > radius * radius:
				continue
				
			var point = Vector2(position.x + dx, position.y + dy)
			
			#print("from %s, looking at point %s" % [position, point])
				
			if GlobalWorld.tile_has_building(point, "farm_grown"):				
				if closest == -1 or d < closest:
					closest = d
					tile = point
					
	if closest == -1:
		on_impossible()
		
	else:
		on_complete()
	
func on_complete():	
	emit_signal("farm_found", tile)
	.on_complete()

func on_impossible():
	print("niks kunnen vinden")
	.on_impossible()
