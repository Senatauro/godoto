extends State
class_name EnemyFollow

@export var enemy: EnemyScript
@export var move_speed: float = 10

func _enter() -> void:
	# Called when the state is entered
	pass

func _exit() -> void:
	# Called when the state is exited
	pass

func process(delta: float) -> void:
	# Called every frame while the state is active
	pass

func physics_process(delta: float) -> void:
	var closest_enemy: Node3D = enemy.get_closest_enemy();
	var direction_to_enemy = closest_enemy.global_position - enemy.global_position;
	enemy.velocity = direction_to_enemy.normalized() * move_speed
	
	pass
