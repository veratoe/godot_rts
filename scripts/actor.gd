extends Area2D

export var speed = 50
export var destination = PoolVector2Array()
# Called when the node enters the scene tree for the first time.

var has_destination : bool = false
var is_moving : bool = false
var route_points : Array

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_destination:
		find_path(destination)
		move(delta)
		
	if is_moving:
		$player2/AnimatedSprite.play()
	else: 
		$player2/AnimatedSprite.stop()
		$player2/AnimatedSprite.frame = 0

func find_path(destination: Vector2):
	route_points = get_tree().get_root().get_node("root/Navigator").get_simple_path(position, destination, false)

func move(delta: float):
	is_moving = true
	if route_points.size() <= 1:
		print("klaars")
		is_moving = false
		has_destination = false
		return
		
	var point = route_points[1]
	print()
	
	var v = (point - position).normalized()
	v *= delta * speed 
	
	position += v.clamped((point - position).length())
	
	if position == destination:
		has_destination = false
		is_moving = false
	
func _draw():
	# if there are points to draw
	if route_points.size() > 1:
		for p in route_points:
			draw_circle(p - get_global_position(), 8, Color(1, 0, 0)) # we draw a circle (convert to global position first)

func _unhandled_input(event):
	if event is InputEventKey:
		pass
	else:
		if Input.is_action_pressed("ui_click_left"):
			print(event.position)
			has_destination = true
			destination = Vector2(event.position)
