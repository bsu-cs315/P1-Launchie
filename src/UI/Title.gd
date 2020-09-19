extends CanvasLayer


func _on_PlayButton_pressed():
	var game_scene: PackedScene = load("res://src/Main.tscn")
	get_tree().change_scene_to(game_scene)
