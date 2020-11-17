extends "res://addons/godot-behavior-tree-plugin/blackboard.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.set("enemies", get_tree().get_nodes_in_group("enemies"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
