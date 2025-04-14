extends RigidBody2D
class_name Player

@onready var ground_check: ground_check_area = $ground_check
@onready var item_kick: Area2D = $item_kick

@onready var sprite_2d: Sprite2D = $Sprite2D



var input_direction : Vector2
var is_jumping : bool
var is_falling : bool
var is_on_ground : bool
var character_direction : int = 1 #1 = forward, -1 = backward
var item_kick_target : Vector2 = Vector2(13.0, 0.0)

var player_speed : float = 3000.0
var player_air_speed : float = 1000.0
var jump_force : float = 250.0
var max_speed : float = 75.0

func _physics_process(delta: float) -> void:
	
	#handle inputs
	input_direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("down", "up"))
	is_jumping = Input.is_action_just_pressed("jump")
  
	#change character facing direction
	if input_direction.x != character_direction and input_direction.x != 0:
		sprite_2d.scale.x *= -1
		character_direction *= -1
		item_kick_target *= -1
		item_kick.position = item_kick_target
  
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
