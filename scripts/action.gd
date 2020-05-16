class_name Action extends Reference

var time_spent : float = 0
var time_complete : float 

signal action_completed
signal action_impossible

enum Status {
	IN_PROGRESS,
	IMPOSSIBLE,
	COMPLETE
}

# waarom kan dit geen type Status zijn?
var status : int

func _init():
	status = Status.IN_PROGRESS
	pass

# wordt niet automatisch aangeroepen, moet door owner van deze action worden
# afgetrapt
# @TODO een manager voor maken?

func _process(delta : float):	
	if self.status == Status.COMPLETE:
		return
	
	if self.status == Status.IN_PROGRESS:
		self.time_spent += delta
	
		if self.time_complete != null and self.time_spent >= self.time_complete:
			self._on_complete()
		
		
# deze hoeven wellicht niet uitgeschreven, maar 1 globale status change handler?
		
func _on_complete():	
	emit_signal("action_completed")
	self.status = Status.COMPLETE
	pass
	
func _on_impossible():	
	self.status = Status.IMPOSSIBLE
	pass
		




