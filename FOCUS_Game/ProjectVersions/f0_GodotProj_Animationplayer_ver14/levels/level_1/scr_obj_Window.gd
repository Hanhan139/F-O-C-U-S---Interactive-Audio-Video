extends class_FindableObject

signal window_found

func _func_object_found():
	emit_signal("window_found")
	print("window found emitted")
	$sfx_discovered.play()
	$sfx2D_window.play() #needs to be here cuz one looping sound

func _on_Timer_timeout():
	object_animation.set_frame(0)
	object_animation.play("window")

func _on_obj_Clock_clock_found():
	findable = true
