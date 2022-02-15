extends Area2D

var in_field = false
signal popup_active

# warning-ignore:unused_argument
func _process(delta):
	if in_field == true:
		if Input.is_action_just_pressed("focus"):
			print("kacskaringós kacsafarok")
			emit_signal("popup_active")

# warning-ignore:unused_argument
func _on_InSceneMenu_body_entered(body):
	print("kacskaringós")
	in_field = true


# warning-ignore:unused_argument
func _on_InSceneMenu_body_exited(body):
	in_field = false
