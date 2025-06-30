extends Node

signal server_hosted();

signal server_on_peer_connected(id: int);
signal client_on_peer_connected(id: int);
signal server_on_peer_disconnected(id: int);
signal client_on_peer_disconnected(id: int);
signal on_connected_to_server();
signal on_connection_failed();
signal on_server_disconnected();

const TCP_PORT = 4560
const UDP_PORT = 4561

# Main Network functions
func create_server():
	var peer = ENetMultiplayerPeer.new();
	peer.peer_connected.connect(peer_connected);
	peer.peer_disconnected.connect(peer_disconnected);
	var server_creation_response = peer.create_server(UDP_PORT, 10);
	multiplayer.multiplayer_peer = peer;
	server_hosted.emit()
	pass

func create_client(server_ip: String):
	var peer = ENetMultiplayerPeer.new();
	peer.peer_connected.connect(peer_connected);
	peer.peer_disconnected.connect(peer_disconnected);
	peer.create_client(server_ip, UDP_PORT);
	multiplayer.multiplayer_peer = peer;
	multiplayer.connected_to_server.connect(connected_to_server);
	multiplayer.connection_failed.connect(connection_failed);
	multiplayer.server_disconnected.connect(server_disconnected);
	pass

# Clear the connections on the signals and remove the multiplayer peer
func finish_networking():
	for con in multiplayer.multiplayer_peer.peer_connected.get_connections():
		multiplayer.multiplayer_peer.peer_connected.disconnect(con.callable);
	for con in multiplayer.multiplayer_peer.peer_disconnected.get_connections():
		multiplayer.multiplayer_peer.peer_disconnected.disconnect(con.callable);
	for con in server_on_peer_connected.get_connections():
		server_on_peer_connected.disconnect(con.callable);
	for con in client_on_peer_connected.get_connections():
		client_on_peer_connected.disconnect(con.callable);
	for con in server_on_peer_disconnected.get_connections():
		server_on_peer_disconnected.disconnect(con.callable);
	for con in client_on_peer_disconnected.get_connections():
		client_on_peer_disconnected.disconnect(con.callable);
	for con in on_connected_to_server.get_connections():
		on_connected_to_server.disconnect(con.callable);
	for con in on_connection_failed.get_connections():
		on_connection_failed.disconnect(con.callable);
	for con in on_server_disconnected.get_connections():
		on_server_disconnected.disconnect(con.callable);
	multiplayer.multiplayer_peer = null

# Peer handling functions
## Everyone
func peer_connected(peer_id: int):
	print("Peer connected. Peer ID:", peer_id);
	server_on_peer_connected.emit(peer_id);
	client_on_peer_connected.emit(peer_id);

func peer_disconnected(peer_id: int):
	print("Peer disconnected. Peer ID:", peer_id)
	server_on_peer_disconnected.emit(peer_id);
	client_on_peer_disconnected.emit(peer_id);

## Client only
func connected_to_server():
	print("Connected!!!")
	on_connected_to_server.emit()
	pass

func connection_failed():
	print("Failed to connect :/")
	on_connection_failed.emit();
	finish_networking()
	pass

func server_disconnected():
	print("Server went down, possibly");
	on_server_disconnected.emit();
	pass