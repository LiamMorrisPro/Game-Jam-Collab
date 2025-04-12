extends RigidBody2D
class_name Player

@onready var ground_check: ground_check_area = $ground_check

var input_direction : Vector2
var is_jumping : bool
var is_falling : bool
var is_on_ground : bool

var player_speed : float = 5000.0
var player_air_speed : float = 1000.0
var jump_force : float = 600.0
var max_speed : float = 200.0

func _physics_process(delta: float) -> void:
	
	#handle inputs
	input_direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("down", "up"))
	is_jumping = Input.is_action_just_pressed("jump")
	
	#check if on ground
	if ground_check.collider_list != []:
		is_on_ground = true
	else:
		is_on_ground = false
	
	
	
	#jumping
	if is_jumping and is_on_ground == true:
		apply_central_impulse(Vector2(0,-jump_force))
	
	#horizontal movement
	if input_direction.x != 0 and is_on_ground == true:
		apply_central_force(Vector2(input_direction.x * player_speed, 0))
	elif input_direction.x != 0:
		apply_central_force(Vector2(input_direction.x * player_air_speed, 0))


func _integrate_forces(state):
	
	if state.linear_velocity.x > max_speed || state.linear_velocity.x < -max_speed:
		state.linear_velocity.x = max_speed * input_direction.x
