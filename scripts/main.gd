extends Node

@export var mob_scene: PackedScene
var score

func game_over() -> void:
    $ScoreTimer.stop()
    $MobTimer.stop()
    pass # Replace with function body.

func new_game() -> void:
    score = 0
    $Player.start($StartPosition)
    $StartTimer.start()
    pass

func _on_score_timer_timeout() -> void:
    score += 1;
    pass # Replace with function body.

func _on_start_timer_timeout() -> void:
    $MobTimer.start()
    $ScoreTimer.start()
    pass # Replace with function body.

func _on_mob_timer_timeout() -> void:
    # Create a new instance of the Mob Scene
    var new_mob = mob_scene.instantiate()

    # Choose a random location on Path2D
    var mob_spawn_location = $MobPath/MobSpawnLocation
    mob_spawn_location.progress_ratio = randf()

    # Set the mob position based on the random value inside the spawn location
    new_mob.position = mob_spawn_location.position

    # Set the mob's 


    pass # Replace with function body.
