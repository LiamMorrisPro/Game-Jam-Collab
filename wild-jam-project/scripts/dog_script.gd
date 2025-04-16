extends RigidBody2D


var detection_array = []

var target_position
var can_see_enemy : bool = false

var tackle_force = 100.0
var tackle_direction : Vector2

enum state {patrol, chase, tackle}
var dog_state : state = state.patrol
var patrol_dir = 1

func _physics_process(delta: float) -> void:
	
	if can_see_enemy:
		#chase player
		pass


func tackle():
	
	pass

func raycast_detect(target : Player):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(Vector2(0, 0), target.position, 1|2)
	var result = space_state.intersect_ray(query)
	
	if result.collider.is_in_group("Player"):
		can_see_enemy = true


func _on_detection_radius_body_entered(body: Node2D) -> void:
	detection_array.append(body)

func _on_detection_radius_body_exited(body: Node2D) -> void:
	detection_array.erase(body)
