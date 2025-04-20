extends AudioStreamPlayer2D

const FRESH_AIR = preload("uid://smeseyam17hl")
const EVERYDAY_LIFE_ = preload("uid://d4idlw62nt68f")


func play_music(music : AudioStream, volume = 0.0) -> void:
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()

func play_music_level():
	play_music(FRESH_AIR)

func play_music_menu():
	play_music(EVERYDAY_LIFE_)

func muffle_music():
	pass

func unmuffle_music():
	pass

func fade_out_music():
	var tween = create_tween()
	tween.tween_property(self, "volume_db", -40, 1.5)

func fade_in_music():
	var tween = create_tween()
	tween.tween_property(self, "volume_db", 0, 1.5)

func stop_music():
	stream = null
	stop()
