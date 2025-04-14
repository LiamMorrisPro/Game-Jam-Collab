extends Button

var original_size := scale

var grow_size := Vector2(1.1,1.1)

func _ready() -> void:
	self.mouse_entered.connect(on_entered)
	self.mouse_exited.connect(on_exited)
	
func on_entered():
	grow_btn(grow_size,.1)

func on_exited():
	grow_btn(original_size,.1)
	
func grow_btn(end_size : Vector2, duration: float) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,'scale',end_size,duration)
