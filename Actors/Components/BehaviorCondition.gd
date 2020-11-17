extends "res://addons/godot-behavior-tree-plugin/condition.gd"


func tick(tick:Tick) -> int:
	return int(Tick.Blackboard != null)
