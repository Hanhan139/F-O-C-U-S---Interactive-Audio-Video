extends class_FindableObject

signal clock_found

func _ready():
	$ClockHand.hide()
	
func _func_object_found():
	$ClockHand.show()
	$ClockHand/AnimationPlayer.play("rotatin'_shrimp")
	emit_signal("clock_found")
	print("clock found emitted")
	$sfx_discovered.play()

func _on_Timer_timeout():
	object_animation.set_frame(0)
	object_animation.play("wolf_clock")
	$sfx2D_object.play()
	_func_start_timer()


func _on_obj_Clock_body_entered(_body):
	pass
#	print("potato")
