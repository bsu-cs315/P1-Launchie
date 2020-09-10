extends RigidBody2D

signal projectile_launched

export (int) var launch_speed = 200

var needs_rotated = 0

func _ready():
	pass
	
#	angle in radians, strength float between 0 and 1
func launch(angle, strength):
		rotation = angle
		angular_velocity = 0
		apply_impulse(Vector2(), Vector2(abs(cos(angle)) * launch_speed * strength, abs(sin(angle)) * launch_speed * strength * -1))
		emit_signal("projectile_launched")
		$AnimatedSprite.play()
		$AudioStreamPlayer.play()
		


