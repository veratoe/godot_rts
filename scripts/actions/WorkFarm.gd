class WorkFarmAction extends Action:

	const FARM_DURATION : float = 2.0
	
	func _init():
		time_complete = FARM_DURATION
		
	func _process(delta):	
		#print(self.time_complete, " : " , time_spent)
		#print("Farm_action processed")	
		._process(delta)
		
	
	
	func on_complete():
		print("%s Farm action done, %s" % [self.time_complete, self.time_spent])
		.on_complete()
