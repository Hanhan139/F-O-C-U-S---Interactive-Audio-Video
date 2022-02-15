extends AnimatedSprite



func _on_obj_TutorialSpace_tutorial_switch():
	$AnimationPlayer.play("fade_out")



func _on_obj_TutorialSpace_tutorial_switch_back():
	$AnimationPlayer.play("fade_in")


func _on_I_Obj_Heart_arrows():
	$".".hide()
