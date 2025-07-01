extends Control

@export var lobby_scene: PackedScene;

var ip = '127.0.0.1'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_host_btn_pressed() -> void:
	# Host and create and load the lobby scene
	MultiplayerManager.server_hosted.connect(on_server_hosted)
	MultiplayerManager.create_server()
	pass

func on_server_hosted():
	print("Hosted");
	get_tree().change_scene_to_packed(lobby_scene);
	pass

func _on_join_btn_pressed() -> void:
	MultiplayerManager.on_connected_to_server.connect(on_client_connected)
	MultiplayerManager.create_client(ip)
	pass # Replace with function body.

func _on_ip_input_text_changed(new_text:String) -> void:
	ip = new_text;

func on_client_connected():
	print("Client connected");
	get_tree().change_scene_to_packed(lobby_scene);
	pass

func _on_username_input_text_changed(new_text:String) -> void:
	
	pass # Replace with function body.
