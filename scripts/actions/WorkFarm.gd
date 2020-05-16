class_name WorkFarmAction
 
extends Action

const FARM_DURATION : float = 3.0

func _to_string():
	match status:
		Status.IN_PROGRESS:
			return "working on farm for %d " % [self.time_spent]
		Status.COMPLETE:
			return "done working farm"

func _init():
	time_complete = FARM_DURATION
	
func _process(delta):	
	#print(self.time_complete, " : " , time_spent)
	#print("Farm_action processed")	
	._process(delta)
	


func _on_complete():
	#print("%s Farm action done, %s" % [self.time_complete, self.time_spent])
	print("le farm complete")
	._on_complete()
