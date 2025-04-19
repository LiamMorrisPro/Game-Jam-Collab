extends RigidBody2D
class_name Player

@onready var ground_check: ground_check_area = $ground_check

@onready var item_kick: ItemKick = $item_kick
@onready var item_throw: ItemThrow = $item_throw
@onready var item_flip: Area2D = $item_flip

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var input_direction : Vector2
var is_jumping : bool
var is_falling : bool
var is_on_ground : bool
var can_jump : bool = true

var character_direction : int = 1 #1 = forward, -1 = backward
var item_kick_target : Vector2 = Vector2(13.0, 0.0)


var player_speed : float = 3000.0
var player_air_speed : float = 1000.0
var jump_force : float = 250.0
var max_speed : float = 75.0

#coyote time
@onready var coyote_timer: Timer = $CoyoteTimer
var coyote_frames = 6
var coyote = false
var last_floor = false

@onready var jump_timer: Timer = $JumpTimer




func _physics_process(delta: float) -> void:
	
	#check if on ground
	if ground_check.collider_list != []:
		is_on_ground = true
		physics_material_override.friction = 1.0
	else:
		is_on_ground = false
		physics_material_override.friction = 0.0

	
	#handle inputs
	input_direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("down", "up"))
	is_jumping = Input.is_action_just_pressed("jump")
	
	#coyote time
	if !is_on_ground and last_floor and !is_jumping:
		coyote = true
		coyote_timer.start()
	
	#change character facing direction
	if input_direction.x != character_direction and input_direction.x != 0:
		animated_sprite_2d.scale.x *= -1
		character_direction *= -1
		item_kick_target *= -1
		item_kick.position = item_kick_target
		item_throw.throw_force_forward *= -1
		
	#jumping
	if Global.level_clear == false:
		if is_jumping and is_on_ground == true and can_jump || is_jumping and coyote and can_jump:
			can_jump = false
			jump_timer.start()
			linear_velocity.y = 0
			apply_central_impulse(Vector2(0,-jump_force))
	
	#horizontal movement
	if Global.level_clear == false:
		if input_direction.x != 0 and is_on_ground == true:
			apply_central_force(Vector2(input_direction.x * player_speed, 0))
			animated_sprite_2d.play("walk")
		elif input_direction.x != 0:
			apply_central_force(Vector2(input_direction.x * player_air_speed, 0))
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("idle")
	
	
	
	
	
	
	
	last_floor = is_on_ground



func _integrate_forces(state):
	
	if state.linear_velocity.x > max_speed || state.linear_velocity.x < -max_speed:
		state.linear_velocity.x = max_speed * input_direction.x


func _on_coyote_timer_timeout() -> void:
	coyote = false


func _on_jump_timer_timeout() -> void:
	can_jump = true
