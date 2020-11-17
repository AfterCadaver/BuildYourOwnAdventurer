extends Node

var player = null
var grid_position = Vector2.ZERO

var world_speed = 1
var global_time = .5

func _ready():
	pass
	
func _physics_process(_delta):
	
	
	if !player == null:
		grid_position = Vector2(stepify(player.global_position.x, 960),
								stepify(player.global_position.y, 960)) / 960
