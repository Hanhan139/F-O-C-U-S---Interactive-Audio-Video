extends Control

onready var audio = $AudioStreamPlayer2D

onready var sound_1 = preload("res://sfx_audio/f0_sfx_pianochimes/sfx_pianochime_01_vem.wav")
onready var sound_2 = preload("res://sfx_audio/f0_sfx_pianochimes/sfx_pianochime_02_jazzy.wav")
onready var sound_3 = preload("res://sfx_audio/f0_sfx_pianochimes/sfx_pianochime_03_jazzyendpling.wav")
onready var sound_4 = preload("res://sfx_audio/f0_sfx_pianochimes/sfx_pianochime_04_badabloing.wav")

var sounds : Array
var words = ["this", "is", "a", "demo"]

func _ready():
	 # connect audio play finished signal to _on_audio_finished function
	audio.connect("finished", self, "_on_audio_finished")
	# randomize to make sure our random numbers are always random
	randomize() 
	# an array of all sounds
	sounds = [ sound_1, sound_2, sound_3, sound_4 ] 
	# play a random sound 
	_play_random_sound() 


func _play_random_sound():
	# get a random number between 0 and 3
	var sound_index = randi() % 4 
	# get a sound with random index
	var sound = sounds[sound_index] 
	# set the sound to the audio stream player
	audio.stream = sound 
	# play the sound
	audio.play() 

#
func _on_audio_finished():
	pass	
# remove and print the first word in the array
#	print(words.pop_front()) 
#	# pause for one second
#	yield(get_tree().create_timer(1), "timeout") 
#	# if there are words left in the array we continue
#	if words.size() > 0: 
#		# play a random sound again
#		_play_random_sound() 
