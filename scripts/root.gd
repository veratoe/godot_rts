extends Node2D

func _create_world():
	return preload("res://scenes/world.tscn")

func _create_actors():
#	while !ActorsManager.create_actor():
#		ActorsManager.create_actor()
		
	ActorsManager.create_actor(_World.map_to_world(Vector2(54, 13)))

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

	_create_actors()

	pass # Replace with function body.

func _process(delta):	

	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


