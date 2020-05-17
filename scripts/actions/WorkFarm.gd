class_name WorkFarmAction
 
extends Action

const FARM_DURATION : float = 1.0

var actor

func _to_string():
	match status:
		Status.IN_PROGRESS:
			return "working on farm for %d " % [self.time_spent]
		Status.COMPLETE:
			return "done working farm"

func _init(actor):
	time_complete = FARM_DURATION
	self.actor = actor
	actor.find_node("ProgressBar").value = 0
	actor.find_node("ProgressBar").show()
	
func _process(delta):
	actor.find_node("ProgressBar").value = time_spent / FARM_DURATION * 100
	#print(self.time_complete, " : " , time_spent)
	#print("Farm_action processed")	
	._process(delta)
	


func _on_complete():
	actor.find_node("ProgressBar").hide()
	#print("%s Farm action done, %s" % [self.time_complete, self.time_spent])
	._on_complete()
