class_name MoveAction 
extends Action

# alle signals globaal of niet?
signal arrived

var destination : Vector2
var actor

func _process(delta):
	if actor.position == actor.destination:
		_on_complete()

func _init(actor, destination : Vector2):
	# 
	self.actor = actor
	actor.set_map_destination(destination)
	pass	

func _to_string():
	return "Moving to " + str(actor.get_map_destination())

func _on_complete():
	emit_signal("arrived")
	._on_complete()
