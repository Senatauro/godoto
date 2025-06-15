extends Base_Command

class_name Move_Command

var dir: Vector2
var vel: float
var delta: float

# This command 
func _init(node: Node2D, frame: int, _dir: Vector2, _vel: float, _delta: float) -> void:
    _node = node
    _frame_to_execute = frame
    dir = _dir
    vel = _vel
    delta = _delta
    pass


func _execute() -> void:
    print("Command executed")
    var n:Area2D = _node;
    n.position += dir * vel * delta
    pass