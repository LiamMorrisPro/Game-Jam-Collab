extends CharacterBody2D

@onready var ground_check: ground_check_area = $Area2D

var input_direction : Vector2
var is_on_ground : bool = false
var is_jumping : bool = false

var walk_speed = 1000.0
var jump_speed = -1000.0
var player_gravity = 30

func _physics_process(delta: float) -> void:
	
	
	move_player(delta)


func move_player(delta : float):
	input_direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("down", "up"))
	is_jumping = Input.is_action_just_pressed("jump")
	
	#check if on ground
	if ground_check.collider_list != []:
		is_on_ground = true
	else:
		is_on_ground = false
	
	
	if is_jumping:
		velocity.y += jump_speed
	
	
	if input_direction.x != 0 and is_on_ground: #moving on ground
		velocity.x = lerp(velocity.x, walk_speed * input_direction.x, delta * 5)
	elif input_direction.x == 0 and is_on_ground: #stopped on ground
		velocity.x = lerp(velocity.x, 0.0, delta * 10)
	elif input_direction.x != 0 and !is_on_ground: #moving in air
		velocity.x = lerp(velocity.x, walk_speed * input_direction.x / 2, delta * 2)
	elif input_direction.x == 0 and !is_on_ground: #stopped in air
		velocity.x = lerp(velocity.x, 0.0, delta * 1)
	
	
	if !is_on_ground:
		velocity.y += player_gravity
	elif is_on_ground and !is_jumping: 
		velocity.y = 0
	
	
	move_and_slide()
