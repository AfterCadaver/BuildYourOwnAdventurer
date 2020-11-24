extends Prop


export (int, 1, 50) var health_points = 100
onready var current_health = health_points

var attacker: KinematicBody2D

func _ready():
	add_to_group("props")


func _process(delta):
	$ProgressBar.value = current_health
	
	if current_health <=0:
		attacker.add_to_inventory("Wood")
		queue_free()

func get_chopped():
	print("chopped")
	current_health -= 1

func _on_Area2D_body_entered(body):
	if body is Player:
		body.connect("chop", self, "get_chopped")
		$ProgressBar.visible = true
		attacker = body
		

func _on_Area2D_body_exited(body):
	if body is Player:
		body.disconnect("chop", self, "get_chopped")
		attacker = null

