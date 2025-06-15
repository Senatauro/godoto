class_name Base_Command

var _node: Node
var _frame_to_execute: int

## Create a new command;
## frame: The frame that this command should be executed
func _init(node: Node, frame: int = 0) -> void:
    _node = node
    _frame_to_execute = frame

func _execute():
    # Should be implemented on extended class
    pass
    