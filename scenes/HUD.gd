extends CanvasLayer

signal start_game

func set_strength(value):
	$StrengthBar.value = value

func show_game_over():
	$StartButton.show()
	
func hide_tutorial():
	$RightArrow.hide()
	$LeftArrow.hide()
	$SpaceBar.hide()
	
func show_game_win():
	$WinLabel.show()

func _on_Button_pressed():
	emit_signal("start_game")


