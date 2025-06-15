class_name NodeComponent extends BaseComponent
# ECS Component - Stores reference to a Godot node

const NAME = "NodeComponent"

var node: Node = null
var node_type: String = ""

func _init(godot_node: Node = null):
	if godot_node:
		node = godot_node
		node_type = godot_node.get_class()

func _get_name() -> String:
	return NAME
