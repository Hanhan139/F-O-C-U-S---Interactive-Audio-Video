extends class_FindableObject


func _func_on_player_entered(body):
	print("quit button found")
	if body.name == 'scn_player_anim' and seen == false:
		interactable = true
		print("signal sent")
		emit_signal("sig_ObjInteractable", true)
