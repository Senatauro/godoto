class_name PlayerTag extends BaseComponent
# ECS Component - Stores ONLY information (variables); No logic

const NAME = "PlayerTag"

func _get_name() -> String:
	return NAME
