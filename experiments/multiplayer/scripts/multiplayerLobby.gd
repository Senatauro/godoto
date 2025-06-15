extends VBoxContainer

var player: int;
var otherPlayers: Array[int]

func _ready() -> void:
	print("!@32131231")
	player = multiplayer.multiplayer_peer.get_unique_id()
	var playerLabel = Label.new()
	playerLabel.text = str(player)
	$".".add_child(playerLabel);

	multiplayer.multiplayer_peer.peer_connected.connect(on_peer_connected)
	for p in multiplayer.get_peers():
		on_peer_connected(p);


func on_peer_connected(peerId: int):
	var playerLabel = Label.new()
	playerLabel.text = str(peerId)
	$".".add_child(playerLabel);
