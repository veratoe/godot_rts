extends Area2D

export var speed = 40
export var destination = PoolVector2Array()
# Called when the node enters the scene tree for the first time.

var has_destination : bool = false
var is_moving : bool = false
var route_points : Array
var velocity : Vector2
var float_position : Vector2

func _ready():
	position = Vector2(32, 32)
	float_position = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_destination:
		find_path(destination)
		move(delta)
		
	$player2/AnimatedSprite.flip_h = velocity.x < 0
		
	if is_moving:
		$player2/AnimatedSprite.play()
	else: 
		$player2/AnimatedSprite.stop()
		$player2/AnimatedSprite.frame = 0

func find_path(destination: Vector2):
	route_points = get_tree().get_root().get_node("root/world").find_path(position, destination)
	
func move(delta: float):
	is_moving = true
	if route_points.size() <= 1:
		print("klaars")
		is_moving = false
		has_destination = false
		return
		
	var point = route_points[1]
	print()
	
	var weight = get_tree().get_root().get_node("root/world").get_weight(position)


	velocity = (point - position).normalized()
	velocity *= delta * speed / weight
	
	
	float_position += velocity.clamped((point - position).length())
	position.x = round(float_position.x)
	position.y = round(float_position.y)
	
	if position == destination:
		has_destination = false
		is_moving = false
	
func _draw():
	pass

func _unhandled_input(event):
	if event is InputEventKey:
		pass
	else:
		if Input.is_action_pressed("ui_click_left"):
			print(event.position)
			has_destination = true
			destination = Vector2(round(event.position.x), round(event.position.y))
			
# doet niks??
func _on_Area2D_area_entered(area):
	print('wubbels')
	pass # Replace with function body.
