extends Node

var current_frame = 0
# A timeline for storing all the commands that have already been executed
# [{frame: 100, command: Command}, {frame: 100, command: Command}, {frame: 200, command: Command}]
var timeline = []

# A timeline for storing all the commands that will still be executed
# {frame: 300, command: Command}
var commands_to_execute: Array[Base_Command] = []

func get_current_frame():
	return current_frame;

func add_command(command: Base_Command):
	commands_to_execute.push_back(command);

func _physics_process(delta: float) -> void:
	print("Current frame:", current_frame);
	print("Current commands to execute", commands_to_execute)
	# While the first command is different than null and it has the same frame as the current one
	while(commands_to_execute.get(0) != null && commands_to_execute[0]._frame_to_execute == current_frame):
		var command: Base_Command = commands_to_execute.pop_front()
		command._execute()
		timeline.append(command);
	current_frame += 1;
