extends class_FindableObject

func _ready():
	_func_SetVisibility(true)

func _func_object_found():
	get_tree().quit()
