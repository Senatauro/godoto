extends BaseSystem
class_name InputSystem

func _update(world: World, delta: float):
	# Checks first if there are any components that match this
	var entities = world.get_entities_with_components([PlayerTag.NAME, InputComponent.NAME])
	if(entities.size() == 0):
		return
	
	var dir_x = 0
	var dir_y = 0
	if(Input.is_action_pressed("mover_direita")):
		dir_x = 1;
	elif(Input.is_action_pressed("mover_esquerda")):
		dir_x = -1;
	
	for entity in entities:
		var component : InputComponent = world.get_component_from_entity(entity, InputComponent.NAME);
		component.input_X = dir_x
		
	pass
