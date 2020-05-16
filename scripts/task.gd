# een Task bestaat uit een set actions

class_name Task
extends Reference

var actor
var action

func _init(actor):
	self.actor = actor

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

func set_action(action : Action):
	self.action = action
	
func _to_string():
	return "task"
	
