extends Node2D

func _create_world():
	return preload("res://scenes/world.tscn")

func _create_actors():
	for i in 200:
		ActorsManager.create_actor()	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

	var world = _create_world()
	add_child(world.instance())
	
	_create_actors()

	pass # Replace with function body.

func _process(delta):	

	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


