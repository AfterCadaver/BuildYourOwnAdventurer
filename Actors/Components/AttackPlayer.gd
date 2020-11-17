extends "res://addons/godot-behavior-tree-plugin/action.gd"

func tick(tick: Tick) -> int:
	
	tick.actor.shoot_arrows()
	
	return OK
