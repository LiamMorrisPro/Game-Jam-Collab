extends RigidBody2D

@export var move_axis: String = "x"
@export var distance: float = 50
@export var speed: float = 50
@export var string_visible: bool = true

var direction := 1
var start_pos: Vector2

@onready var raycastright: RayCast2D = $Raycastright
@onready var raycastleft: RayCast2D = $Raycastleft
@onready var raycastup: RayCast2D = $Raycastup
@onready var raycastdown: RayCast2D = $Raycastdown
@onready var string: Sprite2D = $Sprite2D/string

func _ready() -> void:
	if not string_visible:
		string.hide()
	start_pos = global_position

func _physics_process(delta: float) -> void:
	var move_vector := Vector2.ZERO

	if move_axis == "x":
		move_vector.x = speed * direction

		if raycastleft.is_colliding():
			var collider = raycastleft.get_collider()
			if collider and collider is not Player and not collider.is_in_group("Items"):
				direction = 1

		if raycastright.is_colliding():
			var collider = raycastright.get_collider()
			if collider and collider is not Player and not collider.is_in_group("Items"):
				direction = -1

		if global_position.x >= start_pos.x + distance:
			direction = -1
		elif global_position.x <= start_pos.x - distance:
			direction = 1

	elif move_axis == "y":
		move_vector.y = speed * direction

		if raycastup.is_colliding():
			var collider = raycastup.get_collider()
			if collider and collider is not Player and not collider.is_in_group("Items"):
				direction = -1

		if raycastdown.is_colliding():
			var collider = raycastdown.get_collider()
			if collider and collider is not Player and not collider.is_in_group("Items"):
				direction = 1

		if global_position.y >= start_pos.y + distance:
			direction = -1
		elif global_position.y <= start_pos.y - distance:
			direction = 1

	linear_velocity = move_vector
