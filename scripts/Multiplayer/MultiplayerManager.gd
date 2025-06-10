extends Node

const SERVER_PORT = 8080;
const SERVER_IP = "127.0.0.1"

# Multiplayer Manager:
# Autoloaded (Always avaliable) node that will handle multiplayer connections and server creation

func host_server():
    print("Start server")
    # Creates a new peer
    var server_peer = ENetMultiplayerPeer.new();
    server_peer.create_server(SERVER_PORT)
    multiplayer.multiplayer_peer = server_peer;
    pass

func join_server():
    print("Join server")
    pass