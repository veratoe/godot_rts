extends Node2D

export(float) var tooltip_timeout_threshold : float = 0.3

onready var parent = get_parent()

onready var tooltip = get_node("tooltip/PanelContainer")


var tooltip_timeout : float
var actor
var is_mouse_over_actor : float

func set_tooltip(text: String):
	tooltip.get_node("Label").text = text

#func _on_actor_mouse_enter(actor):
#	self.actor = actor
#	is_mouse_over_actor = true
#
#func _on_actor_mouse_exit(actor):
#	self.actor = null
#	is_mouse_over_actor = false

func _ready():
	set_process(true)


func _process(delta: float):
	var tile = _World.world_to_map(
		get_global_mouse_position()
	)
	
#	pathfinder.buildings.get_cellv(tile)
#	if is_mouse_over_actor:
#		set_tooltip(str(actor.task))
#	else:
	tooltip.get_node("Label").text = "%s, %s" % [
		tile, _World.buildings.get_cellv(tile)
	]
	
	tooltip_timeout += delta
	if tooltip_timeout > tooltip_timeout_threshold:
		tooltip.visible = true
	else:
		tooltip.visible = false
	update()
	
func _input(event):
	if event is InputEventMouseMotion:
		tooltip_timeout = 0.0
		tooltip.visible = false

func _draw():
	draw_rect(Rect2(parent.map_to_world(parent.world_to_map(get_global_mouse_position())), Vector2(16, 16)), Color(1.0, 1.0, 1.0, 0.3), false)
	tooltip.set_position(Vector2( 
		round(get_local_mouse_position().x + 16), 
		round(get_local_mouse_position().y - 8)))
	

	#SignalsManager.emit_signal("actor_deselected", self)

#	for tile in _World.buildings.get_used_cells_by_id(28):
#		draw_rect(Rect2(_World.map_to_world(tile), Vector2(16, 16)), Color(0, 255, 0, 0.2), true)
#
#	for tile in  _World.buildings.get_used_cells_by_id(29):
#		draw_rect(Rect2(_World.map_to_world(tile), Vector2(16, 16)), Color(255, 0 , 0, 0.2), true)
#
#	for tile in  _World.buildings.get_used_cells_by_id(30):
#		draw_rect(Rect2(_World.map_to_world(tile), Vector2(16, 16)), Color(0, 0, 255, 0.2), true)
	pass
	#for x in range(size.x):
	#	draw_line(Vector2(x * 16, 0), Vector2(x * 16, size.y * 16), Color(1.0, 1.0, 1.0, 0.1))
	#for y in range(size.y):
	#	draw_line(Vector2(0, y * 16), Vector2(size.x * 16, y * 16), Color(1.0, 1.0, 1.0, 0.1))
