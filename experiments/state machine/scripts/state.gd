extends Node
class_name State

signal transition

func _enter():
    pass

func _exit():
    pass

# No _ because this will only be called from the state machine
func process(delta: float) -> void:
    pass

# No _ because this will only be called  from the state machine
func physics_process(delta: float) -> void:
    pass