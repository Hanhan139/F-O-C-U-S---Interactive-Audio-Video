extends class_FindableObject


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Timer_timeout():
	object_animation.set_frame(0)
	object_animation.play("rain")
