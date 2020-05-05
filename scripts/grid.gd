extends Node2D

onready var size = get_parent().size

func _draw():
	pass
	#for x in range(size.x):
	#	draw_line(Vector2(x * 16, 0), Vector2(x * 16, size.y * 16), Color(1.0, 1.0, 1.0, 0.1))
	#for y in range(size.y):
	#	draw_line(Vector2(0, y * 16), Vector2(size.x * 16, y * 16), Color(1.0, 1.0, 1.0, 0.1))
