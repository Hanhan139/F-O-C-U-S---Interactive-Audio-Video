extends Node2D
export(String, FILE) var scene
onready var timer = get_node("Timer")

func _ready():
	timer.start()
	get_tree().paused = true
	("paused")
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_transparent")
	$ColorRect.hide()
	$sfx_ambientLv00.play()

func _on_Timer_timeout():
	get_tree().paused = false
	print("timeout")

func _on_Timer_SceneChange_timeout():
	$background_character/AnimatedSprite.play("eye_opened")


func _on_background_character_animation_finished():
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_creme")

func _on_TransitionScreenBlack_transitioned():
# warning-ignore:return_value_discarded
	get_tree().change_scene(scene)

func _on_I_Obj_Heart_sig_PlayerVisibility():
	$Timer_SceneChange.start()
