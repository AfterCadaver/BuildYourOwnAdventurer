extends "res://addons/godot-behavior-tree-plugin/condition.gd"


func tick(tick: Tick) -> int:
	
	var enemies_array = tick.blackboard.get("enemies")
	if enemies_array.size() > 0:
		return OK
	
	else:
		return FAILED 
