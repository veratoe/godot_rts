extends Area2D

export var speed = 40
# Called when the node enters the scene tree for the first time.
var destination: Vector2 setget set_destination

onready var world = get_tree().get_root().get_node("root/world")

var has_destination : bool = false
var is_moving : bool = false

var route_points : PoolVector2Array # world coordinates

var velocity : Vector2
var float_position : Vector2

func set_destination(value: Vector2):
	# mooi afronden van de getallekes
	destination = world.map_to_world(world.world_to_map(value))
	find_path()

func _ready():
	set_process(true)
	position = Vector2(320, 160)
	float_position = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_destination:		
		move(delta)
		
	$AnimatedSprite.flip_h = velocity.x < 0
		
	if is_moving:
		pass
		$AnimatedSprite.play()
	else: 
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
		
	update()

func find_path():
	route_points = world.find_path(position, destination)
	
func move(delta: float):
	var point: Vector2
	
	is_moving = true
	
	if position == destination:
		has_destination = false
		is_moving = false
		return
	
	if route_points.size() > 1:	
		point = route_points[1]
		if position == point:
			route_points.remove(1)
			point = route_points[1]
					
	elif route_points.size() > 0:
		point = destination
	else:
		print("no route")
		is_moving = false
		has_destination = false
		return
	
	
	var weight = world.get_weight(position)

	velocity = (point - position).normalized()
	velocity *= delta * speed / weight
		
	float_position += velocity.clamped((point - position).length())
	position.x = round(float_position.x)
	position.y = round(float_position.y)
	

	
func _draw():
	draw_rect(Rect2(destination - position, Vector2(16, 16)), Color(0.5, 0.5, 1.0, 0.2))
	
	for point in route_points:
		draw_rect(Rect2(point - position, Vector2(16, 16)), Color(1.0, 0.0, 0.0, 0.2))
	pass

func _unhandled_input(event):
	if event is InputEventKey:
		pass
	else:
		if Input.is_action_pressed("ui_click_left"):
			has_destination = true
			self.destination = get_global_mouse_position()
			
# doet niks??
func _on_Area2D_area_entered():
	print('wubbels')
	pass # Replace with function body.
