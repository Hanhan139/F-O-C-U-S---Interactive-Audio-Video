extends Popup
signal popup_deactivate

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	$MarginContainer/VBoxContainer2/VBoxContainer/scn_player_anim.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_I_Obj_GameButton_body_entered(body):
	if Input.is_action_just_pressed("focus"):
		emit_signal("popup_deactivate")
