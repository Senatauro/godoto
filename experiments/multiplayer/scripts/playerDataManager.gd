extends Node

var playerData = { "name": "name"};
var SAVE_FILE_PATH = "user://player_data.json"

# https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html
func _init() -> void:
    print(SAVE_FILE_PATH)
    pass

func load_player_data():
    
    pass