extends BaseSystem
class_name MovementSystem

func _update(world: World, delta: float):
	var entities = world.get_entities_with_components([InputComponent.NAME, MoveComponent.NAME])
	if(entities.size() == 0):
		return;
	for entity in entities:
		var component: InputComponent = world.get_component_from_entity(entity, InputComponent.NAME)
		
		pass
