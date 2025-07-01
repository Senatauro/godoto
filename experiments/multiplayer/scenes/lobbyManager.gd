extends Control

var players: Array[int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# If server add the id of the own user on the list
	if(multiplayer.is_server()):
		players.append(multiplayer.get_unique_id());
		MultiplayerManager.server_on_peer_disconnected.connect(remove_user)
		update_ui()
		pass
	# If it's not the server send the user data to the server
	else:
		register_new_user.rpc_id(1, multiplayer.get_unique_id());
	pass # Replace with function body.

func remove_user(player_id: int):
	print("Removed user")
	players = players.filter(func(player): return player != player_id)
	print("Players: ", players)
	update_user_list_on_clients.rpc(players)

func update_ui():
	for children in $userListPanel/userList.get_children():
		children.queue_free()
	for user in players:
		var label = Label.new();
		label.text = str(user)
		$userListPanel/userList.add_child(label);
	pass

# Send message
func _on_message_input_text_submitted(message: String) -> void:
	message = str(multiplayer.get_unique_id()) + ": " + message
	send_chat_message.rpc(message);
	pass # Replace with function body.


# RPCs
# any_peer: Anyone can call this
# call_local: The function can be called on the local peer, usefull if the players is also the server
# reliable: will be delivered
# 3: the channel that this message is being sent
@rpc("any_peer", "call_local", "reliable", 3)
func register_new_user(player_id: int):
	# We want to register the players only on the server
	if(multiplayer.is_server()):
		players.append(player_id);
		update_user_list_on_clients.rpc(players);

# authority: Only the server can call this
# call_local: The function can be called on the local peer
# reliable: Will be delivered
# 3: the channel the message is being sent
@rpc("authority", "call_local", "reliable", 3)
func update_user_list_on_clients(_players):
	players = _players
	update_ui()
	pass

# any_peer: Anyone can call this
# call_local: will also be executed on the local client
# reliable: will be delivered
# 3: channel this will be sent on
@rpc("any_peer", "call_local", "reliable", 3)
func send_chat_message(message: String):
	var newMessage = Label.new()
	newMessage.text = message;
	var labelSize = $chatPanel/VSplitContainer/ScrollContainer/messageHistory.size.x
	newMessage.custom_minimum_size.x = labelSize
	newMessage.autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
	$chatPanel/VSplitContainer/ScrollContainer/messageHistory.add_child(newMessage);
	pass
