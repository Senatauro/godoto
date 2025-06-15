class_name MoveComponent extends BaseComponent
# ECS Component - Stores movement-related data

const NAME = "MoveComponent"

var speed: float = 300.0
var acceleration: float = 1000.0
var friction: float = 800.0

func _get_name() -> String:
	return NAME
