extends Node2D

export(String, FILE) var scene

onready var fade_to_black = get_node("TransitionScreenBlack/AnimationPlayer")
func _ready():
	_func_fade_in()



func _on_Timer_timeout():
	_func_fade_out()

func _func_fade_in():
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_transparent")
	
func _func_fade_out():
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_dark")
#	if fade_to_black.animation_finished("fade_to_black"):
#		print("plopp")
#		_func_change_scene()

			
func _func_change_scene():
# warning-ignore:return_value_discarded
	get_tree().change_scene(scene)


func _on_TransitionScreenBlack_transitioned():
	print("plopp")
	_func_change_scene()
