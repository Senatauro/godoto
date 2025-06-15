extends CharacterBody3D
class_name EnemyScript

var enemies_in_range: Array[Node3D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
	pass

func _on_detection_range_body_entered(body:Node3D) -> void:
	enemies_in_range.append(body)
	print("Enemies in range", enemies_in_range)
	pass # Replace with function body.

func _on_detection_range_body_exited(body:Node3D) -> void:
	enemies_in_range.remove_at(enemies_in_range.find(body));
	pass # Replace with function body.

func get_enemies_on_range():
	return enemies_in_range

func get_closest_enemy() -> Node3D:
	print("Enemies on range here", enemies_in_range)
	return enemies_in_range[0];