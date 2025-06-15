extends State
class_name EnemyIdle

@export var enemy: EnemyScript
@export var move_speed: float = 10

var start_position: Vector3;

func _init() -> void:
	if(enemy):
		start_position = enemy.position

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
	# Called every physics frame while the state is active
	var enemies_in_range = enemy.get_enemies_on_range()
	if(enemies_in_range.size() > 0):
		transition.emit(self, "follow");
	pass
