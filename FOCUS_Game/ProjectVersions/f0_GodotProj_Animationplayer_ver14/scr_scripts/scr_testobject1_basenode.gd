extends Node2D
#Heart testobject

#x is a test variable, nothing important later
var x = 0
var counter = 10
var timer = Timer.new()


#Signals: Character appears
signal sig_ShowPlayer ()
signal shut_down
signal object_detectable

func _ready():
	hide()

func _on_Area2D_body_entered(area):
#	var thing_entered = area.get_name()
#	print(str(thing_entered) + " entered testobject: heart")
#	if area.get_name() == "KinematicBody2D":
#		x += 1
#		print ("Entered heart!" + str(x))
#		if (x > 3):
#			pass
#		elif (x == 3):
#			emit_signal("sig_ShowPlayer")
#			$aux_heart_found.play()
#			$Area2D/AnimatedSprite.play("anim_heart_beat")
#			show()
#			_func_check_timer()
#			$aux_success.play()
#		else:
#			$aux_heart_seeking.play()
	var thing_entered = area.get_name()
	print(str(thing_entered) + " entered testobject: heart")
#	if area.get_name() == "KinematicBody2D":
	x += 1
	print ("Entered heart!" + str(x))
	if (x > 3):
		pass
	elif (x == 3):
		emit_signal("sig_ShowPlayer")
		emit_signal("shut_down")
		emit_signal("object_detectable")
		$aux_heart_found.play()
		$Area2D/AnimatedSprite.play("anim_heart_beat")
		show()
		_func_check_timer()
		$aux_success.play()
	else:
		$aux_heart_seeking.play()


func _func_check_timer ():
	if (counter == 10):
		timer.connect("timeout",self,"_on_timer_timeout")
		#timeout is what says in docs, in signals
		#self is who respond to the callback
		#_on_timer_timeout is the callback, can have any name
		yield(get_tree().create_timer(1), "timeout")
		add_child(timer) #to process
		timer.start() #tp start
		print ("started timer!")

func _on_timer_timeout():
	print ("beep")
	counter = counter - 1
	print ("counter = " + str(counter))
	if (counter <= 0):
		timer.stop()
		print ("stopped timer!")
	$aux_heart_found.play()
