extends Node2D



export var speed = 20
# Called when the node enters the scene tree for the first time.
var destination: Vector2 setget set_destination

var world
var next_point : Vector2

var type : int

var has_destination : bool = false
var is_moving : bool = false

var route_points : PoolVector2Array # world coordinates
var route_index : int

var velocity : Vector2
var float_position : Vector2

func set_destination(value: Vector2):
	has_destination = false
	# mooi afronden van de getallekes
	destination = world.map_to_world(world.world_to_map(value))
	
	if !find_path():
		return
		
	if route_points.size() > 1:
		has_destination = true
		next_point = route_points[1]
		route_index = 1
	
func initialize(type : int, world : Node2D, position : Vector2):
	self.type = type
	self.world = world
	self.position = world.map_to_world(world.world_to_map(position))
	add_to_group("actors")

func _ready():
	$AnimatedSprite.set_sprite_frames(ActorsManager.sprite_frames[self.type])
	float_position = position
	route_points.resize(1000)

func find_path():
	if !world.pathfinder.initialized:
		return
	var path = world.pathfinder.find_path(position, destination)
	if !path:
		return
	route_points = path
	return true

	
func _process(delta: float):
	
	$AnimatedSprite.flip_h = velocity.x < 0

	if is_moving:
		$AnimatedSprite.play()
	else: 
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
		
	
	
	if !has_destination:	
		if randi() % 10 == 0:	
			self.destination = Vector2(randi() % 800, randi() % 500)
		return
	
	is_moving = true

	if position == destination:
		has_destination = false
		is_moving = false
		return
		
	if route_index > route_points.size() - 1:
		has_destination = false
		is_moving = false
		return

	next_point = route_points[route_index]

	if position == next_point:
		route_index += 1
		return

	velocity = (next_point - position).normalized()
	velocity *= delta * speed

	float_position += velocity.clamped((next_point - position).length())
		
	position.x = round(float_position.x)
	position.y = round(float_position.y)


	

	
#func _draw():
#	draw_rect(Rect2(destination - position, Vector2(16, 16)), Color(0.5, 0.5, 1.0, 0.2))




func _on_actor_area_entered(area):
	pass
	
