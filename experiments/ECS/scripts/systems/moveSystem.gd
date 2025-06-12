extends BaseSystem
class_name MovementSystem

func _update(world: World, delta: float):
	var entities = world.get_entities_with_components([InputComponent.NAME, MoveComponent.NAME, TransformComponent.NAME])
	if entities.size() == 0:
		return
	
	for entity in entities:
		var input_comp: InputComponent = world.get_component_from_entity(entity, InputComponent.NAME)
		var move_comp: MoveComponent = world.get_component_from_entity(entity, MoveComponent.NAME)
		var transform_comp: TransformComponent = world.get_component_from_entity(entity, TransformComponent.NAME)
		
		# Calculate movement based on input
		var input_vector = Vector2(input_comp.input_X, input_comp.input_y)
		var target_velocity = input_vector * move_comp.speed
		
		# Apply acceleration/deceleration
		if input_vector.length() > 0:
			# Accelerate toward target velocity
			transform_comp.velocity = transform_comp.velocity.move_toward(target_velocity, move_comp.acceleration * delta)
		else:
			# Apply friction when no input
			transform_comp.velocity = transform_comp.velocity.move_toward(Vector2.ZERO, move_comp.friction * delta)
		
		# Update position based on velocity
		transform_comp.position += transform_comp.velocity * delta
