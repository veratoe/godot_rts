extends Camera2D


# Declare member variables here. Examples:
var step : int = 50
# var b = "text"
var is_drag : bool = false

var zoomed_out : bool = false

var last_mouse_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():	
	position = Vector2(800, 300)
	last_mouse_position = get_local_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	pass

func _input(event):

	if Input.is_action_pressed("ui_camera_right"):
		position.x += step
	if Input.is_action_pressed("ui_camera_left"):
		position.x -= step
	if Input.is_action_pressed("ui_camera_down"):
		position.y += step
	if Input.is_action_pressed("ui_camera_up"):
		position.y -= step

			
	if event is InputEventMouseButton:		
		if event.button_index == BUTTON_WHEEL_DOWN and !$Tween.is_active() and !zoomed_out:		#			
			$Tween.interpolate_property(self, "zoom", null, Vector2(2, 2), .5, Tween.TRANS_CUBIC, Tween.EASE_OUT)						
			$Tween.interpolate_property(self, "position", null, get_position() - 0.5 * get_viewport().get_size(), .5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			$Tween.start()
			zoomed_out = true
			
		if event.button_index == BUTTON_WHEEL_UP and !$Tween.is_active() and zoomed_out:									
			$Tween.interpolate_property(self, "zoom", null, Vector2(1, 1), .5, Tween.TRANS_CUBIC, Tween.EASE_OUT)			
			$Tween.interpolate_property(self, "position", null, get_position() + 0.5 * get_viewport().get_size(), .5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
			$Tween.start()
			zoomed_out = false
			
		if event.pressed and event.button_index == BUTTON_RIGHT:
			is_drag = true
			last_mouse_position = get_global_mouse_position()
		else:
			is_drag = false

	if event is InputEventMouseMotion:
		if is_drag:			
			position -= get_global_mouse_position() - last_mouse_position
			
	
#	
#	print(get_local_mouse_position())
#	print(get_position())
#
	position.x = clamp(position.x, 0, 1000)
	position.y = clamp(position.y, 0, 1000)
