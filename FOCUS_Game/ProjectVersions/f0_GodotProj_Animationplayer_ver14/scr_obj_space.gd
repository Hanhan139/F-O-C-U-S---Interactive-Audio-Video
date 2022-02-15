extends AnimatedSprite

onready var space = get_node(".")

# warning-ignore:unused_argument
func _unhandled_input(event):
	if Input.is_action_pressed("focus"):
		space.play("space")
	if Input.is_action_just_released("focus"):
		space.play("space_up")
