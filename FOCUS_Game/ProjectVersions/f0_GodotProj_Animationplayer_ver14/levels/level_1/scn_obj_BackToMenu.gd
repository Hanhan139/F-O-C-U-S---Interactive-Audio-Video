extends class_FindableObject
export(String, FILE) var scene

signal object_found

func _ready():
	$".".hide()
	_func_SetVisibility(true)
	if not scene:
		scene = owner.changeScene

func _func_object_found():
	emit_signal("object_found")
	$TransitionTimer.start()
	$sfx_discovered.play()

func _on_TransitionTimer_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene(scene)

#
func _on_obj_bed_bed_appeared():
	$AnimationPlayer.play("fade_in")
	$".".show()
	findable = true
