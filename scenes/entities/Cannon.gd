extends KinematicBody2D

signal empty
signal change_inventory(count)
signal change_strength(value)

export (float) var rotation_speed = 1.5
export var strength_speed = 5
var rotation_dir = 0
var triggered = false
var strength = 0
var projectiles_remaining = 3

func _ready():
	pass # Replace with function body.

onready var projectile_packed = preload("res://scenes/entities/Projectile.tscn")

var time_held = 0
var direction = 1

func _physics_process(delta):
	rotation += rotate_on_input(delta)
	rotation_degrees = clamp(rotation_degrees, -90, 0)
	if Input.is_action_pressed("ui_accept") && are_projectiles_sleeping() && projectiles_remaining != 0:
		time_held += delta
		strength += time_held * strength_speed * direction
		if strength >= 100 || strength <= 0:
			direction = -direction
			time_held = 0
		strength = clamp(strength, 0, 100)
		emit_signal("change_strength", strength)
	if projectiles_remaining != 0 && Input.is_action_just_released("ui_accept") && are_projectiles_sleeping():
		var projectile = projectile_packed.instance()
		get_tree().get_root().add_child(projectile)
		projectile.position = position
		projectile.launch(rotation, strength / 100)
		projectiles_remaining -= 1
		strength = 0
		emit_signal("change_inventory", projectiles_remaining)
		if projectiles_remaining == 0:
			emit_signal("empty")
		

func rotate_on_input(delta):
	rotation_dir = 0
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
	return rotation_dir * rotation_speed * delta

func are_projectiles_sleeping():
	var sleeping = true
	for node in get_tree().get_nodes_in_group("Projectiles"):
		node = node as RigidBody2D
		if !node.sleeping && node.position.x < get_viewport().size.x:
			sleeping = false
	return sleeping
