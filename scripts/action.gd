class_name Action extends Reference

var time_spent : float = 0
var time_complete : float 

enum Status {
	IN_PROGRESS,
	IMPOSSIBLE,
	COMPLETE
}

# waarom kan dit geen type Status zijn?
var status : int

# _init  KAN NIET OVERGEERFD WORDEN!
func _construct():
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
			self.on_complete()
		
		
# deze hoeven wellicht niet uitgeschreven, maar 1 globale status change handler?
		
func on_complete():	
	self.status = Status.COMPLETE
	pass
	
func on_impossible():	
	self.status = Status.IMPOSSIBLE
	pass
		




