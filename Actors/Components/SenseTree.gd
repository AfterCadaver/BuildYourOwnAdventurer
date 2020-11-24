extends "res://addons/godot-behavior-tree-plugin/condition.gd"




func tick(tick: Tick) -> int:
	
	var trees_array = tick.blackboard.get("props_array")
	if trees_array.size() > 0:

		return OK
	
	else:
		return FAILED 
