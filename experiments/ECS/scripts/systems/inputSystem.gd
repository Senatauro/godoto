extends BaseSystem
class_name InputSystem

func _update(world: World, delta: float):
	# Checks first if there are any components that match this
	var entities = world.get_entities_with_components([PlayerTag.NAME, InputComponent.NAME])
	if(entities.size() == 0):
		return
	
	var dir_x = 0
	var dir_y = 0
	
	# Handle horizontal input
	if(Input.is_action_pressed("mover_direita")):
		dir_x = 1
	elif(Input.is_action_pressed("mover_esquerda")):
		dir_x = -1
	
	# Handle vertical input (add these actions to your input map if they don't exist)
	if(Input.is_action_pressed("mover_cima")):
		dir_y = -1
	elif(Input.is_action_pressed("mover_baixo")):
		dir_y = 1
	
	for entity in entities:
		var component : InputComponent = world.get_component_from_entity(entity, InputComponent.NAME)
		component.input_X = dir_x
		component.input_y = dir_y
