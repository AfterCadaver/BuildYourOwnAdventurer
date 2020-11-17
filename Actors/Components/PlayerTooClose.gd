extends "res://addons/godot-behavior-tree-plugin/condition.gd"


func tick(tick: Tick) -> int:
	
	var player = tick.blackboard.get("player")
	var player_distance = player.position.distance_to(tick.actor.global_position) 
	
	if player_distance >= 100:
		return OK
	
	else:
		return FAILED 
