extends BaseSystem
class_name RenderSystem

func _update(world: World, delta: float):
	# Get all entities that have both NodeComponent and TransformComponent
	var entities = world.get_entities_with_components(["NodeComponent", "TransformComponent"])
	if entities.size() == 0:
		return
	
	for entity in entities:
		var node_comp = world.get_component_from_entity(entity, "NodeComponent")
		var transform_comp = world.get_component_from_entity(entity, "TransformComponent")
		
		if node_comp == null or transform_comp == null or node_comp.node == null:
			continue
			
		# Update the node's transform based on ECS data
		var node = node_comp.node
		
		# Handle different node types appropriately
		if node.has_method("set_global_position"):
			node.global_position = transform_comp.position
		elif node.has_method("set_position"):
			node.position = transform_comp.position
		
		if node.has_method("set_rotation"):
			node.rotation = transform_comp.rotation
		
		if node.has_method("set_scale"):
			node.scale = transform_comp.scale
