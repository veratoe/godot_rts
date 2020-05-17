extends ViewportContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Viewport/Particles2D.emitting = true
	pass # Replace with function body.

func _input(ev):
	if ev is InputEventMouseButton:
		$Viewport/Particles2D.restart()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
