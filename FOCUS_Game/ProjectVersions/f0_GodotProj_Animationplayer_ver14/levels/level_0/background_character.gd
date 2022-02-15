extends Node2D
signal animation_finished
func _ready():
	pass # Replace with function body.


func _on_I_Obj_Heart_sig_PlayerVisibility():
	$Timer.start()


func _on_Timer_timeout():
	$AnimationPlayer.play("FadeIn")
	$AnimatedSprite.play("default")


func _on_AnimatedSprite_animation_finished():
	if ($AnimatedSprite.animation == "eye_opened"):
		emit_signal("animation_finished")
