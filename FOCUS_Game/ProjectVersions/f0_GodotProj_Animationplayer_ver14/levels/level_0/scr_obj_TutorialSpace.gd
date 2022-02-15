extends Node2D

var visibility = false 

signal tutorial_switch
signal tutorial_switch_back

func _on_I_Obj_Heart_body_entered(_body):
		$obj_blankspace/AnimationPlayer.play("fade_in")
		$space_text/AnimationPlayer.play("fade_in")
		emit_signal("tutorial_switch")
		
func _on_I_Obj_Heart_body_exited(_body):
		$obj_blankspace/AnimationPlayer.play("fade_out")
		$space_text/AnimationPlayer.play("fade_out")
		emit_signal("tutorial_switch_back")
