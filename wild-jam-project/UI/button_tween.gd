extends Button

var original_size := scale

var grow_size := Vector2(1.1,1.1)

const BUTTON_SELECT = preload("res://SFX/ButtonSelect.wav")
const BUTTON_HOVER = preload("res://SFX/ButtonHover1.wav")


func _ready() -> void:
	self.mouse_entered.connect(on_entered)
	self.mouse_exited.connect(on_exited)
	self.pressed.connect(on_pressed)
	mouse_entered.connect(on_hovered)
	
func on_entered():
	grow_btn(grow_size,.1)

func on_exited():
	grow_btn(original_size,.1)
	
func grow_btn(end_size : Vector2, duration: float) -> void:
	pass
	#var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(self,'scale',end_size,duration)

func on_pressed():
	SFXManager.play_sound(BUTTON_SELECT)

func on_hovered():
	SFXManager.play_sound(BUTTON_HOVER)
	
