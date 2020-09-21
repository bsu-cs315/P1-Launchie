extends RigidBody2D

signal projectile_launched

export var launch_speed: int = 200
	
	
func launch(angle: float, strength: float):
		rotation = angle
		apply_impulse(Vector2.ZERO, Vector2(abs(cos(angle)) * launch_speed * strength, abs(sin(angle)) * launch_speed * strength * -1))
		$AudioStreamPlayer.play()
		emit_signal("projectile_launched")
