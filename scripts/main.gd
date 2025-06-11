extends Node

@export var mob_scene: PackedScene
var score

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	pass # Replace with function body.

func new_game() -> void:
	print("Nw game")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")
	pass

func _on_score_timer_timeout() -> void:
	score += 1;
	$HUD.update_score(score)
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

	# Set the mob's perpendicular to the path direction
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Add some randomness to te direction
	direction += randf_range(-PI/4, PI/4);
	new_mob.rotation = direction
	
	# Choose the velocity for the mob
	var velocity = Vector2(randf_range(150, 250), 0);
	new_mob.linear_velocity = velocity
	
	# Add the new mob to the main scene tree
	add_child(new_mob)
	
	pass # Replace with function body.
