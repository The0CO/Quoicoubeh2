extends RayCast3D

@onready var audio_player = get_node_or_null("/root/Main/Level/AudioStreamPlayer")
var is_playing = false  # Pour savoir si le son est déjà en train de jouer

func _physics_process(delta):
	if is_colliding():
		var hit = get_collider()
		if hit.name == "ciel2" and audio_player:
			if not is_playing:
				audio_player.play()
				is_playing = true
	else:
		if is_playing and audio_player:
			audio_player.stop()
			is_playing = false
