extends "res://levels/level_0/scr_cutscene_1.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _func_fade_in():
	$TransitionScreenBlack/AnimationPlayer.play("fade_from_creme")
	
func _func_fade_out():
	$TransitionScreenBlack/AnimationPlayer.play("from_creme_to_ded_transparent")


#
#func _on_TransitionScreenBlack_transparent():
#	pass
##	_func_change_scene()
##	$TransitionScreenBlack/AnimationPlayer.play("from_creme_to_ded_transparent")
