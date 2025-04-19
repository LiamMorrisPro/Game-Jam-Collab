extends Node

@onready var transit: SceneTransition = $SceneTransition
const main_menu = "res://UI/main_menu.tscn"
const level_select = "res://UI/level_selector_screen.tscn"

const LEVEL_CLEAR = preload("uid://c5a6a473tkvya")

#ui dependencies
@onready var minute_label: Label = $GameUI/Level_UI/ColorRect/HBoxContainer/minute_label
@onready var second_label: Label = $GameUI/Level_UI/ColorRect/HBoxContainer/second_label
@onready var msec_label: Label = $GameUI/Level_UI/ColorRect/HBoxContainer/msec_label

@onready var level_ui: Control = $GameUI/Level_UI
@onready var win_screen: Control = $GameUI/Win_Screen

#timer 
var time_taken : float
var minutes: int = 0
var seconds: int = 0
var msec: int = 0

var timer_on : bool = true

#doing it this way ensures that every level will have a mailbox, or you'll find out pretty quick that it doesn't
@export var mailbox: MailBox



@onready var level_select_btn: Button = $GameUI/Win_Screen/NinePatchRect/VBoxContainer/LevelSelectBtn
@onready var main_menu_btn: Button = $GameUI/Win_Screen/NinePatchRect/VBoxContainer/MainMenuBtn

@onready var time: Label = $GameUI/Win_Screen/NinePatchRect/Time
@onready var best_time: Label = $GameUI/Win_Screen/NinePatchRect/BestTime



#start a timer on level start
func _ready() -> void:
	Global.level_clear = false
	Musicplayer.play_music_level()
	win_screen.visible = false
	level_ui.visible = true
	mailbox.parcel_delivered.connect(self.level_clear)

func _process(delta: float) -> void:
	
	
	if timer_on:
		time_taken += delta
		
		msec = fmod(time_taken, 1) * 100
		seconds = fmod(time_taken, 60) 
		minutes = fmod(time_taken, 3600) / 60
		minute_label.text = "%02d:" % minutes
		second_label.text = "%02d." % seconds
		msec_label.text = "%02d" % msec


func level_clear():
	print("cleared")
	#get_tree().paused = true
	if Global.level_clear == true:
		return
	
	SFXManager.play_sound(LEVEL_CLEAR)
	
	Global.level_clear = true
	Global.set_level_complete(Global.current_level,time_taken)
	time.text = "Time: "+str((round(time_taken * 100.0) / 100.0)) #make func in Global script to save best time and recent time
	timer_on = false
	win_screen.visible = true
	
	# get the win size cuz it can be different and that messes it up if it is
	var start_pos = Vector2(win_screen.position.x, -win_screen.size.y)
	var end_pos = Vector2(win_screen.position.x, (get_viewport().size.y - win_screen.size.y) / 2)

	win_screen.position = start_pos
	
	#Creates like a bounce slide mechanic
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(win_screen, "position", end_pos, 0.8)\
		.set_trans(Tween.TRANS_BOUNCE)\
		.set_ease(Tween.EASE_OUT)


func _on_main_menu_btn_pressed() -> void:
	transit.Transition()
	await transit.on_transition_finished
	get_tree().change_scene_to_file(main_menu)
	Musicplayer.stop_music()

func _on_level_select_btn_pressed() -> void:
	transit.Transition()
	await transit.on_transition_finished
	get_tree().change_scene_to_file(level_select)
	Musicplayer.stop_music()
