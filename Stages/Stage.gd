extends Node2D


var use_pathfinding = true
onready var this


var arrow = preload("res://Props/Tools/Arrow.tscn")

func _ready():
	for actor in get_tree().get_nodes_in_group("actors"):
		actor.connect("shoot", self, "spawn_projectile")
		
		
func spawn_projectile(emitter, target):
	var this = arrow.instance()
	
	this.position = emitter.position
	this.direction = (target.global_position - emitter.global_position).normalized()
	this.rotation = this.get_angle_to(target.global_position)
	
	add_child(this)
