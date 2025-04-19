extends RigidBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var tackle_timer: Timer = $tackle_timer

var detection_array = []

var target_position
var can_see_enemy : bool = false

var can_tackle = true
var tackle_force = 500.0
var tackle_direction : Vector2

enum state {patrol, chase, tackle}
var dog_state : state = state.patrol
var patrol_dir = 1

var jump_vector : Vector2 = Vector2(700, 300)

func _ready() -> void:
	animated_sprite_2d.play("sleep")


func _physics_process(delta: float) -> void:
	var target_vector : Vector2 = Vector2.ZERO
	
	
	for target in detection_array:
		raycast_detect(target)
	
	if detection_array.size() > 0:
		target_position = detection_array[0].global_position
		target_vector = target_position - global_position
	else:
		return
	
	
	if target_vector.length() < 15:
		tackle(target_vector)
	
	#chase enemy
	if can_see_enemy:
		if target_vector.x > 0 and target_vector.length() > 20:
			linear_velocity.x = lerp(linear_velocity.x, 1000.0, delta)
			animated_sprite_2d.play("walk")
			animated_sprite_2d.scale.x = 1
		elif target_vector.x < -0 and target_vector.length() > 20:
			linear_velocity.x = lerp(linear_velocity.x, -1000.0, delta)
			animated_sprite_2d.scale.x = -1
			animated_sprite_2d.play("walk")
	else:
		linear_velocity.x = 0
		if animated_sprite_2d.animation != "sleep":
			animated_sprite_2d.play("idle")



func tackle(target_vector):
	if can_see_enemy and can_tackle:
		print('Tackling player!')
		can_tackle = false
		tackle_timer.start()

		var player = detection_array[0]
		var direction = (target_position - global_position).normalized()
		
		if player and player is Player:
			player.apply_central_impulse(direction * tackle_force)
			animated_sprite_2d.play("bark")
			animated_sprite_2d.scale.x = sign(direction.x)
		
		animated_sprite_2d.scale.x = sign(direction.x)

func raycast_detect(target : Player):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(Vector2(0, 0), target.global_position, 1|2)
	var result = space_state.intersect_ray(query)
	
	if result.collider.is_in_group("Player"):
		can_see_enemy = true


func _on_detection_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		detection_array.append(body)

func _on_detection_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		detection_array.erase(body)


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "bark":
		animated_sprite_2d.play("idle")


func _on_tackle_timer_timeout() -> void:
	can_tackle = true
