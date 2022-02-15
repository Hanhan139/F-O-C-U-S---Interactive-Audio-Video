extends "res://scr_scripts/TransitionScreen.gd"

signal transparent

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_dark":
		emit_signal("transitioned")
#		$AnimationPlayer.play("fade_to_transparent")
#		print("fading to normal")
		
	if anim_name == "fade_to_creme":
		emit_signal("transitioned")
#		$AnimationPlayer.play("fade_to_transparent")
#		print("fading to normal")
#		emit_signal("transparent")
	
	if anim_name == "fade_from_creme":
		emit_signal("transparent")
	
	if anim_name == "from_creme_to_ded_transparent":
		emit_signal("transitioned")
