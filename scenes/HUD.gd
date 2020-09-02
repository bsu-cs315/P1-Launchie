extends CanvasLayer

signal start_game

func show_game_over():
	$Button.show()
	
func show_game_win():
	$Label.show()

func _on_Button_pressed():
	$Button.hide()
	$Label.hide()
	emit_signal("start_game")


