extends Node2D

func _create_world():
	
	return preload("res://scenes/world.tscn")

func _create_actors():
	return preload("res://scenes/actors.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var world = _create_world()
	add_child(world.instance())
	var actors = _create_actors()
	add_child(actors.instance())
	pass # Replace with function body.

func _process(delta):	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


