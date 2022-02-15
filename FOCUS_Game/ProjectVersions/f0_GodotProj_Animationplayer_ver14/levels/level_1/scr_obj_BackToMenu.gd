#extends "res://levels/0_mainmenu/scrI_Obj_CreditsButton.gd"
extends class_FindableObject
export(String, FILE) var scene
#signal object_found

func _ready():
	findable = true
	$".".hide()
	_func_SetVisibility(true)
	$CollisionShape2D.set_disabled(true)
	
	if not scene:
		scene = owner.changeScene

func _func_object_found():
	emit_signal("object_found")
	$TransitionTimer.start()
	$sfx_discovered.play()

func _on_TransitionTimer_timeout():
	get_tree().change_scene(scene)

func _on_obj_bed_bed_appeared():
	$".".show()
	$AnimationPlayer.play("fade_in")
	findable = true
