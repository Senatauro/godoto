extends Control    

var ip = "127.0.0.1"

@export var new_scene : PackedScene;

func _on_host_btn_pressed() -> void:
	MultiplayerManager.host()
	self.hide()
	get_tree().change_scene_to_packed(new_scene)
	pass # Replace with function body.

func _on_join_btn_pressed() -> void:
	MultiplayerManager.join(ip)
	self.hide()
	get_tree().change_scene_to_packed(new_scene)
	pass # Replace with function body.


func _on_ip_edit_field_text_changed(new_ip:String) -> void:
	ip = new_ip
	pass # Replace with function body.