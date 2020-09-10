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
	
func set_projectile_remaining(count):
	$InventoryLabel.text = str(count) + " Projectiles Remaining"
	
func increase_score():
	$ScoreLabel.text = str(int($ScoreLabel.text) + 50)

func _on_Button_pressed():
	emit_signal("start_game")


