extends Camera2D


# Declare member variables here. Examples:
var step : int = 100
# var b = "text"
var is_drag : bool = false

var last_mouse_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	last_mouse_position = get_local_mouse_position()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	
	self.smoothing_enabled = true
	
	if Input.is_action_pressed("ui_camera_right"):
		position.x += step
	if Input.is_action_pressed("ui_camera_left"):
		position.x -= step
	if Input.is_action_pressed("ui_camera_down"):
		position.y += step
	if Input.is_action_pressed("ui_camera_up"):
		position.y -= step
		
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_RIGHT:
			is_drag = true
			last_mouse_position = get_global_mouse_position()
		else:
			is_drag = false
		
	if event is InputEventMouseMotion:
		if is_drag:
			self.smoothing_enabled = false
			position -= get_global_mouse_position() - last_mouse_position
			
	
	position.x = clamp(position.x, 0, 1000)
	position.y = clamp(position.y, 0, 1000)
