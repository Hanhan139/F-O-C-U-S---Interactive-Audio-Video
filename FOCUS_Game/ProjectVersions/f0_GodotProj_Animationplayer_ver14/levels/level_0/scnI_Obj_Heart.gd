extends class_FindableObject

signal arrows

func _ready():
	$Particles_black.emitting = false
	$Particles_gold.emitting = false

func _on_Timer_timeout():
	object_animation.set_frame(0)
	object_animation.play("heart")
	$sfx2D_object.play()
	_func_start_timer()

func _func_object_found():
	_func_change_player_visibility()
	$Particles_black.emitting = true
	$sfx_discovered.play()
	$Timer_Particle.start()
	emit_signal("arrows")


func _on_Timer_Particle_timeout():
	$Particles_black.emitting = false
#	$Particles_gold.emitting = false
