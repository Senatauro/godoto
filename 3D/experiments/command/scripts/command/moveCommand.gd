extends Command
class_name MoveCommand3D

var direction = Vector3.ZERO
var velocity = 0;
var delta = 0;

func _init(node_to_execute: CharacterBody3D, frame: int, dir: Vector3, vel: float, d: float) -> void:
    _node = node_to_execute;
    _frame_to_execute = frame
    direction = dir
    velocity = vel
    delta = d
    pass

func _execute() -> void:
    #(_node as Node3D).position += direction * velocity * delta;
    (_node as CharacterBody3D).velocity = direction * velocity * delta;
    print("Velocity", (_node as CharacterBody3D).velocity)
    pass