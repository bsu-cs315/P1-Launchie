extends Node


func _on_Target_body_entered(body: Node2D):
	if "Projectile" in body.name:
		$HUD.increase_score()
	

func _on_Cannon_finished():
	$HUD.show_return_button()


func _on_Cannon_inventory_changed(count: int):
	$HUD.set_projectile_remaining(count)


func _on_Cannon_strength_changed(value: float):
	$HUD.set_strength(value)
