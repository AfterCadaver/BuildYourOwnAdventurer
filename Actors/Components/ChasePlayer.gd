extends "res://addons/godot-behavior-tree-plugin/action.gd"


func tick(tick: Tick) -> int:
	
	tick.actor.attraction_movement()
	tick.actor.speed = 30
	
	return OK
