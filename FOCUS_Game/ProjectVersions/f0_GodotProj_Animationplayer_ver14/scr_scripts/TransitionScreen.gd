extends CanvasLayer

signal transitioned

#func _ready():
#	transition()
	
func transition():
	$AnimationPlayer.play("fade_to_black")
#	print("fading to black")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		emit_signal("transitioned")
		$AnimationPlayer.play("fade_to_normal")
#		print("fading to normal")
