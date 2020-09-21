extends CanvasLayer

var score: int = 0


func _process(_delta):
	$SpaceBar.modulate.a = 1
	$RightArrow.modulate.a = 1
	$LeftArrow.modulate.a = 1
	if(Input.is_action_pressed("ui_accept")):
		$SpaceBar.modulate.a = .5
	if(Input.is_action_pressed("ui_right")):
		$RightArrow.modulate.a = .5
	if(Input.is_action_pressed("ui_left")):
		$LeftArrow.modulate.a =.5
		

func set_strength(value: float):
	$StrengthBar.value = value


func set_projectile_remaining(count: int):
	$InventoryLabel.text = str(count) + " Projectiles Remaining"
	
	
func increase_score():
	score += 50
	$ScoreLabel.text = "Score: "+str(score)


func show_return_button():
	$ReturnButton.show()


func _on_ReturnButton_pressed():
	get_tree().call_group("Projectiles", "queue_free")
	get_tree().change_scene("res://src/UI/Title.tscn")
