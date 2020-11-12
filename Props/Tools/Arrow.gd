extends KinematicBody2D

class_name Arrow

var direction = Vector2.ZERO
var speed = 90

func _ready():
	pass


func _physics_process(delta):
	move_and_slide(direction * speed)


func _on_Area2D_body_entered(body):
	if body is Enemy:
		queue_free()
