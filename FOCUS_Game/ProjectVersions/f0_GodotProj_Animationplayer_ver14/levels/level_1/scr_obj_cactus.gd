extends Area2D

var cacti_squishable = false
var cacti_findable = false

# warning-ignore:unused_argument
func _process(delta):
	if cacti_findable:
		if Input.is_action_pressed("focus") && cacti_squishable:
			cacti_squishable = false
			$obj_cactus.set_frame(0)
			$obj_cactus.play()
			$sfx_cactus.play()
			$Timer.start()

func _ready():
	$".".hide()
# warning-ignore:return_value_discarded
	connect("body_entered", self, '_func_on_player_entered')
# warning-ignore:return_value_discarded
	connect("body_exited", self, '_func_on_player_exited')

func _on_obj_ShelfClock_shelfclock_found():
	$".".show()
	cacti_findable = true

# warning-ignore:unused_argument
func _func_on_player_entered(body):
	cacti_squishable = true
# warning-ignore:unused_argument
func _func_on_player_exited(body):
	cacti_squishable = false

func _on_Timer_timeout():
	cacti_squishable = true
