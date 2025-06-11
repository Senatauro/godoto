class_name InputComponent extends BaseComponent
# ECS Component - Stores ONLY information (variables); No logic

const NAME = "InputComponent"

# -1 to 1
var input_X: int
# -1 to 1
var input_y: float

func _get_name() -> String:
	return NAME
