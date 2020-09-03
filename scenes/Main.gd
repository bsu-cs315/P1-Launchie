extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_HUD_start_game():
	get_tree().call_group("Projectiles", "queue_free")
	var _reloaded = get_tree().reload_current_scene()

func _on_Cannon_launch():
	$HUD.show_game_over()


func _on_Target_body_entered(body):
	if body.name == "Projectile":
		$HUD.show_game_win() # Replace with function body.


func _on_Cannon_change_strength(value):
	$HUD.set_strength(value) # Replace with function body.
