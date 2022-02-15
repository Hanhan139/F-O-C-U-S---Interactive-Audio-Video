extends class_FindableObject
signal rain_found
func _ready():
	findable = false
#	$CollisionShape2D.set_disabled(true)

func _func_object_found():
	$sfx_discovered.play()
	$sfx2D_object.play()
	$AnimatedSprite.play("rain")
	emit_signal("rain_found")

func _on_Timer_timeout():
	pass

func _on_obj_ShelfClock_shelfclock_found():
	findable = true
