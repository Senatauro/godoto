extends Node

const PORT = 12345
var multiplayer_peer: ENetMultiplayerPeer
var id: int;



# Host a server
func host():
	# Create a new peer that will handle the current multiplayer session
	multiplayer_peer = ENetMultiplayerPeer.new();

	# Create the server
	multiplayer_peer.create_server(12345, 4);
	
	multiplayer_peer.peer_connected.connect(on_peer_connected)
	multiplayer_peer.peer_disconnected.connect(on_peer_disconnected)
	# Set the multiplayer peer that we just created to the peer on the multiplayer object for the game
	multiplayer.multiplayer_peer = multiplayer_peer;

	id = multiplayer_peer.get_unique_id()

func join(ip: String):
	multiplayer_peer = ENetMultiplayerPeer.new()

	# Connect the peer to the server
	var response = multiplayer_peer.create_client(ip, PORT);
	print("Response", response)

	if response != OK:
		printerr("Error when trying to connect");
		return

	multiplayer.multiplayer_peer = multiplayer_peer;
	id = multiplayer_peer.get_unique_id()

func finish():
	multiplayer_peer = null
	multiplayer.multiplayer_peer = null

func on_peer_connected(peerId: int):
	if(multiplayer.is_server()):
		print("Server: Peer ID: ", peerId)
	else:
		print("Client: Peer ID: ", peerId)
	pass

func on_peer_disconnected(peerId: int):
	if(multiplayer.is_server()):
		print("Server: Peer disconnected ID: ", peerId)
	else:
		print("Client: Peer disconnected ID: ", peerId)
