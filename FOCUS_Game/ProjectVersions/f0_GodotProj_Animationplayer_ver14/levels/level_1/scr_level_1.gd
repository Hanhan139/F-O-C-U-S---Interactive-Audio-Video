extends Node2D

export(String, FILE) var changeScene

func _ready():
	$TransitionScreenBlack/AnimationPlayer.play("fade_from_creme")


func _on_obj_Rain_rain_found():
	$BlueCharacter/Timer.start()



func _on_Timer_timeout():
	$BlueCharacter/AnimationPlayer.play("fade_out")


func _on_BackToMenu_transition_to_scene():
	$TransitionTimer.start()



func _on_TransitionTimer_timeout():
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_creme")



func _on_obj_bed_bed_appeared():
	pass # Replace with function body.


func _on_obj_BackToMenu_object_found():
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_dark")
