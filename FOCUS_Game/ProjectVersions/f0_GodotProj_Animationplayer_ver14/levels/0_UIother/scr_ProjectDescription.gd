extends Node2D

export(String, FILE) var scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_dark")
	$TransitionTimer.start()



func _on_TransitionTimer_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene(scene)
