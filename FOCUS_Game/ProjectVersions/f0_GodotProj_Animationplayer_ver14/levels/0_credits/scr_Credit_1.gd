extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_transparent")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_obj_CreditMenuButton_object_found():
	$TransitionScreenBlack/AnimationPlayer.play("fade_to_dark")
