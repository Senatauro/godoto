extends CharacterBody3D

@export var test = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.physics_jitter_fix = -1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var dir = Vector3.ZERO
	if(Input.is_action_just_pressed("mover_direita")):
		dir = Vector3.RIGHT
	if(Input.is_action_just_released("mover_direita")):
		print("Just released")
		dir = Vector3.ZERO
		var moveCommand = MoveCommand3D.new(self, CommandExecutor.get_current_frame() + 10, dir, 0, delta);
		CommandExecutor.add_command(moveCommand);

	if(dir != Vector3.ZERO):
		var moveCommand = MoveCommand3D.new(self, CommandExecutor.get_current_frame() + 10, dir, 100, delta);
		CommandExecutor.add_command(moveCommand);
	var col = move_and_slide()
	#if(col):
	#	print("Collision happened")
	pass
