extends RigidBody2D


var detection_array = []

var target_position
var can_see_enemy : bool = false

var tackle_force = 100.0
var tackle_direction : Vector2

enum state {patrol, chase, tackle}
var dog_state : state = state.patrol
var patrol_dir = 1

var jump_vector : Vector2 = Vector2(700, 300)

func _physics_process(delta: float) -> void:
	var target_vector : Vector2 = Vector2.ZERO
	
	
	for target in detection_array:
		raycast_detect(target)
	
	if detection_array.size() > 0:
		target_position = detection_array[0].global_position
		target_vector = target_position - global_position
	
	if target_vector.length() > 15:
		pass
	
	#chase enemy
	if can_see_enemy:
		if target_vector.x > 0 and target_vector.length() > 20:
			linear_velocity.x = lerp(linear_velocity.x, 1000.0, delta)
		elif target_vector.x < -0 and target_vector.length() > 20:
			linear_velocity.x = lerp(linear_velocity.x, -1000.0, delta)
	else:
		linear_velocity.x = 0



func tackle():
	
	pass

func raycast_detect(target : Player):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(Vector2(0, 0), target.position, 1|2)
	var result = space_state.intersect_ray(query)
	
	if result.collider.is_in_group("Player"):
		can_see_enemy = true


func _on_detection_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		detection_array.append(body)

func _on_detection_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		detection_array.erase(body)
