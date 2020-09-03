extends CanvasLayer

signal start_game

func set_strength(value):
	$StrengthBar.value = value

func show_game_over():
	$StartButton.show()
	
func show_game_win():
	$WinLabel.show()

func _on_Button_pressed():
	$StartButton.hide()
	$WinLabel.hide()
	emit_signal("start_game")


