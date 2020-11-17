extends "res://Props/Tools/Tool.gd"

class_name Arrow

var direction = Vector2.ZERO

func _ready():
	add_to_group("moving objects")


func _physics_process(delta):
	move_and_slide(direction * speed)


func _on_Area2D_body_entered(body):
	if body is Enemy:
		#queue_free()
		pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
