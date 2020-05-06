extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Label_actors").text = "Actors: %s" % [ActorsManager.get_totals_actors()]
	get_node("Label_fps").text = "FPS: %s" % str(Engine.get_frames_per_second())




