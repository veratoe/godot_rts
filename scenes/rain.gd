extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self,
	"modulate", Color(0.2, 0.2, 0.2, 1), Color(1, 1, 1, 1),  1.0, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self,
	"position", self.position - Vector2(3, 0), self.position + Vector2(3.0, 0.0),  1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self,
	"position", self.position + Vector2(3, 0), self.position - Vector2(3.0, 0.0),  1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1.0)
	
	
	$Tween.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
