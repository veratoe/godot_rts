class_name FlashIcon
extends AnimatedSprite

enum types {
	APPLE = 16
}

var icon_frames = preload("res://sprite_sheets/flash_icons.tres")
var tween : Tween

var type

var audio_player : AudioStreamPlayer2D
var pop_sound = preload("res://sounds/pop.wav")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _init(type, position: Vector2):
	audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)
	frames = icon_frames
	scale = Vector2(0.1, 0.1)
	self.position = position
	centered = false
	
	set_frame(5)
	
	
	
	#set_process(true)

func _draw():
	pass
	#draw_rect(Rect2(position, Vector2(10, 10)), Color(0, 0, 0))
		

# Called when the node enters the scene tree for the first time.
func _ready():
	
	audio_player.set_stream(pop_sound)
	audio_player.play(0)
	
	#self.position = position
#	sprite.show()
#	sprite.play()

	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self, "position", position + Vector2(0, -16), position + Vector2(0, -32), 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.interpolate_property(self, "modulate", Color(100, 100, 100, 1), Color(1, 1, 1, 1), 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.05, Tween.TRANS_LINEAR,  Tween.EASE_OUT, 2.0)
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.05, Tween.TRANS_LINEAR,  Tween.EASE_OUT, 2.05)
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.05, Tween.TRANS_LINEAR,  Tween.EASE_OUT, 2.1)
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.05, Tween.TRANS_LINEAR,  Tween.EASE_OUT, 2.15)
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.05, Tween.TRANS_LINEAR,  Tween.EASE_OUT, 2.2)
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.05, Tween.TRANS_LINEAR,  Tween.EASE_OUT, 2.25)
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.05, Tween.TRANS_LINEAR,  Tween.EASE_OUT, 2.3)
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.05, Tween.TRANS_LINEAR,  Tween.EASE_OUT, 2.35)
	
	tween.connect("tween_all_completed", self, "queue_free")
	tween.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
