extends "res://addons/godot-behavior-tree-plugin/condition.gd"



func tick(tick: Tick) -> int:
	
	if tick.actor.trees.size() > 0:

		return OK
	
	else:
		return FAILED 
