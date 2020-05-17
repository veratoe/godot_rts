extends ViewportContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Viewport/Particles2D/Tween.interpolate_property($Viewport/Sprite,
	"modulate", Color(0.2, 0.2, 0.2, 1), Color(1, 1, 1, 1),  1.0, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	$Viewport/Particles2D/Tween.interpolate_property($Viewport/Sprite,
	"position", $Viewport/Sprite.position - Vector2(3, 0), $Viewport/Sprite.position + Vector2(3.0, 0.0),  1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Viewport/Particles2D/Tween.interpolate_property($Viewport/Sprite,
	"position", $Viewport/Sprite.position + Vector2(3, 0), $Viewport/Sprite.position - Vector2(3.0, 0.0),  1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1.0)
	
	
	$Viewport/Particles2D/Tween.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
