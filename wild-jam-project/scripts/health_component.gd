extends Node2D
class_name HealthComponent

signal dead
@onready var sprite_2d: Sprite2D = $"../Sprite2D"


@export var MAX_HEALTH := 100.0
var health : float

func _ready():
	health = MAX_HEALTH

func damage(attack):
	health -= attack
	
	if health >= 50:
		sprite_2d.frame = 39
	elif health >= 20:
		sprite_2d.frame = 40
	elif health >= 20:
		sprite_2d.frame = 41
	
	if health <= 0:
		died()

func died():
	emit_signal("dead")
	get_parent().queue_free()
