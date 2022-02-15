extends Node2D


func _ready():
	hide()
	var handler_showplayer = get_tree().get_root().find_node("scn_testobject1", true, false)
	handler_showplayer.connect("sig_ShowPlayer", self, "func_HANDLE_ShowPlayer")

func func_HANDLE_ShowPlayer():
	print("Found me~ <3")
#	show()
#	$char_AnimationPlayer.play("char_sleep_fadein")
