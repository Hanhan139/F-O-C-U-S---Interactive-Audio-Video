extends Node2D

func _ready():
	$".".hide()

func _on_obj_Rain_rain_found():
	print("PINEAPPLE")
	$Timer.start()
	
func _on_Timer_timeout():
	$".".show()
	print("PLOPPPPP")
	$AnimationPlayer.play("fade_in")
