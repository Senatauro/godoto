extends Node

# ECS World Singleton

signal reset_world
var in_game = false

var next_id : int = 1
# Component: Entities that use this component
var component_entity_rel = {}
# Entity: components that this entity has
var entity_component_rel = {}

# Systems
var input_system
var movement_system  
var render_system

func _ready():
	# Initialize systems
	input_system = InputSystem.new()
	movement_system = MovementSystem.new()
	render_system = RenderSystem.new()

func reset():
	next_id = 1;
	component_entity_rel = {}
	entity_component_rel = {}
	reset_world.emit()

func create_entity() -> int :
	var entity_id = next_id;
	entity_component_rel[entity_id] = {}
	next_id += 1
	return entity_id

func add_component(entity_id: int, component: BaseComponent) -> Error:
	# Check if the entity exists
	if(entity_component_rel.get(entity_id) == null):
		printerr("Entity doesn't exist", entity_id)
		return ERR_DOES_NOT_EXIST

	# Check if the component already exists, if not, create an empty object and generate the connection between component and entity
	var component_name = component._get_name()
	component_entity_rel.get_or_add(component_name, {})
	component_entity_rel[component_name].get_or_add(entity_id, {})
	component_entity_rel[component_name][entity_id] = component
	
	# Do the same for the entity->component relation
	entity_component_rel.get_or_add(entity_id, {})
	entity_component_rel[entity_id].get_or_add(component_name, {})
	entity_component_rel[entity_id][component_name] = component
	
	return OK

# Will return only the entities that have all the matching components
func get_entities_with_components(components_list: Array) -> Array:
	var entities_found = {} # Entity ID: times found
	if(components_list.size() == 0):
		printerr("Component list is empty")
		return []
	
	# Populate the list with the entities of the first component
	for component in components_list:
		var entities = __get_entities_with_component_name__(component).keys()
		for entity in entities:
			entities_found.get_or_add(entity, 0)
			entities_found[entity] += 1
	var entities_keys = entities_found.keys()
	var entities_that_match = []
	for i in entities_keys.size():
		var entity = entities_found[entities_keys[i]]
		if(entity == components_list.size()):
			entities_that_match.append(entities_keys[i])
	
	return entities_that_match

func get_component_from_entity(entity_id: int, component_name: String) -> BaseComponent:
	return component_entity_rel.get(component_name, {}).get(entity_id)

# INTERNAL FUNCTIONS
func __get_entities_with_component_name__(component_name: String) -> Dictionary:
	return component_entity_rel.get(component_name, {})

func _physics_process(delta: float) -> void:
	#if not in_game:
	#	return
	print("In game")
	# Update all systems in the correct order
	input_system._update(self, delta)
	movement_system._update(self, delta)
	render_system._update(self, delta)
