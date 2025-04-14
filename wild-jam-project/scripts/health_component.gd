extends Node2D
class_name HealthComponent

signal dead

@export var MAX_HEALTH := 100.0
var health : float

func _ready():
	health = MAX_HEALTH

func damage(attack):
	health -= attack
	if health <= 0:
		died()

func died():
	emit_signal("dead")
	get_parent().queue_free()
