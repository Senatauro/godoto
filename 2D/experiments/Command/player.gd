extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 0.1
	Engine.physics_ticks_per_second = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("mover_direita")):
		var movCom = Move_Command.new(self, CommandExecutor.get_current_frame()+2, Vector2.RIGHT, 100, delta);
		CommandExecutor.add_command(movCom);
	pass
