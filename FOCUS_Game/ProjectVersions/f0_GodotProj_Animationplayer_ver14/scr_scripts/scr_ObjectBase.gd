extends Area2D
class_name class_FindableObject

#const Player = preload("res://scn_scenes/scn_player_animated.tscn")
export(String, FILE) var default_noise
export var distorted_noise_player_active = false

onready var object_animation = get_node("AnimatedSprite")
onready var object_noise = get_node("sfx2D_object")
onready var animation_timer = get_node("Timer")
onready var target_position1 = get_node(".").position
onready var player = get_node("../scn_player_anim")

var animation_active = false
var audio_active = false
var seen = false
var distorted_played = false
export var findable = false
var interactable = false
#var default_noise = preload("res://spr_sprites/f0_debugPlaceholders/sfx_test01.wav")
var manual_timer = 0

#-----distance measurement variables ------
var dist_nrml = 0
var arr_pos = [0,0]
var arr_pos_done = [1,3]

signal sig_position
signal sig_ObjInteractable
signal sig_PlayerVisibility

#---------------- DELTA AND READY -----------------
func _ready():
# warning-ignore:return_value_discarded
	connect("body_entered", self, '_func_on_player_entered')
# warning-ignore:return_value_discarded
	connect("body_exited", self, '_func_on_player_exited')
	

func _process(_delta):
	object_animation.visible = animation_active
	object_noise = audio_active
#distance detection part
	if findable:
		_func_determinePlayerPosition()
		$CollisionShape2D.set_disabled(false)
		_func_determineDistance()
		if (arr_pos[0] != arr_pos[1]):
#			print("AAA")
			_func_send_signal()
	if !findable:
		$CollisionShape2D.set_disabled(true)
#	if (arr_pos[0] != arr_pos[1]):
#		print("AAA")
#		_func_send_signal()

#---------------- FUNCTIONS --------------------
#Player entering/exiting
func _func_on_player_entered(body):
#	print("player_entered")
	if body.name == 'scn_player_anim' and seen == false and findable:
		interactable = true
#		print("signal sent")
		emit_signal("sig_ObjInteractable", true)

func _func_on_player_exited(_body):
	interactable = false
#TEST BLACKED OU
	emit_signal("sig_ObjInteractable", false)
#	print("exited")

#Player input event
func _unhandled_input(event):
	if seen == false && interactable == true:
		if event is InputEventKey:
			if Input.is_action_pressed("focus"):
				manual_timer += 1
#				print("manual_timer", manual_timer)
				if manual_timer >= 40:
					interactable = false
					animation_active = true
					seen = true
					$CollisionShape2D.set_disabled(true)
					_func_SetFindability(false)
					_func_start_timer()
					_func_object_found()
					emit_signal("sig_ObjInteractable", false)
					emit_signal("sig_position", arr_pos_done)
					$TransitionScreen.transition()

func _func_SetFindability(x):
	findable = x
	print("Findability is currently set ", findable)
	
	
func _func_SetVisibility(y):
	animation_active = y

func _func_start_timer():
	animation_timer.start()
	
func _func_change_player_visibility():
	emit_signal("sig_PlayerVisibility")

func _func_play_distorted_sound():
	$sfx2D_distorted.play()
# --- Empty functions to be filled in children if needed
#Called once after uncovering the object in input event
func _func_object_found():
	pass

func _func_signal_received():
	pass

func _func_signal_sent():
	pass

# --- Signals received ---
#Signals by self
func _on_Timer_timeout():
	object_animation.set_frame(0)
	object_animation.play("default")
	$sfx2D_object.play()
	_func_start_timer()


#--- Distance detection functions ----
#Sends the players distance to this object to the player
func _func_send_signal():
#	print(" messed ")
	emit_signal("sig_position", arr_pos)

func _func_determineDistance():
	var player_position = player.global_transform.origin
	var distance = player_position.distance_to(target_position1)
	dist_nrml = int(distance/30)
#	print("what was this again", dist_nrml)

func _func_determinePlayerPosition():
	var pos_new = 0
	match dist_nrml:
		10, 11, 12, 13, 14: 
			pos_new = 0
			distorted_played = false
		9, 8, 7, 6, 5, 4, 3, 2, 1: 
			pos_new = 1
			if (distorted_noise_player_active && !distorted_played):
				_func_play_distorted_sound()
				distorted_played = true
		0: 
			pos_new = 2
			distorted_played = false
	_func_savePosition(pos_new)

func _func_savePosition (pos_current):
	arr_pos[0] = arr_pos[1]
	arr_pos[1] = pos_current



