extends Node

# The current frame, it's used to execute the commands
var current_frame = 0;
# All the commands that were already executed
var timeline: Array[Command] = []
# Commands to execute
var commands_to_execute: Array[Command] = []

func _init() -> void:
    seed("test".hash())

func _ready() -> void:
    pass

func _process(_delta: float) -> void:
    pass

func _physics_process(_delta: float) -> void:
    while(commands_to_execute.size() > 0 && commands_to_execute.get(0)._frame_to_execute == current_frame):
        var command = commands_to_execute.pop_front()
        command._execute()
        pass
    current_frame += 1;

func add_command(command: Command):
    commands_to_execute.append(command)
    commands_to_execute.sort_custom(_sort_by_frame);

func get_current_frame() -> int:
    return current_frame

func _sort_by_frame(a: Command, b: Command):
    if(a._frame_to_execute < b._frame_to_execute):
        return true
    return false