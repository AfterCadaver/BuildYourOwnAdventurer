extends "res://Actors/Actor.gd"


class_name Player

export var able_to_pathfind = false
export var able_to_play = true

var path = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("players")
