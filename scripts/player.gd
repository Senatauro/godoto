extends Area2D

signal hit


@export var speed = 200
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vel = Vector2.ZERO; # Start the frame without moving the player
	if(Input.is_action_pressed("mover_esquerda")):
		vel.x -= 1;
	if(Input.is_action_pressed("mover_direita")):
		vel.x +=1
	if(Input.is_action_pressed("mover_cima")):
		vel.y -= 1;
	if(Input.is_action_pressed("mover_baixo")):
		vel.y += 1;

	if(vel.length() > 0):
		vel = vel.normalized() * speed;
		position += vel * delta;
		position = position.clamp(Vector2.ZERO, screen_size)
		if (vel.x != 0):
			$AnimatedSprite2D.animation = "walk"
			#$AnimatedSprite2D.flip_v = false;
			#$AnimatedSprite2D.flip_h = vel.x < 0
		#elif (vel.y != 0):
			#$AnimatedSprite2D.animation = "up"
			#$AnimatedSprite2D.flip_v = vel.y > 0
		$AnimatedSprite2D.play()
		var new_rot = rotate_toward(rotation, vel.angle(), 20 * delta)
		rotation = new_rot
	else:
		$AnimatedSprite2D.stop()


func _on_body_entered(body:Node2D) -> void:
	hide()
	hit.emit()
	# This will disable the area colision after the colision has been processed.
	# Disabling the colision while it's processing can cause godot to crash
	$CollisionShape2D.set_deferred("disabled", true);
	pass # Replace with function body.

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false