extends Node

func _ready() -> void:
	var player_id = World.create_entity();	
	World.add_component(player_id, InputComponent.new())
	World.add_component(player_id, MoveComponent.new())
	World.add_component(player_id, PlayerTag.new());
