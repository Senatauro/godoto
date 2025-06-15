class_name Command

var _node: Node;
var _frame_to_execute: int;

func _init(node: Node, frame:int):
    _node = node;
    _frame_to_execute = frame;

func _execute():
    pass