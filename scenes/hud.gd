extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var show_actor_panel : bool = false
var actor : Actor

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalsManager.connect("actor_selected", self, "_on_actor_selected")
	SignalsManager.connect("actor_deselected", self, "_on_actor_deselected")
	set_process(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("PanelContainer/VBoxContainer/Label_actors").text = "Actors: %s" % [ActorsManager.get_totals_actors()]
	get_node("PanelContainer/VBoxContainer/Label_fps").text = "FPS: %s" % str(Engine.get_frames_per_second())

	if show_actor_panel:
		$PlayerInfo.visible = true
		find_node("PlayerSprite").set_sprite_frames(ActorsManager.sprite_frames[self.actor.type])
		find_node("PlayerPosition").text = "Position: " + str(_World.world_to_map(self.actor.position))
		find_node("PlayerType").text = str(ActorsManager.types.keys()[self.actor.type]).to_lower().replace("_", " ")
		find_node("PlayerStatus").text = self.actor.get_status()	
	else:
		$PlayerInfo.visible = false
func _on_actor_selected(actor):
	show_actor_panel = true
	self.actor = actor

	
	
func _on_actor_deselected():
	show_actor_panel = false;
	self.actor = null


	

