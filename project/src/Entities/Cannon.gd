extends KinematicBody2D

signal finished
signal inventory_changed(count)
signal strength_changed(value)

export var rotation_speed: float = 100
export var strength_speed: int = 5

var strength: float = 1
var direction_rotation: int = 0
var direction_strength: int = 1

onready var projectiles_remaining := 3
onready var projectile_packed: PackedScene = load("res://src/Entities/Projectile.tscn")


func _physics_process(delta):
	rotation_degrees = clamp(rotation_degrees + rotate_on_input(delta), -90, 0)
	if are_projectiles_sleeping() && projectiles_remaining == 0:
		emit_signal("finished")
	if Input.is_action_pressed("ui_accept") && are_projectiles_sleeping() && projectiles_remaining != 0:
		change_cannon_strength(delta)
	if projectiles_remaining != 0 && Input.is_action_just_released("ui_accept") && are_projectiles_sleeping():
		launch_projectile()


func change_cannon_strength(delta: float):
	strength = clamp((strength * delta * strength_speed * direction_strength) + strength, 1, 100)
	if strength >= 100 || strength <= 1:
		direction_strength = -direction_strength
	emit_signal("strength_changed", strength)


func launch_projectile():
	var projectile = projectile_packed.instance()
	get_tree().get_root().add_child(projectile)
	projectile.position = position
	projectile.launch(rotation, strength / 100)
	projectiles_remaining -= 1
	strength = 1
	emit_signal("inventory_changed", projectiles_remaining)


func rotate_on_input(delta: float) -> float:
	direction_rotation = 0
	if Input.is_action_pressed("ui_right"):
		direction_rotation += 1
	if Input.is_action_pressed("ui_left"):
		direction_rotation -= 1
	return direction_rotation * rotation_speed * delta


func are_projectiles_sleeping() -> bool:
	var sleeping = true
	for node in get_tree().get_nodes_in_group("Projectiles"):
		node = node as RigidBody2D
		if !node.sleeping && node.position.x < get_viewport().size.x:
			sleeping = false
	return sleeping
