extends KinematicBody2D
class_name class_player

onready var int_anim = get_node("Interaction_control2")
#very reasonable and respectable vars of movement
const speed_default = 500
const var_acceleration = 139
const var_friction = 50
var var_speed = speed_default
var velocity = Vector2.ZERO
#more questionable vars of reactions and interactions
var detect = false
var interactable = false
var anim_version = 0
var reversability = true
var manual_timer = 0
var allow_movement = true

#---player position evaluation variables
onready var arr_pos_default = [0,0]
onready var arr_pos = arr_pos_default
#---array saving the different animations, player_anim.play("animP_0_blink")
var arr_player_anim = ["animP_0_blink", "animP_2_detect1", "animP_2_detect2", "animP_4_interact", "animP_5_fadedot", "animP_1_open", "animP_6_close"]
#0 blink, 1 detect1, 2 detect2, 3 interact, 4 fadedot, 5 openeye, 6 closeeye


#--- GENERAL FUNCTIONS ---- #. ⋅ ˚̣- : ✧ : – ⭒ ⊹ ⭒ – : ✧ : -˚̣⋅ . ⋅ ˚̣- : ✧ : – ⭒ ⊹ ⭒ – : ✧ : -˚̣⋅ .
# --- READY AND DELTA ---

func _ready():
	$particle.emitting = false
	$Particles_Focus/Particles2D.emitting = false
	var sigRec_ObjInteractable = get_tree().get_root().find_node("ObjectBase", true, false)
	sigRec_ObjInteractable.connect("sig_ObjInteractable", self, "_on_ObjectBase_sig_ObjInteractable")
	var sigRec_ObjPosition = get_tree().get_root().find_node("ObjectBase", true, false)
	sigRec_ObjPosition.connect("sig_ObjPosition", self, "_on_ObjectBase_sig_position")
	_func_player_matchAnimation(0)

func _process(delta):
	#Player movement from a tutorial, slightly questionable
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("key_right") - Input.get_action_strength("key_left")
	input_vector.y = Input.get_action_strength("key_down") - Input.get_action_strength("key_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity += input_vector * var_acceleration * delta
		velocity = velocity.clamped(var_speed * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, var_friction * delta)
# warning-ignore:return_value_discarded
	move_and_collide(velocity)
	_func_playerInteraction()
	if Input.is_action_just_released("focus"):
		if allow_movement: var_speed = speed_default

# --- Other functions ---
func _on_InSceneMenu_sig_ObjInteractable(p1):
	interactable = p1

# - Player interaction
func _func_playerInteraction():
	if Input.is_action_pressed("focus") and interactable == true:
		int_anim.play("animP_4_interact", false)
		manual_timer += 1
		reversability = true
		var_speed = 0
		_func_InteractionControl()
		# maybe for short space?
	if Input.is_action_just_pressed("focus") and interactable == true:
		int_anim.play("animP_4_interact", false)
		reversability = false
		var_speed = 0
		# - - - - - - - - - - - 
	if Input.is_action_just_released("focus") and reversability == true and interactable == true:
		if manual_timer >= 5:
			int_anim.play("animP_4_interact", true)
			reversability = false
			manual_timer = 0
			if allow_movement: var_speed = speed_default

#--------------------------------- PLAYER ANIMATION ----------------------------
# - Animation Match
func _func_handle_animation():
	print("function_handle_animation")
	if interactable: return
	_func_player_matchAnimation(0)
	interactable = false

func _func_player_matchAnimation(x):
	if interactable:
		x = 2 #we do this to force it to go to state 2 if interactable, regardless to the distance
	match x:
		0:
			$particle.emitting = false
			int_anim.play(arr_player_anim[0])
#			print("Play 0")
			if (arr_pos[0] > arr_pos[1]):
#				print("Play 1 reversed")
				int_anim.play(arr_player_anim[1], true)
				arr_pos[0] = arr_pos[1]
		1:
			$particle.emitting = false
			$Particles_Focus/Particles2D.emitting = false
			if (arr_pos[0] > arr_pos[1]):
#				print("Play 2 reversed")
				int_anim.play(arr_player_anim[2], true)
			elif (arr_pos[0] < arr_pos[1]):
#				print("Play 1")
				int_anim.play(arr_player_anim[1], false)
		2:
				$particle.emitting = true
				int_anim.play(arr_player_anim[2], false)
		3:
			int_anim.play(arr_player_anim[4])
			$Particles_Focus/Particles2D.emitting = false

func _on_Interaction_control2_animation_finished():
	if ($Interaction_control2.animation == arr_player_anim[3]):
#		print("interaction control - animation something something MY MULE")
		$Timer_PostFocus.start()

# - Manual Position evaluation with distance
func func_handleDistance(arr_pos_received):
	arr_pos = arr_pos_received
	anim_version = arr_pos[1]
	_func_player_matchAnimation(anim_version)
	reversability = true
	
func _func_Interactable(p1):
	interactable = p1
	if !interactable:
		int_anim.play(arr_player_anim[2], true)

# --------------------- CODE GRAVEYARD ----------------☆ ～('▽^人) 
	#reversability is basically about if the player has done the interaction or not. If not, the animation is reversable. If it did, the animation doesnt get reversed on releasing space. Seriously, nevermind this. I'm swimming against a current. With rabid racoons tryin to bite off my toes

# --- Signal handling ---
# - Inside/Child signals:
func _func_InteractionControl():
	pass
	if manual_timer >= 40:
		var frame = $Interaction_control2.frame
		if frame == 8:
			$Particles_Focus/Particles2D.emitting = true
			$particle.emitting = false
			if Input.is_action_just_released("focus"):
				int_anim.stop()
				_func_handle_animation()
		elif frame == 7:
			$Particles_Focus/Particles2D.emitting = false

# - Outside/SomwhereInTheSceneTree signals:
func _on_ObjectBase_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)

func _on_ObjectBase_sig_ObjInteractable(p1):
	interactable = p1
	$particle.emitting = true

#--- Signals connected by objects ~ヾ(・ω・)

func _on_ObjectBase2_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)

func _on_ObjectBase3_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)

func _on_ObjectBase4_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)

func _on_I_Obj_Heart_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)

func _on_obj_Clock_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)
	
func _on_obj_ShelfClock_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)
	
func _on_obj_Window_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)
	
func _on_obj_PC_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)

func _on_obj_Rain_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)
func _on_obj_Raining_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)

func _on_ObjectBase2_sig_ObjInteractable(p1):
	_func_Interactable(p1)

func _on_ObjectBase4_sig_ObjInteractable(p1):
	_func_Interactable(p1)

func _on_ObjectBase3_sig_ObjInteractable(p1):
	_func_Interactable(p1)

func _on_I_Obj_Heart_sig_ObjInteractable(p1):
	_func_Interactable(p1)
		# THE PROBLEM IS HEREEEEEEEEEEE ARGHHHH
		
func _on_obj_Raining_sig_ObjInteractable(p1):
	_func_Interactable(p1)
		
func _on_obj_Clock_sig_ObjInteractable(p1):
	_func_Interactable(p1)

func _on_obj_ShelfClock_sig_ObjInteractable(p1):
	_func_Interactable(p1)

func _on_obj_Window_sig_ObjInteractable(p1):
	_func_Interactable(p1)

func _on_obj_PC_sig_ObjInteractable(p1):
	_func_Interactable(p1)

func _on_obj_Rain_sig_ObjInteractable(p1):
	_func_Interactable(p1)

#----------- Menu buttons -------

func _on_I_Obj_QuitButton_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)#
#
func _on_I_Obj_GameButton_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)

func _on_I_Obj_CreditsButton_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)
	
	
func _on_I_Obj_QuitButton_sig_ObjInteractable(p1):
	interactable = p1
	_func_player_matchAnimation(2)
		
func _on_I_Obj_GameButton_sig_ObjInteractable(p1):
	interactable = p1
	_func_player_matchAnimation(2)

func _on_I_Obj_CreditsButton_sig_ObjInteractable(p1):
	interactable = p1
	_func_player_matchAnimation(2)
		

# warning-ignore:unused_argument
func _on_I_Obj_QuitButton_body_exited(body):
	_func_player_matchAnimation(0)

# warning-ignore:unused_argument
func _on_I_Obj_GameButton_body_exited(body):
	_func_player_matchAnimation(0)

# warning-ignore:unused_argument
func _on_I_Obj_CreditsButton_body_exited(body):
	_func_player_matchAnimation(0)

func _func_PlayerVisibility():
	$AnimationPlayer.play("player_fade_out")
	allow_movement = false
	var_speed = 0
	$Timer_Unhide.start()

func _on_Timer_Unhide_timeout():
	$AnimationPlayer.play("player_fade_in")
	allow_movement = true
	var_speed = speed_default

func _on_I_Obj_Heart_sig_PlayerVisibility():
	_func_PlayerVisibility()

func _on_ObjectBase2_sig_PlayerVisibility():
	_func_PlayerVisibility()

#-------------------------------------------------------
func _on_Timer_PostFocus_timeout():
	int_anim.play(arr_player_anim[0])
#-------------------------------------------------------

func _on_StartingBase_BaseStance():
	int_anim.play(arr_player_anim[0])

# warning-ignore:unused_argument
func _on_StartingBase_body_entered(body):
	int_anim.play(arr_player_anim[0])


func _on_BackToMenu_sig_ObjInteractable(p1):
	_func_Interactable(p1)


func _on_BackToMenu_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)
	


func _on_obj_BackToMenu_sig_ObjInteractable(p1):
	_func_Interactable(p1)


func _on_obj_BackToMenu_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)

func _on_obj_CreditMenuButton_sig_ObjInteractable(p1):
	_func_Interactable(p1)


func _on_obj_CreditMenuButton_sig_position(arr_pos_received):
	func_handleDistance(arr_pos_received)
	
#cactus signal
func _on_Area2D_body_entered():
	pass # Replace with function body.




