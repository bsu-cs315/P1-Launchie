extends KinematicBody2D

signal launch
signal change_strength(value)

export (float) var rotation_speed = 1.5
export var strength_speed = 5
var rotation_dir = 0
var triggered = false
var strength = 0

func _ready():
	pass # Replace with function body.

onready var projectilePacked = preload("res://scenes/entities/Projectile.tscn")

func reset():
	strength = 0
	triggered = false
	rotation = 0

var time_held = 0
var direction = 1

func _physics_process(delta):
	rotation += rotate_on_input(delta)
	rotation_degrees = clamp(rotation_degrees, -90, 0)
	if !triggered && Input.is_action_pressed("ui_accept"):
		time_held += delta
		strength += time_held * strength_speed * direction
		if strength >= 100 || strength <= 0:
			direction = -direction
			time_held = 0
		strength = clamp(strength, 0, 100)
		emit_signal("change_strength", strength)
	if !triggered && Input.is_action_just_released("ui_accept"):
		triggered = true
		var projectile = projectilePacked.instance()
		get_tree().get_root().add_child(projectile)
		projectile.position = position
		projectile.launch(rotation, strength / 100)
		emit_signal("launch")
		

func rotate_on_input(delta):
	rotation_dir = 0
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
	return rotation_dir * rotation_speed * delta
