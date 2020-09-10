extends Node

func _on_HUD_start_game():
	get_tree().call_group("Projectiles", "queue_free")
	var _reloaded = get_tree().reload_current_scene()


func _on_Target_body_entered(body):
	if "Projectile" in body.name:
		$HUD.increase_score()


func _on_Cannon_change_strength(value):
	$HUD.set_strength(value)


func _on_Cannon_empty():
	$HUD.show_game_over()
	$HUD.hide_tutorial()


func _on_Cannon_change_inventory(count):
	$HUD.set_projectile_remaining(count)
