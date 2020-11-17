extends Node2D


onready var BB = $BlackBoard

var use_pathfinding = true
var time = 0.5
var arrow = preload("res://Props/Tools/Arrow.tscn")

func _ready():
	
	var actors = []
	var enemies = []
	
	BB.set("actor_array", actors)
	BB.set("actor_array", enemies)
	BB.set("time", 0.5)

	for actor in get_tree().get_nodes_in_group("actors"):
		actor.connect("shoot", self, "spawn_projectile")
	$TileMap.update_dirty_quadrants()
		
func get_time():
	return float(OS.get_ticks_msec()) / 1000
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		slow_motion()
		
	time += delta / 120
	
	BB.set("time", time)
	
	if time >= 1:
		time = 0

func avoid_mobs():
	var mobs_array = []
	mobs_array = get_tree().get_nodes_in_group("enemies")

func spawn_projectile(emitter, target):
	var new_arrow = arrow.instance()
	add_child(new_arrow)
	
	new_arrow.position = emitter.position
	new_arrow.direction = (target.global_position - emitter.global_position).normalized()
	new_arrow.rotation = new_arrow.get_angle_to(target.global_position)
	
func slow_motion():
	for node in get_tree().get_nodes_in_group("moving objects"):
		node.slow_motion(true)
