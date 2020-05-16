class_name FarmTask
extends Task

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# weird!
func _init(actor).(actor):
	pass

var farm_position : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):		
	if self.action == null:
		self.set_action( FindFarmAction.new(_World.world_to_map(actor.position), 5) )		
		self.action.connect("farm_found", self, "_on_farm_found")
		
	self.action._process(delta)

func _on_farm_found(farm_position : Vector2):
	self.set_action(MoveAction.new(actor, farm_position));
	self.farm_position = farm_position
	self.action.connect("arrived", self, "_on_arrived_at_farm")

func _on_arrived_at_farm():
	self.set_action(WorkFarmAction.new(actor))
	self.action.connect("action_completed", self, "_on_work_farm_completed")
	
func _on_work_farm_completed():
	SignalsManager.emit_signal("actor_work_farm_completed", farm_position)
	self.action = null

func _to_string():
	return "Farming; " + self.action.to_string() if self.action != null else ""
