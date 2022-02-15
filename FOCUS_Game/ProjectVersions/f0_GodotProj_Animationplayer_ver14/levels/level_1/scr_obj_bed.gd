extends Sprite

signal bed_appeared
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_obj_Rain_rain_found():
	$Timer.start()
	
func _on_Timer_timeout():
	$".".show()
	$AnimationPlayer.play("fade_in")

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("bed_appeared")
