extends class_FindableObject

signal shelfclock_found

func _ready():
	$ClockHand.hide()

func _func_object_found():
	emit_signal("shelfclock_found")
	print("Shelf found emitted")
	$sfx_discovered.play()
	$ClockHand.show()
	$ClockHand/AnimationPlayer.play("rotatin'_shrimp")
	object_animation.set_frame(0)
	object_animation.play("shelf")

func _on_Timer_timeout():
	$sfx2D_object.play()
	_func_start_timer()

func _on_obj_PC_pc_found():
	findable = true
