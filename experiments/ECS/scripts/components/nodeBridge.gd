class_name NodeBridge extends Node
# Bridge script that connects any Godot node to the ECS system
# Attach this script to any node you want to control with ECS

@export var auto_create_entity: bool = true
@export var add_input_component: bool = false
@export var add_movement_component: bool = false
@export var add_player_tag: bool = false
@export var speed: float = 300.0

var entity_id: int = -1
var target_node: Node

func _ready():
	# Get the parent node or use self if this is the main node
	target_node = get_parent() if get_parent() != get_tree().current_scene else self
	
	if auto_create_entity:
		create_ecs_entity()

func create_ecs_entity():
	# Create ECS entity
	entity_id = World.create_entity()
	
	# Always add NodeComponent and TransformComponent
	var node_comp = NodeComponent.new(target_node)
	World.add_component(entity_id, node_comp)
	
	var transform_comp = TransformComponent.new()
	# Initialize transform with current node position
	if target_node.has_method("get_global_position"):
		transform_comp.position = target_node.global_position
	elif target_node.has_method("get_position"):
		transform_comp.position = target_node.position
	World.add_component(entity_id, transform_comp)
	
	# Add optional components based on settings
	if add_movement_component:
		var move_comp = MoveComponent.new()
		move_comp.speed = speed
		World.add_component(entity_id, move_comp)
	
	if add_input_component:
		World.add_component(entity_id, InputComponent.new())
	
	if add_player_tag:
		World.add_component(entity_id, PlayerTag.new())
	
	print("Created ECS entity ", entity_id, " for node ", target_node.name)

func get_entity_id() -> int:
	return entity_id

func get_component(component_name: String) -> BaseComponent:
	if entity_id == -1:
		return null
	return World.get_component_from_entity(entity_id, component_name)

# Helper methods to easily add components at runtime
func add_component(component: BaseComponent):
	if entity_id != -1:
		World.add_component(entity_id, component)

func make_player():
	add_player_tag = true
	add_input_component = true
	add_movement_component = true
	if entity_id == -1:
		create_ecs_entity()
	else:
		# Add components to existing entity
		World.add_component(entity_id, PlayerTag.new())
		World.add_component(entity_id, InputComponent.new())
		if not World.get_component_from_entity(entity_id, "MoveComponent"):
			var move_comp = MoveComponent.new()
			move_comp.speed = speed
			World.add_component(entity_id, move_comp)
