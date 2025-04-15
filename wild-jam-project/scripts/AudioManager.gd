extends Node

func play_sound(stream: AudioStream) -> void:
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = stream
	audio_player.finished.connect(remove_node.bind(audio_player))
	add_child(audio_player)
	audio_player.play()
	
	
func remove_node(instance: AudioStreamPlayer) -> void:
	instance.queue_free()
