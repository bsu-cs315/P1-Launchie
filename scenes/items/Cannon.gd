extends KinematicBody2D

signal launch

export (float) var rotation_speed = 1.5
var rotation_dir = 0
var triggered = false

func _ready():
	pass # Replace with function body.

onready var projectilePacked = preload("res://scenes/entities/Projectile.tscn")

func reset():
	triggered = false
	rotation = 0


func _physics_process(delta):
	rotation += rotate_on_input(delta)
	rotation_degrees = clamp(rotation_degrees, -90, 0)
	if !triggered && Input.is_action_pressed('ui_down'):
		triggered = true
		var projectile = projectilePacked.instance()
		get_tree().get_root().add_child(projectile)
		projectile.position = position
		projectile.launch(rotation)
		emit_signal("launch")

func rotate_on_input(delta):
	rotation_dir = 0
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
	return rotation_dir * rotation_speed * delta
