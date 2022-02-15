extends Node2D
var paused = false
#Any object that changes the scene will look for this cariable, changeScene, in the level they are in
export(String, FILE) var changeScene

func _ready():
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_transparent")
	$Timer.start()
	
# warning-ignore:unused_argument
func _process(delta):
	pass


func _on_I_Obj_GameButton_object_found():
#	get_tree().get_node("scn_player").set_process(false)
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_dark")

#
#func _on_I_Obj_CreditsButton_object_found():
#	$TransitionScreenBlack/AnimationPlayer.play("fade_to_dark")


func _on_I_Obj_CreditsButton_object_found_credits():
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_dark")


#func _on_Timer_timeout():
#	$TransitionScreenBlack/AnimationPlayer.play("fade_to_transparent")
