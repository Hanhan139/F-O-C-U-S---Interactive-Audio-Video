extends class_FindableObject

export(String, FILE) var scene
signal object_found

func _ready():
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
