extends class_FindableObject

signal pc_found

func _func_object_found():
	emit_signal("pc_found")
	print("PC found emitted")
	$sfx_discovered.play()
	$sfx2D_PCbgHumming.play()

func _on_Timer_timeout():
	object_animation.set_frame(0)
	object_animation.play("pc")
	#PLAY RANDOMISED SOUND HOW?
	$sfx2D_object.play()
	_func_start_timer()

func _on_obj_Window_window_found():
	findable = true

