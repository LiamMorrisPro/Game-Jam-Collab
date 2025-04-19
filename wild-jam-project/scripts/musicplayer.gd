extends AudioStreamPlayer2D

const level1_music = preload("uid://ckdj1dmhu2nuc")
const FRESH_AIR = preload("uid://smeseyam17hl")


func play_music(music : AudioStream, volume = 0.0) -> void:
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()

func play_music_level():
	play_music(FRESH_AIR)

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
