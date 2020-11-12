extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 30

func _ready():
	pass


func _physics_process(delta):
	direction = move_and_slide(direction * speed)
