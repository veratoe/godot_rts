class_name FindFarmAction 
extends Action
	
signal farm_found(tile)
	
var closest : int = -1
var tile : Vector2

var position : Vector2
var radius : int

var time : float  = 0

func _to_string():
	match status:
		Status.IMPOSSIBLE:
			return "no grown farms around"
		Status.COMPLETE:
			return "farm found"
	return "checking around"

func _init(position: Vector2, radius: int).():	
	self.position = position
	self.radius = radius

func _process(delta : float):
	# niet elk frame zoeken, te intensief denk ik
	time += delta
	if time < 2:
		return
		
	time = 0
	if self.status == Status.COMPLETE:
		return
		
#	print("%s tot %s" % [position.x - radius, position.x + radius])
#	print("%s tot %s" % [position.y - radius, position.y + radius])
#
	for x in range(position.x - radius, position.x + radius):
		for y in range(position.y - radius, position.y + radius):
			var dx = x - position.x
			var dy = y - position.y

			var d = dx * dx + dy * dy

#			if d > radius * radius:
#				continue
				
			var point = Vector2(x, y)
			
			#print("from %s, looking at point %s" % [position, point])
				
			if _World.tile_has_building(point, "farm_grown"):	
				if closest == -1 or d < closest:
					closest = d
					tile = point
					
	if closest == -1:
		on_impossible()
		
	else:
		on_complete()
	
func on_complete():	
	emit_signal("farm_found", tile)
	._on_complete()

func on_impossible():
	._on_impossible()
