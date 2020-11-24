extends Node2D


onready var BB = $BlackBoard

var use_pathfinding = true
var time = 0.5
var arrow = preload("res://Props/Tools/Arrow.tscn")

var mine_locations = []
var tree = preload("res://Props/Tree.tscn")
onready var mineshaft= preload("res://Props/MineShaft.tscn")

func _ready():
	
	var actors = []
	var enemies = []
	
	BB.set("actor_array", actors)
	BB.set("enemy_array", enemies)
	
	BB.set("time", 0.5)

	for actor in get_tree().get_nodes_in_group("actors"):
		actor.connect("shoot", self, "spawn_projectile")
	$StageGenerator.generate($TileMap)
	
	for mines in $StageGenerator.randomly_add($TileMap):
		var this = mineshaft.instance()
		this.position = mines * 16
		add_child(this)
		
	for trees in $StageGenerator.randomly_add($TileMap, 80):
		var this = tree.instance()
		this.position = trees * 16
		$YSort.add_child(this)
	

	$TileMap.update_dirty_quadrants()
	
	$BlackBoard.set("enemies", get_tree().get_nodes_in_group("enemies"))
	$BlackBoard.set("mines_array", get_tree().get_nodes_in_group("mines"))
	$BlackBoard.set("props_array", get_tree().get_nodes_in_group("props"))
	$HUD.set_props_to_clickable()
	
func get_time():
	return float(OS.get_ticks_msec()) / 1000
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		slow_motion()

		
	time += delta / 12000
	
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
