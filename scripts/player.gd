extends Area2D

@export var speed = 200
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
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
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
