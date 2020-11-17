extends "res://addons/godot-behavior-tree-plugin/condition.gd"


func tick(tick: Tick) -> int:
	
	if tick.blackboard.get("time") == 0.5:
		return OK
	
	else:
		return FAILED 

