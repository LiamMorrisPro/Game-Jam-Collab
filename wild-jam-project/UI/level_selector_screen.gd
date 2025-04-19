extends Control

@export var transit : SceneTransition

var Level_1 = preload("res://Levels/Level_1.tscn")
var Level_2 = preload("res://Levels/Level_2.tscn")
var Level_3 = preload("res://Levels/Level_3.tscn")




func _on_level_1_button_pressed() -> void:
	transit.Transition()
	await transit.on_transition_finished
	Musicplayer.fade_in_music()
	get_tree().change_scene_to_packed(Level_1)


func _on_level_2_button_pressed() -> void:
	transit.Transition()
	await transit.on_transition_finished
	Musicplayer.fade_in_music()
	get_tree().change_scene_to_packed(Level_2)


func _on_level_3_button_pressed() -> void:
	transit.Transition()
	await transit.on_transition_finished
	Musicplayer.fade_in_music()
	get_tree().change_scene_to_packed(Level_3)
