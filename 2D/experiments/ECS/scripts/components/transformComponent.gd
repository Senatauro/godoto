class_name TransformComponent extends BaseComponent
# ECS Component - Stores position, rotation, and scale data

const NAME = "TransformComponent"

var position: Vector2 = Vector2.ZERO
var rotation: float = 0.0
var scale: Vector2 = Vector2.ONE
var velocity: Vector2 = Vector2.ZERO

func _get_name() -> String:
	return NAME
